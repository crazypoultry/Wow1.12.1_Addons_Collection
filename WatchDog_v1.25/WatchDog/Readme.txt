==========================
WatchDog by Vika/Cladhaire
cladhaire@gmail.com
==========================

Watchdog is a highly customizable set of UnitFrames first and foremost.  When logging in for the first time, you'll see a single UnitFrame towards the center of your screen.  It will display some information about your character, and windows will pop up as party members, pets and targets show up.

You can open the configuration menu by typing /wdog, /wd or /watchdog, depending on what other addons are installed in your system (/wd conflicts with Wardrobe type addons).  There are a number of options available on this screen, and I won't explain them all since they'll be changing quite soon.  

You can open the click-casting configuration screen by clicking "Click-casting" on the options screen, or by typing /wdog cc.

Click-casting allows you to set up different profiles for the way WatchDog responds to your clicks, as well as integrating these clicks into the Blizzard raid UI and CTRaidAssist.  For example for a priest, you could set it so:

Shift-LeftClick: Flash Heal
Alt-LeftClick: Greater Heal
Control-LeftClick: Renew
Alt-RightClick: Dispel Magic
Control-RightClick: Power Word:Shield
Shift-RightClick: Power Word:Fortitude

This makes targeting and casting spells much easier and can make playing the game a little more than mashing the keyboard =).  This mod can also be used for non-heals, as you can customize the hostile clicks seperately from friendly clicks.  The click casting interface allows you to drag and drop from your spellbook so editing is quite easy.

The format strings (Target Format 1, Player Format 2, etc.) are what defines what is seen on each frame-- and can be customized per type of frame.  Format strings are entered using a system of [tags].  A full listing of the tags available is:

===Layout===
Each line will accept three layout tags.  These have the function of changing where in the frame the text will appear, along with resetting the color to White
* [left] - Puts the text in the lefthand textfield
* [center] - Puts the text in the center textfield
* [right] - Puts the text in the right textfield

===Basic Information===
* [name] - This tag will display the name of the character associated with that frame.  This tag is unique in that you can specify a number after the tag itself to truncate the string if it gets too long.  For example:
** [name 10] applied to "Lord Alexander" would become "Lord Alexa..."
** [name 5] applied to "[[Cladhaire]]" would become "Cladh..."
** [name 10] applied to "[[Cladhaire]]" would become "[[Cladhaire]]"
* [curhp] - Current HP of the unit.  This will work for hostile units as well, if you have "Calculate Hostile HP Precision" toggled on
* [maxhp] - Maximum HP of the unit.
* [percenthp] - The current percentage of health the unit has left.  This works for all units out of the box.
* [missinghp] - The amount of HP that is missing from a unit
** Unit A has 3000 maximum hit points, they currently have 2000/3000, [missinghp] will return 1000
* [curmp] - Current Mana/Energy/Rage/Focus of the unit.  This will work for hostile units as well.
* [maxmp] - Maximum Mana/Energy/Rage/Focus of the unit.
* [percentmp] - The current percentage of Mana/Energy/Rage/Focus the unit has left.  This works for all units out of the box.
* [missingmp] - The amount of Mana/Energy/Rage/Focus that is missing from a unit
** Unit A has 100 Maximum Energy, and they currently have 20 energy.  Missingmp will return 80.
* [typemp] - Returns "Rage, "Focus", "Energy" or "Mana" depending on what type of energy the unit 
has
* [combos] - Returns a numerical value of how many combo points you have accumulated against the current target
* [combos2] - Returns a visual representation of how many combo points you have
** If you have 3 combo points, returns "@@@"
** If you have 2 combo points, returns "@@", etc.

===Extended Information===
* [level] - Returns the level of the unit, using the information given by the API.  If the level is unknown to us, it will return ??
* [class] - Returns the class of the unit (Paladin, Rogue, Warrior, Shaman, etc.)  This works for mobs as well
* [creature] - Returns the "Creature Family" of the unit (Dragonkin, etc)
* [smartclass] - You can use this tag, and it will return either [class] or [creature] depending on what the unit is.  Helpful for some frames.
* [status] - Returns "Dead" if the unit is dead, "Ghost" if the unit has released, "Offline" if the unit has logged offline, "Combat" if the unit is currently in combat, "Resting" if the unitframe is the player unitframe, and we're currently "Resting" (i.e. in an Inn).
* [classification] - Returns "Rare", "Rare Elite", "Elite", "Boss" depending on the classification of the mob
* [faction] - Returns the faction group that the unit belongs to: "Steamwheedle Cartel", etc.
* [connect] - Returns "Offline" if the unit is disconnected
* [race] - Returns the race of the unit
* [pvp] - Returns PvP if the unit is flagged for PvP
* [plus] - Returns "+" if the unit is considered a "Plus Mob" (Elite, Boss, Rare, etc.)
* [sex] - Returns the sex of the unit
* [rested] - Returns "Rested" if the unit is currently resting
* [leader] - Returns "(L)" if the unit is currently party leader
* [leaderlong] - Returns "(Leader)" if the unit is currently party leader
* [happynum] - Returns a number corresponding to your pets happiness level
* [happytext] - Returns the text corresponding to your pets happiness level
* [happyicon] - Returns the following icons, based upon pet happiness (:), :|, :()
* [curxp] - Returns the players currently amount of experience
* [maxxp] - Returns the amount of XP needed to reach the next level
* [percentxp] - How far through the level you are (as a percentage)
* [missingxp] - How much XP you need to level
* [restedxp] - How much experience you have that will get you double experience
* [tappedbyme] - Returns "*" if you will receive experience for a kill (you've tapped the mob)
* [istapped] - Returns "*" if the unit is tapped by someone else, and you will not receve experience for it
* [pvpranknum] - Returns the PvP rank number of the unit
* [pvprank] - Returns the PvP rank of the unit (in text)
* [fkey] - Returns the FKey that is associated with that unit as far as in-game targeting goes (F1, F2, F3, etc)

===Color Tags===
* <RRGGBB> - Will color the text after this label the color you specify.  Won't cross [left][right][center] boundries
* [statuscolor] - Colors the following text to correspond with the returns from [status].  Typically is used to color [status]
* [happycolor] - Returns the happiness of your pet as a color.
* [white] - Resets the color to white
* [aggro] - Returns the hostility of a unit (green, red, yellow)
* [difficulty] - Returns the color of a unit's difficulty as compared to you (grey, green, yellow, orange, red)
* [colormp] - Returns the color of the energy bar (for energy, rage, focus, etc)
* [inmelee] - Returns red if you are engaged in melee attack
* [incombat] - Returns red if the unit is currently "In Combat"
* [raidcolor] - Returns the raid color
* [lowhpcolor] - Returns RED if the unit is below 20% health
* [lowmpcolor] - Returns BLUE if the unit is below 20% mana
