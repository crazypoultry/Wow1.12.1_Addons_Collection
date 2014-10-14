Critastic v. 0.5
  By Gearshaft of Zul'jin
  October 7, 2006

http://www.Orgrimmar.org/


About

This addon will emote when you get high crits. It also stores your highest crit for you, and remembers what mob it was on. Critastic stores damage crits (/crit) and healing crits (/critheal) independently. You can set what the emote will say for each damage and healing, and set the emote threshold (the number your crit must be higher than to do an emote.) The threshold can be set to a fixed number or to a percent of your highest recorded crit. Example: /crit 2500 or /crit 90%. The emote text supports variables too. Here's the variables it supports:

%c = last crit
%t = last crit target
%s = last crit spell
%hc = highest crit
%ht = highest crit target
%hs = highest crit spell
%p = your name

Thats it. Happy critting.


Why?!?

I wrote this for a friend initially because the other similar mods didn't do exactly what I wanted. Needed more customization options etc. 


Changes

0.5
    - Added percentage based crit emote threshold support. This will dynamically adjust the threshold amount when your highest crit changes.

0.4
    - Fixed an issue where all non-variable letters in emotes would be lowercase, instead of how you typed them.
    - Isolated damage crits from healing crits. The damage interface is accessable via /crit and the healing interface is /critheal. All commands, variables, and settings for both interfaces are identical but independant.

0.3
    - Added support for healing crits.
    - Changed the default emote to include more info. (/crit resetall - to use it if you have Critastic installed already)
    - Cleaned up some code and made some code optimizations.

0.2
    - Added storing of the used spell in the crit. It's accessable via %s for your emote, and %hs for your highest spell crit.
    - Fixed a conversion to number bug.

0.1
    - Initial Release

