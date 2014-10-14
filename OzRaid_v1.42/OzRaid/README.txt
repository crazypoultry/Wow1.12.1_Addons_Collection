OzRaid Bars Readme
------------------

Q: What is it?
OzRaid is a set of configurable windows to show health/mana bars & buffs.
At its simplest, you can view the current raid group health, and any buffs/debuffs you care about. At its most complex, you can use it to build 'reminder' windows for buffing, curing, show the currently targetted mobs (with debuffs applied), build an emergency monitor, and many more things on top.

Q: So.. isn't it like CT Raid Assist?
No.
All it does is show health/mana bars. It doesnt provide any of the other cool things CT does (like boss warnings, and many more) This addon was written simply to provide a smaller & neater overview of the raid than the CTRaid (and now Blizzard) party frames. But it now does so much more.
It also works in parties & solo as well as raids ;)

Q: So how do I use it?
Basic controls:
You can drag the windows around, you can click the 'x' to hide them, or the little speech bubble icon to open the options. You can also click the minimap icon to open the options too.

The options panel consists of several tabbed screens. The important window to notice is the selection box right at the top. This has the name of the current window you are editing in the options. Just select the desired window and edit away!
(Preset pane is discussed at the bottom)

To use it fully, you must understand how it works:

-----------------------------------------------------------
It all starts with an INPUT:
This can be:
Party/raid members health or mana
Your 'subparty' health/mana
CLASS health or mana (all themembers lumped by class)
Targetted mobs health/mana

On the input pane is also a slider for the healthy/injured cutoff. Any bar that is lower than this value will be considered 'injured', anything above is considered 'healthy'. You may need these later...

-----------------------------------------------------------
You can then FILTER the input
This will hide bars based on the parameters you ask for.
The filters can be by subgroup (within the raid), by class, by range, by buffed/debuffed status, or by health status (healthy, injured, dead, offline)
IF A BAR MATCHES ANY FILTER THAT IS OFF< THE BAR WILL NOT DISPLAY!

-----------------------------------------------------------
You then SORT the bars
The available sorts are:
<none> - don't sort.
Bar Length (asc) - this puts the shortest bars at the top.
			 Not massively useful to be honest as dead people float to the top
Health Status -	This is the good one. Short bars go to the top, but dead and offline
			people are pushed to the bottom.
Group - Sorts by subgroup within the raid
Class - Sorts by class (obviously)
Range - sort by range.
Raid Icon - Sort by the coloured raid icon. Useful for keeping track of targetted mobs

You can sort the bars twice, the order will be preserved for the second sort for things of an equal value. So what does that mean then? Well, suppose you want to view the bars split into groups, with the lowest value at the top of each group. You would first sort by 'Health Status', and then by 'Group'. As everyone within one subgroup will sort by the same value (group 1 = 1, group 2 = 2 etc.) then the realtive order from the first sort (most hurt at the top) is preserved. Dont worry, you dont have to understand this. Just have a play until it works.

The sorts can also apply a 'heading' to the output. Word of advice - don't apply more than one heading, and unless you want millions of headings, set only the heading for the last sort to be on. In the health/group example above - set heading for 'group' to be active and 'health' to be off.
Anything more than that and you are, quite frankly, asking for trouble.

There are also some extra options here that have 'leaked' from the display pane.
Texture - lets you assign one of 11 possible bar textures to the health bars. Useful if you want to match another addon in look & style.
'Hide Aggro Glow' is a new feature. If this checkbox is blank, then members of the raid who have aggro will get a blue gow around them. The more mobs are targetting them, the brighter the glow. Please note that I can only track mobs that someone is targetting, if noone is targetting a mob then I do not know who it is agroing on.

-----------------------------------------------------------
Now decide how you want the bars DISPLAYed
First option is colour. You can colour by class, have green/red 'health' bars, or blue/purple 'mana' bars. You can even mix and match with the 'party blue, rest green' option that will show your own subgroup in a raid using the blue/purple bars, and everyone else in red/green. This is useful for the emergency monitor style windows.

