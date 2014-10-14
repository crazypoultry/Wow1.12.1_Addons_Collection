vAssist v0.8
by ven (m.fasse@gmail.com)


[Description]
vAssist lets you set up to 6 main tanks and adds windows to your interface which shows name and health of the tank's target. Clicking the windows will assist the tank by targeting the tank's target (pretty much like CTRA's MTTarget). I also added commands for use in macros and keybindings.


[Why?]
I like the MTTarget window of CTRA but CTRA's MTTarget function has very limited usage if you don't participate in raids where everyone uses it.
Other tank management mods like beyondRaid or Multi Assist didn't satisfy me, so I created my own one. It's very simple and small and will be invisible unless you need it.


[Commands]
'/vassist [<num>]' - Assists MT #<num>. If <num> is not specified the most valid MT will be assisted.
'/vassist set  [<num>]' - Sets your target as main tank #<num>. Example: '/va set 1'. Without <num> first free MT slot will be used.
'/vassist unset <num>' - Unsets main tank #<num>. Example '/va unset 1'.
'/vassist unsetall' - Unsets all main tanks.
'/vassist hide' - Hides the MTTarget windows (If you just want to use the binding or the '/vassist' command.)
'/vassist show' - Makes the MTTarget windows visible again.
'/vassist scale <num>' - Scales the MTTarget windows. <num> can be a number between 1 and 15.
'/vassist showinfo <num>' - Displays short information about the tank's target in your chat frame.
'/vassist mttt on/off' - Displays a small text which tells the current target of MT's target.
'/vassist colors on/off' - Enables/Disables the use of colors to show aggro status.
'/vassist border on/off' - Enable/Disable the display of borders.
'/vassist interval <num>' - Changes the update interval. <num> in seconds.
'/vassist help' - show ingame help.

'/va' can be used instead of '/vassist'

Shift + Click will move the MTTarget windows.


[ToDo]
- Translation (french)
- Options GUI
- ACE


[Notes]
- Background color of MTTarget window changes depending on MTTarget's target. If your tank's target is the tank (tank has aggro) the background will be green, if you are the MT's target it'll be red, otherwise the background will be black.
- Localization: This mod should work with any client.
- This mod is designed for use in parties or raids. If you set a player as main tank and he's not in your party or group most of vAssist's features won't work. Usage will be limited to a behavior like using the "Assist" key while having the tank targetted.


[Changes]
v0.8
- added pet support

v0.7
- updated German localization
- updated slash command list
- (Shift + Click will move the MTTarget windows.) moved from notes to command list
- added ability to change update interval

v0.61
- small fix with grey MTT windows showing on startup
- small changes in assist behavior

v0.6
- fixed an issue with default settings not loading
- added onUpdate interval
- added scaling
- changed toc to 11000

v0.5
- changed toc to 1800
- changed background color behavior
- added multiple tank support (up to 6 MTs)
- changed some slash commands to fit multiple tank support

v0.41
- fixed small bug with MTTT string

v0.4
- added target of MT's target
- added commands: 'mttt', 'colors', 'border'
- changed border style to tooltip, imho it looks better. waiting for feedback :)

v0.32
- another bugfix
- removed an info message which didn't work properly due to an issue with wow's engine :\

v0.31
- tweaked code a bit
- maybe the bug which occured when members leave your party disappeared. This didn't happen for me, so I'm not able to test it

v0.3
- changed the background colors. If MT's target doesn't have a target at all the BG will be black.
- changed the way you assist the MT. Should now properly attack on assist (if activated in game options).
- (hopefully) fixed nil value bugs people were experiencing

v0.2
- added german translation

v0.12
- added color coded background

v0.11
- added key binding to set MT
- fixed a small bug

v0.1
- initial release