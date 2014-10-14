NOTE: If you login to Kargath to ask me a question about this mod, check to see where I am
first. If I'm in a raid zone, don't bother sending me any tells. They will be ignored. I do
not log in each night to answer questions from people who cannot understand the concepts
of setting up a macro or setting up a keybinding. There is an email address, an AIM address,
and an IRC channel listed at the end of the documentation. If I'm busy, either leave a comment here or use one of those methods of contact. If I'm not raiding, then I'll be happy to talk to you. There are no exceptions to this, and if you persist on bothering me
while raiding, I will add you to my ignore list.

--LazyTank--
by Dayne <Paradosi>, Kargath/US


--What is it?--

LazyTank is, essentially, a very long and semi-intelligent macro for tanking. It prioritizes your threat moves and selects the best of the bunch to perform at any keypress. It is a one-button solution for tanking, you just set it up in a macro, spam it, and go to town.
A blind-in-one-eye half retarded monkey could hold aggro with this mod, which sadly, is
about the quality of most tanks out there.

It is also compatible with the KLH ThreatMeter mod. No additional configuration is necessary, it'll detect it on it's own.

--(Nerd Stuff, skip if you don't want to know how the mod works)--

Basically, the logic flow is thus -

If Revenge is up, use it. If it's not up, use Sunder Armor, but leave enough rage for
Revenge when it does come up. Once 5 Sunder's are stacked, start alternating between
Sunder Armor and Heroic Strike, always making sure enough rage is left for Revenge. That
is the basic logic flow. 

Now, to make things even more muddy, there are some option toggles that get thrown in, and pre-empt the hate routine. They will be listed in order of priority:

-Bloodrage: If you are above 50% health and Bloodrage is available, it will be used.

-Execute: If you toggle this one, then once your target falls below 20%, you will switch
to Battle Stance and it will only cast execute from there on in. Yes, this was added in
specifically with Vael in mind.

-Thunderclap: It will check for the Thunderclap debuff, and, if not present, switch to Battle Stance and use it. 
NOTE: If you have a Thunderfury in the raid, do not turn this on. It will not overwrite 
Thunderfury, and the mod presently does not check if the Thunderfury debuff is up or not. 
If you toggle this on and the Thunderfury debuff is on the mob, you will get caught in an
endless loop. I don't want to hear about it if this happens to you. I will code in a debuff
check for Thunderfury eventually, but it's low priority.

-Demoralizing Shout: If this is toggled on, then once 3 Sunders are on the target, it will
cast Demoralizing Shout. Be careful with this, like Thunderclap, if DemoShout keeps getting pushed off, you might find yourself in an endless loop and lose hate on the mob. This is mostly to help the MT if their offtanks are lazyasses.

-Battle Shout: If this is toggled on, then once 3 Sunders are on the target, it will cast Battle Shout. Shuts up pesky rogues who are in your group.

-Rage Dump: If you have over 60 rage, then it will spam Heroic Strike. This is now a toggle.

After that comes, the normal Revenge, Sunder, Sunder/Heroic Strike spam. There are two exceptions. The first one is if you have Shield Slam. If so, then it's higher in the priority list than Sunder, but lower than Revenge. Ie, the threat order becomes Revenge, Shield Slam, Sunder, then Sunder/HS once 5 are applied. There is no additional configuration necessary for Shield Slam, if you have it, LazyTank will detect it and use it automatically.
There is also a toggle for the automatic use of Shield Block. If toggled on, it has higher priority than Shield Slam, Sunder, or Heroic Strike, but not Revenge (obviously, since the normal point of using Shield Block is to get Revenge lit up).

In addition to all the threat related moves, there is a fear break routine. What it basically does is move you to Berserker Stance, casts Berserker Rage (but only if it's available) and then puts you back in Defensive Stance. When your Berserker Rage cooldown reaches 5 seconds, it will notify you. When the Berserker Rage cooldown expires, it will
also notify you. The fear break routine only works if Berserker Rage is available, if it's on cooldown, it will tell you so.

-Paranoia Checking - If toggled on, once your health reaches under the specified threshold,
it will use 'save my ass' special moves and items. The default paranoia % is 20%, and can
be increased or decresed by 5% via the use of /lzt increment and /lzt decrement respectively.
Paranoia is implemented in the following order:

1. If equipped and not on cooldown, use Lifegiving Gem
2. If trained and not on cooldown, use Last Stand
3. If not on cooldown, use Shield Wall
4. If in inventory and not on cooldown, use Major Healthstone
5. If in inventory and not on cooldown, use Major Healing Potion

If nothing is available, LazyTank will inform you as such and continue on through it's normal
routine. There is a 2 second choke between the triggering of paranoia items (ie, if it
uses Lifegiving Gem, it won't move on to using Last Stand for another 2 seconds, even if
you're still below the paranoia defined threshold)

--How To Use It--

Requirements: Heroic Strike, Sunder Armor, Revenge, Shield Block, Berserker Rage, Bloodrage, Thunderclap, and Shield Slam (if you have it) *must* be somewhere on your action bars. You do not have to have a keybinding assigned to them, they just have to be there. If you are getting any LUA errors, this is the first thing to check. In addition, the Attack icon from your spellbook must also be somewhere on an action bar, though it is not required to be bound to
a key. If you have your Main Hand weapon anywhere on an action bar, take it off, otherwise LazyTank might try to Equip/Unequip your Mainhand weapon instead
of using Auto Attack. (Nerdy Explanation: The only way to check whether or not auto-attack is active is to check the Texture of the Attack action... which changes each time you change weapons. If you change Mainhand weapons alot, you will also run into issues with auto-attack)

-Implementations-

There are two ways to use LazyTank. In your KeyBindings, there are two options. HateMonger and Fear Break. HateMonger is the equivalent to typing /lzt hate. This fires off the main
hate routine, and is the guts of the entire mod. The second keybinding, Fear Break, is the equivalent to typing /lzt zerk. If you bind a key to this, just tap it three times and that's all you need to do. I *strongly* recommend the use of keybinding the routines over Macros.

The second way to use LazyTank is via Macros. I'm not going to tell you how to setup a Macro. Ask one of the smart people in your guild. 

For a macro, all you need to do is create one with the command /lzt hate, and then drag it to your action bar and pound on that key. That's it. For the Fear Break routine, create a macro with the command /lzt zerk and drag it to your action bar. Pound it when you're tanking Magmadar, Onyxia, or Nefarian. 

The following is the full list of commandline options available to LazyTank:

/lzt hate: Main threat routine
/lzt zerk: Fear Break routine
/lzt shout {on|off}: Toggles Battle Shout checking
/lzt block {on|off}: Toggles Shield Block checking
/lzt execute {on|off}: Toggles Execute checking
/lzt thunderclap {on|off}: Toggles Thunderclap Checking
/lzt demoshout {on|off}: Toggles Demoralizing Shout checking
/lzt brage {on|off}: Toggles Blood Rage checking
/lzt dump {on|off}: Toggles Rage Dump
/lzt help: Shows the LazyTank help list
/lzt status: Shows the current status of your toggles
/lzt increment: Increments the paranoia threshold by 5%
/lzt decrement: Decrements the paranoia threshold by 5%

Recommendations: 

1) Automatically using Shield Block is situational. For fights where you're going
to be raged starved just because the mob can't hit you hard enough, automatically using Shield Block is not the thing to do. It has the effect of being very slow to get Sunder up to 5, and you want that up to 5 as soon as possible for the sake of all melee damage, but it also amplifies the situation, forcing you to take less damage, and thereby rage starving you even more. I generally do not have Shield Block toggled on for trash mobs, and I usually do for boss fights. Just because the name of the mod is LazyTank, doesn't mean you get to slack off entirely. 

2) Depending on your raid, you may not want to have Demoralizing Shout toggled on. If you find debuffs are constantly getting pushed off, then you will get caught in a cycle where LazyTank checks for DemoShout, finds it's not there, and casts it every few seconds, because someone is knocking it off. This is not ideal for holding threat if you are in a high dps guild. It's up to each and every single warrior to determine whether or not they want this toggled on. 

3) Use Execute tanking at your own risk. If you toggled it on for Vael, but then forgot to take it off, I don't want to hear any bitching when Broodlord owns you. Vael has taught me the value of using Execute as a threat holding tool, and there are quite a few mobs I do Execute tank on, but it does tend to give your healers fits as your damage spikes are just that little bit much bigger.

