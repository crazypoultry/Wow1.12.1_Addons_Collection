
HealPoints - A WoW benchmark addon for healers, Version 1.12.1
================================================================

1: About
2: Usage
3: Formulas used
4: HealPoint stats
5: Equipment supported
6: Talents supported
7: Buffs supported
8: Known bugs and limitations
9: Frequently asked questions (FAQ)
10: Version history

----------------------------------------------------------------
1: About
----------------------------------------------------------------

HealPoints was developed by Eridan, Argent Dawn EU. With assistance from Melthruil (coding and testing),
Elanae & Tas (testing), Nihlo, Nyce & olixxl (German localization).

HealPoints uses a modified version of the BonusScanner library by CrowleyAJ.
http://ui.worldofwar.net/ui.php?id=1461

HealPoints was inspired by TankPoints by Whitetooth.
http://www.curse-gaming.com/mod.php?addid=1365

----------------------------------------------------------------
2: Usage
----------------------------------------------------------------

The addon is accessed from the Character Info sheet. Below the character, the computed HealPoints benchmark
value will be displayed (healing classes only). If you mouse-over the "HealPoints: xxxxx" line, additional
information (such as mana regen) will be displayed.

If you click on "HealPoints: xxxxx", the HealPoints Calculator will be displayed. The calculator is divided
into three parts. Several of the displayed stats have explanatory tooltips - just mouse-over.

The bottom part displays basic stats such as intelligence and spirit. These stats can be adjusted using
buttons or by entering a value directly. You can then observe how this will change other stats. (Useful to
choose between +24 healing or +4 mana/5s enchants for your new bracer, for example)

The middle part displays stats about the healing spells your character knows. You can select the different
spells using the drop down menus. The right drop down menu is used for heal-over-time (HoT) spells and is
only used for priests and druids. For each of the selected spells, HP/sec, HP/mana, Tot HP(-r) and Tot HP(+r)
are displayed. Tot HP(-r) is the amount of HP you can heal with the selected spell using a full mana bar
without manaregenration. Tot HP(+r) is the same, but with mana regeneration taken into consideration.

The top part explains how the HealPoints stat is computed. It consists of two parts: PowerPoints and
EndurancePoints. Both are explained by tooltip and in section 4 of this readme.

----------------------------------------------------------------
3: Formulas used
----------------------------------------------------------------

Effect of spirit:
Spirit increases normal mana regeneration. For priests 13 + spirit / 4 is regenerated every 2 seconds.
For paladins, druids and shamans, the value is 15 + spirit / 5. (For very low levels of spirit (<50) these
formulas are no longer accurate.)

Intelligence and spell crit:
Int increases the chance for a spell critical. The following was posted by Tseric on the WoW US boards:

	"The basic mechanic of INT to Crit% is an increase of 1% every 59.5 points for mages.
	A mage is generally expected to have around 286 points of INT at 60. This works out to
	about 5% crit on average for mages. It is possible to go higher, as Crit% does go up
	incrementally."
 
	"We only published numbers for mages at level 60 and it works out to 59.5 INT/1% Crit.
	The number is not a standard for all classes at all levels, it varies in each case."

and more recently:

	"Here are some other numbers to that end: At level 60, these are expected numbers of INT and
	points per Crit% Warlock 200 - 60.6 Druid 192 - 60 Shaman 160 - 59.2 Priest 250 - 59.5"
 
Based on testing done by various WoW players and posts by Tseric, 
HealPoints currently uses the following:
	0.8% base crit for Priests
	1.8% base crit for Druids
	2.3% base crit for Shamans

	30.0 int = 1 % crit for Paladins
	59.5 int = 1 % crit for Priests
	60.0 int = 1 % crit for Druids 
	59.2 int = 1 % crit for Shamans

A spell crit increases the healing effect by 50 %. Heal-over-time spells cannot crit.
(For regrowth the burst part can crit, the HoT part not.)

+healing and spell casting time:
The effect of +healing equipment varies with spell casting time. For burst spells, casting time of 3.5s or
longer gives full effect. Faster spells get x/3.5s of the +healing bonus (where x = casting time). Heal over
time (HoT) spells are treated similarly, but with 15s instead of 3.5s. For these spells, the +healing bonus
is divided between each HoT tick. If a spell has reduced casting time (from talents or equipment), the
original casting time is used to find the effect of +healing.

+healing and lowlevel spells:
Healing spells learned before level 20 have reduced effect from +healing equipment. HealPoints uses the
following formula (from www.wowwiki.com, verified by my own testing):
      effect = 1 - ((20 - lvl) * 0.0375) 
