Spirit Versus Intellect v1.11.0 by Ted Vessenes (tedvessenes@gmail.com).

-------------------------------------

This mod computes and compares the effectiveness of spirit, intellect, and
mana/5.  This is the core processing component of the mod; it does not do
any data output on its own.  Currently there is a titan plugin which should
be bundled with this installation that will output the data.  The mod is
effectively dependant on Titan until someone wants to write non-Titan
dependant output code.

Data recording automatically turns on and off when you enter and leave combat.
If you quickly reenter combat (within 12 seconds), it will continue recording
in the same session.  Otherwise old data will be cleared when the next combat
starts.

-------------------------------------

Known issues:

The mod has been prepared for localization but no translations are in place.
See the Localization.lua file for more information if you'd like to help out.