4) I changed the commandline usage to make it easier to setup tanking sets. The old way was that the commandline option simply toggled whether or not it was active, now you can explicitly tell it what you want turned on and off.

5) Use Paranoia checking at your own risk, and set your thresholds properly. Otherwise,
prepare to go through ALOT of Major Healing Potions

For example - For the Twin Emperors, I would setup the following macro:

/lzt execute off
/lzt shout on
/lzt demoshout off
/lzt block off
/lzt thunderclap off
/lzt brage on

This would ensure you weren't trying to Execute tank at any point (which will get you killed), makes sure you keep Battle Shout up, used Bloodrage when it came available, and did not use any of your AoE abilities to aggro little bugs. When you walk into the twin emps room, use that macro. Then you can set one up for Trash enabling all the stuff you just
turned off and hit that once the Emps are dead. 

--Misc.--

Some of you are going to feel like this mod is cheating. I don't care. It's called LazyTank
because that is, essentially, what it turns you into, but my main goal is to generate as much threat as possible in as short amount of time. This is alot easier if I take most of my reaction time and the possibility of me fat fingering a key or two out of the equation. This mod is intended for level 60 power gaming warriors who are tanking in a raid setting, and whether or not you use it is entirely up to you. Every single function and command is supported by the scripting language, so it is 100% legal. If you feel like flaming me, fine, it'll be ignored. If this helps you and your guild out, then I'm glad. I wrote this mod for my own personal use, but decided to share it for anyone else who may feel the same way, and that's the bottom line. Like it or lump it, I don't care which.