where lvl is the level the spell is learned.

+healing and regrowth:
For regrowth, the +healing bonus is split in two. Half is applied to the HoT-effect and 2.0/3.5 of the other
half is applied to the burst heal effect.

Blessing of Light and lowlevel spells:
BoL also have reduced effect for spells learned before level 20. I've found these values:
Holy Light rank 1: 20 %; rank 2: 40 %; rank 3: 70 %

----------------------------------------------------------------
4: HealPoint stats
----------------------------------------------------------------

PowerPoints:
Hitpoints healed in 1 minute using your most powerful spell, starting with 100% mana.
Regeneration and 5 second rule are taken into account.

EndurancePoints:
Hitpoints healed in 5 minutes using your most efficient spell, starting with 0% mana.
Regeneration and 5 second rule are taken into account.

These are the default settings. You can change them by clicking  the "Configure"-button in the
calculator window.

----------------------------------------------------------------
5: Equipment supported
----------------------------------------------------------------

The BonusScanner library is used to detect 
* +healing 
* +mana/5s 
* +spell crit
* +spell crit (holy)

It has also been modified to support the following set/equip bonuses:
* Allows x% of your Mana regeneration to continue while casting.
* Improves your chance to get a critical strike with Nature spells by x%.
* Reduces the casting time of your Regrowth spell by 0.x sec.
* Reduces the casting time of your Holy Light spell by 0.x sec.
* Reduces the casting time of your Healing Touch spell by 0.x sec.
* -0.x sec to the casting time of your Flash Heal spell.
* -0.x sec to the casting time of your Chain Heal spell.
* Increases the duration of your Rejuvenation spell by x sec.
* Increases the duration of your Renew spell by x sec.
* Increases your normal health and mana regeneration by x.
* Increases the amount healed by Chain Heal to targets beyond the first by x%.
* Increases healing done by Rejuvenation by up to x.
* Increases healing done by Lesser Healing Wave by up to x.
* Increases healing done by Flash of Light by up to x.
* After casting your Healing Wave or Lesser Healing Wave spell, gives you a 25% chance to gain Mana equal
  to x% of the base cost of the spell.
* Your Healing Wave will now jump to additional nearby targets. Each jump reduces the effectiveness of the
  heal by x%, and the spell will jump to up to two additional targets.
* Reduces the mana cost of your Healing Touch, Regrowth, Rejuvenation and Tranquility spells by x%.
* On Healing Touch critical hits, you regain x% of the mana cost of the spell.
* Reduces the mana cost of your Renew spell by x%
* Your Greater Heals now have a heal over time component equivalent to a rank x Renew.

Please note that equipment with activated abilities are (typically) not supported.
(Ex: Scroll of Blinding Light, Neltharion's Tear, Gri'lek's Charm of Valor, ...)

----------------------------------------------------------------
6: Talents supported
----------------------------------------------------------------

Druid:
Balance
	Moonglow
Feral Combat
	Heart of the Wild
Restoration
	Improved Healing Touch, Reflection, Tranquil Spirit, Improved Rejuvenation, Gift of Nature,
	Improved Regrowth

Paladin:
Holy
	Divine Intellect, Healing Light, Illumination, Holy Power
Blessing of Light (all ranks) is also supported.

Priest:
Discipline
	Mental Agility, Mental Strength, Meditation
Holy
	Improved Renew, Holy Specialization, Spiritual Healing, Improved Healing, Divine Fury, Spiritual Guidance

Shaman:
Enhancement
	Ancestral Knowledge
Restoration
	Improved Healing Wave, Tidal Focus, Tidal Mastery, Purification

----------------------------------------------------------------
7: Buffs supported
----------------------------------------------------------------

All buffs that increase intelligence, spirit and mana pool are supported.
(Ex: Arcane Intellect, Divine Spirit, Blessing of Kings).

In addition, the following buff bonuses are supported:
	+3% spell crit from Moonkin aura.
	+3% spell crit from "Slip'kik's Savvy".
	+10% spell crit from "Rallying Cry of the Dragonslayer".

	+8 mana/5s from Nightfin soup
	+12 mana/5s from Mageblood potion

Please note that Blessing of Wisdom is not supported as I've been unable to find a way to detect BoW rank
and detect if the caster had the Improved BoW talent.

----------------------------------------------------------------
8: Known bugs and limitations
----------------------------------------------------------------

Normal mana regeneration values are not accurate for very low spirit values (below 50 or so).

The spell crit% formulas are uncertain for level 60 paladins and not correct for characters below level 60.

Overhealing isn't considered.

For Heal-over-time spells, HealPoints assumes that the effect isn't overwritten.
For Regrowth and Greater Heal with the Transcendence 8/8 bonus, HealPoints assumes that the HoT
effect isn't overwritten by anyone else (HealPoints calculates overwrites done by yourself).

Known bugs/limitations with item tooltips:
- Changes in set bonuses are not detected
- Does not currently work correctly for relics
- Will not appear for items which already have very large tooltips

----------------------------------------------------------------
9: Frequently asked questions (FAQ)
----------------------------------------------------------------

Q: Why is (name of slow, powerful spell) selected as my most efficient spell and used to compute
EndurancePoints when (name of fast, less powerful spell) has much higher HP/mana?

A: The advantage with slow, powerful spells is that you don't need to cast so many of them to heal a lot.
And fewer casts means more time with normal mana regeneration. Fast spells may be cheap, but they don't heal
a lot so you need to cast more of them - meaning little or no time with normal mana regeneration.

If there is a large difference between your casting regen and normal regen, a slow and powerful spell will
probably heal more in x mins than a fast, less powerful. Actually, EndurancePoints are computed for all
spells you know with the spell giving the highest value selected as the most efficient.

Q: Will you make a similar addon for damage spells and/or physical attack abilities?

A: No :-)

