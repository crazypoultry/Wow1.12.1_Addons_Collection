FlexTotem/readme.txt

	INDEX

1	Beginner Section
1.0	What is FlexTotem?
1.1	Installing the default configuration
1.2	Upgrading FlexTotem
1.3	Removing FlexTotem

2	Advanced Section
2.0	What is FlexTotem? Part II
2.1	Totem Events
2.2	Totem Timers
2.3	Totem Stomper 
2.4	Starting From Scratch
2.5	Setting Up Buttons
2.6	Setting Up Events
2.7	Linking FlexTotem To FlexBar

3	Command Line Options

4	Additional Options

5	Important Links


1.0	WHAT IS FLEXTOTEM


Just like TotemTimers, it allows you to show 4 duration timers of the totems you currently have on the ground. The 
buttons are remapped to the totems you cast, so clicking them will recast that particular totem. Once a totem is expired
or destroyed, the button will fade to indicate that, but you can still recast the last totem of that element you used by
clicking the faded button.

If you hover over the 4 buttons at the bottom, you see all the other totems you have, each column represents a different
element. They stay visible until you move the mouse out of the grid. Now if you leftclick some of the totems, you drop 
them. But if you rightclick the totems in the grid, little numbers appear in the right upper corner of each button, 
indicating in which order you clicked them. If you rightclick a totem from an element that already has a number, that 
totem will get the same number and the old totem will lose its number. If you rightclick a totem that has a number 
already, all numbers are cleared. What these numbers do, is set which totems you want to be able to stomp, and in which 
order. As you can see, the totem that was marked with a 1 now appears to the right of the 4 element buttons. This is the 
stomper button. If you click it, it will cast that totem, and the button will change to the totem marked with a 2. The 
totem stomper registers what totems are currently on the ground. Once all the totems in the stomp list are dropped, the 
stomper button will dissappear. Clicking it again will do no harm, it will do nothing at all.

The behavior of the buttons and grid as described above, are from the default configuration. In the rest of this section 
(1) I'll explain how to install that. You don't need to know much about FlexBar to do this, but it is still trickier to 
install than most addons. There are great alternatives available if you do not want or need the flexibility of flexbar, 
namely Melki's TotemTimers for the element buttons and Raknor's Frowning Circle for stomping totems. If you want to set 
up your own custom designed configuration, you can skip the rest of this section and go to the Advanced section.


1.1	INSTALLING THE DEFAULT CONFIGURATION


Download the FlexTotem archive from Curse Gaming and extract it in your Interface/AddOns directory. 

Once in game, give the following command:

	/flextotem default

This will use flexbar buttons 90 to 116. You can use 27 different buttons by selecting a different starting button. You 
can also set the scale of the element buttons (scale1), the scale of the buttons in the grid (scale2), the padding between
the buttons, the location of the left bottom button and wether it should show the grid below (align=top) or above 
(align=bottom) the static buttons. This next line does the same as /flextotem default:

	/flextotem default start=90 scale1=10 scale2=8 padding=3 x=300 y=300 align=bottom

You can drag the whole thing with the anchor on the first element button on the bottom left. 

Go to the keybindings, and set any keybinds you want to use. The bottom right button is the stomper button. While the 
configuration is unlocked, you can see the FlexBar button numbers in the middle of the buttons.

Once the keys are bound and the buttons are in the right place, give the following command:

	/flextotem lock

Finally, make sure 'Enhanced Tooltip' is enabled in your game interface options!

If you want to use the advanced stomper mode, which is a bit smarter but requires slightly more performance, you have to
give this command:

	/flextotem advanced

That should be all.


1.2	UPGRADING FLEXTOTEM


Normally, FlexTotem can just be updated by extracting the archive in your addons folder again. You do not need to rerun 
the /flextotem default command unless stated otherwise. 


1.3	REMOVING FLEXTOTEM


If you don't use FlexBar, you can just remove the FlexBar and FlexTotem directories in your Interface/AddOns folder.

If you do want to keep your other FlexBar settings, give the following command in game:
	
	/flextotem remove

