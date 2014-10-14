Notes by Andersen, Silvermoon

Summary:
Notes keeps track of notes in an easy-to-use GUI.
Raid leaders and raid assistants can print notes to
raid chat.  Notes marked as "sync" will 
synchronize notes that are printed by someone else
using the notes mod who set their note to 'sync'.

Furthermore, any note can be executed as a LUA script
and called via a macro.  The macro script necessary to
execute the Notes script is easily visible.  This 
essentially makes a nearly unlimited macro length. 
Notes can also hook into the OnUpdate and OnEvent calls 
that WoW makes while playing for easy Add-On Development.

Thanks to Salamengel and Merphle (Author of LuaPad) 
for inspiration. Thanks to Sumul and Shinsplitter for 
suggestions.

use /notes to show the GUI

Features:
* Multiple notes and easy navigation
* Lock notes
* Revert changes to last time the GUI was shown
* Fully functional LUA mode/macro editor
* Note synchronization

---

Note: Printing a note will stagger the 
information printed so raiders have a time to read 
the entire note as you print it.  If you type a message 
while a note is being printed, syncing will not work.

Note: Notes will not sync via whispers or channels
between versions 1.1x and 1.2+

---

Change Log:
v1.3a (11/17/06)
	* Added slider to adjust auto delay amount for printing
	* Increased default delay for long message chunks
	* Success message printed when a Note has completed printing
	* Integrated ChatThrottleLib for support when printing with
		auto delay off
	
v1.3 (9/27/06)
	* Changed the "Go to" page button to link back to the table
		of contents page if you are currently looking at a page
		> Pressing enter after manually typing in a page will
		  still navigate to that page
	* The Table of Contents page is a scrollable list of page links,
		which should make book navigation much better
	* Fixed sync errors with channels
	* Raid syncing will no longer report an error to people in your 
		guild who are in different raids
	* GUI updates will no longer execute when the GUI is not visible.

v1.2 (9/5/06)
	* Removed the checkbox to show or hide the minimap icon
	* Added /notesicon command to toggle the minimap button
	* Added /printnote and /stop commands
	* Added a /printnote macro selection box
	* Added bindings to toggle the Notes UI and minimap button
	* Added support for importing/exporting of mods via files 
		(email your notes)
	* Pages of books that are set to "sync" will sync, even if 
		the page itself is not set to sync
	* Pressing esc will lose focus from the frame.  Pressing esc
		when no field has focus will hide the UI
	* Notes errors will be less annoying
	* Notes should be syncable from the raid leader again

v1.1b (8/23/06)
	* Removed bogus debugging print functions

v1.1a (8/23/06)
	* Added custom note import capability

v1.1 (8/22/06)
	* Added a minimap icon
	* Added "Notebooks" (Compilations of notes)
	* Added multi-select for delete/copy/compile
	* Added communications panel to send notes to 
		other places. Syncing messages only hidden
		when notes are synced through raid chat
	* Added stop printing button
	* Added /runnote command
	* Changed the "important" label to "sync"
		Any previously "important" notes will
		be considered normal after installing
		this version
	* Notes that exist must be flagged as sync to 
		overwrite it with new data.  Notes that are
		not marked sync will not be overwritten
	* Able to sync multiple notes simultaneously now
		(Still only one note can be synchronized at
		at a time per person)
	* Fixed undo functionality
	* Sync notes uses the new CHAT_MSG_ADDON channel
	* The LUA - Setup note is now executed on start up
		This means don't type ReloadUI() in this note

v1.0a (8/12/06):
	* Bug fix for notes synchronization

v1.0 (8/10/06):
	* Initial revision	
