Addon Name: 	SnaFu
Author:			Theondry, Perenolde Alliance
Version:		1.83
Home:           http://s15.invisionfree.com/DOoL/index.php?showtopic=131
                (which is not updated as frequently as)
                http://svn.wowace.com/root/trunk/FuBar_SnaFu
Dependencies:	None - plugs into FuBar 2.0 if present.
                Note, this is an Ace2 addon but has no external dependancies.
                    That's what the libraries are for.

Description:
    SnaFu purports to track soulstones on members in your current grouping.
    SnaFu also provides minor pet command capability for Warlocks.

Current Functionality:
    Provides the user with the number of soulstones in place on members of the current
        grouping (party, raid, solo).
    Provides the name and class (via colouring) as well as time left on the stones (subject to limitations).
    Provides a rough estimate (to within 15 seconds) of the cooldown on other warlocks soulstones.
        This info is only shared amoungst other users of SnaFu v1.4 and higher.
    Provides an audio, splash, and text notification on soulstone buff loss (either from death or expiration).
    FuBar text can be toggled to show number of soulstones in place, or time to expiration of the oldest
        stone (subject to Known Limitations on timers)
    For the warlock user, it also provides a keybinding to access pet skills in a dumb fashion.
        Voidwalker - Sacrifices pet if the pet's or player's health is below 11%
        Felhunter - Attempts to Devour Magic on the target and player, (in that order), or
            Attempts to Spell Lock the target.  (zero spell detection.  No, I won't code that in.)
            /snafu togfhspell
        Succubus - Seduces target if a humanoid (very VERY limited reseduction support.)
        Imp - Plays a sound.  (the imp is so noisy!)
        Fel Guard - Intercepts
    I don't expect to provide very much configurability or logic here.  It's purpose is to remove the bloat left by
        Graguk's Servitude in his absence, as well as Blizzard's hamstringing of functions.
        I do not check for the existance of any spells, so only the Imp is guarenteed to work from Day 1.
    Chat channel (should be unaffected by drunkeness)
        /SnaFu chat <message>
        /snc <message>
    Misc. other functions I think.

Known bugs: None

Known limitations:
    Not compatible with SnaFu 1.3.  All SnaFu users in a raid must either have 1.4 or higher,
        *OR* 1.2 or lower.  (1.2 has no communcation function, and so is unaffected.)
        1.3 was a quick hack to learn to use the comms.  :)
    Seduction support is incomplete.  Does not properly reset when targets change.  I'm not sure 
        how to deal with this, for now, so it just resets after a minute.  For right now, if you want
        to autoreseduce a new target more frequently than that, you're on your own.
    Scanned SS timers set to 30 minutes on first detection of stones (i.e., from logging in, joining a raid, etc.)
        If they have SnaFu, it'll be fine, though.

Planned Additions:
    Easy way to change sounds.  (currntly just toggles on or off.)
    Easy way to colour chat names with class color.  (not as simple as it first looked.)
    Version 2 will break compatibility (again) as I will be moving to a different data encoding method.