TotemTimers AddOn 8.26.2006 (Totem Timers and Notification)
FYI this is a beta release as I am unable to test the code for the trinket.

Insomniax & ShardTracker Users!
--
If you are having problems getting TotemTimers to work with Insomniax or 
ShardTracker, please edit ShardTracker.toc and add TotemTimers to the 
OptionalDeps line.  Aparently ShardTracker does not properly hook the 
casting functions and therefore TotemTimers never recieves notice that 
a totem is being cast.  This edit should resolve your issues.

Upgrading
--
As a precautionary measure, please do '/tt reset' when upgrading.

Introduction
--
This is my personal implementation of TotemTimers.  Its a little more
full-featured than what i've seen available.  It provides an expiration and
destruction notice and provides a transparent background totemtimers frame
which can be enabled or disable.  You can even disable and enable the
expiration and warning messages.  Right now the message is static and
hardcoded into the code but if you are that interested you can hack the code.
I haven't had time to add commandline parsing for anything besides these
really simple commands but the next step is VERY easy and i'll be working on
it as soon as i get a chance but right now i like where the AddOn is at.

New:
Command Line Configuration

Features:
Tooltips
Raid Support
Movable Icons
MultiShaman Support
Various Icon Arrangements
Custom Totem Ordering
Fixed or Dynamic Totem Buttons
Click to Recast
Totem Expiration Warnings / Notice
Damage Tracking
German Goodness (Thanks to Oliver)
Thanks to Danemo for help with the trinket translations in German
Thanks Tenebrok for the fixes with French translations

Configuration
--
To configure you can use the commandline now.  Here are the commands, also 
available by tying /tt or /totemtimers in-game.

TotemTimers Slash Commands
/tt <setting> [option]

show / hide
  -Show TotemTimers

hide
  -Hide TotemTimers

lock 
  -Lock TotemTimers Position (Clicking Recasts Totem)

unlock 
  -Unlock TotemTimers Position (Icons Draggable)

arrange [horizontal|vertical|box]
  -Set the arrangement of the TotemTimer icons.  There are four buttons
   that can be arranged horizontally, vertically or in a box of four.

align [left|right|top|bottom]
  -This sets the alignment.  This option varies depending on the arrangement
   you have going.  Left and Bottom are the same, as are Right and Top.
   The only case where this really matters is when the style is set to "buff".
   It is suggested you leave this on left.

warn [on|off]
  -Turn Expiration Warnings On/Off.  When a totem has 10 seconds left ( 5 
   seconds for Magma Totem ), TotemTimers will display a warning message 
   above your character.

notify [on|off]
  -Turn Notifications On/Off.  When a totem gets destroyed (damage or timeout),
   TotemTimers will display a message above the character.

style [buff|fixed|element|sticky]
  -Set the icon style.  Buff simulates the blizzard buffs which vary based on
   how many buffs are currently active.  Fixed creates space for four icons
   and each icon pops up at the same place all the time, if a certain element
   does not have an active totem, the icon place is left blank.  Element is
   similar to fixed except that when the totem is not active, a generic icon
   is used as a placeholder.  Sticky (default) shows the last totem of that
   element that was used (faded to show that it is not active).  This allows
   you to click-recast the totem even if it has expired.  Note, sticky will 
   not show an icon until a totem is destroyed or has expired.

time [blizzard|ct]    
  -Set the Time Format.  Blizzard is the default Blizzard style ( 3m ).  
   CT style is like a normal time format ( 01:39 ).

order [element1] [element2] [element3] [element4]
  -Set Totem Ordering.  Air / Water / Fire / Earth are possible elements.  
   Beware that you should always specify all elements if you want TotemTimers
   to work correctly!


ChangeLog
--
ChangeLog

8.24.2006 - Thanks Sayclub for these on 8.24.2006

8.23.2006 - When you die the totems reset.

8.22.2006 - Fixed TOC to 11200

7.2.2006 - Fixed new talents with help of Quidel of Hellscream.

06.21.2006 - Fixed anchor problem and fixed timers for patch 1.11. 

06.20.2006 - Patch day!! Updated TOC and I never figured out what the heyfool.wav is so I removed it cuase it was just bloating filesize.

2.1.2006 - Added Support for realms with AQ open for new GoA & SoE totems.

4.2.2006 - Fixed for French Client

3.29.2006 - Fixed for 1.10. Thanks to Aeith for the .xml help

2.14.2006 - Changed German trinket name. Hopefully fixes that.

2.11.2006 - Changed it back to "Erd". Let me know if it is still not functioning.

2.10.2006 - Changed TT_EARTH = "Erde" instead of "Erd". Still working with the German client on water/Ancient Mana Spring totem.

2.1.2006 - Fixed Interface version to 10900 & repaired a syntax error with the German and French clients.

