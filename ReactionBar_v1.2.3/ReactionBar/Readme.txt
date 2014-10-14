ReactionBar gives you access to the most relevant skills depending on your target.  This is important because there are so many skills and ranks of skills you can't possibly have them all bound to easily accessible keys, however with ReactionBar you can.
ReactionBar does this by switching the skills on your main ActionBar depending on if your target
- is something you can attack and
- is at a certain range.
For healing classes only the first applies, for Hunters both apply.

ReactionBar can automatically switch between 3 pages of skills, a fourth for no target, a fifth one is available through a bindable key toggle, and then three more are available by holding CTRL, ALT or SHIFT.
1. FriendlyPage - shown when out of combat or targetting a friendly player or npc.
2. EnemyPage    - shown when targetting a hostile target
3. RangePage    - (Hunters only) shown when the Auto-Shot skill is in range
4. NoTargetPage - shown when you have no target
5. ExtraPage    - shown while a configurable key is held down
CTRL/ALT/SHIFTPage	- shown while CTRL/ALT/SHIFT is held down

ReactionBar defaults to the FriendlyPage with a value of 2, so don't be alarmed if your new character has no actions shown to start with, just drag your friendly actions here from your SpellBook.

ReactionBar doesn't give you extra bars, but utilises your existing ActionBars.  It will work with the default UI, as well as Gypsy, CTMOD and GBars ActionBar mods.  It won't work with Discord Action Bars or FlexBar as they provide their own framework to do this, it also now won't work with Nurfed as they seem to have modified how their ActionBars work.

As I mentioned before ReactionBar provides custom functions for Hunters as well as for Druids.  The self-casting of heals while targetting an enemy is also provided and ReactionBar has no problems with duels, in fact it takes it a step further.

When you duel it's critical to get the first blow or spell in.  However your target is friendly until right at the last moment and your offensive spells aren't shown.  What ReactionBar does is capture the duel request and flag your duel partner as an enemy, when the duel countdown starts ReactionBar automatically switches to the enemy page so you can spam whatever offensive spell to get the upper hand as soon as your target becomes hostile.

About now you might be thinking to yourself, but I need to self cast heals on myself while I have an enemy targetted and don't want to lose my target.  Well ReactionBar has got that covered with the advanced self cast feature.  Keybindings need to be setup for this in the World of Warcraft keybindings menu under the ReactionBar SelfCast heading.  This allows you to cast on yourself, any of the actions from the friendly page even if you are targetting an enemy and have the enemy page shown.

For Druids the functionality makes sense in caster form but not in any of the shapeshifted forms.  ReactionBar disables the automatic page switching when the druid changes form and enables it when they return to Humanoid form.  The toggleable extra Action Page is accessible in shapeshifted form.

The Hunter range switching occurs at 5.5 yards, this is just before Melee skills become available.

CTRL/ALT/SHIFT page switching was added reluctantly, but now that I've played around with it I really like it.  Coupled with the new Auto Self Cast you can heal really well.  Say you always use Alt for self casting, now you set the ALT page to the same page as the Friendly Page.  Targetting and enemy, nothing or yourself, ALT casting heals you.  Now if you are targetting a friendly, the Friendly page is already shown, so just set ALT combinations to the old Blizzard self cast keybinds and you still cast on yourself even if you're targetting a friendly.

CTRL/ALT/SHIFT page switching if enabled uses an OnUpdate function, if you don't like them, don't worry, you can still use the bindable key toggle and bindable self casting.  CTRL/SHIFT/ALT page switching is disabled by default, so if you're happy with how it worked before you don't need to do anything, it will still all work the same as before.

The pages that are used by the friendly, enemy, range and toggleable Action Pages can be configured using the slash commands below.  Defaults are 1 for enemy, 2 for friendly, 3 for the extra page and 4 for range page.  For most people that will be fine, but if you want to change them, The default WoW UI has 6 Action Pages.  By default you can scroll through all 6 of them.  Once you start turning on the extra bars at the right hand side and above the MainBar frame, you lose Action Pages to scroll through.  With all extra bars open you are left with 2 Action Pages in the MainBar frame, by default ReactionBar uses both of these to switch between.

