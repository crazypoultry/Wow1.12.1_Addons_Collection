ErosManaConserve Version 0.9

----Installation----
-Unzip the file into your \World of Warcraft\Interface\Addons directory. ("C:\Program Files\World of Warcraft\Interface\AddOns" by default)
-In game create a macro that contains(with out the quotes) "/erosconserve Greater Heal(Rank 4),2000".  For instuctions on how to create a macro see below.
-Replacing "Greater Heal" with the spell you would like to cast
-Replacing "4" with the Rank of the spell you would like to cast
-Replacing "2000" with the amount of Health Points the target should be missing in order to continue casting
-Note that the spacing and COMMA are VERY important. Also make sure there are NO carriage returns at the end.

----Examples----
NOTE: It's recommended you put the following examples into macros that can be dropped on your spell bars
/erosconserve Greater Heal(Rank 4),2000
	-or-
/erosconserve Flash Heal(Rank 7),1000
Please note that the spacing and the COMMA are VERY important.

----DESCRIPTION----
This mod is meant to ease the pain us healers have experienced by losing CT_RaidAssit's Mana Conserve option.

----How it Works----
-It will begin to cast the given spell on your current target (regardless of how much health she is missing).
-After casting has begun, any subsequent clicks will check to make sure that your ORIGINAL casting target has at least X amount of health missing otherwise the spell is interrupted (where X is the numeric value supplied to the /eroscommand).
-It is worth repeating that subsequent clicks will continue to check your ORIGINAL target that you had when you began casting no matter who is your current target or even if you no longer have a target.

----How it Works Example----
-Let's assume I've created a macro that contains (without the quotes): "/erosconserve Greater Heal(Rank 4),2000"
-I have placed the macro into a bar slot that is bound to the '3' key.
-I find a target "Darco" who I would like to heal and click 3.
-Greater Heal(Rank 4) begins casting no matter how much health Darco has
-I click '3' again and the mod checks to make sure that Darco needs at least 2000 Health Points. Let's assume he could still use 2000 HPs.
-I select another target, "Frazz", and click '3' with 0.5 seconds left before Greater Heal(Rank 4) will finish casting.
-The mod checks Darco's health again, and interrupts the spell casting because Darco no longer needs 2000 or more HealthPoints because someone else healed him.
-710 mana saved.


----How to Creat a Macro----
-In game press the 'esc' key until the game menu pops up.
-Click "Macros"
-Click "New"
-Enter a name for your macro and choose an Icon to use for it.
-Click "OK"
-Enter, without the quotes "/erosconserve Greater Heal(Rank 4),2000"
-Replacing "Greater Heal" with the spell you would like to cast
-Replacing "4" with the Rank of the spell you would like to cast
-Replacing "2000" with the amount of Health Points the target should be missing in order to continue casting
-Make sure there is no carriage return at the end of the macro text.
-Drag the icon for your new macro onto your spell bar and close the Macro window.  Your done!

