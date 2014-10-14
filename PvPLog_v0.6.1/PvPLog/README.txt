PvPLog 
Author:            Andrzej Gorski
Maintainer:        Matthew Musgrove
Based on Work by:  Josh Estelle, Daniel S. Reichenbach
Version:           0.6.1
Last Modified:     2006-10-23

README

Installation:
    You should have just downloaded PvPLog.zip
    This file will unzip to:
        PvPLog/
        PvPLog/README.txt
        PvPLog/CHANGES.txt
        PvPLog/TODO.txt
        PvPLog/PvPLog.toc       
        PvPLog/PvPLog.xml    
        PvPLog/PvPLog.lua       
		PvPLog/PvPLogUI.xml
		PvPLog/PvPLogUI.lua
		PvPLog/localization.lua
		PvPLog/MarsMessageParser.lua
		PvPLog/MyMinimapButton.lua

    Place the entire PvPLog directory in your 
    WoW/Interface/AddOns directory.

    
Use:
    PvPLog will automatically log your PvP and duel wins and losses.

    You can enable/disable PvPLog with:
        /pvplog enable
        /pvplog disable
    When disabled PvPLog will *not* track any of your PvP activites.

    When you win/lose a PvP battle, or duel, PvPLog will notify you
    as the data is recorded.
    
    Whenever you mouseover someone for which you have a PvP record
    the mouseover tool tip will contain the number of wins and
    losses you have against that player (provided that option is enabled).
    It will also produce an audible ding on mouseover to inform you of
    a player you have a record with (if you have the ding sound enabled).
    At this time a message is also displayed overhead with your record
    (if you have the display enabled).

    When targetting a player you have a PvP record with, your record
    will be displayed below the target window.  This text is movable.
        /pvplog targetreset
            May be used to reset the text to its original position.

    You may enable or disable the floating text display.
        /pvplog display [enable|disable]

    You may enable or disable the ding sound.
        /pvplog ding [enable|disable]

    You may enable or disable the mouseover effects.
        /pvplog mouseover [enable|disable]

    You may disable all spam effects (mouseover, ding, floating
    display).
        /pvplog nospam

	You may open the configuration window that allows you to set
	most of the options.  
		/pvplog config
	This window can also be opened by right-clicking the PvPLog minimap
	button.  If you have Cosmos installed then a button will be added
	to the Earth Features Menu (or the Khaos menu if the Earth Features
	Menu is disabled) that will open and close the configuration window.
	If you have the myaddons addon installed then it will be added there
	as well.
	
    You may get some basic statistics using:
        /pvplog stats
		
	You may view your PvP stats in a window using:
		/pvplog pvp
		
	You may view your duel stats in a window using:
		/pvplog duel

    You may get the version of PvPLog with:
        /pvplog version

    You may get the vendor tag of PvPLog with:
        /pvplog vendor

    You may reset your PvPLog settings using:
        /pvplog reset confirm
    Be careful as this will erase all your records!

	
    If you have any comments, questions, or suggestions, feel free to 
    email me at:
           Matthew Musgrove <mr.muskrat@gmail.com>

    Updates for PvPLog are available from these AddOn sites:
    * http://www.wowroster.net
