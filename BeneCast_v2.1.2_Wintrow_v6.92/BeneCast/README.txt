BeneCast - by Skurel
updated by Wintrow

____________
|INTENTIONS|
------------
By Wintrow. I will try to update this Readme to the current up to date version with
as much respect to Skurel as possible. Still, original text might get deleted and new one added
without indication who wrote what. This is to enhance readability over completeness.

My goals in keeping BeneCast up to date are (not in that order):
- fix bugs (naturally)
- add features needed due to patches (like new spells)
- add features that do not pervert the intention of BeneCast
  That means: No directly offensive spells!
  For instance: while 'Rapid Fire' or 'Rockbiter Weapon' improve your fighting abilities
  they do not directly damage anything. You still have to do that yourself.
_________
|WEBSITE|
---------
http://asuaf.org/~skurel/   (original version)
http://ui.worldofwar.net/ui.php?id=2375  (updated version)
_______
|EMAIL|
-------
skurel@gmail.com
ex__inferis@hotmail.com  (Wintrow)
_________
|VERSION|
---------
2.1.2 BETA - 03/12/2006
2.1.2 BETA Wintrow 6 - 26th of april 2006
______
|TODO|
------
Paladin spell lists are be too large for the Options.
The interface art needs to be updated to allow for the Paladin spell list
as well as the Greater Blessing names.

After Mend Pet and Health Funnel, more pet spells. Bestial Wrath comes to mind.

Raid buttons still seem to have a few interesting properties. As
described in the quirks section. I'll try working them out. Details or
ideas on these things would be greatly appreciated, since I don't raid yet (too low level).

Along with the current flashing of HoT-buttons when the HoT is active on the target
an estimate for how long it's gonna last. Usefull for upkeeping HoT's on tanks with the
least possible overlapping. Might use CT_RA's channel to communicate castings to other healers.

Selection of preferred target to execute bindings. Now uses a 'Smart mode'.
If target = friendly, heal target
If no target, or not friendly heal self

For pallies: Set a blessing as preferred for a specific person/pet. Say, you have a friend
druid named Wintrow :p. Wintrow likes to go Cat Form for some nice damage or Bear Form for tanking.
Wintrow is Resto-specced and likes to heal as well. Therefore both Blessing of Might AND
Blessing of Wisdom are usefull to him. If you group with him and he's main healer set BoW as
his 'preferred blessing'. This way, BoM will be hidden as long as BoW is his preferred blessing.
This will require a sub-categorising of the Blessings of course so BoP isnt disabled while BoW is
active. Also, YOU define what is preferred, so Blessing of Salvation is possible as well.
________
|QUIRKS|
--------
The Standard UI raid Pullout frames act a bit strange if there the same
raid member is represented multiple times. The BeneCast buttons will
always appear on the newest pullout frame with that raid member.

Healing those outside of your party/raid does not have accurate healing as
the WoW API does not allow one to know their exact health, rather you only
know their health percentage.

The spell name to select a spell line often does is not the strongest
spell in the spell line. For instance Purify will show instead of Cleanse.
Selecting a spell in a line will allow you to cast any spell in the line,
allowing Cleanse to be cast from the cure spell line in Paladins and Greater
Heal to be cast in the Priests Heal spell line.

It seems BeneCast responds to events before CT_RaidAssist. This causes
BeneCast to move around buttons and CT_RA frames before CT_RA handles it's
frames. You can fix this by rechecking a raid option button in the BeneCast
Raid tab.

Changing the layout of buttons for raid members can cause some interesting
layout problems. Raid member frames will move/hide based on the buttons
for the raid member before them. I recommend that the preferred raid snapto
be selected before entering a raid.

Sometimes a raid member's buttons "switch" with another raid member.
Clicking on a button for member A will cast on B and clicking a button on
member B will cast on member A. Are the buttons just attached to the wrong
spot? I don't know, I've never seen it. If you right click on the border
around the buttons it should have the name of the person those buttons will
cast on. So, is the name on displayed in the right click menu the name of
the person the buttons are attaching to or the person it's casting on?

