CensusPlus - by Rollie of Bloodscalp aka Cooper Sellers

  WEBSITE

   http://www.warcraftrealms.com/

  VERSION

    3.5.1 - 10/07/2006 - Update
	- Finally put in place a way to do a normal /who while census is running
		-  If your /who returns more than 3 results, the friends frame window 
			will be displayed and the census will be paused
	- Added an audible sound that can be played with the census is complete.  In addition
		an option has been added to the options panel to disable this feature.
	- Moved the Verbose option to be a character specific option
	- Added Spanish Translation, props to Nekormant of EU-Zul'jin for this translation
	
    3.5 - 08/29/2006 - Update
	- Updated TOC for patch 1.12
	- New commands:
		/census take - allows you to start a census via command line
		/census stop - allows you to stop a census via command line
	- Added a right click menu to the mini-map button to allow you to do common
		census functions like Take, Stop, and Pause
	- Added a player list feature that will show you the list of players for currently
		selected filters in the display.  This list is capped at 1000 players.
	- Modified the locale detection to hopefully clear up locale issues
	- Added battleground wait time collection information which will soon start being reflected
		on the site
	- Removed the restriction on taking census snapshots while in battlegrounds
	- Made efforts to removing the lag created when a census finishes.  You will likely still
		see the lag if you have the Census window open when a census completes, but if it
		is closed, there should be no noticable lag.
	

    3.4 - 07/03/2006 - Update
	- Updated TOC for patch 1.11
	- New commands:
		/census timer ## - will set the timer for the autocensus function (in minutes)
	- Added a confirmation box when you hit the Purge button
	

    3.3 - 03/30/2006 - Update
	- Updated TOC for patch 1.10
	- Added a couple of new commands:
		/census who XXXX - will return any local data you have where a character name or guild
				matches (partially or fully) the given term
		/census who unguilded ## - where ## is a level, will return all unguilded characters
				of that level
	- Attempt at removing the extra 3 or less spam for German clients

    3.1 - 1/03/2006 - Update
	- Many fixes pertaining to profile data gathering
	- Added method to determine regional servers (EU vs US)
	- Added fixes for searches and battlegrounds
	- Added pruning options, can now do the following:
		/census prune x - prunes data older than X days
		/census serverprune - will prune all data other than the current server
	- Several other minor fixes and tweaks
  
    2.0 - 4/23/2005 - Update
        -Friends panel will no longer even attempt to open if the auto-close who is selected.  This 
            allows any other panels to be open during a census and they will not close or change your
            view.
        -Mini-Census button is now moveable.  You'll have to click just around the button to move it
        -Added PVP Honor tracking.  This will be viewable on the site soon.
        -Modified the time tracking, cool new stats on the site to follow soon.
        -Added in some regional server detection.  Please note if you get any error messages detailing
            that the Mod thinks your locale should be set differently and let me know about them.
        -Auto-census will no longer start as soon as you log in and will instead wait 5 minutes.

    1.8 - 3/23/2005 - Update
        -Silenced the Friends panel clicking when opening and closing during a census
        -Implemented the new time() and date() APIs
        -Removed /censusdate
        -Added option to take auto-census
        -Added option window

   1.4 - 2/4/2005 - French and German localization
   1.3 -            - Small bug fix for error in 1.2
   
   1.2 - 1/19/2005 - Update
        -Fixed a bug with a current census that is paused becoming unpaused when you close certain windows. 
        -Added a /censusverbose command that will toggle the CensusPlus messages on/off. 
        -Modified the way a census is taken. Instead of the divide and conquer style used that started a census 
            with 1-60 and going from there, it will now start in 5 level increments and divide if necessary. 
        -Added guild support. The mod will now capture guild data when viewed on the guild panel. This data 
            is used to provide more comprehensive data on the site and is available through the guild exports. 
        -Added a tracking feature that will allow tracking of the number of characters seen during a census. 
            This data is displayed on the Activity Page 
   
   1.0 - 1/10/2005

  INTRODUCTION

    CensusPlus came about due to requested changes and desired options
    not present in the original Census UI Mod by Ian Pieragostini.
    
    I spoke with Ian and he has lost interest in World of Warcraft modding
    and encouraged me to modify the Census Mod to my liking.  Thus I
    have done so.
    
    The original Census UI Mod basically took snapshots of your current
    realm and faction.  You could keep this data and combine it with 
    other snapshots to provide greater statistical analysis.
    
    CensusPlus offers many features above and beyond what the original Census
    UI mod provided.  Here follows a list of added features:
    
        -  Abilty to minimize the main census window
            which provides you the abilty to actually play while a census
            is being taken
        -  Ability for the Friends panel not to be shown after
            each /who is sent to the server.  This keeps the UI open from 
            the main Census window
        -  Ability to pause and unpause the current census
        -  Ability to stop the current census in progress
        -  Added a date information which allows the user to place a
            date timestamp on all characters that are found during census's
            taken that day --  This helps facilitate greater accuracy in 
            results when census data is uploaded to www.warcraftrealms.com
        -  Data on number of characters seen during the census snapshot.
        -  Collection of Honor points data.

  USAGE
  
    Unzip the files into your %World of Warcraft/Interface/AddOns directory.  It
    should create a CensusPlus directory with the installed files.
    
    If you have Cosmos installed, CensusPlus will register itself with Cosmos
    and you can invoke the Census window by selecting the CensusPlus option from
    the Census menu.
    
    You can also invoke the CensusPlus window by typing /censusplus or /census+
    
    You can select to not open the Friends panel when a /who is sent.
    
    You can select to automatically display the Mini-Census button which must be
    visible in order for a Census to be taken while the main Census window is 
    minimized.
    
    By selecting the Take button from the main census panel, you will initiate a
    Census snapshot.  Depending on the population of your realm and faction, this could 
    take several minutes.
    
    Clicking the Purge button will purge all your collected data from your local Census
    database.
    
    Clicking the Stop button will stop the current census if one is in progress.
    
    Clicking the Pause button will pause the current census if one is in progress.
    
    If you so choose, you can upload your collected census information to 
    http://www.warcraftrealms.com    Doing so will greatly help in the tracking
    of your realm and faction's population numbers and statistics.
      
    
    