Next remove the FlexTotem directory from your Interface/AddOns folder, and FlexTotem should be properly uninstalled.


2.0	WHAT IS FLEXTOTEM? PART II


FlexTotem only adds three things.


2.1 	TOTEM EVENTS


First it adds new events to FlexBar. Whenever a totem is created, it will fire an event called 'GainAir', 'GainEarth', 
'GainFire' or 'GainWater'. Similarly, once a totem is expired or destroyed, it will fire an event called 'LoseAir', 
'LoseEarth', 'LoseFire' or 'LoseWater'. In both cases, the target of the event will be the name of the totem (minus the 
Totem at the end). These totem names will be different depending on your client language. You can now make events just 
like FlexBar's GainAura, but for totems. So for example:

	/flexbar runmacro on='GainEarth' target='Earthbind' macro='/s Feel free to stick around!'


2.2	TOTEM TIMERS


Secondly, it will allow you to place timers of each element to show the duration of the totem currently dropped. You can
put the timers under any flexbar buttons, with the following commands:

	/flextotem earth 117
	/flextotem air 118
	/flextotem water 119
	/flextotem fire 120


2.3	TOTEM STOMPER


And third, it adds stomper functionality. How this works is that you add an event to your totem buttons, for example on 
rightclick, that will put them on the list. You have to do that with a runscript event that calls Totem_SetStomp(). 
Let's say you have your totems in flexbar buttons 90-110, you can create the following event:

	/flexbar runscript on='rightbuttonclick' target=90-110 script='Totem_SetStomp()'

Now you should see the little numbers appear on the buttons when you rightclick them. This uses flexbar's normal button 
textfield, so you can't use text on these buttons. Next you assign a flexbar button, this can be anywhere in your 
current flexbar setup, to remap according to the sequence you set with the rightclicking. You can do that with the 
following command:

	/flextotem stomp 100

This is all that FlexTotem does. Everything else, like the totem grid or the remapping of the element buttons, is done 
in FlexBar.


2.4	STARTING FROM SCRATCH


First of all, make sure you have a keybind to flexbar's graphic user interface. Flexbar's main menu will allow you to 
open the Script Editor and the Event Editor. I advice you to write your setup in the script editor, so you can store it, 
change it and run it again if required. If you run the script as a config, you can skip the /flexbar before every 
command. The event editor is also a must have because it's easy to lose track of what flexbar events you have going on.


2.5	SETTING UP BUTTONS


Here's how I made the default configuration. Note that this example is without the new Tranquil Air totem, but that
would follow the same principle. I'm going to use buttons 90-116 for this, so first let's make sure they are visible.

	/flexbar show button=90-116

I want my element buttons to be larger than the totem grid. I'll make the element buttons scale 10 (100%) and the 
buttons in the totem grid scale 8 (80%).

	/flexbar scale button=90-94 scale=10
	/flexbar scale button=95-116 scale=8

For the button placement, I like to start with a 'moveabs' command, to place one button at an absolute location that I 
can use as a base location for the rest of the buttons. You don't have to do this at all, you could even drag every 
button by hand, but it would be harder to replicate it on another computer or after a fresh install. In this case, I 
take button 91 and place it at location 10, 170.

	/flexbar moveabs button=91 xx=10 yy=170

Next I use 'moverel' to move the other 3 element buttons and the stomper button to the right of button 91. Each button
is 32 pixels to the right of the one before.

	/flexbar moverel button=92 trgbtn=91 dy=0 dx=32
	/flexbar moverel button=93 trgbtn=92 dy=0 dx=32
	/flexbar moverel button=94 trgbtn=93 dy=0 dx=32
	/flexbar moverel button=90 trgbtn=94 dy=0 dx=32

Now the totem grid. I'm going to group the buttons of the first element Air, so I can use the 'verticalgroup' command to
put them in a vertical line. Once that is done, I move them relatively to the element buttons. If you move a button that
is an anchor of a group, the whole group moves. I anchor the groups by the bottom button, so the anchors are all the 
same distance from the element buttons.

	/flexbar group button=95-100 anchor=100
	/flexbar verticalgroup group=100 padding=2 width=1
	/flexbar moverel button=100 trgbtn=91 dx=3 dy=26

