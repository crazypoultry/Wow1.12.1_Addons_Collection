SwiftShift 1.7
By Trimble Epic

Table of Contents:
1) Introduction
2) What's New
3) Usage
4) Macro Usage

=-=-=-=-=-=-=-=
1) Introduction
=-=-=-=-=-=-=-=

This mod changes the way Druid shapeshifting works - hopefully, making it more 'natural' feeling.

The way shapeshifting works normally, using the standard UI, is that you have to click a shapeshift form to shapeshift into an animal form, but to shift back, you have to click the same button again.  This causes the following problems:  1) When things are laggy, and you press the button to shapeshift, sometimes it doesn't seem to work, so you press the button again - only to find out, after lag, that you shifted and then shifted back, wasting precious time and mana, and 2) When you are in one form like cat, and you want to shift into another form like bear, you must first press the correct button to get out of the form that you are in, and then press the button for the form that you want to be in.  This makes it difficult to shapeshift to the form you want, especially when combat is hot and heavy and (unless you are VERY cool-headed) you are prone to making mistakes.  Adding the lag factor and it gets even worse because you have multiple opportunities to 'over-shift', wasting even more mana and time.

SwiftShift solves these issues by changing the way the buttons work to shift you into forms.

First, when you press the button to go into Bear mode, if you press bear mode again, you will stay in bear mode.  This means that you can press the button for bear mode as many times as you want/need, and you won't accidently shift out of bear mode.  If you do want to shift out of bear mode, then you can press/click the button for humanoid mode, or just press the button for cat mode or travel mode once, and it will take you out of bear mode.

=-=-=-=-=-=-=
2) What's New
=-=-=-=-=-=-=

New in version 1.7 of SwiftShift is the following:

*	SwiftShift has been updated to work with the 1.10 patch and the new tooltip rules.

New in version 1.5 of SwiftShift is the following:

*	SwiftShift now 'catches' the error that occurs when you try to shapeshift to Travel Form while swimming, and the error that occurs when you try to shapeshift to Aquatic Form while not swimming.  SwiftShift now remembers these errors and automatically adjusts your desired form of traveling for the next time you press the button.  This conversion is automatic for both Travel Form and Aquatic Form.  When the error occurs, just press the button again and SwiftShift will shift you to the correct usable form.  Bottom line is this: for either travel form, just tap the keybind for it until you're in the right form - you may have to press once or you may have to press twice, but you still won't accidently overshift.

*	SwiftShift now features a 'feedback' system designed to help report problems to me, the author.  If you suspect SwiftShift of having a problem, use the slash command '/ss talktome'  This will cause SwiftShift to provide feedback in the normal chat channel as to what it's doing.  You can turn off the feedback by using the same slash command again; it's a toggle.

=-=-=-=-=
3) Usage
=-=-=-=-=

To use SwiftShift instead of the default UI, do the following:

For hotkey use, Open your control panel and find the section for SwiftShift.  Assign keyboard keybinds to the functions that you want to be able to use.  There is nothing stopping you from over-riding the default UI shift keys of Ctrl-F1 thru Ctrl-F5.  Personally, I prefer to put them on non-shifted keys like F6, F7 and F8.

Also keep in mind that you don't really need to bind a key for Humanoid form since you can just tap a button for a form other than the one you're in to unshift - however, a keybind for humanoid form was included for your convenience anyway.

For Mouse-clicking button use, you should create macros to use SwiftShift, and then put those macros on your actionbars, or alternately, you can put them on extra bars provided by other addons such as Cosmos or Flexbar, etc.

To do so, create a macro such as the following:

/script SwiftShift('Cat Form')

and put that macro button wherever you want it.

=-=-=-=-=-=-=-=
4) Macro usage
=-=-=-=-=-=-=-=

This mod exposes one very simple function:

SwiftShift(form name)

When used in macros or scripts, the function SwiftShift() will return TRUE if you are already in the desired form, and FALSE if it caused you to shift.

For a druid, viable names are 'Bear Form', ,'Dire Bear Form', 'Cat Form', 'Aquatic Form', and 'Travel Form'

To shift to humanoid form, you may use 'Humanoid Form', 'Night Elf Form', or 'Tauren Form'

Some examples of using SwiftShift in macros are as follows:

/script if SwiftShift('Bear Form') then CastSpellByName('Bash(Rank 1)') end
/script if SwiftShift('Bear Form') then CastSpellByName('Demoralizing Roar(Rank 1)') end
/script if SwiftShift('Bear Form') then CastSpellByName('Feral Charge') end
/script if SwiftShift('Cat Form') then CastSpellByName('Prowl(Rank 1)') end
/script if SwiftShift('Cat Form') then CastSpellByName('Track Humanoids') end
/script if SwiftShift('Cat Form') then CastSpellByName('Cower') end
/script if SwiftShift('Cat Form') then CastSpellByName('Dash(Rank 1)') end
/script if SwiftShift('Cat Form') then CastSpellByName('Claw') end
/script if SwiftShift('Humanoid Form') then CastSpellByName('Moonfire(Rank 1)') end
/script if SwiftShift('Humanoid Form') then CastSpellByName('Healing Touch(Rank 1') end
/script if SwiftShift('Humanoid Form') then CastSpellByName('Regrowth(Rank 1') end
/script if SwiftShift('Humanoid Form') then CastSpellByName('Rejuvenation(Rank 1') end
etc, etc...

To use these, you just have to tap the button that contains the macro repeatedly until it executes the ability you want.  Using the first macro above as an example, if you are in Cat Form, fighting a caster mob, and you notice that he is beginning to cast a heal spell, you can quickly start tapping the macro for Bash, and will do the following:

1) shift you from cat to humanoid
2) shift you from humanoid to bear
3) activate bash to stop them from spellcasting

This can happen very quickly depending on lag.

For questions or comments, you may email the author directly at TrimbleEpic@HotMail.Com

Thanks, and enjoy shifting easier!