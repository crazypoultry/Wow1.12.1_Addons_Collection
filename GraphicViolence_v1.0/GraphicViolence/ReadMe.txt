Graphic Violence
Author: Abenadi | Kel'Thuzad US

Graphic Violence is a combat log graphing mod that records healing, damage done, and damage received. It also graphs your group's health over time and marks other combat log events that can't be quantitatively graphed. One of the most useful features is being able to filter the graph for certain key words.

-----
USAGE
-----
No setup is necessary - the addon will appear in the middle of your screen when it is first loaded, and will start with a maximum y-value of 1000.

* Default Values: Type /gvreset to reset combat log data and y-maximum.

* Move the GV interface: Click and drag the top title bar anywhere on your screen.

* Resize: Click and drag the bottom right corner of the GV interface.

* Look at older combat log data: Click and drag an empty area on the graph to the left and right to change the timespan displayed. If you drag the graph into the 'future', the graph will automatically snap back to display the newest information on the far right. Combat log history is discarded after about 20 minutes to avoid hogging system resources.

* Change Y-scale / maximum damage displayed: Scroll your mouse-wheel up or down while the mouse is over the graph; the maximum damage displayed will increase or decrease by 10% with each scroll with a minimum of 50 and no maximum.

* Display event detail: Move your mouse over any bar or dot on the graph to display the events for that category and second. You may have to temporarily disable displaying of some categories to view the event details of overlapping bars (see "Toggle categories").

* Toggle categories: Check or uncheck the boxes in the lower left to change which categories of events to display. Data will continue to be collected for unchecked categories. The categories are:
	Health: green
	Damage done: blue
	Damage received: red
	Healing done: white
	Player deaths: yellow
	Non-quantitative combat log events: orange

* Filter events: Type the criteria you wish to search by in the textbox. Press ENTER when finished. Clear the textbox and press ENTER again to stop filtering the data. The filter will be applied to all categories; combat log data will only be graphed where the text of the combat log event contains the search term. For example you can type the name of a group member to show the damage done to or by that group member (if the member's name is also the name of an ability or is otherwise generic, there may be additional data displayed), or type 'backstab' while soloing to show your backstabs. Your filter can contain more than one word, for example, "Hateful Strike" while fighting Patchwerk will only show his hateful strikes against off-tanks. Search terms are not case-sensitive.

--------------
Change History
--------------

1.0
	- First public release

1.1B
	- There is now a readme! This is it!
	- All borrowed images have been replaced with self-authored images.
	- Added more complete, player-searchable health history.
	- Changed from dots to primarily bars to enhance visibility and ease of detail display.
	- Improvements to detail display (no longer displays behind graph).
	- Layer improvements.
	- Various minor bugfixes.
	- Adjusted limit on data history.
	
1.0B
	- First release - private beta