Added Tranquil Air to Melki's Totem Timers 6.7.2 (Beta 5)
All totems should be supported now.

--  NEW AUTHOR --  Zulah Takes over.
--  NEW AUTHOR --  Zulah Takes over.
--  NEW AUTHOR --  Zulah Takes over.

 2.14.2006
2005-11-23
Moved the Totem Data into a seperate file, and added support (cross your fingers) for the new trinket. 


2005-11-13
Fixed cast spell by name hook so this addon should now work with frowning circle. My apologies for the original code I sent to Melki being broke. Added German Localization from http://mitglied.lycos.de/jefferson_/temp/totemtimers.zip.

2005-10-20
- Updated TotemTimers for 1.8
- Thanks to Grumpy Walker, TotemTimers should now work with some of the more
  usefull totem addons.  (Can't even remember which one he was using).  Anyways
  i had forgot to hook the CastSpellByName function (i never use it) but macros
  and a few addons do.  So its there now!  Whooop.
- Again, i've kinda decided i don't have the time to _really_ put time into this
  addon so people are welcome to take this off, or send me patches etc etc and
  if they're not too much complicated re-writting or anything i'll throw them in.
  Maybe i should make this a sourceforge project like a lot are doing.

2005-09-17
- Sorry for the delay folks, I left on patch day for the CMJ fest in NYC.
- The regex should be fixed up.  Thanks to Mekhazzio and everyone else that 
  sent some feedback with the 1.7 changes.  Good call on the regex.  My machine
  seems to handle the old regex fine but in some cases it would expand that out.
  Stupid of me, even though i hate to admit i was wrong ;)
- Think i fixed the German ordering issue.  Test it out.  I had forgot to update
  something in version 6.0 that was effecting where the order was being
  saved.  Should be golden girls now.


2005-08-30
- This should properly add checks for configuration data related to the
  totem order.  I believe this was just because of the way because of 
  differences between the US and German clients.  It should be resolved.
- When playing a non-shaman character, the addon should be completely 
  disabled.  There still may be an issue between when the variables get
  loaded and when the player enters the world.  If you still get errors
  let me know.


2005-08-29
- Missed checking for a null value error on line 710, this should fix it.


2005-08-28
- German is _completely_ translated thanks to Oliver, AGAIN!  What a trooper.
- This is it for a while if there are no major bugs.


2005-08-27:
- Made minor modifications to the French localization so it should be easier 
  to translate for whoever wants to do it.
- Previous totems in the sticky style setting will now be saved when you 
  logout or zone.  However, the times will be reset so if you cast and 
  relog real quick you won't have your timers.  Sorry!


2005-08-23: 
- New major version.  I revamped the options dialog along with adding a box
  layout (thanks for the idea Fobia!).  
- New styles have been added!  Please review the slash commands revamp above.
  You can now have the totems locked and unlocked as well as deciding which
  kind of view you want.  Element placeholders, sticky icons, no placeholders,
  or blank spaceholders.
- There is no longer a need to use the Extended Tooltips option.  Booyah!
- Resolved the Insomniax compatability error.  Not my fault!  Please read
  above.
- Still can't figure out what error you guys are having with range.  I put 
  down a bunch of totems, zoned, ran, did everything i could think of 
  to try and get this error out but it never occurred for me.  Who knows,
  maybe when I made these changes i fixed something up.  Sorry if it 
  still doesn't work.  Maybe you could give me the error?  If you DID
  post the error already i might have missed it when i was on vacation.
  I'm actively checking cursed-gaming and my e-mail so please repost.


2005-08-18:
- Updated the frost resistance and fire resistance icons.
- Testing galore!  I tested a bunch.  I haven't found the roots of any problems
  that have been tested.  REALLY SORRY!!! ahhh, please try to pinpoint this 
  more.  


2005-08-11:
- Fixed this bug with self-cast.  Blizzard added a paramater to a function
  that i wasn't handling.  I think everything is fixed and thank you very
  much to Mahler.  I'm still out of town but i wanted to get this fixed.  


2005-07-19:
- Patched changes for 1600.  There was some extra damage information
  being reported in the chat messages that should be fixed now.

- Frost/Fire resistance icons were updated and they should now match
  up.

- Thanks to everyone who is using the AddOn.  Like i have said before,
  i'm off playing a priest now (blasphemy!) but there was a huge response
  with the new patch so I wanted to get it working for the people who 
  were using it.  I also fixed a few extra things that should've been
  updated (regular expressions that needed updating).  I'll be out of 
  town for a month, i'll check in every once and a while.  Enjoy.

  PS: If your self-cast stops working (i noticed errors of my own with 
  selfcast delays) i am still not sure how to fix this.  I'm also not 
  quite sure how to fix the extended tooltips thing.  I know it can 
  be done (i believe CT has a work around) but i'm too busy right now
  to dig through their code.  Sorry guys, use Telo's self-cast addon 
  and keep the extended tooltips on.  Lets call it a feature?

