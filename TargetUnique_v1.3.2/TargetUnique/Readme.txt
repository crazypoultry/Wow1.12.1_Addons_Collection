Simple Clean, effective. With a keypress or macro, TargetUnique goes
into "acquisition mode" and watches every target you mouseover,
checking it against targets of other people in your group/raid/CTRA
tank list. If no one is targeting it, it becomes your new target; it's
that simple.

As another feature, a "panic button" targets the nearest enemy that isn't 
targeted by a living tank.

I created this because I began to truly despise hound packs and Garr;
if the person assigning targets uses TargetUnique, the task is over in
seconds. If all tanks have it--well, they can basically do the
targeting for you.

Target Acquisition (mouseover):

  To start target acquisition, either bind a key to "Start/Stop Target 
  Acquisition" or make a macro for "/tuq target".  TargetUnique will
  check every non-friendly npc you mouseover and choose as your new target 
  the first one it finds that isn't targeted by anyone.

  This mode is used to "set up" fights involving many creatures, 
  particularly those with identical names.

Target Acquisition (panic/nearest):

  To acquire "panic targets" (nearest target not targeted by a living tank),
  bind a key to "target nearest unique target" or make a macro for 
  "/tuq nearest"; the mod will iterate through the nearest targets it can
  find (up to 10) and target the first one it finds that is not targeted by 
  a living person in your party/raid/tank/class list.

  Warning: "/tuq nearest" will clear your current target--and WoW's "nearest
  "target" functions don't have a huge range--you'll still need to be 
  pretty close!

Commands:

/tuq target      - begins target acquisition
/tuq nearest     - targets nearest enemy not targeted by a living tank
/tuq log         - begins spouting useless debug information
/tuq toggletanks - toggles "just check CTRA tank list" setting
/tuq config      - opens config panel

