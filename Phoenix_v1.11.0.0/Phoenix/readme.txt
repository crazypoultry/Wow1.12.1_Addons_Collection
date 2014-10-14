Phoenix Developer's Addon.
Version 22-Jun-2006 1.11.0.0

==============================================================================
History
==============================================================================
1.11.0.0- Toc bumped to 11100, couple of minor fixes
1.9.0.0 - Toc updated to 10900
1.7.0.0 - Fixed /pxs command. Esc now closes devpad. Toc updated to 1700
1.6.0.1 - Fixed scrollbar bug. Now you can have longer scripts and scroll them
1.6.0.0 - Interface updated to 1600
1.3.0.1 - Internal object identifier is added to print out when dumping an
          'unprintable' type. This is sipposed to help keeping track of the 
          same 'unprintable' values between different dump runs.

==============================================================================
Introduction
==============================================================================

In this addon I tried to make my life as an addon troubleshooter as easy as
possible. I didn't want to spend a lot of time writing everything from scratch
so I just consolidated useful functions from different addons into a single
one. Please refer to Credits section for the information on addons that I have
used.

This addon won't be of much interest for a regular user, although it can
provide some service for an advanced user. Here is what the features of this
addon:

* Allows to write, store and execute named code snippets
* Allows to hook up code snippets to different warcraft events
* Doesn't have any addon dependencies. 
* Ability to call code snippets by name both from other snippets and by a 
  chat command
* Built-in function for running a chat command form a script
* Ability to run a start-up script
* Built-in function and a chat command for dumping content of a variable, with
  a support for looping structures
* Displays script errors in a chat window
* Ability to display Phoenix output in a dedicated chat frame
* Short aliases for most of chat and script commands

In this file terms 'code snippet' and 'script' are used interchangeably.

==============================================================================
User Interface
==============================================================================

The user interface is quite obvious, so I won't go into details here. To show
the UI type '/pxt' or make a keybinding that suits you. I personaly bound the
UI toggle to Ctr-D (D - DevPad). When UI is shown 'New Script' button will
create a new code snippet, 'Delete script' button will delete a code snippet
currently showing, and 'Run Script' will run currently showing script. Click
differntert code snippet buttons to switch between scripts you wrote.
Initially there is no code snippet buttons because you haven't written a
snippet yet. One pecularity of the UI is that there is no 'Save' button, an
entry is saved on lost of focus. I'm not sure that I liek this design, but
this is how Notepad works, and I ddin't what to spent too much time on
modifing its behaviour. Put your script name into the 'Name' edit box, this
way you'll be able to tell one script from another. 'Event' check box is for
marking script as an even handler, please refer to Event Hookup section of
this document.

==============================================================================
Run Script
==============================================================================

There are 3 ways to run a named script. 

* You can select your script in the UI and the press 'Run Script' button
* You can type '/pxs scriptname', where scriptname is the name of your sctipt.
  You can include this in your macros too. And you can drag those macros to
  an action bar as you do normaly to assign a keybinding to it.
* From a script you can invoke a named script by calling pxs function as
  folows: 'pxs("scriptname")', where scriptname is the name of your sctipt.

When a script is executed there is two special variables that you can access 
from inside the script. 'pxname' variable will give you the current running
script name (string) and 'pxevent' will let you know id the script is executes
as an event handler or not (boolean). For more information on event handlers
see Event Hookup section of this document.

==============================================================================
Startup Script
==============================================================================

If you name one of your scripts 'Startup' it will be executed on 
VARIABLES_LOADED event.

==============================================================================
Event Hookup
==============================================================================

If you name your script as one of World of Warcraft events you'll be able to
process this event in your script. For doing this you will need to check
'Event' check box of the UI when your script is selected. For example you may
name your script 'ZONE_CHANGED_NEW_AREA'. Write 'pxp("you changed an area!");'
as your script body, select 'Event' check box and when you cross an area
border you will see this message in your chat window. If an event has
parameters you can access them the usual way through 'arg1' - 'arg9' global
variables. Sometimes when you doing some complex debugging and have lots of
event hooked up you want to play game for a while without all this processing
behind, but then you want return back to monitoring the same event. There is
event override flaf that serves this purpose. If it's on all event handlers
will be ignored. To togle this flag run '/pxv 'chat command. You can use a
keybinding as well. I usualy bind it to Ctrl-E (E - Events).

==============================================================================
Phoenix output
==============================================================================

You can select to which chat frame Phoenix will write all its output.
Sometimes I find it usefull to create a separate 'Debug' chat frame that will
have all script errors and any Phoenix output and nothing else. Create a new
chat window as you do normaly. Then run '/px chat [name]' command. Specify
your new window name as name paramater, i.e. '/px chat debug'. If there is no
window with such name the output will be printed to the default chat frame. If
you just type '/px chat' the current window name for Phoenix output will be
printed.

==============================================================================
Script Errors redirection
==============================================================================

Normaly script erros is displayed in a popup window. Most of the time I find
this annoying. You can toggle between this default behaviour and printing
errors in the chat window by typing '/pxc'. Or you can use a keybinding. I
usually bound this to Ctrl-C (C - Chat). While in this mode all errors printed
will be interanly saved, and can be printed again on demand. '/pxe' command
will print all the accumulated errors, while '/pxe [last]' command, where last
is the number of last errros you want to see will print only so many last
erros. If some script just keep generating same error repeatedly you can make
it shut up by changing the timeout parameter. For example if timeout is set to
10 seconds then if the *same* error is generated within 10 seconds from the
previous it will not be displayed. It doesn't affect *different* errors. The
default for timeout is 1 second which is good for most situation. In case you
want to increase it type '/px timeout [length]', where length is number of
seconds for the new timeout. If you just type '/px timeout', the current time
out will be displayed.

