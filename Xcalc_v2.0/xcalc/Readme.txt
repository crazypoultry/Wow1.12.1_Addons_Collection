Xcalc v. 2.00
Author: Moird (peirthies@gmail.com)

Xcalc is a fairly basic calculator that allows mathmatical equations to be entered via the console
or by using the GUI calculator interface.

Xcalc is based off of QuickCalc by Mark Ribau.  A good portion of the code has been rewritten, and
the GUI has been completely rewritten.

Installation
------------------
Extract the zip and put the xcalc folder into
 \World of Warcraft\Interface\AddOns
 **WARNING**
 xcalc 2.0 files have changed and any previous version needs to be deleted before.  ie. dont copy
 this over 1.0 installation.
 
 
Usage
----------------
slash commands:
 /xcalc
 /calc
 /=
 
there is a = minimap icon that will all open the GUI interface.
also of importance xcalc will rebind your all your numberpad keys to the gui interface when the Gui
is open so it is not necessary to bind those keys.  the GUI will rebind the numberpad keys back to
their original bindings when the window closes.  With the GUI open use shift+enter to open the chat
dialog, and you can shift+left click on the number window to output that to the chat dialog if it is
open.
 
Xcalc does support computing of expressions from the command line.  This is accessed by using the
slash commands with the expression after the slash command.
 
Math operators:
+ - * / ^ ( )

Special Keyword:
ans -- Will return the last answer given from using the slash commands

Math Functions:
abs() acos() asin() atan() atan2(,) ceil() deg() floor() frexp() ldexp() exp() log() log10() min([,...])
max([,...]) mod(,) rad() random([[,] ]) randomseed() sqrt() cos() sin() tan()
Please see http://www.wowwiki.com/World_of_Warcraft_API#Math_Functions for more information on the math functions.

Money strings:
#.#g
#.#s
#c
#g#s#c
#g#s
#g#c
#s#c

example:
 /calc 2 + 2
 xcalc Result: 2 + 2 = 4

 /calc 3.5g
 xcalc Result: 3.5g = 3g50s

 /calc (3.5g + 50s) * 2
 xcalc Result: (3.5g + 50s) * 2 = 8g

 /calc 4g / 5
 xcalc Result: 4g / 5 = 80s
 
===========================
Version History:
v2.00 (15SEP2006)
		- Complete GUI rewrite (there was a latent problem with the original way it was written)
		- Added Controls to position/hide Minimap Icon
		- Option to turn off Automatic Keybindings
		- Escape Key will close the window
v1.00 (27AUG2006)
		- Initial Release