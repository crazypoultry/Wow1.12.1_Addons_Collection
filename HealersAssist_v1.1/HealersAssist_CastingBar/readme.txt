Healers Assist - CastingBar

Author:
-------
Alason aka Freddy
http://black-fraternity.de (PM to Alason)
hacb@freddy.eu.org

Requirements:
-------------
Healer Assist (Version >= beta 25 is required)
Healers Assist - Mana Save is supported, but not required
eCastingBar is supported, but not required
sm_UnitFrames is supported, but not required

Purpose:
--------
Allows you to modify your casting bar text with spell, estimated heal, target, etc.
If you are using Mana Save you're able to change the color of your casting bar (Color depends on whether you're overhealing or not).

Installation:
-------------
Copy it to your Interface\AddOns dir, and enable it in the HA Plugin Options.
You can modify the pattern/color settings by clicking the configuration button for the plugin at HA plugins configuration.

Notes:
-------------
These variables are possible:

@spellname - Original spell name
@shortspellname - A short spell name
@rank - Rank of the spell
@target - Target of the heal
@casttime - The cast time of the spell
@estimated - Your estimated heal
@overhealpercent - Estimated overheal Percentage
@hp - Current HP of your heal target
@hpmax - Max HP of your heal target
@hpdiff - Difference between Max/Current HP
@healcount - Count of incoming heals
@estimateratio - Debuff modifier percentage (Mortal Strike, etc.)
@totalestimatedheal - Estiamted sum of all incoming heals
@n - New line

Example:
@shortspellname > @target (@estimated)
would change the text in your casting bar to e.g. "Flash Light > Avatar (832)"

History:
-----------------
Version 1.04:
- Added option to change casting bar color depending on whether you're overhealing or not (Requires Mana Save plugin)
- Removed ArcHUD Support

Version 1.03:
- Added Support for ArcHUD
- Added Support for sm_UnitFrames

Version 1.02:
- Now require HA beta >= 25
- Added @n (New line)
- Fixed @estimated/@totalestimatedheal, modifiers weren't added (Mortal Strike, etc.)
- Now using HA_MyselfHealer.GroupHeal to make sure it's not a group heal

Version 1.01:
- Fixed a possible error message at startup
- Added @overhealpercent, @hp, @hpmax, @hpdiff, @healcount, @estimateratio, @totalestimatedheal
- Changed the way the text is updated (to update hpdiff, etc.)

Version 1.00:
- Initial release


