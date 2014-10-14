FeralSkills v1.5
----------------------------
FeralSkills combines up to 24 buttons into 4, for druids. FeralSkills will work for all druids, not just Feral spec'd druids. This is ideal for mapping to mouse buttons and other devices, where available buttons are not unlimited, but you still want to be able to do every thing. By combining all of your commonly used skills into a few buttons, you're free to do other things like concentrate on movement. Some skills can be cast at the same time as others, in the same button press even, which FeralSKills will take full advantage of. FeralSkills is *highly* customizable, so you will be able to ensure that every time you press a button, it does exactly which skill you intend it to.

FeralSkills provides 4 actions, which do the following:

Maul+:
 Auto-Attack
 Maul
 Growl
 Enrage
 Feral Charge
 Faerie Fire (Feral)
 Demoralizing Roar

Claw+:
 Auto-Attack
 Claw
 Rip
 Ferocious Bite
 Tiger's Fury
 Rake
 Faerie Fire (Feral)
 Cower

Shred+:
 Auto-Attack
 Shred
 Ravage
 Rip
 Ferocious Bite
 Tiger's Fury
 Faerie Fire (Feral)
 Cower
 Pounce

Shift+:
 Bear Form
 Cat Form
 Aquatic Form
 Travel Form
 Mount + [any instant of your choice]


Installation - Copy the FeralSkills folder to your WoW/Interface/Addons/ directory like any other addon, and make sure that it is enabled on the character select screen.

How to Use - Type '/fs' in game to bring up the settings dialog. Here you can extensively FeralSkills, to do whatever you want it to. In the Global tab of this dialog are buttons to Create Macros, either in your global macros, or your character-specific macros, for the basic FeralSkills actions, and individual shifting buttons if you desire. Click the button for the Maul+/Claw+/Shred+/Shift+ macros in either global or character-specific, to create a macro for each of the 4 skills. *You will only need to do this ONCE*, not every time you change the settings. Open your Macros dialog ('/macro'), and switch to the character-specific macros tab if you chose to create the macros there. Drag the 4 created macros from there to your action bars, wherever you want. These action buttons will display the cooldown and energy/rage requirements of the basic skill they are named after. Lastly, place all basic skills that you want FeralSkills to use on an actionbar, anywhere, even hidden. ie, scroll up to page 6 where you never put any actions, and toss them all there. This is important, so that FeralSkills can detect cooldowns, range requirements, and usability of those skills.

Keybindings - Alternatively, you may use key bindings instead of macro action buttons. There will be a FeralSkills heading in the standard keybindings dialog, with the 4 skills under it. There will also be 4 macros for the 4 individual shapeshift forms, if you prefer to use them that way.

FAQ:
Q: Does FeralSkills require any other interface options to be on?
A: Yes, be sure to enable Enhanced Tooltips in the Interface Options dialog. This setting is on by default, so most people will have it on already. If you have it off, an error will be displayed, telling you to turn it on.

Q: I clicked the Create Macros button, but I don't see any macros created. What gives?
A: You're probably looking at the wrong tab of the Macros dialog. There are 2 tabs, global and character-specific.

Q: Shift+ isn't working with certain modifiers. What's wrong with it?
A: Couple things can be going wrong. First of all, shift-clicking any action button picks it up. That's part of the default UI. So you'll need to use a keybinding to use Shift+, or bind a key to the action bar slot that you put Shift+ in, in order to use the Shift modifier. Also, if you're using it via a keybinding, and a certain combination isn't working, check to see if you have something else already bound to that combination. Another option is to use the individual shapeshift buttons, which there are Create Macros buttons and keybindings for.


