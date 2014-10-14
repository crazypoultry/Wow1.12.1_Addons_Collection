= FuBar_OutfitterFu - FuBar support for Outfitter =

Author: Ruinna <ruinna.vogel@gmail.com>
Site: http://www.wowace.com/wiki/FuBar_OutfitterFu
$Date: 2006-12-28 05:13:14 -0500 (Thu, 28 Dec 2006) $
$Revision: 22422 $

== Overview ==

This fu lets you place an icon and menu in your FuBar for quick access to the [http://wow.curse-gaming.com/en/files/details/4784/outfitter/ Outfitter] mod.

== Requirements ==

* FuBar v2.0+
* Outfitter v1.3.2+

== Features ==

* Collapsible outfit categories.
* Colorized outfit names; blue if an item in outfit is banked, red if an item is missing.
* Left-click on icon or text to toggle the main Outfitter config pane.
* Option to hide outfits having missing items.

== Usage ==

Roll the mouse over OutfitterFu to see a tooltip containing your list of outfits from Outfitter. Left-click on an outfit to change into it. If an outfit is blue, then an item in that outfit is banked (Bank frame must be open to detect this state). If an outfit is red, then an item in that outfit cannot be found. Click the OutfitterFu icon or text to toggle the main Outfitter configuration window.

== Installation ==

# Install FuBar and Outfitter.
# Copy the `FuBar_OutfitterFu` directory to your `WoW/Interface/AddOns` directory.

== Feedback ==

* [http://www.wowinterface.com/portal.php?id=235&a=listbugs Bug reports]
* [http://www.wowinterface.com/portal.php?id=235&a=listfeatures Feature requests]

== Release Notes ==

[2006-12-28] 2.0.22422
* Fixed some issues with use of AceDB.

[2006-12-27] 2.0.22263
* (KarlThePagan) Added option to hide outfits with missing items.
* Updated docs to include pointers to wowinterface.com author portal.
* Updated encoding of English localizations file to DOS.
* Added some localization strings.
* Updated to use AceLocale-2.2.
* Updated X-Embeds and OptionalDeps entries in TOC.

[2006-10-03] 2.0.12798
* Clicking on OutfitterFu now properly toggles Character and Outfitter frames.
* Removed unnecessary external libraries.
* Restructured source for inclusion in wowace SVN repository.

[2006-09-25] 2.0.16
* Added embedded libraries referenced by TOC.

[2006-09-22] 2.0.15
* Updated to support FuBar-2.0.
* TOC file updated for WoW release 1.12.

[2006-06-25] 0.1.14
* Bug fixes for detached tooltip mode.
* DOS encoding of source files for easy notepad.exe reading.

[2006-06-20] 0.1.11
* TOC file updated for WoW release 1.11.

[2006-06-19] 0.1.4
* Initial beta release! Please test and let me know of any troubles you have with OutfitterFu.
