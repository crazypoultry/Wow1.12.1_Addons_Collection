--- RamzClock ---
DESCRIPTION:

Simple and easy to use digital clock with an ability to set different local and server time.
Includes cooldown tracker.

INSTALLATION:

Simply unpack archive to the folder <WoW Folder>\Interface\Addons

SETTINGS:
- You can draw program window using mouse + Shift 
- Time sliding sets in this way:
  	Alt+leftclick - 1 hour forward
	Alt+rightclick - 1 hour back
- Ctrl+right click opens configuration window dialog

SLASH COMMANDS:
- /ramzclock - displays help
- /ramzclock config - opens configuration window dialog
- /ramzclock reset - loads default settings


VERSIONS HISTORY:

--- v.1.8 ---

WHAT'S NEW:

- 30 minutes time ajustment feature
- Now you can tell clock to show current date.
  Also you can ajust date format. There is no ingame help for date format ajustment atm.
  Please refer to C function 'strftime' manual to find out more information about it.
  I've placed this manual into a file 'strftime.txt'. Also please note that not all conversion specifications will be work correct.
  So use it at your own risk.
- TOC file updated according to path 1.12

--- v.1.7 --- 

WHAT'S NEW: 

- New .toc file for patch 1.11


--- v.1.6 ---

WHAT'S NEW:

- Both 12 and 24 hours time formats are supported
- Configuration window
- New feature. Cooldown Tracker. Mod automatically detect if you or your other characters
  has active cooldowns and shows time left to its expiration.
  Also mod can send notifications to the chat window on any cooldown expired.
  You can track cooldowns and send notifications for character you currently playing 
  or for all characters on your account.
  To update cooldowns you have to open or close trade skill window.
  Also mod keeping an eye on all things that you're doing in trade skill window.
  It trying to intercept any successful crafting process events, check cooldown
  and set it if necessary (this feature might be not work in some cases
  that still not clear for me).
- Several SLASH commadns were added.
- Default position of clock window changed.
- Fixed alot of bugs. Damn it. Hope i didnt bring new ones :)


--- v.1.1 ---

WHAT'S NEW:

- Clock display is smaller and IMHO better-looking.
- Time set keys are removed (read below about how to set the time).
- Options were debugged. 
- Window drawing function was changed.
- Mod is fully compatible with API 1.10.
