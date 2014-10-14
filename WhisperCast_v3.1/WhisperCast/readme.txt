WhisperCast v2.9
----------------
This interface addon allows a buffer/curer to queue up spell requests from members of thier party.

**Localization: English, German, French, Korean, and Chinese spell/trigger support**

Members of your party send you a whisper with one of the supported buff/cure triggers. i.e. "/tell Sarris fort" will cause "Power of Word: Fortitude" to be queued for cast on you.  For the debuffs, just whisper the type of debuff and it will queue the correct cure spell.  The trigger matching is configurable to exact match only, match first whole word, or any whole word in a whisper.  '/wc announce' will display a message in party/raid chat about how members can use WhisperCast.  They can also send send a whisper with 'wc' for a complete list of the spells you have enabled for queueing.

You use the "Cast" button, "/wc cast" macro, or a key binding to cast that requested spell on the requester.  You can't just type "/wc cast" into a chat window, it must be run from a macro.

Right click on the "Cast" button or Titan panel plugin to open the options menu.

Supported buff/cure spells and the trigger phrases:

PALADIN
'Purify' = 'purify' 'poison' 'disease'
'Blessing of Sanctuary' = 'sanctuary'
'Blessing of Sacrifice' = 'sacrifice'
'Blessing of Wisdom' = 'wisdom'
'Blessing of Salvation' = 'salvation'
'Cleanse' = 'cleanse' 'dispel'
'Blessing of Kings' = 'kings'
'Blessing of Might' = 'might'
'Blessing of Light' = 'light'
'Blessing of Freedom' = 'freedom'

MAGE
'Amplify Magic' = 'amplify'
'Arcane Intellect' = 'ai' 'int'
'Dampen Magic' = 'dampen'
'Remove Lesser Curse' = 'curse'
'Arcane Brilliance' = 'group ai' 'group int' 'brilliance'

DRUID
'Gift of the Wild' = 'gift' 'group mark' 'gotw'
'Abolish Poison' = 'poison'
'Remove Curse' = 'curse'
'Thorns' = 'thorns'
'Mark of the Wild' = 'mark' 'motw'
'Innervate' = 'innervate'

SHAMAN
'Cure Disease' = 'disease'
'Cure Poison' = 'poison'
'Water Breathing' = 'water'

PRIEST
'Divine Spirit' = 'spirit'
'Prayer of Fortitude' = 'group fort' 'group fortitude' 'group stam' 'group stamina'
'Power Word: Shield' = 'shield'
'Fear Ward' = 'fear' 'ward'
'Power Word: Fortitude' = 'fort' 'fortitude' 'stam' 'stamina'
'Abolish Disease' = 'disease'
'Shadow Protection' = 'shadow'
'Dispel Magic' = 'dispel'

WARLOCK
'Ritual of Summoning' = 'summon'
'Detect Greater Invisibility' = 'invis'
'Unending Breath' = 'water'

WhisperCast features:
o Automatic available spell selection based on your class
o Smart rank selection based on your targets level
o Smart target range and cooldown detection
o Doesn't queue up duplicate spell requests from the same person
o Can only queue requests from members of your raid/group
o Can hide buff/cure request whispers
o Can play a sound then queue fills or is empty
o Can flash queue count display when it isn't empty
o Titan panel support
o Dropdown menu to change queue settings, right click on Cast button to access
o Small interface, with minimize cabability
o Display of what is waiting in your queue
o Queued requests have to fail 3 times before being dequeued
o Will only queue spells that you really have, no kings if you don't have the talent or never bought a spell
o Can limit queue casting to critual spells while your in combat, only cures and blessing of wisdom currently
o Hidden automaticly for classes without any group castable spells
o Configurable trigger matching on exact, start of whipser, or whole word in whisper
o Dump status of queueable spells and their triggers - '/wc status'

/wc <command>
Commands are:
    announce - Advertise WhisperCast availability in raid/party chat
    enable/disable - enable disable spell queueing from whispers
    status - display all your queueable spells and the triggers
    cast - execute one cast out of your queue
    clear - clear your queue
    reset - reset all options and standalone gui position
    match [exact|start|any] - set your trigger matching level: exact=whisper is the same as a trigger, start=whisper starts with a trigger, or any=whisper contains a whole word matching trigger
    show/hide - set standalone gui visability
    min/max - minimize or maxamize the standalone gui
    debug - dump internal info about spells ids and action button ids
    help - this message

Special Thanks to:
Djoraan for German trigger translations and localization fixes
Killerking for Chinese spell/trigger localizations
Esmir for Korean spell/trigger localizations

Version history
---------------
Version 2.9:
-Fixed problem with spell casting caused by action button search bug
-Fixed bug that caused queueing to be disabled when reloading ui in a very laggy raid instance
-Send feedback whispers to people requesting spells, when their spell is queued, failed, cleared, etc.
-Feedback whispers can be disabled with "Send feedback whispers" on options menu
-'/wc announce' command to announce WhisperCast availbility in raid/party chat
-'wc' whisper trigger that will respond with your enabled spells and triggers
-Feedback whispers and 'wc' responces can be hidden with "Hide WhisperCast whispers" on options menu
-Korean spell/trigger localizations by Esmir

Version 2.8:
-WoW 1.7 patch update
-Chinese spell/trigger localization support
-Framework to allow interface localizations, see French for example
-Warlock summon now leaves the summoned targeted so other addons chat feedback works.

Version 2.7:
-Flash queue display when not empty
-Play a sound when queue fills or empties
-Hide buff request whispers
-Completed German and French spell/trigger internationalization
-Fixed action button search from maybe being confused by macros

v2.6:
-Titan panel plug-in support
-"X" button on main window now just hides instead of disabling queueing
-Queueing can now be disabled from the right-click drop down menu
-Added warlock support for summon and water breathing
-Added shaman water breathing
-Added German trigger translations done by Djoraan
-Fixed a few german spell names

v2.5:
-Option to disable queueing of selected spells
-Added options menu to change combat/group/spell queueing, right click on cast button to access menu

v2.4:
-fixed Mage Arcane Brilliance CT raid error

v2.3:
-update to 1.6 client
-fixed druid cure poison trigger
-allow in combat queueing by default
-international support for German(full) and French(partial) spells

v2.2:
-update to 1.5 client
-added druid innervate

v2.1:
-fixed misspelled Power Word: Fortitude trigger
-added Prayer of Fortitude, Arcane Brilliance, Gift of the Wild, Blessing of Sanctuary
-doesn't dequeue a failed cast because your sitting anymore or on a taxi

v2.0:
-initial public release

Original WhisperCast by Valconeyet his is a recode by Sarris of Blackhand.  Minimize and Close graphics borrowed from MonkeyQuest.  Spell rank and level data originally from from BestBuff.

This code is released into the public domain.  Do what ever you want with it, but
I would appreciate credit for direct derivations.

Updates are available from:
http://www.curse-gaming.com/mod.php?addid=463
http://ui.worldofwar.net/ui.php?id=1297

Sarris of Blackhand