--Future Plans--

-Code Optimization: This is my first mod, and as such I'm sure there are things I could have done better. Once I get everything actually working, I'll make it as slim as I possibly can. That being said, it's not exactly a memory hog.
-Thunderfury debuff check for ThunderClap - I will, eventually, get around to coding a check for this to eliminate the possibility of an endless loop if ThunderClap is toggled on and the Thunderfury debuff is active. It's not very high  priority though
-Force Paranoia: Keybinding and command for forcing all paranoia abilities to go off with
no joke at continual keypresses. This is mostly going to be implemented for my own use, for
cases like Maexxna just before a Web Spray with her enraged.

--Acknowledgements--

The idea from this mod originally came from Stabya (Leela). It's based off a mod called
Sunder Armor or Revenge (S.A.O.R). I found it one day, liked it, and then it broke in a
patch. I never went looking for a new version, but when I joined Paradosi, I felt I needed
something of an edge. Like any good tinkerer, I decided to just go ahead and code my own.
So thank you to Stabya, without who's S.A.O.R mod, this one wouldn't exist (and considering
checking out Stabya's very excellent BerserkerRage addon if you find LazyTank isn't suited
to your needs). This mod is also dedicated to the Paradosi rogues, without whom the mod
would never have been necessary. 


--Contact--

Server: Kargath
Faction: Horde
Name: Dayne
Email: drakonblayde@gmail.com
IRC: #kargath, #paradosi on irc.gamesurge.net as Dayne|Home or Dayne|Work
AIM: drakonblayde

Suggestions, questions, and comments are always welcome. If you can break the mod, I would appreciate knowing how so I can fix it!