I now have one column of small buttons on top of the first element button. Next I do the same for the other 3 elements.

	/flexbar group button=101-106 anchor=106
	/flexbar verticalgroup group=106 padding=2 width=1
	/flexbar moverel button=106 trgbtn=92 dx=3 dy=26

	/flexbar group button=107-111 anchor=111
	/flexbar verticalgroup group=111 padding=2 width=1
	/flexbar moverel button=111 trgbtn=93 dx=3 dy=26

	/flexbar group button=112-116 anchor=116
	/flexbar verticalgroup group=116 padding=2 width=1
	/flexbar moverel button=116 trgbtn=94 dx=3 dy=26

Now I've got all the buttons where I want them. But I want the whole grid to appear when I hover over the element 
buttons, so I don't need these groups per element. You could make each element appear seperately though, or have them 
displayed at all times. You could open the grid by clicking or pressing a button, or make it fade or disappear after a 
number of seconds. That is all done with events, which will be in the next section. But for now I want to remove the 
current groups and make one big group of the whole thing, so I can drag it all at the same time.

	/flexbar ungroup group=100
	/flexbar ungroup group=106
	/flexbar ungroup group=111
	/flexbar ungroup group=116
	/flexbar group button=90-116 anchor=91

Lastly, I want the totem buttons to not cast totems when you rightclick them, because I'm going to use rightclick to set
the stomper sequence. To avoid confusion, all that flexbar's advanced button state does is make sure it isn't cast on 
rightclick.

	/flexbar advanced button=95-116 state='on'


2.6	SETTING UP EVENTS


Now it's time to add the behavior to the buttons. It is important to understand that the remapping of the element 
buttons is not done by FlexTotem, but with FlexBar events. For example, button 100 in the totem grid holds the 
Grounding totem. When you cast a Grounding totem, I want the button that has the Air element timer to change into 
button 100. You can do this with a 'remap' event. The 'button' is the button that will change and 'base' is the button 
it will change into.

	/flexbar remap button=91 base=100 on='GainAir' target='Grounding'

Next I have to do this for all the totems. This means you can set them up in any way you want, but if you move a totem 
in your grid, you have to change the event that remaps it accordingly. Note that while the event name is the same, the 
totem names are different if you are using a non-english client.

	/flexbar remap button=91 base=95 on='GainAir' target='Sentry'
	/flexbar remap button=91 base=96 on='GainAir' target='Windwall'
	/flexbar remap button=91 base=97 on='GainAir' target='Windfury'
	/flexbar remap button=91 base=98 on='GainAir' target='Nature Resistance'
	/flexbar remap button=91 base=99 on='GainAir' target='Grace of Air'
	/flexbar remap button=92 base=101 on='GainWater' target='Mana Tide'
	/flexbar remap button=92 base=102 on='GainWater' target='Fire Resistance'
	/flexbar remap button=92 base=103 on='GainWater' target='Disease Cleansing'
	/flexbar remap button=92 base=104 on='GainWater' target='Poison Cleansing'
	/flexbar remap button=92 base=105 on='GainWater' target='Mana Spring'
	/flexbar remap button=92 base=106 on='GainWater' target='Healing Stream'
	/flexbar remap button=93 base=107 on='GainFire' target='Frost Resistance'
	/flexbar remap button=93 base=108 on='GainFire' target='Flametongue'
	/flexbar remap button=93 base=109 on='GainFire' target='Fire Nova'
	/flexbar remap button=93 base=110 on='GainFire' target='Searing'
	/flexbar remap button=93 base=111 on='GainFire' target='Magma'
	/flexbar remap button=94 base=112 on='GainEarth' target='Stoneclaw'
	/flexbar remap button=94 base=113 on='GainEarth' target='Stoneskin'
	/flexbar remap button=94 base=114 on='GainEarth' target='Strength of Earth'
	/flexbar remap button=94 base=115 on='GainEarth' target='Tremor'
	/flexbar remap button=94 base=116 on='GainEarth' target='Earthbind'

