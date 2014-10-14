UseByName - v12

Syntax:
/usebyname <item>
<item> is a case insensitive substring match or a regex.
Search starts in pack 0 slot 0 and runs to pack 4 slot N.

Use the first available bandage:
/usebyname bandage

Use a lesser healing potion:
/usebyname Lesser Healing Potion

Use anything that begins with less:
/usebyname ^Less

Use anything the ends in good and contains head:
/usebyname .*head.*good$

Note:
After WoW client version 1.6, you can no longer use /usebyname
typed as a command or called from another addon.  You must
create a macro and make an action button for it to work.
This was done to prevent macros auto-using items.

** CapnBry <bmayland@capnbry.net> **

Version History:
12 - Fix syntax error, missing 'end'.
11 - Interface version 11200.
10 - Interface version 11100.
9 - Interface version 11000.
8 - Interface version 10900.  
7 - Interface version 1500.
6 - Interface version 1300.
5 - Interface version 4216.
4 - Interface version 4222.
3 - Interface version 4211.
2 - Interface version 4150.
1 - Initial
