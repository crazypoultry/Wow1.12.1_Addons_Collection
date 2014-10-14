
Current Version
---------------

MozzFullWorldMap (Fan's Update) v2.05.11200





General Description
-------------------

Show Unexplored Areas on the WorldMap, and now also on AlphaMap (Fan's Update)

MozzFullWorldMap is simple: it adds a new checkbox in the upper left of the world map named 'Show Unexplored Areas'. Checking it will do just that.

The default settings mean that unexplored areas appear with a blue/green tinge. I believe this setting is the most useful as it means that you can see all the details of the map, while still being able to identify which areas you have not yet explored.
You can change the behaviour of the AddOn via the Slash commands detailed below, and remove the blue tinge completely, leaving you with a standard view of each map as though you had already explored every area :)

This AddOn is compatible with :
WorldMapFrame,
AlphaMap,
MetaMap (you should disable MetaMapFWM if using this AddOn)

This AddOn adds a 'Show Unexplored Areas' checkbox to your world map.

Uses a hardcoded set of overlay data which duplicates data available in the client.  Since it
also queries the client to find out which overlays should be 100%, it will detect discrepancies
in the client data and record any mismatched or not-present data in a saved Errata table.


Original by Mozz, updated by Shub, and currently kept alive by Telic.





Change History
--------------

Changes in (Fan's Update) v2.05.11200 from v2.00.11200
------------------------------------------------------

- very small change to increase compatibility with versions of AlphaMap (Fan's Update) v2.30.11200 and later
- added a localisation file for anyone who wants to localise the ONE single text string ;)



Changes in (Fan's Update) v2.00.11200 from v2.00.11100
------------------------------------------------------

- Simplay a .toc update



Changes in (Fan's Update) v2.00.11100 from v2.00
------------------------------------------------

- Simply a toc update


Changes in (Fan's Update) v2.00 from v1.10 - Telic
--------------------------------------------------

- made compatible with "AlphaMap (Fan's Update)" so unexplored areas can now be seen in the AlphaMap AddOn.


Changes in v1.10 from v1.02 - Shub
----------------------------------

Fixed bug where entire map was blue when first opened.
Added three commands:
/mozzfullworldmap blue -- shows unexplored areas in blue
/mozzfullworldmap normal -- shows unexplored areas in the normal color
/mozzfullworldmap trans [0.0...1.0] -- makes unexplored areas transparent (0.0 is completely
    clear, that is invisible, 1.0 is completely opaque, the default)



Changes in v1.02 from v1.01 - Shub
----------------------------------

Minor bug fix



v1.00 Updated for WoW Patch 1.10 by Shub


Original MozzPack version by Mozz