2005-06-13:
- Fixed some french support

- Hopefully i fixed some of the actionbar error problems.  I think its 
  all due to a race condition between casting a totem and it registering.
  I think i've run to the end of what i can actually do without causing
  more problems and overhead.  I'm already very cautious about hooking
  the casting functions.  Totem support is just a hack to the whole arena
  of things that _should_ be in the game already.  Hopefully this fixes
  the problems people have been having.


2005-06-02:
- French Localization Should Work!!!! (thanks Islorgris & bloodix)


2005-06-01: 
- Complementary release.

- German translation is working i think.  Oliver sent me a patch file for 
  localization and I haven't heard anything from him that says otherwise.

- I don't have support in this program for any other mods i don't use.

- I'm willing to let someone help patch this up and such cause i've put 
  my shaman on hold for a while.  I login to test this stuff but no idea
  about the real world.  I've tested damage and all that, but there are
  so many different variables in this program.  If you update anything, I
  would be willing to put you no the list and put up new versions.


2005-05-20:
- German translation is broke again.  I did a bunch of updates and i haven't 
  had time to talk with Oliver.  I think he has a working copy, but this is
  beta.

- Multishaman support is the only support now.

- TotemTimers should now work great with multiple shamans and not goof up
  your messages or your timers.  

- Tooltips!

- Time format can be made to match Blizzards.

- Recasting is based off the level you casted.

- I no longer parse chat messages except for damage calculation.  I am now
  hooking the casting function to get all the spell information.  I think
  it works ;).

- Eventide is now automatically calculated.  BOOOYAH!

- TotemTimers is now disabled when you are not playing a shaman. However,
  its always the same between shaman.  I'm not going to go based on server
  and player. 

- Unfortunatly(sp?) i haven't had time / urge to play my shaman.  Busy with
  real life / drinking / work and as such i've kinda ignored development.
  Best way to get stuff fixed is to e-mail me, as i've stopped checking the
  ui sites partially but i'll try to keep up.  Let me know.

- This is a beta, use at your own risk sucka!


2005-05-08: 
- Regular expressions for the German client has been updated and I believe it
  to work better.  This includes some internal changes so we might be chasing
  some bugs down soon.

- Added MultiShaman support.  This should remove the totem destruction spam
  everyone was seeing and make the totem timers work better overall.  This
  means, you shouldn't see anymore interference with other shamans.

- When TotemTimers is unlocked you will now see icon placeholders and the name
  of the element that placeholder is representing.  Feel free to leave it
  unlocked, it will still work the normal way, but you will lose click to 
  recast ability.


2005-05-06:
- German Translations / Compatability fully working.  All you German shaman
  should give it up for Oliver.  If it weren't for him this thing would have
  never worked.


2005-05-06:
- Added ordering

- Overhauled the slash commands

- Added fixed locations for totem timers

- Recasting still wasn't working.  I figured out it was a loading type error
  which has been resolved.  

- Some other stuff.  I really can't remember.  It should all be available.
  Oliver is gonna kick my ass for making him do some over again.  Hopefully by
  4.2 we'll be able to say German translation is fully working and in there.
  Ugh, i changed too much.  I don't think i'm going to be adding features for
  a while.  If someone wants a feature then code it up and send it to me.  

- Added eventide timer updates.

- I think i'm losing my mind.


2005-05-06:
- There was a problem with the recasting function.  Basically, indexing the
  spell list.  Anyways i fixed it up i think and it works US again.  I think
  they ninja changed a few function's functionality and it messed things up.

- Still working on german translation stuff.  I think this fix should resolve
  some issues we were having.  I have faith this fix means it DOES work 
  on German clients.  Sorry for so many updates the past few days.

2005-05-05:
- Updated the localization.  German version wasn't working properly due to me
  using GetLocale instead of actually calling the function GetLocale().  Sorry
  about that.

- There was a recasting error with the Totems for the german version too
  (recasting function where you click and it recasts?  we'll all famaliar?)
  anyways, names are formed differently "Totem _____ V" and in the US we use
  "____ Totem V" so ... anyways, it should be fixed.  If you're getting a nil
  reference let me know.

- Beta French translations are in.  If it all works then great.  If not
  someone in france fix up localization.fr.lua please :)


2005-04-01:
- The TotemTimers can now be oriented vertically or horizontally (see the
  in-game help /tt)

- German Localization has been added but not tested, please e-mail me
  feedback.

- Locking the toolbar makes it so clicking the Totem icon will recast that
  Totem type with the max level you have available.  (There is no way to see
  what level totem is being cast).

- Fixed the low-level Stoneclaw Problem.

- Minor Bug Fixes.


2005-03-23:
- Updated the Totem Icons for the latest patch.

- Updated to 1300 version.

- Added slash configuration commands.


