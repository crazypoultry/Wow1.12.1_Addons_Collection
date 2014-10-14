Main functionality explanations:

 * Opening the Opium window
   
     To do this, either click the Minimap button (looks like a book), or bind a keyboard
     button for it (Hit ESC and Keyboard Bindings), or type '/pwho' in the command window.


 * Opening the KoS windows

    To do this, either open the main Opium window, hit 'KoS Players', or 'KoS Guilds'.

    Or, you can write '/kosp' or '/kosg' to open the KoS Player or KoS Guild window, respectively.

    Or, you can bind a keyboard button to do either.


 * Adding a player or guild to the KoS list

     Target the player in question, hit the tiny book icon on his player frame,
     and that player will be added to the KoS list. (Note: This button can
     easily be moved to where you want it, by shift+clicking the button
     and then dragging it elsewhere. It should remember it's location
     in future sessions).

     Or, target an ally, right-click the target frame, and pick 'KoS' in the
     menu that appears.

     Or, open the relevant KoS window (players or guilds), then hit 'Add', 
     give an optional reason (can be empty), and OK.

     Or, open the main Opium window and if the player or guild is recorded on the 
     list (depending on your options), you simply Control+click to add the player 
     to the KoS list, or Alt+click to add the guild.

     Or, you can use the command window. '/kosp <playername><,reason>' or equivalent /kosg.
     See more detailed explanation below. (Hint: Using a macro '/kosp %t' you can 
     set up a shortcut to add the currently targeted player to the list with the touch of
     a button)

 * PvP Stats Tracking

     Opium now has support for tracking PvP deaths and kills. These will
     show up on a per-player basis in the main screen, or you can view
     statistics by pressing the 'PvP Stats' button in the main window.

     Note: Opium will only track kills/deaths of players it has recorded.
     So if it's set to 'All' or 'Combat' all kills/deaths will be stored
     (even duels), if it's 'Enemies' only kills/deaths of the opposite faction
     will be stored, 'Allies' will only track duels, and 'None' will track none.

 


GUI Interface:

   The functionality of the GUI is pretty straightforward.

   The only things that really need explaining, are the shortcuts in
    the main Opium window.

   * If you're typing something and Shift+Click an entry in the window, a text
     with the stats of that player will be copied to the text you're writing (like a link).

   * If Control+Click an entry, that player will be added to the KoS list, and you will
     be prompted to give a reason.

   * Similarly, Alt+Click on an entry will add that players -guild- to the KoS list, and you
     will be prompted to give a reason.

   Another thing to note, is that both Opium items on the player frame (the KoS toggle button,
   and the 'KoS' text itself, can both be dragged to new positions if the default positions
   are not suitable. This should keep between sessions, as well.



Slash command summary:

'/op addflag <newflag>': Adds a new flag, in addition to the inbuilt 'KoS' and 'Friendly' flags.
'/op stats': Display servers/records stored
'/op autostore [none|allies|enemies|all]': Specify which players to store automatically. Default is all.
'/op toggleguilddisplay': Toggle showing the guildname in player tooltip
'/op resetall': Delete all Opium data.

'/pwho <playername>': Without an argument, this toggles the player list. With an argument,it tries to 
       look up that playername in the list, and outputs info on that player in the console.

'/op chatframe': Choose which chat frame Opium should print messages to. 1 is general, 2 is combat etc
'/op mmbutton': Toggle the minimap button

'/op textalert': Toggle text alert when seeing a KoS'ed player
'/op soundalert': Toggle sound alert when seeing a KoS'ed player
'/op trackpvpstats': Toggle tracking of PvP stats

'/kosg <guildname><,reason>': Without an argument, this shows the guilds in your KoS list, and the 
                              reason you've specified (if any). With a guildname argument, you toggle 
                              that guild's KoS status. The reason is optional (and if specified, the 
                              guild is set to KoS with that reason, even if it's already on the KoS list. 
                              In other words, if you specify a reason it's not a toggle).

'/kosp <playername><,reason>': See above, same thing.

Note that both these commands uses a "," (comma) to seperate the guild/player name, and for that reason you 
can't have a comma in the reason you specify (everything after the second comma will be ignored).


Example usage:

Say I'm ganked by FotmPaladin42 while I'm afk. I'd like to find out who actually ganked me.

So, I hit the Opium button on the minimap, or do '/pwho'.

The main Opium window pops up, and shows me that Fotmpaladin42 is a level 50 human paladin, 
is an Officer of Argent Dawn (shows both guild rank and guild name), and I saw him last five minutes ago.

Since I have this indescribeable hate now for this guy, I'd like to remember him so I can 
specifically gank him back at some later point.

So, I do simply hold Control and click his name in the list, and a dialog pops up asking me
 for a (optional) reason, and then adds him to the KoS list.

If I want to add someone who isn't necessarily on the list, I can simply add them using:
'/kosp formpaladin42,I hate this guy'

Or, if I want to add someone I have targetted, there's a tiny icon on the 
target frame I can click to add them.

When, the next day I come across a group of Alliance, the mouseover of one of them suddenly says:

'Fotmpaladin42
Level 50 Human Paladin
<Argent Dawn>
KoS Player: Ganked me while offline'

If that group decides to roll me, I simply open Opium and I'll most likely have 
a nice list of who they were.

Later someone else from that guild ganks me. I decide I hate their entire guild 
with a passion now.

So, I either hold Alt and click on someone in that guild in the list, and 
(optionally) give a reason.

Or I just do: '/kosg argent dawn,Bloody gankers all of them'

Every member of Argent Dawn I now come across, will have
'KoS Guild: Bloody gankers all of them' in their tooltip.

Or, on the other hand, if you grouped with a really talented healer in BRS last 
night, but forgot his name...

I simply open Opium, filter after Priests and my own faction, scroll down, and see 
that around 15 hours ago you grouped with 'Healsjoo', you can do:

'/kosp healsjoo,Very good healer!'

It's not limited to enemies, and the 'KoS' label is just there as a matter of convenience.

If I at some point want to see all the guilds I have in the KoS list, I do 
'/kosg', or hit the 'KoS Guilds' in the main Opium window (/pwho).

This will give me a window showing all the guilds in my KoS list, and allow me to
 add/remove/edit entries in that list.


