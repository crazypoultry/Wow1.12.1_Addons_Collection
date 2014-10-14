RangeHelp v4.1
==============

***** Not for kids. Only usable by Hunters level 12 and above. May be usable by other classes if you are an adventurous type. *****

To install, extract files to your "World of Warcraft\Interface\AddOns" folder.

Usage:
/rh 	- to customise the mod
/rh ui  - to customise the mod's UI
/rh spell - to customise the spell key bind

/rh options
===========
- Melee Spell : If it says "OK", that means it has successfully found a melee spell on your actionbar to retrieve melee distance information. If it says "Not Found", that means a melee spell could not be found on your actionbar (Attack and Raptor Strike are NOT considered as melee spells). RangeHelp will try to find the following spells on ANY of your actionbar pages for melee distance information, "Wing Clip", "Disengage".

- Range Spell : If it says "OK", that means it has successfully found a range spell on your actionbar to retrieve range distance information. RangeHelp will try to find the following spells on ANY of your actionbar pages for range distance information, "Auto Shot", "Arcane Shot", "Concussive Shot", "Serpent Sting", "Aimed Shot".

- Melee Bar No. : Actionbar page number to switch to when you are in a melee state.

- Range Bar No. : Actionbar page number to switch to when you are in a range state.

- Lock Actionbar During Combat : When checked, your actionbar is locked when a target is selected and you will not be able to change your actionbar page, however rangehelp would still switch your actionbars depending on the range to the target. If it's unchecked you are able change the actionbar page when a target is selected, however, the actionbar page will still switch when transiting from a melee to a range state and vice versa.

- Hide Range Info Frame : When checked, the range information will be hidden.

- Dead Zone Melee Page : When checked, the actionbar will switch to the melee actionbar page when the target is in your dead zone.

- Enable Actionbar Switch : Disable this option if you do not want the actionbar to switch automatically depending on the melee and range states.

- Enable RangeHelp : When checked, rangehelp is enabled. Uncheck this box to disable rangehelp.

- Enable/Disable Custom Range Check Spells : When enabled, you will be able to fill in your own spell names to check for the melee and range states. This is usefull if you plan to use RangeHelp for non-hunters. For hunters, it is recommended that this option is left disabled.

- Customise UI : Click on this button to bring up the Customise UI window.

- Spell Key Bind : Click on this to modify the spells associated with a particular RangeHelp key bind

/rh ui options
==============
In the customise UI window, you will be able to modify the appearance of the range info frame. A dummy range info frame will be shown to preview the changes made. Note that resizing and moving the dummy range info frame will effectively move the actual range info frame.

- Resizable : When checked, you will be able to resize the range info frame by dragging the borders of the frame.

- Movable : When checked, you will be able to move the range info frame to any location on the screen by dragging the frame.

* Note that if both Resizable and Movable options are unchecked, the range info frame will effectively be locked in its place.

- Font Size : By sliding the bar, the font size of the range info text can be increased or decreased.

- Background Colour Lock : When checked, the background colour of the range info frame for all states will be locked (ie the same).

- Border Colour Lock : When checked, the border colour of the range info frame for all states will be locked.

- Font Colour Lock : When checked, the font colour of the range info frame text for all states will be lock
ed.

- Link Background and Border Colour : When checked, both the background and border colours will be locked together.





- Range State : Selecting any of the states will allow you to modify the colour and text of each range states. The dummy range info frame will preview the current colour and text for each selected states. The "All State" option allows the modification of locked colours. 

Once a Range State is selected, you will be able to modify the colour and text of each state by clicking on the "Background Colour", "Border Colour" and "Font Colour" buttons and by editing the "Text" edit box. If either of the buttons are disabled, that means that they are locked together. To modify them, select the "All State" option under the Range State.

On clicking either of the colour modification buttons, the colour picker frame will be shown. In the colour picker frame, you will be able to pick the colour you want and the transparency of the colour. For changes to be recorded, you will have to press the OK button in the colour picker frame. The colour will be previewed in the dummy range info frame as you pick the colour.

The "Text" edit box will allow you to change the text that will appear in the range info frame for each range state. Again, any changes to the text will be previewed in the dummy range info frame.

Changes to the UI will only be made when either the "Apply" or "Confirm" button is clicked.

/rh spell options
=================
In here, you will be able to associate spells to a single key depending on the range of the target. Example of use: a single key that will be able to cast "Aspect of the Cheetah" when the target is Out of Range, "Aspect of the Hawk" when the target is in Long Range, "Aspect of the Monkey" when the target is in Melee/Dead Zone Range.


Before you are able to configure the key association spells, you'll have to bind at least one key to any of the rangehelp keys, ie
1) Press ESC
2) Click on Key bindings
3) Search for the RangeHelp key bind section
4) In this section, you will be able to bind up to 4 different keys to be associated with rangehelp
** Note you DON'T have to bind all 4 keys.


Once that's done, you'll be able to assign the spells to that particular key under "/rh spell".

1) Select the key bind that you'd like to configure from the drop down list. Only the ones that are bound will be listed.
2) Drag and drop a spell or a macro from your spellbook or your macro list into corresponding range box. Note: Only spells from the spellbook and the macro list can be dragged into here. Also, you'll need to DRAG the spell there. It won't work if you click, drag, release and click on the box. 

3) If the checkbox next to the spell box is checked, the spell will be checked if it is in the buff list before the spell is cast. This is to ensure that if the spell is a buff spell, the buff will not be cancelled if the spell is cast again.
4) Confirm when you are done.

When that's done, you'll only need to press a single key during combat to cast a variety of spells depending on your range to the target!

More about RangeHelp
====================
For those who are interested, RangeHelp works by the following sequence:

1) Check if the melee spell is in range. If it is, then you're in melee range.
2) If not in melee range, check if the ranged spell is in range. If it is, then you're in a ranged spell range.
3) If not, check if you are in an interact distance. If it is, then you're in a dead zone.
4) If not, you're out of range.


Enjoy!

Please visit http://www.curse-gaming.com/mod.php?addid=1549 if you have any futher questions.


Credits:
*Speical thanks to Mips as a tester for v4.0.
Thanks to Mips and Corwin Whitehorn for the French translation.
Thanks to Shamane for the German translation. Note: Some abbreviations were used for the German translation (ie. N=AB-Wechsel = ActionBar Switch
														 N = Melee																			 DZ = Dead Zone
														 F = Range)



Ralenod