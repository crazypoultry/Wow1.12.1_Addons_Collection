Description : 
This mod gives warriors and bear form druids a "HateMe" button for generating threat and a "HateYou" button for DPS. HateMe Resurrection is a button mashing mod. It selects what I beleive to be the best spell for the situation and casts it.

This is a very simple mod, it (mostly) auto configures its self. Install it, and then either create a macro ("/hateme" for Threat generation and "/hateyou" for DPS) or bind a key. Then when you have a mob selected, mash the button to either make them hate you with the HateMe button or show that you hate them with the HateYou button.

You are expected to manaully cast Challenging Shout, Shield Wall, Shield Bash, and and other abilities not covered in the mod. I have purposlly left out mulit-enemy ablities and have no plans to add them in the future, so these must be manually cast as well.

This is a tool, it is not auto pilot for warriors... there is still alot about being a warrior that a human mind has to think and decide on. This just takes one small facet (getting aggro and dealing DPS) and automates that...

The only "configuration" you, other than making the macro or key binding, have to do is somewhere on one of your action bars (SHIFT-1 through SHIFT-6, the three stance/form bars, or even the hidden seventh bar), you need to have "Overpower" and/or "Revenge" placed if you have those spells. This is needed, becasue there is no way in the API to tell when they have "lit up" outside of them being in an action bar. The two spells do not have to be visible, as they will still light up when on a hidden bar.

There is now a GUI for HateMe Resurrection's additional commands. This can be reached via key binding or slash command. The following lists HateMe Resurrection's slash commands.

Commands (all commands will work with /hateyou as well)
========
/hateme config (also works with "options" and "settings")
- displays the options screen. This screen contains all the functions of the other slash commands.

/hateme status
- displays current configuration

/hateme rend [ on | off ]
- turns rend on and off. When on, rend will only be used with HateYou. (default is on)

/hateme taunt [ on | off ]
- turns taunt on and off. When on, taunt will only be used with HateMe. (default is on)

/hateme execute [#]
- choose how much rage to store before using execute (default is 10)

/hateme sunder [ more | 5 ] (also works with [ >5 | =5 ] or [ on | off ])
- choose whether to sunder armor after sunder has maxed out its debuff on a mob. Sunders after 5 continue to add threat even if they no longer lower the mob's armor. (default is 5)

/hateme hs [ between | after ] (also works with [ on | off ])
- choose whether to do heroic strike when sunder is on cooldown or wait until all sunders are done. This is useful if you have plenty of rage. If sunder is set to more and hs is set to after, HateMe will not use heroic strike. This command only works on the threat generating HateMe button, not the DPS HateYou button. (default is after)

/hateme test [ on | off ]
- When on, HateMe will report what ability it is using. (default is off)

/hateme immune [ on | off ]
- when on, HateMe will not try to perform an action on a mob it knows is immune. (default is on)

/hateme clear
- Clears all saved immunities and runners.


When you press a button, the following logic happens. If a line evaluates, it stops there and casts that spell or does that action. If a spell/power is listed, and you don't have it... HateMe will skip that step. If a spell needs a shield, and you don't have one equiped, HateMe will skip that step also.

Depending on the stance (or form) the following logic is applied

=============
HATEME button
=============
Berserker
if mob is looking at me then use Berserker Rage
if mob health <= 20% then perform execute
if player health > 50% and rage < 20 then perform bloodrage
if mob health < 40% and you've seen them try to run before then perform hamstring
if self not battle hardened, or battle shout will affect at least 5 units, then use battle shout
if shield slam is not on cooldown then perform sheild slam
if you got this far then use sunder armor
if there is 5 sunders on the target, use heroic strike (There is an option to HS when sunder is on cooldown)

Battle (keep enough rage for overpower at all times)
if mob is looking at anyone else but me and mocking blow is not on cooldown then use mocking blow
if overpower is lit up then use overpower
if mob health <= 20% then perform execute
if player health > 50% and rage < 20 then perform bloodrage
if mob health < 40% and you've seen them try to run before then perform hamstring
if self not battle hardened, or battle shout will affect at least 5 units, then use battle shout
if shield slam is not on cooldown then perform sheild slam
if you got this far then use sunder armor
if there is 5 sunders on the target, use heroic strike (There is an option to HS when sunder is on cooldown)

Defensive (keep enough rage for revenge at all times)
if mob is looking at anyone else but me and taunt is not on cooldown then use taunt
if revenge is lit up then use revenge
if player health > 50% and rage < 20 then perform bloodrage
if shield block is not on cool down and revenge not on cool down then use shield block
if self not battle hardened, or battle shout will affect at least 5 units, then use battle shout
if shield slam is not on cooldown then perform sheild slam
if you got this far then use sunder armor
if there is 5 sunders on the target, use heroic strike (There is an option to HS when sunder is on cooldown)

Druid Bear Form/Dire Bear Form
if you are not in Bear Form, shapeshift
if mob is looking at anyone else but me and growl is not on cooldown then use growl
if player health > 50% and rage < 20 then perform enrage
if mob not afflicted with faerie fire then use faerie fire
if bash is not on cooldown then perform bash
if you have the rage available then use swipe (I'm requiring 5 rage extra so that it can get to maul sometimes. If this doesn't work out I will change it.)
if you got this far then use maul

==============
HATEYOU button
==============
Berserker
if mob is looking at me then use Berserker Rage
if mob health <= 20% then perform execute
if player health > 50% and rage < 20 then perform bloodrage
if mob health < 40% and you've seen them try to run before then perform hamstring
if self not battle hardened then use battle shout
if mortal strike is not on cooldown then use mortal strike
if Bloodthirst is not on cooldown then perform Bloodthirst
if you got this far then use heroic strike

Battle (keep enough rage for overpower at all times)
if overpower is lit up then use overpower
if mob health <= 20% then perform execute
if player health > 50% and rage < 20 then perform bloodrage
if mob health < 40% and you've seen them try to run before then perform hamstring
if your heath > 50% and the mob's heath is > 40% then use rend
if self not battle hardened then use battle shout
if mortal strike is not on cooldown then use mortal strike
if Bloodthirst is not on cooldown then perform Bloodthirst
if you got this far then use heroic strike

Defensive (keep enough rage for revenge at all times)
if revenge is lit up then use revenge
if player health > 50% and rage < 20 then perform bloodrage
if your heath > 50% and the mob's heath is > 40% then use rend
if self not battle hardened then use battle shout
if mortal strike is not on cooldown then use mortal strike
if Bloodthirst is not on cooldown then perform Bloodthirst
if you got this far then use heroic strike

Druid Cat Form
if you are not in Cat Form, shapeshift
if you are not furious, perform tiger fury
if targe has 5 combo points, perform rip
if target is not afflicted by rake then use rake
if you got this far then use claw