Binding casts can also make use of the shift, control, and alt modifiers.
But in order to do so, there must not be anything bound to a key modifier +
the binding you set for the binding cast. So if you have a binding cast to
'Q' if there is a binding for SHIFT+'Q' then BeneCast will not see the 'Q'
binding and make the desired action.

People are getting random crashes (WoW exiting to the desktop). Mostly it's
about some 'memeory cannot be written'. I am stumped why this happens.
Especially since it only affects a certain group of players and then not
every time...
The most recurring one is:
A priest groups with someone else and then crashes
As far as I know it's when a table-variable is being written to on an index = 0.
______________________________
|THINGS I'D LIKE BUT WON'T DO|
------------------------------
These are things I will not work on. Someone else is welcome to try their
hand at playing around with BeneCast to get these to work.

Range detection on spells, so that they can be shaded when out of range.

Shade buttons based on current mana.
_____________________
|ADDON SUPPORT LISTS|
---------------------
Unit Frame AddOn Support list:
Nymbia's Perl 1.2.3b 
Perl Classic .30
MiniGroup vK0.4b
MiniGroup2 (Ace) 2-34
Nurfed Unit Frames v10.14.2005
Discord Unit Frames v2.3
Noctambul Unit Frames 1.2pre7
WatchDog Unit Frames 1.15
SAE_PartyFrame

Raid AddOn Support list:
CT_RaidAssist 1.45

___________________________________________________
|ADDING SUPPORT FOR YOUR FAVORITE UNIT FRAME ADDON|
---------------------------------------------------
Open up BeneCastSnapTo.lua in your favorite text editor and get cracking!

First we must make a table entry for the AddOn. You can just copy one of
the existing tables and use it for your AddOn. Change the name of the
entry to BeneCast_SnapTo.<ADDON> and you've got your own table entry.

Next you need to determine the AddOn name. This is the same name as the
name of the directory(folder) of the AddOn. Make the AddOn part in your
table = to the name of the AddOn. For example: AddOn = 'BeneCast',

The final part is the most tricky. You need to open up the various XML
files in the AddOn and find out what the names of the unit frames are.
We only want the names of the frames you want BeneCast to attach to.
Usually the player frame, party member frames, and target frame.

The name will be declared in the angle brackets of an XML frame object.
Example: <name='PlayerFrame'> There may be other stuff in the angle
brackets, but that's ok. All we want is the name. Often there are
comments in the XML to identify the frame. Comments start with <!-- and
end with -->

Once you have the frame name just find set the BeneCastPanel in your
table entry so that the frame = the frame name. Example:
-- Player Frame
BeneCastPanel1 = { yadda yadda yadda, frame = 'PlayerFrame', yadda yadda yadda},
The point is the attachment point of the BeneCast Panel, and the
relativePoint is the point on the frame where the Panel will attach. You
can offset this by changing the x and y values.
______________
|INTRODUCTION|
--------------
BeneCast is a tool to help the player cast beneficial spells on themselves, 
their party members, and friendly targets. It does so by allowing the player to 
pick and choose what spells they want to show up as clickable buttons from the 
BeneCast interface. The interface can be accessed by clicking on the BeneCast 
button on the Minimap frame, it should look like a little book in a circle.

Who can use Benecast? Everyone!
_______
|SETUP|
-------
To use BeneCast, simply unzip the contents of this zip file into 
C:\Program Files\World of Warcraft\Interface\AddOns\
Replace C:\Program Files\ to the directory you have your World of Warcraft
installed if it is different. There is no need to configure any of the files.
Be sure that within the AddOns directory all the files are in a BeneCast
directory.
_______
|USAGE|
-------
Open up the BeneCast interface by clicking the BeneCast button on the Minimap
frame. You can also specify a key binding for the toggling of the interface.
There you can check what spells you wish to show as BeneCast buttons for
the Player and class frames. Each tab at the side of the BeneCast interface
corresponds to a different class, spells configured for that class will appear
for that class. The first tab is the player tab, which will have your name in the
tooltip. If you want, under the player tab you can specify to have changes in the
configuration of the player to apply to all classes. Note, this chages the
settings for everyone for fast basic party configuration!

Party Notification options are located in the Notification tab. Only one channel
can be selected at a time. The self channel only gives feedback to the player.
Check what you wish to allow to show in the Notification channel.

