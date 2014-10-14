Cirk's Fastcast v1.11.2
=======================
Fastcast is an addon specifically written for those of us who play World of Warcraft on high latency connections, and aims to reduce the effect of that latency on spell casting to a more trivial amount.  By default, the game client only allows a new spell to be cast when it receives notfication from the realm server that the previous spell has finished casting, which can considerably reduce your spell-casting speed when things are laggy, adding 0.5 seconds or even more to the time it takes to cast a spell before you can cast another one.

Fastcast implements a fast casting method that is based on a macro solution from Rusrusrusrus and described by Astos in the official Blizzard UI forums for manually cancelling a current spellcast "early" so as to allow a new spell to begin casting without interrupting the already cast spell.  The solution that Fastcast adopts is based around looking at the timing of when the client started the spell casting action, and then adds a small amount of padding to this to try and accommodate variations in the client to server round trip time, removing the guess work out of when to try and start casting the next spell.

Fastcast works with both normal cast-time spells, and channeled spells.  In addition for channeled spells, Fastcast provides the original feature of Channelcast as well, allowing you to protect your channeled spells from being accidentally interrupted by you pressing your channeled spell action key or button a second time.  Fastcast extends this to allow per-character setting of the maximum time for which your channeled spells are protected, giving you better control for when you want some channeled spells to deliberately be recastable.  Note that since Fastcast is based in large on my original Channelcast code, both these addons do the same (or similar) actions, so you should be sure to remove Channelcast from your addons directory when you add Fastcast.

Some other features provided by Fastcast are:
* Fastcast can optionally adjust the casting bar to have it reflect the spell timing as seen by Fastcast, rather than as seen by the client in terms of the server messages.  What this means is that rather than doing your next spell action (or moving, etc.) just before the end of the casting based on what you think your lag is, you simply wait until the end of the bar is reached instead, since Fastcast will have adjusted the timing.  This feature works with the default casting bar, and support has also been added so that it will work with Repent's eCastingBar, Satrina's CastProgess, and Haste's Otravi CastingBar.  It may not work with other custom casting bar modifications.
* Fastcast will optionally play the usual "thunk" noise for you if you try and cast your next spell while the current spell is still casting and the casting end time (as seen by Fastcast) hasn't yet been reached.  This is useful feedback, but since not everyone likes it, you can turn it off.  (The same sounds when made by the game client itself will still occur however).
* Provides some useful casting and item use functions for macros.


Frequently Asked Questions
--------------------------
Some questions you might have about Fastcast, and some answers!

Q. So how do I use it?
A. Install the addon, and thats pretty much all there is to it. :D

Q. Err, I logged in after I installed Fastcast, and it was showing the settings window already!  Will that happen every time?
A. No, Fastcast displays its settings window automatically only the first time you log in with a new character.  It does that so you know its there, and can make any adjustments you need to (like turning off a feature, etc.).  Settings are not shared between characters, so you'll need to modify them for each one individually.

