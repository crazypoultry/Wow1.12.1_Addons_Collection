Spell Mats Addon.
Version 6-Sep-2006 1.12.0.0

==============================================================================
History
==============================================================================
1.6.0.0 - Initial version
1.6.0.1 - Added support for german. I haven't tested it, because I don't have
german client.
1.6.0.2 - Now using in-game constant for scanning reagents tooltip. It's
supposed to make this addon theoreticaly work for all localized version. 
Thanks Veithflo for the tip.
1.9.0.0 - Fixed bug, when trash was displayed on pet/shapeshift bar. 
          Toc updated to 10900
1.9.0.1 - Fixed work with german & french clients, thanks Hoyel. Sea is 
          optional deps now.
1.9.3.0 - Added some french localization, thank you, Sasmira. Added command 
          line support for color coding of the reagents that are running out.
1.9.3.1 - Added DAB support. Some code restructure. Watch out for new bugs.
1.9.3.2 - Added CT_BarMod support.
1.9.3.3 - Added support for Bongos and BibToolbars. Support for every bar mod
          is in a separate file now, so user can delete the files that are not
          needed. Also this will make adding support for other bar mods (if 
          nescessary) simplier
1.9.3.4 - Updated to work with for DAB 3.1 (no longer support older DAB - 
          update)
1.10.0.0- Fixed for 1.10 patch. Please note that at this stage I didn't retest
          with all the bars addon, so if they are changed the addon may fail.
1.10.0.1- Couple more fixes for 1.10 compatibility. Support for Popbar and
          Telo's sidebar
1.10.0.2- Fixed a bug with Popbar
1.10.0.3- Flexbar support
1.10.0.4- Fast update option added. Please read the updated addon description
          for the details. Fix to improve zoning time.
1.10.0.6- Fixed for comaptibility with latest Bongos
1.10.0.7- Fixed for compatibility with latest Bongos (6.6.6) again.
1.11.0.0- Bumped UI number for patch 1.11
1.11.1.0- Fixed a FastUpdate bug, added some code for better compatibility 
          with DAB
1.11.2.0- Added Nurfed support          
1.12.0.0- Bumped toc, updated Bongos compatibility

==============================================================================
Introduction
==============================================================================

This is very simple addon that displays a number for spell that require 
reagents on action bar the same way as it is displayed for items like 
bandages. For example Levitate spell requires Light Feather. If you have
7 Light Feathers in your inventory this number will be displayed on Levitate
spell button on the action bar. This addon is supposed to work with all such 
spells, but of course I couldn't test every single one. If you observe any 
kind of strange behaviour please report.

From version 1.9.3.0 on, chat command for the addon has been added in order
to being able to configure threshold when counts displayed in red or yellow.

The following bar mods supported:
- BibToolbars
- Bongos
- CT_BarMod
- Discord Action Bars
- Popbar from Cosmos
- Telo's Sidebar
- Flexbar
- Nurfed

==============================================================================
Chat commands
==============================================================================

/sm or /spellmats. This command displays brief help on chat commands for the
SpellMats addon. This help is displayed as well if any SpellMats command is
invoked with improper arguments.

/sm or /smtoggle on|off. This command allows to turn addon on or off from the
command line. on or off argument is mandatory.

/sml or /smlimits reagent yellow red. This command invoked without parameters
will display the current limit for known reagents. Please note that because
the number of different spells that require reagents is not that big there is
no diffetentiation between characters on a single account. /sml will dump
all spell reagents for all characters, providing you've logged on with this
character at least once, had SpellMats on and had respective spell on your
action bar. If you issue /sml command with only one parameter: /sml reagent
this will display limts for this reagent only. /sml reagent yellow red will
set limits for the reagent. For example /sml [Maple Seed] 10 5 will allow
count for Maple Seed to be displayed in white when it's more then 10, in
yellow when it's 6-10, and in red when it's 5 or less. Reagent parameter
should be specified in square brackets, alternatively you can shift-click
on the reagent in your inventory while typing the command to insert the
reagent link into the chat line. The addon understand links as well. Currently
there is no Khaos alternative for configuring this option. There probably 
never will because Khaos currently doesn't allow to configure dynamic option
sets with variable number of options.

/smf or /smfastupdate on|off. This command turns fast update mode on or off.
Please read Fast Update Mode section for more information.

==============================================================================
Fast Update Mode
==============================================================================

This addon may cause a stutter on any inventory changes, i.e. equipping/
unequipping items, doing banking, and simply rearranging items in the 
inventory. I consider this pretty minor, but for some people it's a big deal,
so there is a solution but at a cost. In the Fast Update Mode there is no 
stutter, however if you drag a spell to a new place the counter won't be 
updated until you switch the fast mode off and then back on. At the instant of 
turning the Fast Update Mode on or off the stutter will still occur, but it 
won't happen during normal gameplay in the Fast Update Mode. The following is
the technical discussion of what is happening behind the scene, you can safely
skip it if you don't care.

When inventory changes the addons goes over all the buttons in game - it's 120
standard buttons plus whatever buttons added by bar mods. This leads to a
considerabled delay. The blizard counters for stacked items don't have this
problem because a special even fired in this case that can be processed by
each button individualy if needed. This event is not fired in our case. In the
Fast Mode the addon goes over all the buttons and remeber only those, that has
spells with reagents on it. On every subsequent bag update the addons goes over
only these few buttons and update them. This is super fast. The only problem is
that when you move a spell from the old place to a new one or delete spell from
a button or add a new spell on a button the addon won't know that button has
changed and will still scan the old buttons. I don't want it to rescan all the 
buttons on a button drag because it would be even more annoying to have a 
stutter every time you drag a spell. But you are able to rescan buttons 
manually. When you know that you've just changed your button layout and you are
satisfied with this you turn Fast Update Mode off, and then back on or 
alternatively you can just type /smf on and all the buttons will get rescanned
(the will be a shutter this time but because you do it not so often and only 
at will it's acceptable) after this reagents will keep counted on these new
buttons.

