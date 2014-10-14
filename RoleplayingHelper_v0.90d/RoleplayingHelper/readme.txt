f(-_-;)   --==Roleplaying Helper==--   (^o^)/

Version: 0.90
WoW Patch: 1.12x

---------------------------------------------------------------------------
NOTE: Most of this text is unchanged from the original authors. I've only
      made a few edits so far -- Talyn
---------------------------------------------------------------------------

Many, many, many English RPs by: mithyk
German translations: ArminAce, Isjari

Roleplaying Helper lets your character automatically roleplay when certain events occur.

---------------------------------------------------------------------------
Dwarves & Trolls:  To have RPHelper (and yourselves) automatically talk in a Dwarvish or Troll accent, please download "Dwarvenizer": http://www.curse-gaming.com/mod.php?addid=3481
---------------------------------------------------------------------------

====================================================================
ROLEPLAYING
====================================================================
DELAY: You can set an a delay time, in seconds, between each role play. Delays of 0 could lead to spamming so be careful.
CHANCE: When an event occurs, your character has an adjustable % chance to roleplay to that event.

CUSTOMIZATION
Files have been provided so you can customize what your character will say based on class & race.
(If you want to be schizophrenic, you can even change your Gnome Mage to speak like an Undead Warrior instantly in the menu.)

GRAPHIC MENU
Type /rp while playing to see the menu.
(Warning: a 100% chance and a 0 second delay gets very annoying, very quickly, to the people around you.)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
EVENTS THAT TRIGGER ROLEPLAYING HELPER
A randomly chosen saying or emote may be used when...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
====================================================================
COMBAT EVENTS
====================================================================
---------------------------------------------------------------------------
ENTERING & LEAVING COMBAT
---------------------------------------------------------------------------
     you go into combat mode (note: warriors trigger this when using "Bloodrage")

     you leave combat mode
---------------------------------------------------------------------------
FIGHTING
---------------------------------------------------------------------------
     if your health is above 70% and:
	- an enemy misses you
	- you dodge an enemy's attack
	- you absorb an enemy's attack
	- you block an enemy's attack
	- you parry an enemy's attack

     	- you give a critical hit from physical hits or spells with physical damage (ie: Raptor Strike)
	- you give a critical hit using Arcane, Fire, Frost, Holy, Nature, or Shadow Damage. (Wands do this too) 

     you get hit & you have less health than the last time you got hit
---------------------------------------------------------------------------
PETS
---------------------------------------------------------------------------
     your pet begins attacking
	(some phrases use the name of your pet and the gender of its target)

     your pet stops attacking (you may still be in combat)

     your pet dies


====================================================================
NON-COMBAT EVENTS
====================================================================
     you talk to an NPC
	- if you haven't spoken to this NPC before, with RPHelper loaded, you'll introduce yourself
		(you'll only introduce yourself once to NPCs with the same name [ex: guards])
	- if you're female, you have a chance to "CURTSEY"
	- if the NPCs level is higher than yours, you have a chance to "KNEEL"	
	- RPHelper will distinguish between Beginning, Middle & End of a conversation.

     you resurrect

====================================================================
ANYTIME EVENTS
====================================================================
---------------------------------------------------------------------------
SPELLS
---------------------------------------------------------------------------
     you begin casting a spell
	(Anything with a cast time.  Not instant or channeled.)

     As of v0.77:  All Hunter, Warrior & Warlock spells work (Cast Time, Instant, Channeled)
	See "Known Issues" below about "Next Melee" spells

     you heal someone else

     you critically heal someone else

---------------------------------------------------------------------------
NPC Talks (NPC yells do not count)
---------------------------------------------------------------------------
     a friendly NPC says something 

     an enemy NPC says something


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
KNOWN ISSUES
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Next Melee spells:  have a chance to RP when they're cancelled.
Next Melee spells:  will not RP if you cast another spell before the next melee.
Next Melee spells:  have a chance to RP when you don't do the next melee (ie: enemy dies), then you select a targetting spell without a target, and then you target.
Targetted instant spells:   will only RP if you have a target when you select the spell.

The emote: "ATTACKTARGET" does not seem to work with the code: DoEmote()
Does anyone know another emote word that does exactly the same thing?

If your pet dies and you put a 0 second delay before "pet stop attacking", your character might say a "pet stops attacking" phrase.
 (ex: Good job, [pet name].)

I think... if you are dead when you start the game, you won't say anything when you resurrect the first time.

Please report any other bugs/issues you find.

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
LOCALIZED VERSIONS
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Isjari was kind enough to tweak RoleplayingHelper.lua to make it work on the German client. Everything has since been modified so it should now work on all clients.

NOTE: Localizations are disabled on 0.90 until they are updated and verified functional!

ArminAce & Isjari also translated many of the phrases into German & ArminAce has been updating them.

The German version is now included in the release version.  The files are in a seperate folder called "Deutsch".  All other localizations must use the files in the "English" folder.

Many thanks to both (^_^)

---------------------------------------------------------------------------
THANK YOU
---------------------------------------------------------------------------
You
Everybody who gave me great feedback
Miho
Alexander Brazie [author of Combat Caller] and K. Bishop [author of Lore] whose addons I studied from when learning LUA.


