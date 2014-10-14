MainAssist 2.1

Since this is a complete rewrite it is advised to delete/move the old MainAssist(version 1.5 or lower) folder before installing this version.

Quickstart Guide:
	Once this addon is installed you should see "MainAssist" somewhere on your screen, this can be dragged and will have the tank frames anchored to it when there are tanks to track.  Right clicking this will bring up a menu to configure MainAssist.
	
	Type /ma to get a list of commands, these are all also available in the menu
	
	The menu can be opened in 3 ways
	- Typing /ma menu
	- Right clicking on the MainAssist Header
	- Keybinding
	
	There is also a menu acessable by right clicking on any of the assist windows.
	
	There is a few keybindings available
	- Add your current target to the Custom Tank List
	- Clear the custom tank list
	- Open the Menu
	
	There are currently 2 lists of tanks available
	- The custom tank list is a personal list of tanks that you setup using hotkeys or the menu
	- The CTRA list is the list of tanks setup in CTRA (or compatible addons) that will be automatically kept in sync.

	These lists can be enabled and disabled seperately

	Smart Assist:
		This is an assist feature that will pick one of the defined tanks to assist when pressed
		Currently it will pick from the CTRA tank list if it is enabled and has tanks in it, then from the custom tank list.
		The assist picked is either the first in the list(default) or last, this is configurable per list.
		A custom assist can be set, this will override the automatic behaviour.  If when you use smart assist they have been removed from the list, smart assist will revert back to automatically picking an assist.

Features:
	Automatically syncs to the CTRA tank list
	Add any unit as a custom tank, if the name is found in your raid/party, raid/party's pets, or raid/party's targets it will be shown. This allows you to add bosses to the list and always see who they are targeting.
	Optional Target of Target display for the tanks
	2 Color modes
	  -Self 
	    Unique targets will be given unique colours, your current target will be coloured green.
	  -Unique
	    Unique targets(only one tank on the list targeting them) will be coloured green, targets with more than one person targeting them will be given other colours
	
Changes:
	Version 2.1
	Added option to have the CTRA list automatically add all party members when not in a raid
	Added custom assist to Smart Assist, this sets a person that will always be assisted.
	The entry in the list that will be assisted by smart assist will have thier name text coloured green.
	Added a menu to each assist window, right click to access them
	Added option to show the number of people in your party/raid targeting a tanks target.
	Added option to have the frames grow up from the anchor
	
	Version 2.0b
	Scale settings will now be applied on load
	Updated Korean Localization - thanks gygabyte
	
	Version 2.0a
	Fixed order of libs loading to prevent an error when no other ace2 addons loaded
	
	Version 2.0
	Minor Bug fixes
	Added Korean Localization - Thanks gygabyte


	Version 2 Beta 1
	Complete rewrite - now uses Ace2
	CTRA Tanks are now a seperate list, and keep in sync automatically
	Keep track of mobs targets, add them like you would a player, if any member of your raid/party is targeting them thier target will be shown
	Option to show Target of Target
	2 different ways of coloring the frames
	- Self, targets that match your target will be colored green (same as current behaviour)
	- Unique, targets that are unique in the list will be colored green (for setting up pulls with multiple targets etc)
	Smart assist works differently now
	if the ctra list is enabled it will assist from it, if not from the custom list. You can configure whether the assist is the first or last in these 2 lists.