There are a number of other options in the Setup tab. You can determine what each
option does by reading the tooltips that appear when you mouse over them.

BeneCastPanel frames can be moved. They are locked into place, but can be
unlocked by right-clicking on the BeneCastPanel(not the buttons) and clicking on
the locked option in the dropdown menu. Note, that the name of the associated
member is also shown, to help you keep track of whose buttons you're moving.
After the frame is unlocked you can left-click and drag the frame where you like.
To lock the frame right-click on the frame and click on the locked option in the
dropdown menu. The BeneCastFrame can also be moved, but it does not lock into
place. You can also move the MiniMap button if you unlock frames in the Setup
options.

Heal spells always show up on the frames you specify, save for group heals.
Group heals will only show under the player frame, unless the healer is a Shaman,
in which case they can choose who to cast Chain Heal on. Heal over time spells
flash when the associated heal effect is on the member. (Note, this only occurs
if the default buff/debuff icons of the player are NOT hidden)

If you happen to have Nature's Swiftness, holding down the alt key will cast
Nature's Swiftness before casting the heal. It will automatically try to cast
the strongest heal it can when doing this.

Buff spells will only show when the associated member of your party or target do 
not have the effects of that buff on them. It does not take into account the 
strength of the buff. If you can cast a better buff on the target it will not
show the button, I leave this out for now because tooltips of a buff icon will 
not take talents into account.

Cure spells will only show when the associated member of your party or target 
has an effect on them which you can cure.

A maximum of 10 buttons are shown at once. The precedence in which they are shown are:
Heals
Buffs:
   Buffs
   Party Only Buffs
   Self Only Buffs
Cures
	
Mousing over the spell buttons show the tooltips for the highest rank spell you can 
cast with the mana you had when you moused over. The lower your mana, the lower the
spell rank of the spell in the tooltip.

To cast the spell you want, simply click on the BeneCast button which has the 
texture of the spell you wish to cast.

Strength of a spell is based on various things:
The default strength of the heal spells is the maximum strength you can cast at your
current mana. Holding down the shift key while clicking causes the strength of the heal
to be based on the current health of the target you wish to cast it on. The shift
functionality can be switched under the settings tab in the BeneCastFrame by checking
the Damage Based Heals button. There is also a lower bound on all heal over time spells,
making the target unable to receive a heal with a spell level greater than their level
+ 10. In addition there is a overhealing option which allows you to add ranks to the
spell that would normally be cast. This is done by holding down the control key. If
the Overhealing option is checked in the options then it will automatically overheal
and holding down the control key will cause it to cast without overhealing. The
number of ranks to overheal is set by the overheal slider.

The strength of a cure spell is always the highest possible strength. Since the mana
cost of all cures have been made the same there is no reason to cast a weaker cure.

The strength of a buff is always the highest strength possible for the target. 
This also has a lower bound based on level. The target cannot receive a buff 
with a spell level greater than their level + 10.
___________
|DONATIONS|
-----------
If you'd like to send a donation I certainly don't mind!
You can donate via PayPal to skurel@gmail.com
_________
|CHANGES|
---------

- Utter configurability of W.6. See new tab. You can specify to what and how buttonbars snap to
  a frame. This is really for those Unit Frame-addons that don't have pet frames or that are
  unsupported for now.
  May or may not work yet :)
- dropdown menus work again !! Snapto, RaidSnapto and the rightclick-menu
  on the buttonbars themselves. Thx @Nobula !! Backported to 5.10.
- Reload_UI should work now w/o errors
- Better snapping to RAID-thingies (i hope)
- Added Prayer of Spirit, -of Shad. Prot., Power Infusion and Spirit of Redemption.
- Attempts at fixing crashes. Thx Tayeaden !
- Priest's Abolish Disease is now a different spell.
  So the priest will now see 2 cure buttons. This is because they have a different mana-cost.
- Consolidate/improve event-listening/handling (maybe improve handling during zoning).
  Stops listening to certain events when zoning and then start
  listening again when zoning is done.
- If unselecting 'Damage Based Healing' the priest's Heal/Lesser Heal/Greate Heal are split
  into 3 spells. Experimental. Procedure: Unselect, log off and in, check desired heals.

