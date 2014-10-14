Frowning Circle by Raknor
Version 1.2

Frowning Circle is a Shaman addon that simplifies the use of totems.
Using a single hotkey, Frowning Circle cycles through the selected totems
and casts them. It has a smart recast option so only totems who aren't
already active get recasted.
On the configuration dialog (see screenshot.png) you can select a totem from
each school.

Installation
------------

- Extract like any other addon
- After starting the first time, set a hotkey at least for the configuration
  dialog and the totem throwing in the key bindings dialog.
- Open Frowning Circle configuration dialog and select your totems
- Hit the "Throw totem" key 4 times to surround yourself with a circle of
  ever-frowning totems.

Smart Recast
------------

There are two types of totems: Defensive and offensive.
Defensive totems provide you with some sort of buff, offensive totems don't
provide a buff.
If smart recast is enabled, Frowning Circle won't cast defensive totems which
still provide you with the corresponding buff.
However it is not possible to detect wheter an offensive totem is still
active. So for this the offensive delay is used. If you cast an offensive
totem, Frowning Circle cannot recast it until after the amount of time
specified by the offensive delay has passed. Last cast times get reset if you
switch totem sets or made changes in the configuration dialog.

Using buttons instead of hotkeys
--------------------------------

Some users prefer to use slow buttons instead of quick hotkeys. Frowning Circle
supports this too: Just create a new macro, add one of the following commands
and drag the macro onto an action bar:
- Throw totem:
  /script FrowningCircle_ThrowTotem();
- Open configuration dialog:
  /script FrowningCircle_ShowConfig();
- Change active totem set:
  /script FrowningCircle_ShowConfig(set);
  Replace set with one of the following:
  - 1
  - 2
  - 3
  - 4
  - 5
  - "next"
  - "prev"

Credits
-------

- Addon written by Raknor on EU Stormreaver
- Derkyle for adding Tranq totem support

Special thanks to Norfie and Amtractor for letting me test this addon with his Shaman.