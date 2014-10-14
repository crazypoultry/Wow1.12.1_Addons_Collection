***********************************
Scrolling Combat Text Versions 4.1
***********************************

Website - http://grayhoof.wowinterface.com/

Offical Thread - 
http://forums.worldofwarcraft.com/thread.aspx?fn=wow-interface-customization&t=27803&p=1&tmp=1#post27803

What is it? - A fairly simple but very configurable mod that adds damage, heals, and events 
(dodge, parry, windfury, etc...) as scrolling text above you character model, much like what already 
happens above your target. This makes it so you do not have to watch (or use) your regular combat 
chat window and gives it a "Final Fantasy" feel. 

Where did it come from? - The idea and base code came from the healthbar mod. I liked that mod a 
lot, but it really didn't do all that I wanted. So I decided to use it as a base to create my own 
mod purely as a learning experience. I've continued to work on it and think its now stands on its 
own merits, with almost none of the original code still intact. 

What's it look like? - See the image on the website: http://grayhoof.wowinterface.com/ 

What can it do? 

- Damage messages
- Heals
- Spell Damage/Resists and Damage Type
- Dodges, Blocks, Parries, Absorbs, and Misses 
- Custom Colors for all text events
- Config file to setup custom events (self and target), capture data, and display it.
- Debuff/Buff gain and loss Messages
- Low Health and Mana Warnings with values
- Rage/Mana/Energy Gains
- Enter and Leave Combat Messages
- Rogue Combo Points, 5 CP Alert Message
- Warrior Execute and Paladin Hammer of Wrath alerts
- Honor and Reputation Gain
- Healer ID's
-	Skill Gains
- Four Animation Types (Verticle, Rainbow, Horizontal, Angled Down)
- Four Fonts to choose from
- Ability to flag all text with * to more easily seperate it from target damage 
- Ability to show events as text messages at the top of the screen
- Ability to set the scroll direction to up or down
- Ability to flag any event as critical
- Sliders for text size, opacity, animation speed, movement speed, and on scren placement
- MyAddons, Cosmos, Cosmos2 support
- Settings saved per character
- Load/Delete settings from another character

Where can I download it? - http://rjhaney.pair.com/sct/ 

How do I use it? - First unzip it into your interface\addons directory. It should be in its own 
folder called SCT. Now just run WoW and once logged in, type /sct to get the options screen. 

SCT_EVENT_CONFIG.LUA is used to setup custom message events. Please open up the file (notepad, 
etc...) and read the opening section to understand how to use it all.
PLEASE NOTE - THIS IS THE MOST IMPORTANT FILE IN SCT. IF YOU DON'T READ IT AND USE IT, THEN
YOU ARE MISSING OUT ON A TON OF WHAT SCT HAS TO OFFER IN CUSTOMIZATION

/sctdisplay is used to create your own custom messages. 
Useage:
/sctdisplay 'message' (for white text)
/sctdisplay 'message' red(0-10) green(0-10) blue(0-10)
Example: /sctdisplay 'Heal Me' 10 0 0 - This will display 'Heal Me' in bright red

FAQ
How do I get My Crits or My Hits to show? SCT_EVENT_CONFIG.LUA has all of these
as examples you can simply uncomment (remove the --). You can open the file using any text tool (notepad, etc).

My custom event doesn't work. What's wrong? - Make sure you have the text exactly right, 
punctuation and capitalization matters. If you need help learning how to capture data, please see the 
examples or try this site http://lua-users.org/wiki/PatternsTutorial. If its still not working, please
read about SCT_Event_Debug and SCT_Event_List in the bottom half of SCT_EVENT_CONFIG.LUA to learn how 
to add almost any chat event to SCT's search capabilities

How do I change the text for parry, block, etc...? - open up the localiztions.lua file and look 
for the event you want to change. Then change the text to whatever you like. As of 4.1, you may also 
now add a custom event for these.

How do I get get text to scroll? I only see numbers! - Make sure the "Show Events as Message" 
option is unchecked. This is only if you want events to appear as static text (not scrolling/animated)