For W.6 I switched to a Beta-system. W.5.9 seemed to perform adequately while W.6 was a big leap forward.
Consequence was that the 6.x-BETA is dragging on for quite a while. Also because I refuse to release it
untill all of the features that I added in 6.x work to my satisfaction.
I backported one simple, but very handy fix from 6.x to 5.x thus creating 5.10.

v 2.1.2b.W.5
- Faded out buttons visible in animal forms should not remain faded anymore.
Benecast always hides all buttons before showing them. So W.5 hides the fading there too now.
- Added slash command for debugging on/off:
/benecast debug: this will toggle debugging (default is off,
  but the setting will be remembered across sessions)
- Added debugging code in the select-panel-snap-function.
- Added slash command for setting the snapto:
/benecast snapto <addonname>: this will try to snap to the unit frames of
the addon provided. <addonname> should be replaced with whatever benecast
is putting in its dropdownlist.
- Fix for non-working Moonkin-balance-buttons introduced in W.4
- Fix for Divine Spirit Rank 4
- Fix for dropdown-menu's (snapto, raidsnapto and right-click-menu on panel)

v 2.1.2b.W.4
- Fixed stupid mistake introduced in W.2. The cure poison/curse buttons
were visible in animal (when being poisoned/cursed), but NO buttons were
visible in caster form. This time I was able to test my version --> it works
- Balance spells in moonkin form. I don't have Moonkin (only L36) -->
  pls anyone test this?
- TOC updated
- Shows the Wintrow-version in the title of the optionsform :D

v 2.1.2b.W.3
Prevent nil-error if Benecast can't determine to which frames it
should snap it's raid-buttons to.

v 2.1.2b.W.2
Moved 'b' in version numbering to the 2.1.2-part :p
Visible (but non-clickable) Cure-buttons in animal forms. This way you can
easier see if you need to shift back to human for a quick cure. I hope...
I am certainly trying for them to be faded out.
Try pls. Totally untested for now.

v 2.1.2.W.1b
Trying to fix partypet-support. I never seemed to get button bars when a hunter
with pet joined up. So here it is. Programmed it at work,
tested it at home and it seemed to work.

v 2.1.2
Added AQ ranks
Fixed parsing error with some spells
Fixed some bugs regarding weaponbuffs
Reworked how raid frames are snapped to
Added a +healing bonus scanner for damage based heals
Fixed a typo for showing pet buttons

v 2.1.1
Added SAE_PartyFrame support
Fixed a parsing error in German clients
Made it so the Paladin tab displays correctly for Alliance characters
Fixed the error where friendly Hunters doing Feign Death were considered dead
Fixed the possiblility of an old spell showing if a friendly unit is dead and
resurrection spells are not being displayed.

v 2.1.0
Fixed a typo that caused Dispel Magic to cast on a hostile target rather than
the intended target
Fixed a problem with spells that have no mana cost
Fixed healing friendly targets outside of your party(including party pets)
Raid button optimization
Added Weapon Enchants for Shaman and Human Priests
Added Omen of Clarity
Added the ability to cast Nature's Swiftness just before casting a heal with
a cast time if the alt key is held down (also forces a max heal)
German localization added
Added support for Noctambul Unit Frames 1.2pre7 and WatchDog Unit Frames 1.15
Added options for showing pet and raid buttons

v 2.0.3
Fixed a problem with BeneCast_UpdateButtons being local, which broke
the toggling of showing all buffs
Fixed mana shield's level table
Fixed a few errors with binding casting
Fixed the hiding of blessings when the same greater blessings are active
Added Greater Blessing of Sanctuary
Fixed errors associated with CT_RaidAssist 1.5 not loading the standard UI raid
I think BeneCast should work with Perl Classic now
Changing the SnapTo menus now update buttons

v 2.0.2
Fixed hide minimap button to actually hide the button :p
Added support for a few more Unit Frame AddOns

v 2.0.1
Fixed configuration reset when run for the first time