Version History
---------------
1.5 -
~Updated for Patch 1.11.
~Added a new "FB if it will kill" feature, which will always use Ferocious Bite if the expected damage of the bite will kill the target. This functionality requires MobHealth/MobHealth2/MobInfo, which are now optional dependancies, in order to find out how much health the target currently has. This feature is optional, with a setting for whether or not to use it.
~Added another new feature, Immunity Tracking. With this feature on, FeralSkills will watch for any time your target is immune to a skill you use, make a note of it in your chat log, and remember that that mob is immune to that skill. From then on, it will not use that skill on that mob. Its Immunity Detection is... About 99% accurate. I know of one obscure case where it'll be fooled into detecting an incorrect immunity. In case that should happen, there's a button in the settings (both Cosmos and the options dialog) to reset the immunities list. (My current known exception to the Immunity Detection is if you swipe a demon/elemental that is not banished while an identically named demon/elemental is next to it that IS banished, it'll read the 'Immune' from the banished mob as if it were from the non-banished mob, and think that that mob really should be immune to swipe. If anyone can think of a way of fixing this, or can reproduce any other way to get it to incorrectly detect immunities, please e-mail me at cnervig@hotmail.com)
~Added much more customizability to when shifting happens. Whenever you try to shift into the form you're already in, you can choose to either Do Nothing, Shift to Caster, Prowl (for Cat Form), or Enrage (for [Dire] Bear Form). Your choice for each form can be different. Additionally, you can turn on or off automatic shifting to the appropriate form when you try to Claw+, Shred+, or Mault+. These customizations should help alot, especially for users of extremely customized UIs.
~Other Bears are consider 'High Armor', in regard to taunting, and bleeds.
~Fixed a couple bugs with Cower. It will now not cower against player 
~Added /feralskills as a 2nd slash command, since /fs conflicts with another addon or two. /fs will still work for most.


1.01 -
~Fixed a small bug that caused it to break in 1.10. Should work in 1.10 PTR and release now. Also, in 1.9, you'll need to use the 'Load Out Of Date Addons' option in the Addons dialog.

1.0 -
~FeralSkills is now included with Cosmos.
~Fixed a bug that caused energy checks to evaluate to 0, resulting in Tiger's Fury being used way too often when 'extra energy' was enabled.
~Added individual macros/keybindings for the 4 shapeshift forms.
~Added a new page to the settings dialog, with the different macro creation buttons, and a checkbox for the aformentioned Don't Auto Re-target feature.
~Added a new setting for Growl, to not growl if the target's target can handle the aggro (defined as being a paladin or warrior with at least 40% health). This is quite useful when there are more tanks than just yourself, so you don't waste your growl on a mob that one of the other tanks is already handling.
~Added a check on Demoralizing Roar for Demoralizing Shout, the Warrior version of the spell, since Demo Roar won't override Demo Shout.
~Modified the High Armor check to include plate targets up to 7 levels lower than you, and non-plate targets down to 3 levels higher than you.

Public Beta 5b -
~Fixed another oversight that caused Rake to reapply itself when the target was already raked. Double Oops. (I redid a bunch of the code, completely reworking how it uses settings, so missed a couple things when transfering it over, thanks for helping me catch em!)

Public Beta 5a -
~Fixed an oversight that caused Tiger's Fury not to work with Claw. Oops.

Public Beta 5 -
~1.10 support! Got onto the test server and tried it out, and fixed a small bug causing the whole thing not to work in 1.10. Give it a try on the test server. It's still marked as being for 1.9 though, so you'll need to use 'Load Out of Date Addons' on the test server.
~Khaos support! If you use Khaos (the configuration core of Cosmos), you should find FeralSkills as one of the addons it will configure. This allows you to have multiple settings profiles as well, so you can switch to a different profile for a different situation. Khaos is NOT required; you can still edit your settings using the normal /fs dialog.
~The standard settings dialog should now scale properly.
~Split the Create Macros button into 2 buttons, one to create the macros globally, one to create them for only the current character.
~"High Armor" not takes level into account (for warriors/paladins, must be 5 levels below you or higher, for anyone else must be 2 levels above you to be considered 'High Armor'). I'd like to expand this more some other time, and even make it customizable, but for now, it should do. No more raking the more leper gnomes as you lead your lowbie friends through gnomeregan. :)
~Added a MinRage setting for demoralizing shout, so that you can Maul first, then Demo shout when you've got a bit of rage to spare. Also moved its priority up a bit so that it'll override swipe.
~Added a feature to not auto-target the next mob if your target is dead, or you don't have a target. Should make it so that you never accidently spam the button one too many times as the target is dying, making you instantly FF some mob in the next pull, or even worse, feral charge them. (I did that one too many times too, guys.) :)
~If everyone could try this version out, and let me know of any issues you find, asap, I'd really appreciate it. I'd like to get one more version out before 1.10 hits (no new features, just polish and bugfixes).



Public Beta 4 -
~Localization. FeralSkills is not experimentally localized into French and German. I have no way to test this though, so I'd appreciate any feedback regarding how this works for you. To clarify, the text in the settings dialog is not localized yet (that's a less important task, for a later beta), but it should at least function properly on foreign installations of WoW. If you are able to provide translations for Korean, please e-mail me at cnervig@hotmail.com.
~Bug fixed with Pounce - previously, pounce would not work if you didn't define a modifier key for use with it. Now if you check the box for Pounce, but don't check the box for a modifier key, it will pounce every time instead of Ravage.
~Bug fixed with Growl - previously, stunned mobs, and mobs not in combat would be considered aggroed on someone else, and growl would fire at them, while the setting for 'Growl only when I don't have aggro' was checked. Now growl will fire when you have that box checked, and the target is attacking anyone besides you.
~Bug fixed with Faerie Fire (Feral) - Hopefully this should solve the issues with Faerie Fire (Feral) that most people were having. If you still have problems with it, and also use the addon CastOptions (part of Cosmos), please upgrade to the latest CastOptions. If you still have problems with it, and/or don't use cosmos/CastOptions, please e-mail me at cnervig@hotmail.com.
~Modified error messages to be a bit clearer, and provide the solution to fix them. (ie, turn on Enhanced Tooltips!)
~Bug fixed with Ravage - won't tell you to put it on your bar if you're under level 32. In the rare case that you just turned 32 and haven't trained yet... go train!... Or put up with the errors until you do.
~Misc Bugs that I can't recall specifically.


