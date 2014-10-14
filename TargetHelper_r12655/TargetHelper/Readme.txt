
TargetHelper
============

You get a Key that helps you quickly find a free target for you
by doing a "Target Nearest Enemy" ( Usually <Tab> ) until it finds a suitable target.
This means, it only searches for Targets in the same area that <Tab> does.

For this classes it will check against all group or party members to find a free target
that nobody else in your group or party is targeting:

DRUID:   Beast  or Dragonkin
MAGE:    Beast  or Humanoid
PRIEST:  Undead or Humanoid
WARLOCK: Demon  or Elemental

In case of the Warrior we just make sure that we don't have the target of another warrior:

WARRIOR: Will search a target that no other Warrior in your group or raid is targeting.
