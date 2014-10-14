Warrior Button v0.93 Options Description
Author: Plumac/Mythia of Defiance on Staghelm

NOTE: In order to function properly this mod requires all of your abilities to be on your action bars somewhere.  They do not have to be visible or on your currently active bars, but they need to be there.

NOTE: This mod will not attack CC'd mobs that you have targeted.  If you want it to attack a CC'd mob, hold the ALT key while calling WarriorButton.

Toggle Boxes:

ENABLED - Unchecking this will prevent the mod from doing anything at all.

Auto Target - Using the macro/key will automatically target the nearest hostile non-CC'd enemy if you have no target.

Snare Runners - The mod will attempt to use Hamstring or Piercing howl the instant an enemy begins to flee.

Interrupt Spells - The mod will attempt to use shield bash or pummel on the event that your target begins to cast a spell.  Stance swaps will be called if necessary.

***THE FOLLOWING 3 OPTIONS CAN BE VERY HAZARDOUS AROUND CC'D MOBS AND SHOULD BE DISABLED WHEN CC IS IMPORTANT***
Area of Effect Damage - Upon detecting 2 or more targets that are not CC'd the mod will begin to call AoE abilities such as thunderstrike, whirlwind, cleave, and sweeping strikes.

Single Target Whirlwind - The mod will use whirlwind when in battlestance to do damage even when there is only one target.

Off Tank Thunder Clap - When in Off Tank mode the mod will keep thunder claps up on the target to reduce damage done to the main tank.
***THE PREVIOUS 3 OPTIONS CAN BE VERY HAZARDOUS AROUND CC'D MOBS AND SHOULD BE DISABLED WHEN CC IS IMPORTANT***

Auto Tank with Shield - The mod will automatically pretend you are in Tank mode if you have a shield equipped and are in standard mode.

Priority Sunder Armor - The mod will apply sunders up to 5 while tanking before doing anything else.

Hook Heroic Strike - The mod will treat any use of the heroic strike key as a call of the WarriorButton function.

Break Fears/Incaps - The mod will use Death Wish and BerserkerRage as necessary to break out of any debilitating effects.  Note death wish requires 10 rage, and you cannot stance change to berserker stance while feared/incapped so the mod will not always be able to break you out of fears.

Auto Attack - The mod will toggle your auto attack as necessary.

Charge - The mod will charge you at you target when you are out of combat. (When combined with Auto target this can lead to problems.  Immediately after one fight if you hit the button 2 extra times you will auto target another enemy and then charge it before you have really realized what has happened.)

Intercept - The mod will attempt to use intercept whenever it is available and in range.

Execute - The mod will automatically begin executing mobs below 20% health.  If you are in tank mode with this option checked you will attempt to switch to battle stance and execute.  Disable this option while tanking if you do not want this to happen.

Disarm - The mod will disarm your target. (Note that this is prioritized VERY LOW and will almost never happen outside of tank mode unless you have huge heaping piles of rage.  It is recommended that even if you turn this on you keep the button on your bar to use as necessary.)

Battle Shout - The mod will use battle shout whenever it is not currently on you.

Demo Shout - The mod will use demo shout whenever it is not currently on your target, and your target is in range of demo shout.

Rend - The mod will attempt to rend targets in PVE.  This has no effect on rending rogues in PVP which happens no matter what options you have.

Berserker Rage - The mod will use berserker rage to generate additional rage as appropriate.

Prefer Berserker to Battle - The mod will place you in Berserker Stance independent of who your target is targeting.

Shield Block - The mod will use Shield Block while tanking if Revenge is not usable.

Numerical Edit Boxes:
Max Cycles Per Second(20) - This caps how often the mod will be called per second.  This is to prevent slowing down or crashing WoW.  If you find that you call the mod fast enough to effect your gameplay, lower this value until it works for you.  Note that lowering this value decreases the reaction speed of the WarriorButton mod significantly.

Rage Buffer(10) - The amount of rage that will be held in reserve for emergency use abilties such as spell interrupts, snares, overpowers, taunts, intercepts, etc.  Lowering this will increase the speed at which you start doing damage during a fight, but increase the likelihood of not having rage for a crucial ability.

Stance Rage Loss(10) - The amount of rage WarriorButton will waste when switching stances.  This does take into account your ranks in tactical mastery.

Rage Gen Cut Off(10) - When lower than this amount of rage WarriorButton will attempt to use Bloodrage or Berserker Rage to generate more rage.

Stance Change Delay(1) - The number of seconds after a stance change before WarriorButton will perform another StanceChange.  If you find yourself switching stances like a madman, increase this value.

Area of Effect Check Delay(1) - How often WarriorButton will check to see if AoE is necessary.  If you find your target being switched on you or notice some slowdown increasing this value will help.

MS/BT/SS Rage Window(2) - The number of seconds before your 31 point abilities cooldown wears off that WarriorButton will stop using other non emergency abilities and generate rage.  If you have enough rage to use your 31 point ability, then WarriorButton will still use damage dealing abilities during this window.  If you prefer Heroic Strike or other damage dealing abilities to your 31 point ability, then decrease this value to 0 or 1 second.

Shield Block Window(.5) - The amount of time before your revenge cooldown wears off to use Shield Block to cause a new revenge to be usable if necessary.  Increasing this value can significantly increase the frequency of Shield Blocks use.

Spell Interrupt Window(2) - The number of seconds after WarriorButton detects a spellcast to attempt to interrupt the spell.  After this window, WarriorButton assumes the spell has been interrupted or cast and gives up if it hasn't detected a successful spell interrupt first.  Increase this if you have problems interrupting spells.  Decrease this if you seem to be shield blocking/pummeling unneccesarily.

Last Stand Health Below(10) - Percent health that you must drop below for Last Stand to be called.  Setting this to 0 will disable the use of Last Stand.

Bloodrage Health Above(30) - Percent health that you must be above to use Bloodrage.  Setting this to 100 will disable the use of Bloodrage.

Mode Options Box(Battle DPS) -
Standard - Will do as much damage as possible.

Tank - Will generate as much hate as possible while saving your rage buffer abilities such as hamstring/shield bash.  Will taunt/mocking blow as necessary to regain aggro.  Will stay in defensive stance almost always.

Off Tank - Will generate as much hate as possible, but will not automatically taunt your target onto you.  Will use Thunder Clap to decrease the outgoing damage of your target if the option is set. If aggro ends up on you, you will switch to defensive stance and generate as much hate as possible.