ReactionBar is automatically disabled for your characters that don't need this functionatily. You can easily enable it for that character by using the enable slash command.

Reactionbar has the following slash commands, /reactionbar and /rb are the prefixes.
/rb enable      -- enable ReactionBar functionality
/rb disable     -- disable ReactionBar functionality
/rb status      -- outputs status of ReactionBar
/rb reset       -- resets ReactionBar tp default settings
/rb monitorduel -- toggles pre-duel switching on or off
/rb help        -- show this help message
For the following commands page id is optional, if not given the current page is used, page id should be between 1 and 6.
/rb friendlypage [page id] (default 2) set the friendly action page id
/rb enemypage [page id]    (default 1) set the enemy action page id
/rb rangepage [page id]    (default 3) set the range action page id
/rb extrapage [page id]    (default 3) set the extra action page id
/rb notargetpage [page id] (default 1) set the notarget action page id
/rb ctrlpage  [pageid]     (default 3) set the CTRL action page id
/rb shiftpage [pageid]     (default 4) set the SHIFT action page id
/rb altpage   [pageid]     (default 2) set the ALT action page id
/rb ctrlenable						 (default off) toggle CTRL page switching
/rb shiftenable						 (default off) toggle SHIFT page switching
/rb altenable						   (default off) toggle ALT page switching

ReactionBar has no required dependencies.  It will work with the default UI, as well as Gypsy, CTMOD and GBars ActionBar mods.  It won't work with Discord Action Bars or FlexBar as they provide their own framework to do this. I believe it should work with other mods that change the appearance of the ActionBar.  If you know of any that it doesn't work with, most likely the Self Cast feature, then by all means let me know.

-------------------
  Version History
-------------------
v1.2.3
- fixed self cast bug

v1.2.2
- fixed enable/disable status problem

v1.2.1
- fixed some initialisation errors

v1.2
- CTRL/ALT/SHIFT page switching added
- some code optimization

v1.1.4
- hunter range switch at 5.5yards
- remembers enable param for other classes
- updated TOC for patch

v1.1.3 - 28th February 2006
- fixed REACTIONBAR_ENABLE problem

v1.1.2 - 27th February 2006
- added global variable REACTIONBAR_ENABLE for other mods to determine if ReactionBar is enabled

v1.1.1 - 27th February 2006
- split help output to multilines
- removed a test output line

v1.1 - 26th February 2006
- hunter range functionality added

v1.0 - 8th February 2006
- save variables per character per realm

v0.9b - 19th January 2006
- internationalised the pre-duel switching feature

v0.9a - 18th January 2006
- removed restrictions on friendly and enemy action page ids

v0.9 - 17th January 2006
- added pre-duel switching functionality

v0.8 - 17th January 2006
- fixed bugs in reset function 
  - not disabling for restricted classes
  - typo error in output

v0.7 - 5th January 2006
- fixed bug in setting friendly page
- updated TOC

v0.6 - 17th October 2005
- given access to a toggleable third page for misc actions
- stopped referring to bars, now call them pages
- easier configuring of pages

v0.5 - 14th October 2005
- added reset command
- added compatibility with GBars
- changed defaults for friendly and enemy bar ids
- minor, probably unnoticeable, code tweaks

v0.4d - 13th October 2005
- fr/de localization for Druid support

v0.4c - 12th October 2005
- self cast error actually fixed this time

v0.4b - 12th October 2005
- updated for 1.8 patch
- fixed small self cast error caused by 1.8 patch

v0.4a - 11th October 2005
- extended the useable bar ids from 4 to 6
- fixed a Gypsy Hotbar self cast problem

v0.4 - 11th October 2005
- added Druid support
- added help slash
- added MyAddons support
- now disabled for non healing classes
- second character problems fixed

v0.3 - 8th October 2005
- added slash commands
- configurable friendly and enemy bar id's
- enable/disable Reactionbar functionality
- output status of Reactionbar
- removed class restrictions

v0.2 - 7th October 2005
- self cast functionality
- cleaned up the code

v0.1 - 3rd September 2005
- bar switch functionality