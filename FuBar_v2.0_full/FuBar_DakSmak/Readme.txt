FuBar - DakSmak v0.7.6 (Pre-release. May contain some bugs or irregularities.)

Written by: Daklu
Release Date: Nov 24, 2006

Description: DakSmak is a FuBar plugin that displays the attack tables. An attack table shows what the chances are (as a percentage) for each outcome from an attack. i.e. The chance to hit, chance to crit, chance to miss, chance to be blocked, chance to be dodged, chance to be parried, and chance to be a glancing blow.

DakSmak displays two tables, an "Attack" table that shows the chance for each outcome of the player's attacks and a "Defend" table that shows the chance for each outcome of the target's attacks. If the player does not have a target selected the Attack and Defend tables will be based on a normal mob the same level as the player.

There are certain targets for which the calculations to determine attack outcomes are not well known. (i.e. Elite mobs, other players, etc.) If you select one of those targets, DakSmak will turn the background of the combat tables red to indicate the numbers are likely incorrect.

(For more information on attack tables and how the outcome of each attack is determined, see http://www.wowwiki.com/Attack_table.)


TO INSTALL: Put the FuBar_DakSmak folder in
\World of Warcraft\Interface\AddOns\



Known Issues:
- DakSmak only calculates results for normal (sometimes referred to as "white") melee attacks. It does not predict rates for special class-specific attacks, ranged attacks, or spells.
- DakSmak does not correctly calculate attack outcomes for the following targets: elite mobs, rare mobs, bosses, critters, and other players. When the player selects one of those types of targets the Attack and Defend tables will be incorrect.
- DakSmak does not take into account any +ToHit bonuses (i.e. equipment or talent bonuses) or -ToHit debuffs.
- There currently is a bug that occurs when when the player right clicks on a detached frame before right clicking on the FuBar DakSmak menu. This appears to be a non-fatal error and can be ignored while I try to squash it.


IDEAS FOR FUTURE FEATURES: (In no particular order)
**** Planned for v1.0 release ****
- Implement +/- ToHit bonuses from buffs, talents, equipment, etc.
- Implement localization files for Germany. (I will implement other regions as well if anyone wants to translate for me.)

**** Not currently planned, but under consideration ****
- Vertical (top/bottom) or horizontal (side-by-side) table orientation  [Implemented v0.7.6]
- Add a column for equipment and/or talent and/or racial bonuses
- Change the color of the table text to reflect how close to max your skill is
- Able to show selected stats in the Fubar header
- Able to select the level of a "standard" mob to use for calculating outcome when no target is selected
- Add support for dual weilding
- Add support for ranged attacks and spells
- Add a data collection module for collecting combat data
- Add a PvP communication feature that allows FuBar to trade information if both players have FuBar installed.




SPECIAL THANKS:
- Thanks to the person who wrote the WelcomeHome tutorial and posted it on www.wowace.com.  I had looked at a lot of information and scripts previously, but this is what really pulled it all together for me.
- Thanks to the person who worte the FuBar_ExampleFu tutorial and posted it on www.wowace.com.  Using this as a guide, I was able to port WelcomeHome to FuBar.  (Maybe I'll be able to write up a tutorial detailing how I did it and post that for other users.)
- Thanks to Aegean for writing TitanCombatInfo.  Although my code is not a derivative of his, at the end of my beta development I discovered his addon and found that he had written a GetCritRate() function to pull crit rate directly off the "Attack" spell tooltip.  I pulled that one section of code directly into DakSmak and saved hours of experimenting.
- Thanks to the user community at www.wowwiki.com for all their research into figuring out the algorithms used in the game.  I'm afraid to even guess at how many hours have gone into that.
- Thanks to WoWInterface for providing a wealth of API information without which would make common mods nearly impossible to create.
