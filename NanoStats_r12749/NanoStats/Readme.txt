NanoStats displays your current/previous battle's duration, damage and average DPS, healing and average HPS and the session's total damage and healing. Each quantity can be toggled, and when disabled, the associated processing is not done.

That is all.

No induvidual skill tracking, no raid tracking, no other crap that you don't need. Request these things and I will adjust your definition of 'embarassment.'

NanoStats has been written with the following design goals, which I will stick to relentlessly:

1) Keep the code as lean and fast and LIGHTWEIGHT as possible.
2) Make it run as fast as possible.
3) Keep as tiny a memory footprint as possible.
4) Kill bloat with fire.

NanoStats' parser is tiny. It only uses what it needs.
Others are large and parse all sorts of messages and events that we don't care about. Some others also manufacture tables like they're going out of fashion. NS isn't like that =)

NanoStats also works with ALL locales.
GUI display only has En, Fr and De translations. Again, NS will parse numbers under ALL locales.

Note: Healing is only tracked while in combat. A bunch of people I know were confused about that ;P

To configure, right click the display
To unlock, you have to alt+right-click - I can't change it due to the way things work.