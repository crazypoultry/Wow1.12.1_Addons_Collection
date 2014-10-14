FYI: you can use following plugins to FelwoodGather interface inprovement.
- for  Titan Panel users: TitanFelwoodGather
- for FuBar usees: FuBar - FwgFu
You can find the link at dependencies section.

<important>
- 0.81 mini-map size changed. You should use /fwg reset once.
- If you use 0.80c or earlier, you will get error when someone share songflower buff timer.

Description
------
FelwoodGather helps you and your team mate with felwood fruit gathering, location and timer management.
Whipper Root Tuber, Windblossom berries, Songflower, and Night Dragon's Breath are available.
This addon's main purpose is the timer management for each objects easily.

Feature
------
- Present landmark of Whipper Root Tuber, Windblossom berries, and Night Dragon's Breath with their icons, on world detail map.
- After you got the fruit, display estimate timer on landmark label.
- Highlighten the next spawn timer label.
- Start timer automatically when you got the fruit.
- Notify you with sound before the fruit respawn. default ETA 5min and 1min(configurable).
- Exchange timer with your team mate.
- Reset/announce/share/start/clear the timer from popup menu.
- Original minimap window.

Usage
------
You can use it only drop the files to AddOns folder. No required dependancy.
You can see the information on felwood map window.

* Commands
slash command is /fwg or /felwoodgather. following subcommands available.
/fwg share
  If you want to share the timer you have with your rosters, type this.
/fwg config
  Toggle Configuration window.
/fwg count
  Countdown caller. Do not monopoly the objects. keep window open and pick up together.
/fwg map
  Toggle FelwoodGather map window
/fwg reset 
  Reset FelwoodGather map position
/fwg minimap
  Toggle minimap icons

* Configuration window
 You can customize 
  - Accept timer: If unchecked, your timer does not update by group rosters.
  - Share timer: send timer to your rosters when you loot.
  - Show Minimap Icons: If checked, show fruits icons on your minimap.
  - Minimap updtate interval: interval of update minimap icon info.
  - Notify: If checked, you will get notification with sound effect.
  - Notification 1/2: Time that will notify.
  - Transparency: Icon and label setting on worldmap.
  - Icon size: scale for icon on worldmap.
 Also, you can customize map window from right click menu from minimap title bar area.
  - Transparency: Transparency of minimap window.
  - Scale: Scale of minimap window.

* Menu 
Click the fruit icon. 
 You can Reset / announce / share / start / clear the timer.
 "mark as depop" marks the object which has being despawn.
Right click minimap title bar.
 You can lock/configration minimap/share the timer.

* Bindings
You can key binding following functions.
 Toggle Config Window - Same as /fwg config
 Countdown call - Same as /fwg count
 
* Timers
You will see the timer on world map.
ETA > notification 1                  - green label
notification 2 < ETA < notification 1 - yellow label
ETA < notification 2                  - red label
the timer will spawn next             - white label(highlight)

* Minimap Icons
 show fruits icons if it's in range.
 show half-transparency fruits icons on around minimap if it's not in range but near.
 show yellowed fruits icon if you have timer. it will spawn next.

History
------
0.98
- fixed bug Unknown message: CHAT_MSG_ADDON if you use the other addon which use AddOn message.

0.97
- Addon Message support. you can share the timer automatically when you loot something.
- Change german "call the loot timing" message.

0.96
- RaidLeader channel support.

0.95
- Fix bug the least recent object was shown outside of felwood.
- Fix bug the minimap icons does not hide if you gate out.
- Change minimap icon interface. 
- Change configuration window.
- Remove duplicated Tooltip definition from FelwoodGatherMap.xml
- Fix tooltip related problem.

0.941 bata2
- Fix bug no update minimap icons without map window.
- Objects location get detailed. you may fix timer start related problem.
- Added direction which least recent object on minimap.
- Added minimap tooltip.
- Added information how times you get loot in this session on tooltip.
- Added show minimap icons and it's interval setting on config window.

0.94 beta
- Add Gatherer like Minimap POI. You can toggle show/hide these icons by /fwg minimap
- Change count down caller message for some reason.
- TODO: add direction which least recent object on minimap.

0.91
- Fixed buffname nil value issues on FelwoodGather.lua:654
- Fixed Songflower trigger broken 1.10 patch.

0.90
- Fixed tooltip level using Alphamap support.
- Fixed 1.9.0 German map name change(thx Golgatar).
- Added Start menu. It will start timer manually.

0.82
- Alphamap support. Now you can see FelwoodGather information on Alphamap.
- Added songflowers

0.81 
- Add Songflower. I didn't care them so that several location missed/ not checked.
 Please correct / report locations.
- changed map area to show songflower. you should /fwg reset once.
- Add "mark as depop" to memo the objects are up/down/when.
- Add/changed german localization string. I can not confirm which version strings are right.
  If you had have problem from this, report please.

0.80c internationalization beta.
- Add /fwg reset for avoid minimap position problem.
- Change minimap texture for fix problem the south map does not display.
- fix some i18n problem.

0.80b
- Fixed bug auto show check box does not display correctly.
- Fixed bugs for i18n.
  - redefine class color for minimap blip due to error in German client.
  - change map zone identification function due to zone index not same among different language versions.
  - fix the chat channel name.
- Merge FR and DE resources that provide contributors.

0.80
- Add minimap like WSGCommanader or AlphaMap but focused on producing area.

0.71
- Hotfix for wrong timer restart at Jadenar. I should check item name for each point.

0.70 First public release
- Change share message format. Now you can see human readable information by share command.
  But you cannot communicate with older versions.
- Add countdown caller.
- Add KeyBindings
- Fix highlight bug after latest timer expired.
- Removed myAddons support due to I cannot pass myAddOnsFrame_Register... (?_?)

0.63 
- Fix Berry location on Jadefire.

0.62 
- Fix timer refresh problem outside felwood.

0.61 
- add helper function for support TitanFelwoodGahter

0.60
- add configuration. type /fwg config.
- support Windblossom Berries.
- fix share timer function. now you can use this function.

0.51 
- Notification bug fix.
- Colored timer.

0.50 beta3 release with client 1800
- Added Menu on fruit icon
- Change Icon frame level under the player POI... but not worked.
- Change activation condition. Now you can see the information.
- highlight the next trigger label
- fix bugs for share timer function.

0.40 beta2 release
- code refine
- separate string resources to localization.lua. 
  It will make someone easy to translate to other language versions =P.

0.30 beta release
- Add label with ETA to landmark icons.
- Add landmark information to game tooltop.
- automate map update for timers.
- Add notification.

0.20 alpha2 release
- Add Icons to landmark.

0.10 Alha release