How do I change the fonts? - You can now select from four fonts on the options page. You can also change 
the font of message and apply the font to the in game damage font used for your damage (requires relog)

Version History
4.1 - Added Message options for all events, Added Healer ID, Added Your Heals and Skill gain as events, 
Added new globalization event parser, Added FD check for hunters and low warnings, added most all chat events 
to a new sct_event_config variable for searching on custom events, added debug code to show chat events, 
added ismsg for custom events, Added message text options for positioning, fade duration, size, and font, 
localized option page, added flag to set in game damage to same font as SCT, many other minor tweaks and changes.
4.01 - Fixed rainbow text fade point, Fixed horizontal text Y offset, Improved Execute/Wrath messages, 
fixed custom events not occuring in index order, fixed resets when massive spam, made resets alpha based
4.0 - Added 3 new animations, 3 new fonts, text positioning, Execute/Wrath events, Reputation events,
crit flag for all events, New Profile load/delete, better font sizing, font Outline options,
font Direction options, removed troll berzerk message. Special Thanks to Dennie for his Chinese Version 
of SCT that provided the inspiration for most of these changes.
3.54 - Updated TOC. Added current Health/Mana values to the warning messages.
3.53 - Added Text Movement Distance slider, this along with Animation speed slider should let you better
tweak your SCT Speed. Changed startup to hopefully work better for all users. Changed animation system 
slightly. Update German localization.
3.52 - Fixed spell damage error from 1.8. Added class filter to custom events.
3.51 - Commented out all custom Events, changed load up events so options always load.
3.5 - Added Buff fading event, spell damage type flag, custom event data capture and formatting, 
added glancing and crushing blows, onUpdate code optimization, animation optimization, general code 
cleanup, fixed resists bug (changed event), fixed mana drain bug (warlocks).
3.1 - Added Buff event, mana drains, New German Translations, Cosmos 2 Button support. Please note 
there are some new messages in the combat log from the 1.6 patch that are causing anomolies in SCT 
right now.
3.01 - Added New localization files (from cosmos), added cosmos button, fixed multiple sticky 
crits, turned off some custom events by default.
3.0 - Added custom events for target, Honor gain as event, 5 CP message, flag events as crit, new 
option screen, load other character settings, Fixed bug when getting hit during load, Fixed bug 
with multiple crits on the screen at once.
2.82 - Added Rogue Combo Points, Updated Troll Berserk event, hopefully fixed disappearing 
sound/graphics issue
2.81 - hopefully fixed issue with lingering text and flashing opacity
2.8 - added opacity slider, Troll Berserk alert, Combat alerts, MyAddon Support, random bug fixes, 
general code optimizations.
2.71 - fixed parry bug.
2.7 - added new version friendly parsing system by Ayny, fixed major animation bug (much smoother 
now), fixed custom event bug with weapon procs, added french localization.
2.61 - fixed bug with new frame code and the color selector.
2.6 - added Sticky Crits, Critical Heals, Rage/Mana/Energy Gains. Partial Absorbs and Blocks 
changed. Debuffs and Drowning damage fixed. New Animation System.
2.5	-	added Debuffs, Absorb, Custom Events, Misc Damage (fire, falling, etc...), localization 
file. 
2.12 - fixed toc version
2.11 - fixed toc version, fixed druid low mana bug, fixed defaulting new settings
2.1 - fixed bug with blocks and PvP/Duel damage, added Low Health and Mana warning events
2.02 - fixed bugs with ReloadUI (hopefully), init of the system, and made resists off by default
2.01 - fixed a minor bug with scroll down and resist messages
2.0 - Major code re-write. Added Custom Colors, Direction Toggle, Per Character Settings, 
/sctdisplay ability
1.2 - Added PvP/Duel Damage and actual damage to blocks
1.1 - Added Clearcasting to list of events
1.01 - Fixed a minor option reference
1.0 - Initial Release 