v 2.0
Chews up less memory
More efficient method of handling events
party pet, raid member, and raid pet buttons added
Dragging frames is more responsive
Added Touch of Weakness, Arcane Brilliance
Added Resurrection buttons
Added Assist buttons
The highest available cure is now cast since mana costs have been normalized
Added new Paladin spells in 1.9
Holy Shock is now a heal and has been added
Added options to allow anchoring the Panels to various unit frames


v 1.152
Fixed error with group buttons out of range
Fixed error when loading BeneCast without configuring it
Changed frame borders around the buttons back
Made Frost Ward and Fire Ward self buffs and both hide if one is is active

v 1.151
Fixed error with HoT buttons
Changed frame border around the buttons

v 1.15
toc number changed to 1300
Changed the color of the frame to the default tooltip border to better blend
	with the default UI.
Attempted fix for unclickable buttons
Fixed ordering of deterimining cures in order to have PW:S hide when weakened soul
	is in effect on the intended target
Made Dampen and Amplify Magic party only
Side tabs
Setup based on class
Option for showing tooltips and showing only the spell name in tooltips
Added an option to make button frames movable in the Setup tab
Added overheal functionality when doing damage based healing
Added the option to always overheal when casting heals based on damage
Added a slider to specify the number of ranks you wish to overheal
BeneCast target buttons now show for party members
No longer loses the current target if the target is friendly but not the
	recipient of a spell
Ensured the BeneCastMinimap button would be above the minimap frame
Added spells: Barkskin, Mage Armor, Gift of the Wild, and Prayer of Fortitude
	Gift of the Wild and Prayer of Fortitude only appear for the current target
MoW and PW:F should now hide if their respective group buff is on the intended target
Made Renew level based
Added the option to show buffs at all times
Added Key Binding for toggling the option to show buffs at all times, buffs that are
	on the target are grayed out
Made all party only spells extend into raid groups
No more FrameXML log errors! Fontstrings are not already registered
Clarified and tweaked the functionality of Player As Default

v 1.14
Fixed targeting issue in v1.13
Added Divine Intervention
Fixed issue with buttons 7-10 not resizing

v 1.13
Divine Spirit rank 1 now has spell level of 30
Made it so casting a self only buff never results in switching targets
Casting when you are targetting a unit you can attack no longer switches
	targets(mainly an issue while dueling)
Fixed _spell_level table so that the correct spell level for the
	target is chosen again. Turns out that the table index starts at 1,
	not 0... So much for the placeholder. :P
Fixed issues with BeneCastState[UnitName('player')] having a nil value
Added Fear Ward

v 1.12
Made the button borders resize correctly when they get really small
Fixed a bug where member frames would show, but not the buttons, if
	the member was out of range
Cleaned up the flash so that the texture scales correctly and hides
	when done flashing
	Made the flash act like buffs when about to expire
Fixed a bug when doing anything that starts the casting bar(such as
	gathering/crafting) when you are a rogue, warrior or hunter
Fixed an error in PartyNotify where 'poison' was a heal instead of
	'group'
Fixed an error where going in an out of instances would result in
	multiple entries in the spell table
Sped up loading the AddOn when first entering the world
Made the BeneCastMember frame for the target not cause the TargetFrame
	framelevel to rise rapidly
Attempted to increase performance when targeting
Cleaned up _spell_level table a ton
Made it so buttons correctly appear when first entering the world
BeneCastFrame unregisters its events if class is rogue, hunter, or warrior
PW:S now stays hidden if Weakened Soul is on the intended target
Made Blessing of Sacrifice and Blessing of Salvation party only
Made slowfall a selfbuff
Added Divine Favor
Tweaked placement of buttons
Reworded to Shift for Max Heals to Damage Based Heals
Rearranged buttons to appear as follows HEALS:BUFFS:PARTY ONLY BUFFS:
	SELF ONLY BUFFS:CURES
Added a slashcommand for hiding/showing the BeneCast Options frame.
	Use /benecast or /bc
Put in a slider bar for the number of possible buttons

v 1.11
Made sure notification on instant cast spells is only shown when
	configured to
Fixed number string comparison in party notification

v 1.10
Tweaked notification function to allow spells with no rank

v 1.09
Fixed the bug where a cure magic effect button would appear if the unit
	had a buff that was a magic effect