That takes care of the remapping. But now they're always visible. You could make the buttons hide, but I opted for 
making them fade to alpha 3 (30%) so I can still see what I casted last and can click it to recast it. This means 
however, that you have to set them to alpha 10 (100%) again when a totem of that element is dropped. You can do this as 
follows, basically ignoring the name of the totem.

	/flexbar fade button=91 alpha=10 on='GainAir'
	/flexbar fade button=91 alpha=3 on='LoseAir'
	/flexbar fade button=92 alpha=10 on='GainWater'
	/flexbar fade button=92 alpha=3 on='LoseWater'
	/flexbar fade button=93 alpha=10 on='GainFire'
	/flexbar fade button=93 alpha=3 on='LoseFire'
	/flexbar fade button=94 alpha=10 on='GainEarth'
	/flexbar fade button=94 alpha=3 on='LoseEarth'

When you log out, any totems you may have hanging around will not make your element buttons fade. So for appearance, 
you could add this event to fade the 4 buttons when you log in.

	/flexbar fade button=91-94 alpha=3 on='ProfileLoaded'

Next I can make all the buttons in the grid call the Totem_SetStomp() function when you rightclick them. This will make 
the number in the corner appear and will make the stomper button change accordingly.

	/flexbar runscript on='RightButtonClick' script='Totem_SetStomp()' target=95-116

Last but not least, I don't want the totem grid to be visible all the time. So I'm going to show all the small totem 
buttons (95-116) when you enter either of the 4 element buttons (91-94).

	/flexbar show button=95-116 target=91-94 on='MouseEnterButton'

And similarly, I want to hide all the totem buttons (95-116) when you leave the whole area. Since all these buttons are 
grouped with anchor 91 I can just use the group as the target.

	/flexbar hide button=95-116 target=91 on='MouseLeaveGroup'

