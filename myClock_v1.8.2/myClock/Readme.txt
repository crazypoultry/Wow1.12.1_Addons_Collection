myClock v1.8


Description
===========

myClock is a World of Warcraft AddOn. It's a movable/lockable digital clock.
The time can be offset from the server time.


Install
=======

Extract the files into your ..\World of Warcraft\Interface\AddOns directory.


Features
========

* Show/Hide clock
* Show/Hide Day/Night button
* Movable/Lockable
* 12/24 hours time format
* Time offset from server time
* Options window
* Options saved per character
* Localization (english, french, german)
* Low memory usage (~0.1MB)
* myAddOns support


Usage
=====

To access the options window, you can use the "/myclock" command or the myAddOns
AddOn.

The default options are:

	- Show Clock = Yes
	- Show Day/Night Button = No
	- Lock Position = Yes
	- Half-hour Offsets = No
	- Time Format = 12 Hours (24 Hours for DE and FR clients)
	- Offset = 0 Hour

myClock can be loaded on demand by an ingame AddOn manager like myAddOns. If you
want to use this feature, you have to enable it by adding the following 4 lines in
the myClock.toc file:

	## SavedVariablesPerCharacter: myClockOptions
  1 =>	## LoadOnDemand: 1
  2 =>	..\..\FrameXML\Fonts.xml
  3 =>	..\..\FrameXML\UIDropDownMenuTemplates.xml
  4 =>	..\..\FrameXML\UIPanelTemplates.xml
	Localization.lua
	...


Known Issues
============

* None


Versions
========

1.8 - March 30, 2006

* Removed load on demand

1.7 - October 15, 2005

* Added load on demand
* Added options saved per character

1.6 - October 1, 2005

* Updated myAddOns support
* Added show Day/Night button option
* Added half-hour offsets option
* Removed all slash commands except "/myclock"

1.5 - March 25, 2005

* Added offset saved per account and per server

1.4 - February 4, 2005

* Added german localization
* Added options window
* Added myAddOns support
* Removed settings command

1.3 - January 28, 2005

* Added offset option
* Added about command
* Added settings command

1.2 - January 26, 2005

* Fixed display in 12h format for DE and FR clients
* Added localization.lua file

1.1 - January 24, 2005

* Added french localization
* Added time format option
* Added options save

1.0 - January 12, 2005

* First version released


Contact
=======

Author: Scheid (scheid@free.fr)
Website: http://scheid.free.fr

