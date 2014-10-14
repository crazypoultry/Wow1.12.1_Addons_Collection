BigMacro v1.1 by Jooky
Have you run out of macro slots?  Are you tired of the 256-character limit on macros?  Do you wish you could bind a key to a macro without wasting an action-bar slot?  Then BigMacro is for you!

BigMacro gives you 30 keybindable macros, unlimited in length. (Many thanks to Mook/Talissanti for increasing the number of macros from 10 to 30).

Installation:
-------------
Extract the contents of the .zip archive into your .\World of Warcraft\Interface\Addons folder.

Usage:
----------
Use any text editor to edit the .\World of Warcraft\Interface\Addons\BigMacro\Macros.lua file.
Create your new 'extended' macro in one of the macro##={ } blocks.
Each line of the macro should be surrounded by [[ and ]].

An example section of this would be something like:
macro01={
[[/party Incoming heal to %t]],
[[/script BM_CastSpellByName("Holy Light","Rank 1")]],
}, 

Launch WoW and bind your macro to a key using your in-game keybinding menu.

You can also attach your extended macro to an in-game macro.  To do so, Launch WoW and type "/macro" to bring up the in-game macro interface.  Create a new macro that calls your new 'Big Macro'.
You can call your new 'Big Macro' using the following commands:
"/bm X"
or
/script BigMacro_Execute("macroYY")
X is the macro number between (1 and 30) and YY is the two-digit macro number between (01 and 30) that matches the one in the Addons\BigMacro\Macros.lua file.

To turn echoing of macros on and off, use:
/bm echo on
/bm echo off


Tips:
----------
Due to Blizzard's anti-botting policies, if you attempt to run your BigMacro directly from a 'chat line' (ie. not bound to a button) calls to cast spells may not fire. Make sure you activate your macros with a button-press or mouse-click.

To reliably cast spells, use /script BM_CastSpellByName("Spell Name","Rank #")
Example: /script BM_CastSpellByName("Frost Armor","Rank 1")
If no rank is given, then the highest ranking spell of that name will be used.

Both "/cast" and "/script CastSpellByName" should work under normal usage, but may not work properly in certain situations. The above method is much more reliable.


----------v1.1 - 2005.03.26 -----------------------------------------
* Interface updated to 1300

----------v1.03 - 2005.02.20 ----------------------------------------
* Fixed a bug with BM_CastSpellByName.  This was all Xyzlor's work.  Thanks!

----------v1.02 - 2005.02.19 ----------------------------------------
* Single-line /script commands can now be longer than 256 characters.

----------v1.01 - 2005.02.17 ----------------------------------------
* Added UNKNOWNBEING to player name checks.  If this doesn't kill the nil errors, I don't know what will.

----------v1.0 - 2005.02.16 -----------------------------------------
* Updated .toc file for interface version 4211.
* Bumped version number to 1.0.  I figure we're ready for prime time.

----------v0.4 - 2005.02.13 -----------------------------------------
* Increased the number of macros to 30. (This was all Mook/Talissanti's work.  I just integrated the code.  Big thanks for taking on the drudgery!)
* You are no longer required to specify a rank when using BM_CastSpellByName.  If no rank is given, then the highest-ranking spell of that name will be used. (This is all thanks to Danboo's brilliance.)
* Spell-casting in general is now much more efficient.  (Also thanks to Danboo's brilliance.)
* Users can now optionally specify a server name if they use the same character name on multiple servers
* No longer uses player's chatbox when firing macros
* Made player name checks compatible with all languages

----------v0.3.1 - 2005.02.08 ---------------------------------------
* Fixed a bug that might cause BigMacro not to function for certain players.

----------v0.3 - 2005.02.08 -----------------------------------------
* Turned off echoing by default.
* Added slash-commands for echoing:
/bm echo on --Turns on echoing.
/bm echo off --Turns off echoing.

----------v0.2 - 2005.02.07 -----------------------------------------
* Implemented more-reliable spell-casting.  In BigMacro, "/cast" and "/script CastSpellByName" are not very reliable.  Instead, you should use:
/script BM_CastSpellByName("Spell Name","Rank #")
You'll be much happier in the long-run.

* Added slash-commands to execute macros.  You can now use:
"/bm 1" through "/bm 10"
to execute the macro you choose.  This allows you to call macros from within macros.  If you wish to call macros from within a "/script" command, then use:
/script BigMacro_Execute("macro01") through 
/script BigMacro_Execute("macro10")

----------v0.1 - 2005.02.06 -----------------------------------------
* Initial release