Public Beta 3 -
~Fixed a problem with casting Faerie Fire.
~Fixed a bug with properly saving the value for Max Target Health for Ferocious Bite.
~Added some debug code so that if an error happens, it'll dump a bunch of junk to the chat window which I'll understand. If you do happen to hit an error, please screenshot it and mail it to cnervig@hotmail.com.
~Added functionality for casting Enrage or Prowl if you attempt to shift to cat/bear form and are already in that form. This is off by default, but may be turned on in the Shift+ settings panel.
~Added some functionality to sabotauge DruidBar when it feels like being really stupid. (To the author of DruidBar: Attempting to identify an action as being a shapeshift based only on icon was a *really* dumb idea, especially when it's turned on by default, and there's no visible way for the user to turn it off.)


Public Beta 2 -
~Now finds shapeshift form IDs by name, rather than just assuming bear=1, aqua=2, cat=3, travel=4. This should solve the problems encountered by druids that skipped forms (ie, didn't do the quest for aquatic form)
~No longer casts Faerie Fire (Feral) while prowling, from Claw or Shred.
~Demoralizing Roar works!
~Now looks up the proper macro icon ID by name, rather than just assuming everyone has the same icons that I do. (still don't know why people have different icon indexes...)
~Added a note in-game in chat reminding users to put skills on a hotbar somewhere, whenever it tries to use a skill and can't find it.
~Fixed a problem with properly detecting debuffs on the target (may have caused Rakes or FFs when not intended)


Public Beta 1 -
Initial release



Contact
-------
Please contact me with feedback at cnervig@hotmail.com, including bug reports and feature requests!