Fade on Range - if set, the bars will fade slightly when you are >28 yards away. Useful to make sure you dont get left behind, and so you can shout at the tanks as they run off into the distance wondering where their healing went. If this happens a lot, tell them to get the mod, and set a window up showing healers with fade on range. When all the bars go dark, they can expect imminent and painful death - and they will KNOW it is their own fault. (running away once they drop and pretending they had run ahead is also possible if you're quick)

Debuff Colour - if the unit currently has a debuff on THAT YOU CAN CURE, then with this selected the bar will turn a decidedly ghastly shade of pink. I chose it for its ghastlyness. Combine with the fade on range and you will quickly see who you can cure, and who is doomed to wander around plagued/cursed/etc.

Name position - It, er, sets where peoples names appear.

Red on Dead - The name turns red when they are dead. seful for some, not so useful if you are a rezzer looking for other rezzers to rez and need to see peoples class, which brings me to...

Colour Name - colours the name by their class! But it can make them tricky to see, especialy if the bar is also coloured by class (not reccomended) so:

Outline - puts a chunky outline on the text to make it easier (well, not always) to read

Buff Position - Where the buffs are displayed. Like the name. Only the buffs move.

Big Icons - The buffs can appear BIG and stacked end to end, or if this box is clear, they appear half width/height and stacked in twos. Smaller, but a bit tricky to see unless you can tell them by colour alone.

Hide Icons - This hides other icons, such as party leader, raid icons etc. Use it if you dont care about these icons.

Show Debuff Icon - if the player has a curable debuff on them, this shows it as an icon by the name.

Number position - you can have a numerical value shown for the bar length, and choose where to put it. The only odd thing here is 'Right1' means right-aligned ON the bar, and 'Right2' means 'Over the end of the bar to the right'. Strangely I couldnt fit those descriptions in the teeny-tiny space I had, so I called them 'Right1' and 'Right2' instead, figuring that if people had got this far they might have the courage to click the buttons and see what the difference was.

Number type - value, percent, deficit. Normal people use percent, nerds use value, healers use deficit. Which one are you?
------------------------------------------------------------

Next you can set what BUFFS you want to check

open close the sections to find the buffs. Click on a buff/debuff name to cycle the priorities.
The priorities are:

none - buff will not be displayed. Ever.

lowest/low/medium/high/highest
These are priorities. The buffs are sorted by the priorities, and then displayed. The buffs closest to the edges of the window will be the highest priority ones, tailing off to the ones you dont care about so much. Pretty much any buff you like is viewable (except wizard oils/mana oils as these are item buffs not player buffs apparently), and I havent put in many potions yet either. But if you want to snoop on what other classes are doing, then you can :)

Clear - sets ALL the buffs to 'none'
Default - enables the commonly cared about buffs FOR YOUR CLASS. For mages, its AB/AI, amp/damp magic. For healers, its their own buffs (Prayer of fortitude, gift of the wild etc.) plus renew/regrowth/shield spells that people get when they are being healed.
Default also sets mob debuffs to spells YOU can cast on mobs, as well as all the crowd control spells. Useful eh?

------------------------------------------------------------

Finally, we come to the GENERAL options.
These generally set sizes and other behaviours. Some of the general options have fallen off here onto the presets, so look there too.

They should be fairly self explanatory, for example Bar Height changes.... the height of the bars!
Icon size changes buff/debuff icon sizes as well as the totlebar buttons.
REFRESH is an important one - this is how often the bars update. You _can_ set the bars to update 10 times a second. the server doesnt always send you the data that fast, but you can always pretend. The faster it is, the more chance of slowing your machine down. I have tried to keep everything as streamlined as possible, but at the end of theday, showing all the bars at max refresh rate IS going to impact your performance.

Min/Max bars limit the way the bars are shown. The window will resize to fit the number of bars up to 'max' and down to 'min'.

A few checkboxes at the bottom let you hide various UI elements to make the screen even simpler. You can also set windows to disable if you are solo or not in a raid.

------------------------------------------------------------

PRESETS
Dont touch. They dont work, they will cause the apocalypse if you try them, and the button is disabled. The reset button does work if you manage to gibbon something up really badly.

Also hiding on this page is the WINDOW TITLE! Please use meaningful titles. Its hard to know what window is what in the options if you dont.

