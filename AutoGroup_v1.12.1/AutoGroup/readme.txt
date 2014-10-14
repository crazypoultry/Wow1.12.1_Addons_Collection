Description :
AutoGroup will automatically accept group offers from either anyone on your friends list or anyone at all.

Here's the list of commands:
Basics:
/ag on - Turns AutoGroup on. (Default)
/ag off - Turns AutoGroup off.

Auto-Accept Options
/ag accept friend - Automatically accepts group invites from friends supressing the normal popup. Group invites from anyone else act as usual.
/ag accept guild - Automatically accepts any group invite you get from a guildmate. Group invites from anyone else act as usual.
/ag accept both - Automatically accepts any group invite you get from a guildmate or a friend. Group invites from anyone else act as usual.
/ag accept all - Automatically accepts any group invite you get, supressing the normal popup.
/ag accept none - Does not auto-accept group invites. (Default Mode)
/ag accept emote blah - Sets an emote to be performed when AutoGroup accepts a group invite for you. For example, '/ag accept emote cheer' would do the /cheer emote when it accepts a group invite for you. If you want to make a custom one, use '/ag accept emote em does a little dance', replacing 'does a little dance' with your custom emote.
/ag accept emote - Clears the emote-on-accept.
/ag accept whisper blah - Sets text to auto-whisper when AutoGroup accepts a group invite for you. For example, '/ag accept whisper Thanks!' would whisper the person inviting you with "Thanks!".
/ag accept whisper -Clears the whisper-on-accept.
/ag accept help - Shows auto-accept options.

Auto-Decline Options
/ag decline nonfriend - Automatically declines group invites from people not on your friends list, supressing the normal popup. Group invites from friends act as usual.
/ag decline nonguild - Automatically declines group invites from people not in your guild. Group invites from friends act as usual.
/ag decline both - Automatically declines group invites from people not in your guild or not on your friends list. Group invites from friends act as usual.
/ag decline all - Automatically declines any group invite you get, supressing the normal popup.
/ag decline none - Does not auto-decline group invites. (Default Mode)
/ag decline emote blah - Sets an emote to be performed when AutoGroup declines a group invite for you. For example, '/ag decline emote rude' would do the /rude emote when it declines a group invite for you. If you want to make a custom one, use '/ag accept emote em raspeberries.', replacing 'rasberries.' with your custom emote.
/ag decline emote - Clears the emote-on-decline.
/ag decline emote - Clears the emote-on-decline.
/ag decline whisper blah - Sets text to auto-whisper when AutoGroup declines a group invite for you. For example, '/ag decline whisper Sorry, soloing.' would whisper the person inviting you with "Sorry, soloing.".
/ag decline whisper -Clears the whisper-on-decline.
/ag decline help - Shows auto-decline options.

Additional commands:
/ag status - Shows AutoGroup's current status.
/ag help - Lists all commands for AutoGroup.

Much thanks to Tyndral for letting me use his CareBear mod as a base to work from.
Changes :
1.12.0 changes:
-Changed toc to 11200
-Changed versioning to match WoW
-Fixed a [long standing] bug with guilds and updated code to not keep guild lists. Should reduce data and improve performance.

0.9.6 changes:
-Updated to patch 1.9.0

0.9.4 changes:
-Cleaned out debug code.

0.9.3 changes:
-Really fix the bug reguarding nils on secondary characters.

0.9.2 changes:
-Fixed bug reguarding nil guild lists.

0.9.1 Changes:
-Updated for the 1500 (6/7/05) patch.
-Cleaned code to use new functionality for Player names and realms.

0.9 changes:
-Fixed a bug with how the decline both mode was working.
-Moved ReadMe.txt file into the AutoGroup folder so it shouldn't overwrite other readme's now.

0.8 changes:
-Fixed the help screens to be more accurate.
-Included a readme.txt file.

0.7 changes:
-Fixed a bug. Allows multi-word whispers again.
-Allows custom emotes on accept and decline.

0.6 changes:
-Updated version number for 3/22 patch.

0.5 changes:
-Added guild-related modes.
-Fixed a few functions to make them use their local variables and cut down on global variables.

0.4.1 changes:
-Fixed an error in the help messages.

0.4 changes:
-Added support to auto-decline group invites from anyone or just non-friends.
-Cleaned up popup suppression code.
-Optimized a few functions.
-Changed default to on, but auto-accept set to "none" and auto-decline set to "none", should help avoid any confusion.
-Cleaned up help messages.
-Put in a message telling you when it auto-accepts or declines a group.

0.3a - Initial public release

Known Issues:
-No known issues at this time.