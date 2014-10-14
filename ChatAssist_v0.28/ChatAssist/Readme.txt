===================================================
== ChatAssist Ver 0.28 (World of Warcraft AddOn) ==
===================================================

* About ChatAssist
  ChatAssist replaces the font of World of Warcraft. and Unicode/Japanese font can be read.
  Moreover, a function convenient for a chat is added. 

* Install
  chatassist028.zip and the ChatAssist folder after the decompression
  It moves to "World of Warcraft installation folder\Interface\AddOns". 
  Afterwards, please execute "World of Warcraft installation folder\Interface\AddOns\
  ChatAssist\install_win.bat" and install the font.

  When you copy the font by manually
    please copy your favorite TrueType font to
    "World of Warcraft installation folder\Interface\AddOns\ChatAssist\font01.ttf"

* Usage

  Add Keyword
    /ca add Keyword

  Delete Keyword
    /ca del Keyword

  List Keyword
    /ca list

  Fixation is enabled the channel of the chat mode.
    /ca channelsticky

  Fixation is enabled the Officer chat about the chat mode.
    /ca officersticky

  Fixation is enabled the Whisper chat about the chat mode.
    /ca whispersticky

  Timestamp show/hide
    /ca ts

  Change of format of timestamp
    /ca tsformat %I:%D %p

    The following one can be used for the keyword that can be used to format the timestamp.

    %H 24-hour format of an hour with leading zeros (00-23)
    %I 12-hour format of an hour with leading zeros (01-12)
    %M Minutes with leading zeros (00-59)
    %S Seconds, with leading zeros (00-59)
    %p Lowercase Ante meridiem and Post meridiem (am or pm)
    %P Uppercase Ante meridiem and Post meridiem (AM or PM)

  Enable/Disable such as keywords and time stamps in each chat window.
    /ca window [WindowId(1-7)]
    (One is General in default, and two is Combat Log.)

  Logging
    /ca log

  keyword reaction history is displayed
    /ca history

  channel name is shortened
    /ca shorttag

  channel name is hidden
    /ca hidetag

  name is classified according to the class
    /ca colorname

  Enable/Disable of Unicode Block
    /ca ub

  Enable/Disable of Unicode Block in each channel
    /ca ub [party|raid|raidwarning|guild|officer]

  Default Chat Mode
    /ca defaultchat [say|party|raid|guild|officer]

  On-screen displays
    /ca onscreen [keyword|auction|raidleader|bgleader|officer||whisper]

* ChangeLog
  Ver 0.28 09/19/2006
    * Added Option to disable Unicode Block
    * Fixed bug on-screen display did not function.

  Ver 0.27 09/16/2006
    * Fixed bug Guild member's class was not applied.
    * Fixed bug When two or more windows were displayed, the event by the same message had been 
generated two or more times.
    * Fixed bug The setting is not preserved with ChatAssistOptions.

  Ver 0.26 09/06/2006
    * Added Default chat mode setting.
    * Added On-screen displays of keyword and auction, etc...
    * Added WhisperSticky.
    * Changed The setting of default is Timestamp on, and ColorName on.
    * Fixed bug keyword reacts besides chat.

  Ver 0.25 08/24/2006
    * Added Keybind is added. (/bg)
    * Improved Battleground and Battleground Leader are added to ShortTag/HideTag.
    * Fixed bug ColorName doesn't work by CrossRealm Battleground.

  Ver 0.24 08/23/2006
    * Changed The Interface version is changed to 11200.
    * Fixed bug ItemLink is not displayed with the channel.

  Ver 0.23 08/12/2006
    * Added Setting GUI.
    * Added Keybind(/10,/rw).
    * Added myAddOns support.
    * Improved rewritten text parser.
    * Improved When tag is hide, the channel number can be displayed. (/ca hidechannel)
    * Fixed bug The channel number was not displayed as for ShortTag when the channel number was ten or 
