BigMinimap
---------------------------------------------------------------------------

Provides a binding to toggle the size of the minimap between 1.15 and 2 times
the normal size.

Should appear in the bindings menu as "Toggle Big Minimap"

---------------------------------------------------------------------------
COMMAND LINE

Use the /bigminimap or /bmm command.

/bigminimap
    Display current settings

/bigminimap smallscale <scale>
/bigminimap bigscale <scale>
    Set scale factor for either size. E.g. /bigminimap bigscale 3.0

/bigminimap auto on
/bigminimap auto off
    Set automatic sizing option to on (new behaviour) or off (old
    behaviour). If set to 'on' then it will periodically check the
    scale and reet if it doesn't match (Fixes instance issue, etc)

/bigminimap buffslide on
/bigminimap buffslide off
    Set whether or not buff windows should slide to line up with the
    leftmost edge of the minimap, or whether they should be in their
    standard locations.

/bigminimap reset
    Reset all configuration parameters to their default values.

---------------------------------------------------------------------------
VERSION HISTORY

0.9 2006-01-03
* Fixed buffslide (I think) relative to new new 1.9 frame parenting.
* Workaround for minimap scale propagation bug.

0.8 2005-08-07
* Fixed buffslide so that it moves debuffs properly.
* Fixed buffslide so that gm ticket indicator doesn't reset slide.

0.7 2005-07-19
* Fixed buffslide option overlap on second weapon enchant

0.6 2005-07-18
* Added buffslide option

0.5 2005-03-01
* Added configurable options
* Added option to auto-apply large scaling (DEFAULTS TO ENABLED)
* Added command line /bmm

0.4 2005-02-05
* Set binding description properly!
* Added 'temporary' keybinding

0.3
* Set binding description

0.2
* Correctly sets state of minimap zoom buttons

0.1
* Initial version




