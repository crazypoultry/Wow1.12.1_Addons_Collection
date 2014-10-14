WarriorAlert 0.9.2 by BAW
-------------------------



About
-----
WarriorAlert is an WoW AddOn for warriors. The purpose of the AddOn is to
inform you whenever one of your instant-hit attacks (Mortal Strike, Bloodthirst,
Overpower, Execute and Revenge) is ready to fire. If one of those attacks can be
performed a message will appear on the screen. It does NOT trigger the action
itself, you will still have to press your assigned hotkeys.
It does have plausibility checks though, i.e. the messages will only appear
if you have enough rage and/or the target has less than 20% health etc. Which
messages appear in which stance can be configured



Usage
-----
You can configure WarriorAlert by typing /warrioralert or /walert at the chat
line.
Use /walert unlock to make the message box appear and drag it around with the
mouse. Use /walert lock to lock its position.



To do
-----
- comment the code
- french localization would be nice. I don't speak a single french word, though.
  Any volunteers?
- voice sounds like in OverpowerAlert? Again, any volunteers?



Thanks To
---------
- Interceptor for Overpower Alert, which inspired me to write WarriorAlert
- All contributors to wowwiki.com



Version History
---------------
0.9.2	08/27/06
	- updated to 1.12
	- removed some annoying debug messages you might or might not have encountered

0.9.1	07/15/06
	- should be more class-safe now
	- Overpower message works for dodged special skills now
	- Overpower message is shown more than once a fight
	- Revenge message shows up (more) properly

0.9.0	05/03/06
	- Config dialog is done
	- The position of the messages can be changed. Use /walert unlock to make
	  the box appear and drag it around with the mouse. Use /walert lock to
	  lock its position

0.1.2	01/25/06
	- Fixed the error message if you don't have Mortal Strike skilled

0.1.1	01/24/06
	- Fixed typos
	- Cooldown counting for Mortal Strike works now

0.1	01/23/06
	- Initial Release
	