more when it was effective.

  Ver 0.22 07/28/2006
    * Added function to hide a channel name.
    * Added command which sends tell to target (/tt)
    * Fixed bug Unicode/Japanese was able to be used by some public channels.
    * Fixed bug When the character string was put into the argument of /ca window, the error came out.
    * Fixed bug keyword reaction was carried out when a keyword was displayed by /ca list

  Ver 0.21 07/26/2006
    * Improved scroll with Shift+Mousewheel to top/bottom. and fast scroll with Ctrl+Mousewheel.
    * Improved RaidWarning and Officer were added to Unicode Block.
    * Improved Unicode cannot be used with GuildRecruitment Channel.
    * Changed channel name separates a file for localization.
    * Fixed bug Officer is not omitted though ShortTag is enabled.

  Ver 0.20 07/23/2006
    * Improved It came to be able to use Unicode Font with Mail.

  Ver 0.19 07/04/2006
    * Improved It came to be able to use Unicode Font with Raid Warning.

  Ver 0.18 06/28/2006
    * Improved The mark of the character of ShortTag is changed. (Party->PT,Raid->RD,Raid Warning->RW,Guild->GL)
    * Fixed bug /afk and /dnd command were not able to be used.

  Ver 0.17 06/22/2006
    * Improved The mark of the character of ShortTag is changed. (Party->PT,Raid->RD,Raid Leader->RL,Guild->GL)

  Ver 0.16 06/20/2006
    * Changed The Interface version is changed to 11100.
    * Fixed bug SendChatMessage

  Ver 0.15 05/15/2006
    * Improved It came to be able to use Unicode by screen message (/rs) of CT_RaidAssist.
    * Fixed bug When two item links or more are pasted, it is not normally displayed.

  Ver 0.14 05/13/2006
    * Added KeyBinding of channel switch
    * Fixed bug There is a thing that the debug message enters the auction log.

  Ver 0.13 05/12/2006
    * Fixed bug The item is not linked with a part of item. 

  Ver 0.12 05/12/2006
    * Added The item link can be put on the user channel. (Compatible CopyLink)

  Ver 0.11 05/07/2006
    * Improved KeyBind of the History window is changed to Keyword and the Auction separate 
setting.
    * Improved The regular expression of the URL extraction is changed.
    * Improved The retrieval object of the key word is limited to Say, Party, Raid, Guild, 
Channel, and Whisper.
    * Improved The object of the URL extraction is limited to Say, Party, Raid, Guild, Channel, 
and Whisper.
    * Improved The successful bid and the successful bid out of the sphere are recorded in the 
auction log.
    * Changed To release the event at the zone
    * Changed To generate ClassCache again when ColorName is turned on.
    * Fixed bug The auction log is not correctly recorded.
    * Fixed bug ShortTag doesn't function by the remark with LocalDefense and WorldDefense.

  Ver 0.10 05/03/2006
    * Fixed bug When ColorName is enabled, Rogue cannot be recognized.

  Ver 0.09 05/03/2006
    * Added It is a screenshot in KeyBind. 
    * Fixed bug When the History window is opened with KeyBind, the content is not displayed.
    * Fixed bug Guild is not omitted though ShortTag is enabled.

  Ver 0.08 05/03/2006
    * Added Auction log.
    * Added KeyBinding of chat.
    * Added Color of class.
    * Changed The width of the URL window
    * Fixed bug Unicode is judged to the non-Unicode character.

  Ver 0.07 05/03/2006
    * Added Classification of name according to class.
    * Added Channel name abbreviated function.
    * Added Effective and an invalid switch of Unicode of each channel.
    * Improved The file is separated for localize. 

  Ver 0.06 05/02/2006
    * Added Function to copy URL.
    * Added Keyword History.
    * Improved Unicode cannot be used with Say, Emote, Yell, and Public Channel.

  Ver 0.05 05/01/2006
    * Added It is an invalid effective/switch to individual ChatFrame.
    * Added Logging

  Ver 0.04 04/30/2006
    * Added The mouse wheel in ChatFrame is made effective.
    * Added Timestamp display.
    * Added The function to fix to the user channel.

  Ver 0.03 04/29/2006
    * Added list/add/del of the keyword by the command.

  Ver 0.02 04/28/2006
    * Fixed bug keyword reacts to my name.

  Ver 0.01 04/27/2006
    * Initial Release