HIDE PARTY FRAMES is a new addition. Vaious testers have thrown out most of the Blizz UI in favour of these bars, and couldnt get the party frames to stay hidden a lot of the time. This button will hide the party frame. And every 5 seconds it will check. If the little buggers have appeared again, it will hide them again. With a hammer.

SHOW WINDOW - use this to turn windows on and off. A window that is OFF here will not do any processing. If you have a 'low spec' PC (that's polite for $"&%) then dont use all 8 windows at once.

SHOW TOOLTIPS will show an iddybiddy tooltip when you mouse over a bar. Tells you name, class, and location (if you are in a raid). For various reasons, I cant get party members location if you are not in a raid. Dont ask me why not, they just dont seem to be there. They come up as 'Unknown Zone'. Ho hum.

And theres some buttons & sliders for the minimap icon. Stick it somewhere you like.

------------------------------------------------------------------
MISCELLANEOUS STUFF

Q: What ranges are there?
At present, only 3 ranges are detectable:
<11 yards (trading range)
11-28 yards (follow range)
>28 yards (out of range)
This is all the range info you can get from the WOW API, so please dont ask for more. It is still useful as, for example, debuff curing range is 30 yards, and you can use the 'fade on range' option to show you when youhave got left behind or have run ahead of all your healers.

Q: Its missig feature <x>!
Well, tell me and I might add it. Or I might not. paying gold helps ;)
------------------------------------------------------------------
TUTORIAL 1: Raid overview
A simple raid overview:
PRESETS:
	Set the title to something useful, like RAID
	Show Window = ON
	Show Tooltips = ON
INPUTS
	Party/Raid members health
	Injured cutoff = 100% (doesnt matter)
FILTERS
	Just have everything checked.
SORT
	Sort by Group, heading ON
	<none>
DISPLAY
	Bar colours: Health - Green Red
	Fade on range - ON
	Debuff colour - ON
	Name position - On Bar
	Red on Dead - ON
	Colour Name - ON
	Outline - ON
	Buff Position - LEFT
	Big Icons - ON
	Show Debuff Icon ON
	Number position - meh, personal preference. I leave this off myself, else 'PERCENT, RIGHT1'
BUFFS
	Press the 'Default' button - just the once mind. No need to go mad.
GENERAL
	Fiddle the sizes to your own screen size.
	Refresh - 1s (dont need any faster)
	Min Bars - 0
	Max Bars - 40
	Hide when Empty - ON

------------------------------------------------------------------
Q: Whats this emergency monitor thingy?
Ok, lets go for:
TUTORIAL NO 2:
PRESETS:
	Set the title to something useful, like HEAL ME
	Show Window = ON
	Show Tooltips = OFF
INPUTS
	Party/Raid members health
	Injured cutoff = 80%
FILTERS
	Turn OFF: Healthy, Dead, Offline
SORT
	Sort by Health Status - no headings
	<none>
DISPLAY
	Bar colours: Party blue, rest green
	Fade on range - OFF (you can have it on but it only tests 30 yards and heals are 40 yards)
	Debuff colour - OFF
	Name position - On Bar
	Red on Dead - OFF (you wont see em anyway cos they're filtered out)
	Colour Name - ON
	Outline - ON (personal preference)
	Buff Position - RIGHT
	Big Icons - ON
	Show Debuff Icon OFF
	Number position - RIGHT, DEFICIT
BUFFS
	Ok, start by CLEARing everything
	Then set:
		Priest->Buffs->	Power Word: Shield
					Renew
		Druid->Buffs->	Regrowth
					Rejuvination
GENERAL
	Fiddle the sizes to your own screen size.
	Refresh - 0.3s - nice and fast
	Min Bars - 0
	Max Bars - 8
	Hide when Empty - OFF

Explanation:
Right, this will be a mostly empty window, but as people get hurt they will appear there (once under 80%) You can see what HoT's and shields have been put on them so you dont waste your mana (and the other healers)reapplying them. Your own party will come up in blue/purple, so you can concetrate on them if they appear, otherwise provide some cover for people getting beaten on.