Just like you can change how the buttons look or how they're grouped in the 'Setting Up Buttons' section, you can also 
change this behavior completely by adapting the events. You could make the grid appear and disappear by rightclicking 
the element totems (put advanced state on them and use a rightclick event with toggle='true'). You could also make the 
grid disappear not when you leave the group but after a certain period of time (using flexbar's 'in' parameter).


2.7	LINKING FLEXTOTEM TO FLEXBAR


All that remains now is letting FlexTotem know which flexbar buttons you are using for the timers and the stomper 
button. In this example those would be:

	/flextotem stomp 90
	/flextotem air 91
	/flextotem water 92
	/flextotem fire 93
	/flextotem earth 94

I hope this explanation is sufficient. I suggest you also have a quick look at the Commands section to see a few 
additional FlexTotem options you can set. If you have questions about flexbar coding around this addon, please use the 
thread on the flexbar forum. I'd like to reserve Curse Gaming's comments for bug reports and feature requests. 

Athame.


3	COMMAND LINE OPTIONS


/flextotem air <number>
This docks the remaining duration timer for the air totem that is currently active to a flexbar button with number 
<number>. The default value is 91.

/flextotem earth <number>
This docks the remaining duration timer for the earth totem that is currently active to a flexbar button with number 
<number>. The default value is 94.

/flextotem fire <number>
This docks the remaining duration timer for the fire totem that is currently active to a flexbar button with number 
<number>. The default value is 93.

/flextotem water <number>
This docks the remaining duration timer for the water totem that is currently active to a flexbar button with number 
<number>. The default value is 92.

/flextotem stomp <number>
Once a stomper sequence has been set, flexbar button with number <number> will keep changing to show the next totem to be 
stomped. The default value is 90. When no number is given, this will attempt to use your stomper (for use in macro's).

/flextotem buttons
Shows to which flexbar buttons the timers and stomper are currently bound.

/flextotem interval <ms>
Continues updates are required to display the timers, and for the stomper button in advanced mode. With <ms> you can set
a minimum of milliseconds that pass between each update. The default value is 500 (twice per second).

/flextotem advanced [on|off]
This toggles between the standard mode and the advanced mode for the totem stomper. In advanced mode, the totem stomper 
will consider cooldowns and remaining duration of totems. This will take slightly more performance. Advanced mode is off 
by default.

/flextotem threshold <secs>
In advanced mode, you can have the totem stomper show totems <secs> seconds before they naturally expire. This way you 
can restomp totems without having to wait till they are expired. The default value is 10 seconds.

/flextotem save <name>
Save the current stomper sequence to memory, using <name> as index. In scripts, you can also use Totem_SaveStomp(name).

/flextotem load <name>
Load a stomper sequence from memory using <name> as index, replacing the current sequence. In scripts, you can also use 
Totem_LoadStomp(name).

/flextotem preset <preset>
Set the text that should form the command that is used when you use report. You can use $s to show all the totems
currently on your stomp list. You could also use $a (air), $e (earth), $f (fire) or $w (water) to show the totem of that
element that is on your stomp list. The default preset is "/p How about $s?".

/flextotem report [command]
Executes a command where $s, $a, $e, $f and $w are replaced with the totems in your sequence as described above. If no
command is given, it will use the preset. 

/flextotem debug [on|off]
This toggles the debugging mode on and off. This will provide information about totem and button tracking. Debugging 
mode is off by default.

/flextotem silent [on|off]
This toggles a silent mode. In the silent mode, the mod will not send any messages to the chatwindow, like the loaded 
notification. Silent mode is off by default.

/flextotem reset
All settings are stored between sessions. This command restores all values back to their default value. 

/flextotem default [start=#] [scale1=#] [scale2=#] [padding=#] [x=#] [y=#] [align=top|bottom]
Set up the default configuration in FlexBar. This will remove any events related to the previous totem buttons, then 
create all events and buttons. It will also drop the totem spells in the correct buttons. The configuration has 28 
buttons in total, so you can start it on any button from 1 to 93, using start=#. Default alignedment is 'bottom'.

/flextotem update
If you've set up a configuration with default, this will update the totems in the grid to the current highest ranks.

/flextotem remove
This will remove any events related to the totem buttons.

/flextotem lock [on|off]
This toggles a locked state for when you're using the default configuration. When unlocked, the grid and the button 
numbers will also be visible and you will be able to drag actions in or out of the buttons.


4	ADDITIONAL OPTIONS


FlexTotem also adds conditionals to Flexbar; hasair, hasearth, hasfire, haswater, hasairrank, hasearthrank, hasfirerank
and haswaterrank. With the first 4 you can query what totems are currently out, with the last 4 you can query what rank
the current totems are from the respective elements.

When using the report command $a, $e, $f and $w will be replaced by the names of the totems on your current stomp
sequence. $s will be replaced by a list of your complete sequence.

You can put & in front of any FlexTotem command to prevent it from notifying you in your chat window. This is the same
FlexTotem's silent mode, but for a single command.


Examples:


/flextotem advanced on


/flextotem &load mageset
/flextotem stomp


/if manabelow20<"player"> and not hasfire<>
/cast Fire Nova Totem(Rank 1)
/end
/if manaabove20<"player"> and ((not hasfire<>) or hasfirerank<"1">)
/cast Fire Nova Totem(Rank 3)
/end


/flextotem report /t shammy I'm using $s this fight, ok?


/flexbar runmacro on='gainair' target='Grounding' macro='/flextotem &earth 110'


/flexbar runmacro on='gaintarget' macro='/flextotem &load rogue' if='unitclass<["target" "rogue"]> and not 
haswater<"Poison Cleansing">'


5	IMPORTANT LINKS


FlexTotem Website: http://members.home.nl/wooz/FlexTotem/
FlexTotem Thread on FlexBar's community forum: http://www.flexbarforums/viewtopic.php?t=1361
FlexBar Documentation: http://www.flexbarforum.com/blog/docs/
Download FlexTotem on Curse-Gaming.com: http://www1.curse-gaming.com/mod.php?addid=2298
