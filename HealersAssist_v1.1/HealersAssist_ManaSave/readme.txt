Healers Assist - Mana Save

Author:
-------
Alason aka Freddy
http://black-fraternity.de (PM to Alason)
hams@freddy.eu.org

Requirements:
-------------
Healers Assist (Version >= beta 25)

Purpose:
--------
Save mana ;)
It will abort casts which would have to much overheal

Installation:
-------------
Copy it to your Interface\AddOns dir, and enable it in the HA Plugin Options
Go to the HA Plugin Options and click on the config buttons

Notes:
-------------
Due to the latest changes in patch 1.10 you've to push a key to abort spells.
Because of this you'll have to hit a key everytime you want to check it.
You won't see anything of the plugin!

Here's an example what's currently possible:
1. You hit your spell action button, spell (e.g. a 1000k, 1,5 secs heal) starts to cast
2. After 0.3 seconds you hit it again, nothing will happen because spell hasn't passed min cast time (0.5 secs)
3. 0.3 seconds later (0.6 seconds since spell start) you hit an action button again your heal target has 4100/5000 hp (difference of 900), nothing will happen
   max overheal is set to 20%, that means that the spell will pass up to a hp difference of 800
4. 0.4 seconds later you hit your button, but somebody healed your're heal target to 4500/5000 (difference of 500) => cast will abort

ToDo:
-----------------
- Option to disable the use of MS while control/alt/shift is pushed

History:
-----------------
Version 1.02:
- GUI was added (Config button at HA plugins config)
- Added spell specific settings
- Now you can select between the use of percentage values or fixed ones
- Now require HA beta >= 27
- Now using healer.GroupHeal to make sure it's not a group heal
- Now using the new variables (HA_MyselfHealer/HA_MyselfRaider)
- Settings will be saved in HA Plugins config array now
- Removed slash commands

Version 1.01:
- Now require HA beta >= 24
- Removed HA_MS_ImHealing(), HA comes now with HA_IsPlayerCasting()
- Removed HA_MS_GetMyEstimatedHealValue(), not needed anymore
- Now using OverHealPercent value of HA
- Removed "Control Down" function (While control was hold MS didn't check)
- MS now becomes active now always after the original action, should fix a problem with spells that aren't recognized as completed
- Group healing spells won't be aborted any longer

Version 1.00:
- Initial release