==============================================================================
Expression Dump
==============================================================================

The expression dump feature is designed to allow dump of an expression result
to the chat window. While trivial for 'flat' values can be of a trmendous help
for tables. Type '/pxd expression' to dump an expression. To do the same from
a script use the follwing function 'pxd(expression)'. To understand how this
feature work it's necessary to remember different types of lua variables.
These are:

* nil
* boolean
* number
* string
* function
* userdata
* thread
* table

function, userdata and thread are 'unprintable' in terms that having a
variable of that type we can't find out what's inside. So we will just print a
variable type and some id (more on this later) for the unprintables. All the
type but a table type are 'flat' types, meaning that the content of such a
variable can be printed in a single line. Tables is the most complex structure
for printing because both index and value of a table can be of *any* type. The
dump feature allows to print nested tables, identing each level of nesting.
For the flat types each table entry is printed like '[key] = value;'. If a
value is of a table type it will get printed on the next level. Unprintable
types are assigned ordinal id. This way it can be seen in a dump if two
unprintable in the structure being dumped are the same (have the same id) or
different. If a table that already has been printed (or being printed) occurs
in a deeper level it won't get printed causing infinite loop, instead a string
referense to the apropriate table will be printed. If a key of a table is a
table itself then it doesn't get printed unless it was printed on a higher
nesting level. This table will be treated as unprintable instead. It's
implemented this way because I don't know how to handle it better, and the
situation when it happens is quite rare. It's possible to print the contents
of such 'unprintable' table, because all such tables *from the last dump
command* is stored in an internal varible. You have to type '/pxd table
number' where number is the table id displayed in the previous dump. '/pxd
table name' command will print out a referenced table form the last dump,
where name is the refernce name. It's rarely useful because referenced table
is always a part of original dump anyway. The table references highlighted
with yellow color in output, while unprintables highlied in green.

There is a built-in feature to limit the following criteria while dumping

* maximum nesting level
* maximum string length
* maximum number of elements in a table

The follwing commands control these parameters:
'/px dump depthlimit [number]'
'/px dump stringlimit [number]'
'/px dump entrylimit [number]'

When number is not specified the command prints the current value. Zero means
no limit.

The loop tracking mentioned above can be controlled by the following comand:
'/px dump trackloops [true|false]'

The number of spaces of identation for each level is set as follows:
'/px dump ident [number]'

'/px dump show' command displays the values of all 5 options.

==============================================================================
Script Commands
==============================================================================

Here are commands (with their short aliases) that is invokable form script as
functions:
* Phoenix_RunChatCommand or pxc(command), ex: pxc("/say hello").
  This command sends a chat command as if user entered it manually.
* Phoenix_RunScriptByName or pxs(scriptName), ex: pxs("myScript");
  This command runs a named script.
* Phoenix_Print or pxp(msg, chatFrameName, ...), 
  ex: pxp("Val: %d","Combat",val)
  This command prints out a string into standard Phoenix output chat window.
  if the second prameter is not nill, then it specifies the chat window name
  the string to be printed to. The rest of the parameters are for 
  string.format function, please refer to lua documentation on that.
* Phoenix_DumpExpression or pxd(expression), ex: pxd(DEFAULT_CHAT_FRAME)
  This command dums a given expression in the chat window.

Here are special variables accessible from scripts:
* Phoenix_Script_Name, pxname (string )- the name of current executing script
* Phoenix_Script_Is_Event, pxevent (boolean) - is the current executing sript
  is runing as a handler for an event.

==============================================================================
Chat Commands
==============================================================================

Here is a brief list of chat commands, please see relevant sections for
specific details.

/px - Displays this help
/px script - Displays brief help on script commands
/px chat [name] - set/show to which chat window Phoenix prints all the output
/px timeout [length] - set timeout in seconds to suppress repeated errors

/px dump show
/px dump entrylimit [number]
/px dump stringlimit [number]
/px dump depthlimit [number]
/px dump ident [number]
/px dump trackloops [true|false]

/pxt - toggles Phoenix DevPad
/pxv - toggles event override. When on no event handlers are invoked
/pxr - reloads ui (Shortcut to /console reload)
/pxl - lists hooked up events
/pxs script - runs DevPad script by name
/pxc - toggle chat errors
/pxe [last] - displays all or specified number of last script errors

/pxd expression - dumps expression result
/pxd table number|name - dumps a named table from previous dump

==============================================================================
Key Bindings
==============================================================================

Here is the list of key bindings you can define for Phoenix.
* Reload ui (/pxr chat command)
* Toggle DevPad (/pxt chat command)
* Toggle event override (/pxv chat command)
* Toggle chat errors redirection (/pxc chat command)

==============================================================================
Known Bugs
==============================================================================

* There is a known issue with the name edit box. Sometimes when you have a 
  very long script name, as you click through your script buttons, the short
  names are not entirely displayed. I don't know how to fix this. If you
  expirence this problem and know how to fix this, let me know.

==============================================================================
Credits
==============================================================================

Here is list of addons most of the code and ideas were borrowed from:

* Notepad by Vladimir Vukicevic
  http://www.wowwiki.com/Notepad
* DevTools by Daniel Stephens 
  http://www.vigilance-committee.org/wow/downloads/
* ReactiveMacros by Jooky
  http://www.curse-gaming.com/mod.php?addid=394
* EventCatcher by The Nerd Wonder
  http://showlevel.50megs.com/ec.html
* Luapad by Merphle
  http://www.curse-gaming.com/mod.php?addid=620
* ImprovedErrorFrame by Vjeux
  http://www.wowwiki.com/ImprovedErrorFrame