Q. What is this cast time padding thing, and what should it be set to?
A. The padding is the amount of time that Fastcast will add to your spell time before it allows you to interrupt the spell with the next cast.  By default this is 0.2 seconds, which works pretty well for me where I am (in Australia), and seems to be reasonable for a lot of other players too.  What it really needs to be is a value that encompases the typical variability in your lag to the server, which is not the same thing as your latency, although they are usually related.  For example, my typical latency is around 300 to 400 (i.e., 0.3 to 0.4 seconds), and I find that 0.2 works well for the padding value.  When the latency goes up to 700 or so, using a padding of 0.2 still works for me because although the latency is now higher, it still only varies (on a moment to moment basis) by about 0.2 seconds.  (There's more details on how Fastcast actually works further down this page).

The best way to determine your ideal padding value is to experiment with it.  For mages, one way to do this safely is to find some critter (a toad, rabbit, squirrel, etc.) and chain-cast Polymorph on them as fast as you can for a whole mana bar and see how many interrupts and failures you get.  For healing classes, do the same thing chain-casting heals on yourself.  Warlocks, well, you might want to just try duelling a friend so you can chain-cast something on them :D

Typical values of padding for most people will be between 0.1 to 0.3.  Higher values mean that your spells will take longer to cast on average (although never longer than without Fastcast) while lower values mean you will get more interrupts and spell casting failures.

Q. Hey now I'm occassionally getting spell interruptions or messages saying my spell failed to start casting when I'm chain-casting my spells!  Is it broken?
A. Basically the method that Fastcast uses for the fast-casting is a trade off between reliability (spells will always cast, and will never interrupt each other) and casting speed, where your fastest chain-casting speed is controlled by the cast time padding value.  As you reduce your padding value (and therefore allow spells to cast faster) you are increasing the chance that messages may arrive at the wrong time at the server, and cause a spell interruption.  Increasing your cast time padding means a reduced chances of interruption, but of course you have also reduced your chain-casting speed.

You may also see some odd things like messages from Arcane Missles saying your target is dead, or the next Frostbolt spell not stopping casting until the very end even though your target died right near the start, but neither of those should be a problem usually (most players never even notice this).  These are side effects of using SpellStopCasting in the addon to cancel the current spellcast so tha the next one can be started early.

Q. I'm used to being able to move or interrupt my spell safely about 0.3 seconds or so before the end of the casting bar.  Why doesn't that work anymore?
A. By default Fastcast adjusts the casting bar to show the casting time as seen from Fastcast's perspective, meaning that the end of the casting bar is actually now the end of the spell (i.e., the point at which you can move or interrupt).  This takes the guess work out of knowing how far before the spell reaches the end that you can do other things.  If you'd prefer to keep the normal casting bar behaviour that you've gotten used to, you can just disable that option in the settings window.

Q. What classes does Fastcast work for?
A. Fastcast enables both its fast casting and channeling protection features for Druids, Hunters, Mages, Priests, and Warlocks, and its fast casting feature only for Paladins, Shamans, and Warriors.  Rogues don't have any actions that Fastcast will benefit, so it won't show for them, although the macro callable functions are still available.

Q. My connection is usually really good, but I want Fastcast there for when it bogs down and gets laggy.  If I leave Fastcast on, will it ever make my spells cast slower?
A. No, Fastcast will never make your spells cast slower.  If your padding time is greater than your normal latency, you shouldn't see any difference from having Fastcast there with fast-casting enabled.

Q. Does Fastcast still work if your casting is slowed by a debuff, or if you are taking damage?
A. Yes it does.  Fastcast uses the information on spell duration provided by the client, and handles changes to this when damage is taken.  For channeled spells, when you take damage you lose cast-time remaining, and Fastcast handles that too.

Q. If Fastcast is protecting a channeled spell from being interrupted, does this mean I can't cast anything else unless I move?
A. No, if Fastcast's channel casting protection is enabled, it will only protect you from interrupting that channeled spell with the same action or key press that you started channeling the spell with.  For a mage say, that means you can spam your Arcane Missiles key or button as much as you like without accidentally interrupting yourself, but as soon as you press your Frost Nova or Fireblast key or button, that will interrupt your Arcane Missiles and cast instead just as it always did.

Q. I'm seeing odd things when I use fast-casting with my Paladin's Flash of Light spell (no casting bar and casting failure messages, but the spell still casts), but its fine with Holy Light, what gives?
A. For some reason, the Paladin's Flash of Light spell generates two SPELLCAST_STOP events, rather than the normal one like every other spell, and there's no easy way to work around that and still be able to properly recognize other spells (particularly instant-cast spells) in Fastcast.  Sorry Paladins, you'll just have to live with fast-casting looking odd with Flash of Light for now.  If you want to keep the fast-cast feature for your other spells but have Flash of Light work properly, put it a macro, which will stop Fastcast from letting you interrupt it.

Q. Will Fastcast work with my macros?
A. Fastcast will indeed work with your macros, either macro'd spells or non-spell related macros.  See the separate topic on using macros with Fastcast below for more details.

Q. I currently use a SpellStopCasting() macro like the one from Rusrusrusrus to try and beat the lag manually, do I still need to do that with Fastcast?
A. Nope, at least not just for the purpose of beating the lag manually like you were before Fastcast.  You might still want to use SpellStopCasting() in a macro for fast-casting macro'd spells as described in the macros section below, but normally the only only reason you'd still want to use a SpellStopCasting() would be to deliberately interrupt your current spell, say in order to cast Counter Spell, or Silence on your target.

Q. Will Fastcast work on non-english clients?
A. Fastcast will indeed work on non-english clients, all that will be missing is the appropriate localization language file so that the UI appears in the correct language.  Currently Fastcast only provides english text, but if you want to translate localization.lua into your client's language and send it to me and I'll incorporate it into a new release.


Fastcast slash commands
-----------------------
Fastcast supports the following slash commands:
/fastcast help shows these options.
/fastcast shows or hides the Fastcast settings window.
/fastcast fast [on|off] enables or disables fast-casting for this character (on is the default if you are playing a Druid, Hunter, Mage, Paladin, Priest, Shaman, Warlock, or Warrior).
/fastcast fast # sets the padding value for fast casting in seconds (default is 0.2).
/fastcast protect [on|off] enables or disables channeled spell protection for this character (on is the default if you are playing a Druid, Hunter, Mage, Priest, or Warlock).
/fastcast protect # sets the maximum time that a channeled spell will be protected for in seconds (default is 10).
/fastcast status shows the status of Fastcast.


Fastcast and macros
-------------------
Macros that cast spells are protected from being run again by Fastcast until the minimum spell casting time has been reached (just as for spells), unless the macro indicates it is Fastcast aware (see below).  However, unlike spells, Fastcast will not automatically call SpellStopCasting() when the macro is run again after the minimum time has been reached, leaving this responsibility up to the macro.  This means that you can simply protect a spell from being fast-cast by putting it into a macro to execute.

Non-casting macros:
These are macros that don't perform any casting or cast-time action, such as ones that say something in party or raid chat, toggle an option, assist someone, etc.  Fastcast runs these sorts of macros as you'd expect them to be run.

Normal casting macros:
Because Fastcast will not automatically stop a current spellcast using SpellStopCasting() itself when running a macro, spells cast from normal casting macros are not fast-cast, and the new spell-cast from the macro won't be able to actually cast until the previous spell has finished.  There are a couple of exceptions to this - the first time you cast a spell from a macro after you've been fast-casting normal spells, and if you fast-cast another spell immediately after the macro.  But generally, spells cast normally from macros are not fast-cast, which is a quick and easy way of making your crucial spells safer, but also slower.  If you want to be absolutely sure to prevent another spell from accidentally interrupting your crucial spell when casting it from a macro, add a call to FastcastIgnore() into the macro, which will make Fastcast forget anything that it knows about the spell cast from the macro.

Macros that call SpellStopCasting():
Macros might typically use SpellStopCasting() either for allowing quick interruption of another spell to cast something else (e.g., for quickly casting Silence or Counter Spell on another player or NPC) or for when chaining certain spells together (such as Presence of Mind, or Inner Focus).  As with normal spells, after the first time the macro is run, Fastcast won't allow the macro to run again until the spell's cast-time plus padding has been reached, and it will be safe to call SpellStopCasting() again.  Of course the first time you use the macro, if it calls SpellStopCasting() it will interrupt whatever spell you were currently casting, but that may be a good thing anyway!  If you want to be sure not to interrupt any other current spell first, then use FastcastStopCasting() instead of SpellStopCasting() - see the next section below for details.

Fastcast aware macros:
If a macro calls certain Fastcast functions (see below) then that macro will flagged as being Fastcast aware, and Fastcast will allow that macro to execute at any time, even if it started a spell cast, relying on the macro itself to behave in a suitable manner to preserve spell casting as needed.  For example, you might make a macro Fastcast aware so that you can test a target's health during the casting of a heal spell so as to stop it early if needed to conserve mana.


Fastcast provided functions
---------------------------
Fastcast provides seven functions that you can use to make casting in macros a bit easier, or call from another addon:

	FastcastIsCasting() or FastcastIsCasting(spellNameAndRankOrSpellID, notFast)
	Returns true if there is a current casting or channeling action in progress that hasn't yet reached its end time, or nil otherwise.  You can optionally specify a spell name, a spell name and rank, or a spell ID in the call to FastcastIsCasting to check whether the specific spell is currently being cast (e.g., a mage might use FastcastIsCasting("Frostbolt") to see if they were currently casting their highest rank Frostbolt spell), and can also ask Fastcast to ignore the fast-casting state when you do this by specifying the notFast parameter.  This function can also check for some "active" actions and spells (such as "Attack" or "Auto Shot" or shapeshifts) provided you have them on an action bar somewhere, or that they display their status in the spellbook.
Note that for normal casting actions, you must have at least fast-casting enabled (and channeling protection for channeled spells) or this function will be unable to determine whether you are casting, and will always return nil.  Also note that calling this function from a macro automatically flags that macro as Fastcast aware.

    FastcastStopCasting()
    This function first checks to see if there is a current casting or channeling action in progress that hasn't yet reached its end time, and if so does nothing (returns nil) so as to not interrupt it.  Otherwise, if there is no current spell action in progress, or there is an action in progress but it can be stopped, then the function calls SpellStopCasting() to reset the casting state, and returns true.  If neither fast-casting or channeling protection is enabled, this function will always just call SpellStopCasting() and return true.  Note that calling this function from a macro automatically flags that macro as Fastcast aware.

    FastcastCast(spellName, onSelf)
    If the spell identified by the passed spellName parameter is not in cooldown, then cast it (optionally on the player themselves if the onSelf parameter is provided).  The passed spellName has the same format as spell names passed to /cast or CastSpellByName().  If the spell successfully started casting then the function returns true, otherwise returns nil.  If the spell (and optionally rank) you have requested to be cast is available on the action bar, Fastcast will also check to see whether the spell or action can be used (e.g., Riposte for Rogues) and will not attempt to cast the spell if it isn't usable.  Note that if neither fast-casting or channeling protection is enabled then this function will not be able to determine if the spell was successfully started or not, and will just return true if it did attempt to cast the spell.

    FastcastUseItem(itemDesc)
    Looks for an inventory item using itemDesc as either a slot number (e.g., 14 for the second trinket slot), a slot name (e.g., "Trinket1Slot") where the case is ignored, or an item name (e.g., "Talisman of Ephemeral Power") where the name must be an exact match to that of the item.  If an item name is given, and is not found in the player's inventory (i.e., is not something they are wearing) then the player's bags will be checked, although equipable items (e.g., trinkets) can not be equiped automatically by this method.  If the item is found, and is not in cooldown, then the item is used and the function returns true, otherwise it does nothing and returns nil.

    FastcastAware()
    Called from a macro, this function simply tells Fastcast that the macro (or a function that the macro calls, in the case of addon provided features for example) is to be considered Fastcast aware, and will be responsible for handling any necessary fast-casting conditions (typically using the FastcastIsCasting or FastcastStopCasting functions).

    FastcastIgnore()
    Called from a macro, this function causes Fastcast to discard any information about any spells cast by the macro, effectively disabling fast-casting for those spells.

    FastcastEnabled()
    Intended more for use by other addons than macros, FastcastEnabled returns two boolean values, the first being whether fast-casting is enabled, and the second whether channeling protection is enabled.

As an example of using these functions in macros, suppose you have a mage with a Talisman of Ephemeral Power trinket, and you want it to be used whenever it is up and you are casting Fireball, and importantly you want to be able to fast-cast Fireball with this macro if you need to.  Without using the Fastcast macros, you might have something like:

    /script SpellStopCasting(); UseInventoryItem(GetInventorySlotInfo("Trinket1Slot")); CastSpellByName("Fireball");

Which has the problem that it may cancel any other spell-cast the first time you use it in a chain of spells, and will spam your screen with "Item is not ready" messages if the ToEP is in cooldown.  Using the Fastcast macros, this becomes instead:

    /script if not FastcastIsCasting() then SpellStopCasting(); FastcastUseItem("Talisman of Ephemeral Power"); CastSpellByName("Fireball"); end

Which won't accidentally interrupt another spellcast if you press the macro button or key early, and won't spam you with error messages from trying to use your ToEP when its in cooldown.


Change history
--------------
Fastcast v1.11.2
* Added the notFast parameter to FastcastIsCasting to allow for checking whether a spell is casting but without considering fast-casting it.
* Fixed a bug in FastcastIsCasting when passing a spell name or ID where it wouldn't always check the fast-casting state, and would tell you the spell was still casting even when it was safe to fast-cast interrupt it.
* Fixed a bug that in the state-machine that occured when a macro made a call to cast the same spell as was currently casting but without stopping the previous spell.
* Modified FastcastCast to not do anything if there is already a spell casting action in progress (to avoid seeing unneccessary error messages).

Fastcast v1.11.1
* Changed the way in which Fastcast identifies actions internally so that it can accurately determine when the same action or spell is being cast even when started from different sources (e.g., one from action bar, one from macro).
* Improved how spell failures and interruptions are handled to reduce chances of accidental re-interruption or being locked in a spell-failing state.
* Added the optional parameter to FastcastIsCasting to allow it to check for a specific spell being cast, or whether a specific spell or action is current (as long as the action is on the action bar somewhere, or is marked as current in your spellbook when active).
* Added support for Haste's Otravi CastingBar addon.
* Fixed a bug in FastcastCast which wasn't properly extracting the rank from spell names when the rank was provided.
* Allow any mixed capitalization to be used for the spell names in FastcastCast and FastcastIsCasting.
* FastcastIsCasting and FastcastStopCasting will now show a warning in your general chat tab if you call them when fast-casting is not enabled.
* Fixed a bug in setting the initial casting bar position for channeled spells.

Fastcast v1.11.0
* FastcastCast now checks to see if the requested spell is on an action bar somewhere, and if so uses the action to check whether the spell is castable or not.  Useful for spells and actions that have limitations that are unrelated to their cooldowns (e.g., some Rogue and Warrior talents).
* FastcastUseItem now checks the player's bags to allow for using items such as health stones, potions, and bandages.
* Added support for adjusting the casting bar for eCastingBar and CastProgress.
* Introduced concept of Fastcast aware macros, to allow for other types of macro supported spell casting (such as mana conservation macros and addons).
* Added the FastcastEnabled, FastcastAware, and FastcastIgnore macro-callable functions, and made FastcastIsCasting and FastcastStopCasting automatically flag the macro as Fastcast aware.
* Improved handling of spells that are first cast and then a target is selected (e.g., heal spells).
* Cleaned up login and logout code, and event registration and handling.
* Added handling of the "There is nothing to attack" error.
* Fixed a bug where Fastcast was always trying to adjust the timing of the casting bar, even when this option was disabled.
* Fixed a bug where druid shapeshifts and rogue stealth and similar abilities were not properly being handled when cast from the action bar rather than from the shapeshift bar.

Fastcast v1.10.2
* Removed unneccessary code that was preventing some actions from being handled properly.

Fastcast v1.10.1
* Fix for another bug relating to spells cast from macros.
* Added new macro-callable functions for improving spellcasting from macros.
* Added a Readme.txt file (basically this download page) to the zip file.

Fastcast v1.10.0
* Fixes for channeled spell events for patch 1.10.
* Allow channeled spell protection to work even with targetted spells (e.g., Blizzard).
* Fast-casting between different spell actions should now work properly.
* Reworked the way that macros are handled by Fastcast to greatly increase its utility with these.

Fastcast v1.9.1
* Removed an unneccessary cooldown check that was interfering with the mage "Ice Block" spell; macros that had cooldowns from their first casting action; and being able to stop wand casting.

Fastcast v1.9.0
* First release as Fastcast.

as Channelcast v1.9.2beta2
* Bug fixes for sequencing problems and for when using cast-time spells or items without going through the action bar.
* Now allows macros to be executed even if a spellcast is in progress.  Note that if your macro needs to cast another spell, it should start with a SpellStopCasting() to be sure to cancel any current spell.  You may need to press your macro key or button twice to successfully trigger your desired spell however.
* No longer gets confused by actions for showing your crafting or tradeskill screens (e.g., First Aid, Cooking, etc.)
* Empty actions will no longer cause your current spell to be cancelled early.

as Channelcast v1.9.2beta
* First beta-release of Channelcast with the new fast cast capability.


Explanation of how Fastcast's fast casting mode works
-----------------------------------------------------
Here is basically what Fastcast does when fast-casting mode is enabled:
1. When an action is triggered, record the time at which that happened.
2. When the SPELLCAST_START event is received, use the duration parameter together with the action start time and a padding/fudge factor to determine the earliest time at which we can safely interrupt (cutoff) the spell cast.
3. When the player triggers another action, if the time is less than the cutoff time, then ignore it.
4. When the player triggers another action, if the time is later than the cutoff time, but the spell is still casting (i.e., no SPELLCAST_STOP event yet) then cancel the spell and start the new action instead.


An example of how/why this works is as follows (based on how these things are usually designed, rather than any specific knowledge):

Suppose that your connection to the server has a transmission time of between 100 and 200msec, and the server itself takes 100 to 200msec to process your client's requests and send a response back.  Your latency (i.e., time it takes to send a message from your client to the server and get a response) would then be in the 300 to 600msec range (i.e., a variability of 300msec).

Now lets assume that at time 0 you press your button to start casting your 1.5 second "Scorch" spell.  That means that at about time 0.1 to 0.2 the message arrives at the server saying you want to start casting, and at time 0.2 to 0.4 the server has processed that request and sends a response back saying the spell started casting, which then arrives back at your client somewhere between at time 0.3 to time 0.6.  Some 1.5 seconds after the server sent the "start" message, it sends the "stop" message.  Now depending on how the server processes these things, it may do this based on when the request arrived (best cast), or when the request was processed (worst case).  We'll assume the worst case, meaning the "stop" casting message will be sent at time 1.7 to 1.9, which means it would arrive back at your client somewhere between time 1.8 to 2.1.

Assuming we are using Fastcast's fast-casting implementation with a padding of 0.2, and the player is spamming their cast key as fast at they can, suppose that at exactly time 1.70 the (lucky) player presses their action key again.  Since that is later/equal to 1.7 (time 0 + duration 1.5 + padding 0.2) and the client hasn't received the "stop" message yet (earliest would be time 1.8), Fastcast cancels the current spell (via SpellStopCasting) and starts a new one casting instead.  The cancel message and new spell request are basically sent together at time 1.7, meaning they will arrive at the server at time 1.8 to 1.9.

Probably a lot of the time, the cancel message will arrive after the server sends the stop message, however you can see there is some overlap (specifically between 1.8 and 1.9) where if the stop message arrives, it will cause the server to cancel the current spell and you will get an Interrupted message instead of a stop message.  The only way to fix that is to increase the padding value to match th connection variability (i.e., use 0.3 instead of 0.2).

(Note that if your transmission time to the server was 400 to 500msec rather than 100 to 200msec, but with the same variability, then the 0.3 padding would still apply, even though your latency would now be 900 to 1200).


Thanks to...
------------
Astos of Icecrown for posting the details in the UI forums (else I would never have seen them) and asking whether an addon solution was possible.
Rusrusrusrus of Doomhammer for the macro with the SpellStopCasting() solution on which this is all based.
Yes of Shattered Hand for raising the problem in the mage forums (and sticking at it).


Hope it works well for you!
-- Cirk of Doomhammer
