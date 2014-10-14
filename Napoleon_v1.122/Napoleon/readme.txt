Allows a raid to quickly organize healers and duties.  View your raid members reagents, trades, talents, ping etc.  Has a Fear Ward priority and safety system.

Usage:
'/nap' to bring up the interface at anytime.
'/nap ward' to apply a Fear Ward on your specified tanks by priority.

The interface is split into two sections. The left hand side contains a list of added tanks / duties and their options, and the right hand side contains the list of members in your raid and custom bands.

To add tanks into your list, target the tank and click 'Add Tank'.  Alternatively you can instantly import CTRA or oRA MT lists by using the 'Import' button. Note: NPC's can be added as tanks.

As well as tanks you can also create duties via 'Add Duty'.  Duties can include jobs like AOE, kite, CC, tank, heal, decursing and much more.  So as well as assigning healers to tanks, you can for example assign mages / warlocks to AOE duty.  If you select a non-combat duty that targets raid members, i.e. healing or decursing, then two columns of pulldowns will appear.  The left three pulldowns work like 'And', and the right column works like 'Not'.  You'll get the idea by playing with it.

You can also create custom groups or 'bands' via 'Add Bands'.  Bands allow you to create specific (or broad) groups of raid members that will self adjust as raid members leave or join the raid.  For example, after creating the AOE duty as mentioned above, you can then create for example a custom band that includes AOE characters in groups 1-4 that aren't druids.  When creating or editing a band two columns of pulldowns will be available.  The left three pulldowns work like 'And', and the right column works like 'Not'.  You'll get the idea by playing with it.

Once you have the list of tanks or duties to be assigned raid members or bands, select a tank / duty by clicking on the portrait in the GUI.  This will highlight the tank / duty in brightness. Then select up to raid members or bands from the available raid members on the right hand column.  Once ready, click 'Switch' to move the selected raid member or band to the assigned tank / duty.  To remove members / bands, select them from any tank / duty and click 'Switch' to free them up.

To announce the healing / duty roster first click 'Broadcast', this will bring up the broadcast options.  Clicking 'Broadcast' in this new panel will broadcast the list to the selected channel.

You can save your duties and bands for re-loading at a later time by using the 'Recall' option.  The recall feature allows you to save all bands and duties as well as your current broadcast message.  When you load a dungeon encounter it will load all the duties, bands, and braodcast message that was set when saved.

Members of the raid can get their assigned duties at any time by whispering you '!nap'.  This will whisper them back their assignments.

If a healer class such as paladin, shaman, priest, or druid is selected as a tank, he will automatically be assigned to himself.

Members of your raid have a number next to their name, this indicates which group they are in. Next to this number is a status icon which can be any of:
. tick (everything ok)
. offline icon (offline)
. skull (player is dead)
. globe (in a different zone)

This will help to ensure that real available raid members are allocated to tanks / duties.  Next to this icon is a '+' icon, this is used to get information about that character.  When this '+' icon is green it means that the player has Napoleon v1.05 or greater installed and you can view extensive information about that character.  Red '+' means the character doesn't have Napoleon v1.05 or greater installed.  The more people with Napoleon installed the more informed your raid will be able to gather.  Clicking the '+' next to a band allows you to edit the band.

Player information icons:
I haven't created any tooltips for player information yet, but most information should be understandable by the icon.  The compass icon above and right of the character name has the current ping (latency) of that player.  The row of icons underneath all resistances are Armor, Defense, AP, RAP, HP.  Underneath this row are common reagents used for that class.  Top right hand corner of the player information area contains all their trade skills and levels.

The fear ward system will be initialized if the player has fear ward available in his action slot. This enables the player to either use '/nap ward' as a macro, or the 'Ward' option in the GUI to cast a fear ward prioritized by the tank settings.  Non dwarf priests will not even be able to manipulate the fear ward system.

For each tank, the fear ward system can have three options. 'On' means that the tank will have the fear ward cast on the tank if he hasn't got fear ward already, and that no tanks above him are in need of fear ward. 'Forced' means that if the tank is currently alive and is at least visible, it will not attempt to cast the fear ward on any other tank if fear ward has been turned on. This helps especially for when the tank is slightly out of range or not in LOS to prevent a fear ward cooldown to be wasted. 'Off' means the tank is not eligble for any fear wards. Any tank in the list with fear ward currently applied will have the fear ward icon brightly displayed in the GUI.