v 1.08
Fixed a bug when announcing spells with no rank
Fixed a bug when casting or grabbing tooltips for a buff with no rank
Put in 'Use Player Settings for All' option
Added keybinding for BeneCast options
You can now hide the BeneCast Minimap button if you want
Added Frame Level cleanup to maintain good performance. Ick.

v 1.07
toc number raised to 4216
Raised up Party Member BeneCastMember frames 15 pixels
Reduced Button Spacing
Button size now saves
Can move BeneCastMember frames around
Lowered BeneCastMember frameStrata back to 'LOW' since you can move 'em
Can lock and unlock BeneCastMember frames by right clicking on the frame
Can move the BeneCastFrame
Added tooltips to the buttons when moused over
Independant settings for each BeneCastMember frame
Can toggle the Shift-Click functionality
Added a bunch of Notification options
Tweaked the clearing of relevant fields in BeneCast_Tooltips when done
	which makes curing spells only show when useful. Hopefully working
	as intended
Fixed a little bug with Nature's Swiftness (What I observed it in)
Fixed the bug when running in and out of instances
Performance boost when changing targets, especially if target is
	attackable or in the party
Made HoT buttons flash when effect is on (If I missed one tell me!)
Cooldown animations scale with button size
Dispel Magic now correctly targets the intended friendly if an enemy
	is currently targeted
Remove Lesser Curse now functions as Remove Curse
Made Blessing of Protection a Party Buff only
Removed Omen of Clarity (It's a weapon buff and I feel it doesn't
	belong)

v 1.06
Made BeneCastMember frames of frameStrata = 'MIDDLE' does this work?
	Maybe. Didn't break it... Seems to work
Fixed the clearing of relevant fields in BeneCast_Tooltips when done
	which makes curing spells only show when useful
Made it so low mana does not result in casting a lower strength buff
Clicking the BeneCast button now toggles the BeneCastFrame visibility
Dispel Magic retargets last enemy if it unselected them prior to casting
Fixed problems with spells with no mana cost
Added Blessing of Kings, Innervate, Nature's Swiftness, Omen of Clarity,
	Focused Casting, Inner Focus, Ice Block, Cold Snap, Combustion,
	Evocation, Presence of Mind, Arcane Power, Amplify Curse, Dark Pact,
	Fel Domination,	Soul Link
Rolled Divine Protection and Divine Shield, Frost Armor and Ice Armor 
	into one spell type
Set precedence of buffs so that selfbuffs are shown before partybuffs 
	are shown before buffs
Fixed problem with button cooldowns starting before the buttons updated
Purify for Paladins may not have worked correctly, might be fixed now
	I don't really know! Tell me if problems crop up
Added more checkbuttons for Paladins and expansion for other classes

v 1.05
Fixed a nasty error when trying to load up buffs with no spell rank

v 1.04
Trying to ensure scope control. I hope I did it

v 1.03
Fixed a few of the spell level entries for Paladins

v 1.02
Cleaned up the code quite a bit
Updated for 02/15/2005 patch Interface: 4211
Fixed a bug with casting the wrong buff when clicking on a button
Fixed a bug where there were "blank" buttons when a group heal was checked
Made the BeneCast setup button hide if you can't use BeneCast

v 1.01
Fixed Error when trying to cast a cure
	Assuming there is no lower level bound for targets on cures
Fixed an error when first loading in with a character when BeneCast is enabled
Put in Cooldown animations on buttons!
Made buttons disappear for Druids when shapeshifted

v 1.00
BeneCast put out on website
________
|THANKS|
--------
Thank you danboo! Your loading of spells by reading the tooltip and spell 
choosing functions were invaluable in the writing of this mod. Thanks to all the 
other mod writers out there from which I learned from.

Thanks to Urlik! Without his valiant testing, Paladins would probably still be
broken.

Thanks to Tyndral and Effren! Their help with the unclickable buttons allowed me
to attemp a fix. Hopefully their efforts in helping me has paid off!

Thanks to Hiroko of Argent Dawn(EU). Your help in Greater Blessings was greatly
appreciated!

Thanks to Auric Goldfinger. He's been a real help pointing out and fixing
various bugs.