----------------------------------------------------------------
10: Version history
----------------------------------------------------------------

*** 1.0 ***

Initial release.

*** 1.1 ***

Added support for items with "+x damage and healing spells".

Added "Tot HP (+r)" stat which shows hitpoints healed with selected spell using the whole mana bar when
casting regeneration is taken into account.

Fixed bug regarding the Tidal Mastery shaman talent.

Minor optimizations.

*** 1.2 ***

Added HP/cast as a calculated stat.

Updated to BonusScanner 0.95 beta (including mana and wizard oil support).

Now hopefully supports German clients (but addon UI is still English).

*** 1.2a ***

New attempt at supporting German clients.

Fixed bug regarding the druid talent Improved Regrowth.

*** 1.2b ***

More fixes for German clients.

Fixed bug where the character info sheet would show wrong stats if equipment was switched while the info
sheet was open.

Bugfix for "HealPointsCalculator.lua:418: attempt to compare number with string".

*** 1.3 ***

Update spell crit formula based on information from www.wowwiki.com and the US and EU WoW forums.
Shaman: 20 int = 1 % crit. Paladin/Druid: 30 int = 1 % crit. Priest: 50 int = 1 % crit.

Changed PowerPoints from 30 sec healing to 60 sec healing.
Changed EndurancePoints from 3 min healing to 5 min healing.
Changed RegenPoints from  1 min regen to 3 min regen.
The most important consequence is that int is valued higher.
NB! The HealPoints value is therefore not comparable with earlier versions.

Now detects the +5% spell crit bonus from the "Songflower Serenade" buff.
Now detects the +10% spell crit bonus from the "Rallying Cry of the Dragonslayer" buff.

Added console command "/healpoints" which opens the calculator.

Added time needed to spend the whole mana bar chaincasting a given spell to the tooltip for "Tot HP (+r)".

Fixed a bug where the "Tot HP (+r)" would turn negative for infinite values.
(This would typically happen if you regen more mana during a HoT that the mana cost of the spell).

Fixed a display bug there the healing spell stats would sometimes not properly be updated on equipment changes.

*** 1.4 ***

Based on new testing, the crit formula have been updated yet again.
Druids and Shamans are now both at 40 int = 1 % crit.

Added support for French clients (untested).

*** 1.5 ***

Added support for 'Chain Heal' (shamans)

Added support for the following set bonuses:
'Increases the duration of your Renew spell by 3 sec.'
'-0.4 seconds on the casting time of your Chain Heal spell.'
'Increases the amount healed by Chain Heal to targets beyond the first by 30%.' 

Now detects the +3% spell crit bonus from the Moonkin aura.

Added '/healpoints bscan' for debugging special set/equip-bonuses.

Localization fixes for French clients.

Fixed a minor calculator tooltip bug.

*** 1.6 ***

Updated with the 1.10 priest talent changes, including support for the new 'Spiritual Guidance' talent.

Updated with the 1.10 revised healing spells stats for priests, druids and shamans.

Revised formula for +healing effect for low level spells. (from www.wowwiki.com)

Misc. 1.10 fixes.

*** 1.7 ***

Added support for the paladin spell 'Holy Shock' (only the healing part of the spell)

