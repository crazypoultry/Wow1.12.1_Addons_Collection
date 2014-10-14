Top Er Off - A WoW addon for the healing classes


-- Intro --

Greetings ladies and gents.  This is a little addon that will help you heal you and your fellow party members.  What it does is determine if your target is friendly and in your party, if both of those are true then it will find out how many hitpoints they're missing and cast your strongest standard healing spell (lesser/greater/normal heal, healing touch, healing wave, holy light) to heal them up, but not go over their max hitpoints to save mana. If your current target is not friendly or in your party, it will determine how many hitpoints you are missing, and cast the highest spell to heal you up, but not go over your max hitpoints. This also takes into account the different talents that add to your healing when determining which spell to cast.

I'm not a professional programer by any stretch of the imagination.  The code is probably messy as heck.  I'm sure someone has done this cleaner and better.  If they did, I couldn't find it and wanted to learn how to do it anyway.  Written with B:LUA http://blua.sourceforge.net/


-- Use --

Go into the WoW keybindings menu, scroll down to the Top Er Off keybinding section and bind whatever keys you want for normal casting and fast casting.  You can also create a macro with either "/teo" for normal casting or "/teo fast" (without quotations) and put them in any action button and click it to use.

You can also now use "/teo healover" or "/teo fastover" to have it cast a healing spell one level higher than what your target currently needs for situations where they're being damaged.

-- Known Issues --

* Will not work on entities outside of your party or raid because the UI will only return a percent of total hitpoints missing instead of an exact number.


Version History

- 0.9 - 
  - First release

- 0.91 -
  - Added pet compatability

- 1.0 -
  - Fixed not accounting for +healing talents (Sorry!)
  - Fixed funny noise when casting with Shamans, Druids, or Paladins. It was trying to cast the spell twice.
  - Added functionality for fast cast type spells as well
  - Added keybinding options

- 1.01 -
  - Fixed errors with Shamans, Druids, and Paladins.  Thanks for pointing it out Balastrea.

- 1.02 -
  - Fixed "(player) is at near/max hp." message from appearing when pressing hot-key or macro while not a healing class.

- 1.03 -
  - Fixed Greater Heal(Rank 4) as pointed out by Dimar.  Thanks!

- 1.04 -
  - Updated TOC for 1.9
  - Updated talent check for Paladins to account for their new holy talent tree.
  - Updated talent check for Druids to account for a change in their restoration talent tree from a previous patch. (Late!)

- 1.1 -
  - Added /teo healover and /teo fastover options to heal your target one spell level higher than what is currently needed as requested by Tuplad.  Hope this helps.

- 1.1.1 -
  - Fixed /teo fastover error.  Bad Evil, No cookie for me!  Thanks again for pointing it out Tuplad.
  - Also made it where /teo healover and /teofastover both at least cast rank 1 spells regardless of HP missing.  Seemed unnatural at low levels to skip from no healing to rank 2 healing.

- 1.1.2 -
  - Updated TOC for 1.9.4
  - Updated spell listings to include the new Greater Heal (Rank 5) for priests and Healing Touch (Rank 11) for druids.  Unable to test either since I have neither.  Tell me if it works.

- 1.1.3 -

  - Updated TOC for 1.10
  - Updated talent check for Priests to account for changes in talents from patch 1.10

- 1.1.4 -
  - Fixed max healing on many ranks of Heal and Greater Heal for priests and Healing Touch for Druids.  Credit goes completely to carpone.  Thanks!

- 1.2 -
  - Updated TOC for 1.12.0
  - Made use of the new UnitPlayerOrPetInRaid() and UnitPlayerOrPetInParty() functions to get around the party member pet querk.
  - Added support for bonusscanner 1.1.
  - Added "/teo bonus" command to display the +healing gained through gear and talents. (Requires BonusScanner installed)
  - Changed the the way the Druid spell regrowth is calculated.  It now counts only the initial heal of the spell to determine what rank it casts.  My reasoning behind this is the fast cast spells are more of an emergency heal,thus you'd want the highest rank possible with the best HoT afterwords.

- 1.2.1 -
  - Fixed raid member healing with priests.  It was missing a "target" in the UnitPlayerOrPetInRaid() call.