Added support for:
- Idol of Health
- Idol of Rejuvenation
- Totem of Life

*** 1.8 ***

Added support for the following set bonuses:
'After casting your Healing Wave or Lesser Healing Wave spell, gives you a 25% chance to gain Mana equal to
35% of the base cost of the spell.'
'Your Healing Wave will now jump to additional nearby targets. Each jump reduces the effectiveness of the
heal by 80%, and the spell will jump to up to two additional targets.'

*** 1.9 ***

Added option to configure how the HealPoints-statistic is calculated:
- PowerPoints: Select duration + option to force spell/rank to be used.
- EndurancePoints: Select duration + option to force spell/rank to be used.
- RegenPoints: Select duration

Revised spell crit formulas based on new posts by Tseric:
- Priests 0.8% base crit + 1% crit per 59.5 int
- Druids 1.8% base crit + 1% crit per 60.0 int
- Shamans 2.3% base crit + 1% crit per 59.2 int 

Added support for +3 % spell crit from the Slip'kik's Savvy buff (DM North tribute)
Added support for +12 mana/5s from Mageblood potion
Added support for +8 mana/5s from Nightfin soup

A few German localization fixes.

Improved the way PowerPoints are computed.

*** 1.10 ***

Updated for patch 1.11.

Added a line to item tooltips showing how your HealPoints stat will change if you equip the item.
Known bugs/limitations:
- Changes in set bonuses are not detected
- Does not currently work correctly for relics
- Will not appear for items which already have very large tooltips

Added support for the following items: 
- Libram of Divinity 
- Libram of Light
- Totem of Sustaining

Added support for the following set bonuses:
- Reduces the mana cost of your Healing Touch, Regrowth, Rejuvenation and Tranquility spells by 3%.
- On Healing Touch critical hits, you regain 30% of the mana cost of the spell.
- Reduces the mana cost of your Renew spell by 12%

Removed support for the 'Songflower serenade' buff due to conflict with sanctity aura.

Updated to BonusScanner 1.1 (performance improvements).

Increased accuracy of max mana calculations.

Fixed bug where hp/cast for spells affected by more than one talent (e.g. Gift of Nature and Improved
Rejuvenation) was slightly too high.

*** 1.11 ***

Heal-over-time spells (including Regrowth) are now considered for Power- and EndurancePoints calculations.
Healing is calculated by assuming that you try to keep the HoT effect running continously on 3 targets.
(This can be adjusted in the config window from 1-12 targets.)

Added support for the transcendence 8/8 set bonus.
"Your Greater Heals now have a heal over time component equivalent to a rank 5 Renew."
Same as for HoTs, it is assumed that you cast GH on 3 different targets (configurable).
HealPoints tracks HoT ticks and overwrites in order to compute healing done.

The spell power weapon enchant now also adds +healing (was changed in the 1.12 patch)

Added '/healpoints tooltips off' and '/healpoints tooltips on'.

The HealPoints tooltip line will now also appear on loot roll windows.

Fixed minor config window GUI bug.

Readme updated.

*** 1.12 ***

HealPoints is now an Ace2 addon.

If you inspect a non-enchanted item and the item you're currently wearing in the same slot is enchanted,
the HealPoints change in the tooltip assumes that the new item will be enchanted with the same enchant.
Example: You have Jin'do's Hexxer with +55 healing and Grand Widow Faerlina drops The Widow's Embrace.
The tooltip will now show change in HealPoints assuming that you enchant the new mace with +55 healing.

Config: Duration for Power- and EndurancePoints can now be specified in 30 second increments.

Config: Starting mana (in %) for both Power- and EndurancePoints can now be configured.
Default 100% and 0% respectively (equals pre 1.12 hardcoded values).

Config: Number of targets for HoTs can now be set to 0, effectively disabling HoTs for Power- and
EndurancePoints calculations.

RegenPoints has been removed. HealPoints is now just PowerPoints + EndurancePoints.

Performance improvements.

BugFix: Regrowth and the Transcendence 8/8 bonus now works properly for Power- and EndurancePoints.

BugFix: Dreamwalker 4 piece bonus should now be detected properly.

French localization fix.

Updated code to Lua 5.1 (preparing for The Burning Crusade).

Console commands updated. Use '/healpoints' to view all available commands.

*** 1.12.1 ***

BugFix: Fixed error when learning new spells.

BugFix: HoTs occasionally gave far too many Powerpoints.

BugFix: Several Regrowth and Transendence 8/8 bonus related bugs fixed.

Performance improvements.

Updated Ace2 Libraries.