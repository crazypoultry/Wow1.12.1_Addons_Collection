--[[
========== Enemy CastBar Custom Spell Database =========================================

Instead of using this lines like in the original localization.lua:

	["Unstable Power"] = 		{ t=20.0, d=120, icontex="Spell_Lightning_LightningBolt01" };

you have to use this way to add spells:

	CEnemyCastBar_Spells["Unstable Power"] = { t=20.0, d=120, icontex="Spell_Lightning_LightningBolt01" };

Same for "CEnemyCastBar_Raids" and "CEnemyCastBar_Afflictions" spells :D
========================================================================================


A short description of the spell flags exctracted from the original localization.lua:
-------------------------------------------------------------------------------------

".._Spells" ->
-- IMPORTANT: Maybe some spells which cause debuffs have to be moved to CEnemyCastBar_Afflicitions to be shown
-- "t=x" defines the normal length of the castbar. "d=x" will add a cooldown timer for spells with a casttime and for gains.
-- "g=0" prevents a bar if a player gains this spell. "g=x" shows a bar of x seconds instead of "t=x" if it's a gain.
-- "i=x" shows a bar of x seconds additional to "t" (everytime)

".._Raids" ->
-- "mcheck" to only show a bar if cast from this mob. Shows a spell if the mobname is a part of 'mcheck'. mcheck="Ragnaros - Princess Yauj" possible!
-- "m" sets a mob's name for the castbar; "i" shows a second bar; "r" sets a different CastTime for this Mob (r = "Mob1 Mob2 Mob3" possible *g*)
-- "active" only allows this spell to be an active cast, no afflictions and something else!
-- "global" normally is used for afflictions to be shown even it's not your target, but here the important feature is that the castbar won't be updated if active!
-- "checktarget" checks if the mob casted this spell is your current target. Normally this isn't done with RaidSpells.
-- "icasted" guides this spell through the instant cast protection
-- checkevent="Event1 - Event2" to bind spells to only trigger a castbar if these events were fired. (Example: checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" )
-- aZone="InstanceName" to only allow this spell to trigger a CastBar in the specific (Main)Zone. (Not the minimap zone, but the big global Zone e.g. Stormwind, not Trade District! Example: aZone="Ahn'Qiraj"
-- aBar="NextSpellName" will trigger the defined spell instantly when the source CastBar runs out (e.g. 'Dark Glare'). Will only do that if the User is in combat or dead! Won't broadcast the next triggered spell to the raid!
-- pBar="NextSpellName" will trigger the defined spell instantly when the source CastBar APPEARS! (e.g. 'Web Spray'). Won't broadcast the next triggered spell to the raid!
-- delBar="SpellName" will delete the defined spell instantly when the source CastBar runs out! (e.g. 'Locust Swarm').
-- tchange={"SpellName", duration1, duration2} will change the duration of defined Spell when the CastBar runs out (e.g. tchange={"Inevitable Doom", 30, 15} for '15 sec Doom CD!' Bar). Duration1 is applied (reset) if the EngageProtection is disabled and the player enters combat the next time!

".._Afflictions" ->
-- Warning: only add Spells with the "CEnemyCastBar_SPELL_AFFLICTED" pattern here!
-- fragile="true", if mob with the same name dies, the bar won't be removed
-- multi="true", the bar is not removed if debuff fades earlier (usefull if one spell is allowed to produce multiple afflictions)
-- stun="true", flags all spells which use the same Diminishing Return timer. These 8 Spells were tested to use one and the same timer.
-- death="true", removes the castbar although it is a "fragile"
-- periodicdmg="true" -> don't update and remove those castbars, only allows periodic damage done by yourself
-- spellDR="true", triggers a separate class DR Timer;
	-- always(!) use spellDR together with sclass="PlayersCLASS", or you will produce errors!
-- affmob="true", this stun triggers a class specific DR Timer on a mob (not player), too
-- drshare="name", all spells with the same drshare name will trigger the same DR Timer called 'name'
-- checkclass="classname", will only show this spell to specified class
-- tskill={talentTab, talentNumber, talentTimeBonus, talentClass, offset, relativeTimeBonus(optional) }, adds "talentTimeBonus" to the duration of this skill dependend on invested skillpoints! "Offset" is additionally added to the duration if more than one talentpoint is invested.
-- more to tskill: if "talentTimeBonus" is 0 then the relativeTimeBonus(optional) is used (percentage), needed for hunters talent
-- plevel={durationBonusPerSkillLevel, PlayerLevelAbleToLearnNewSkillLevel (e.g. 60, 40, 20), exchangeLowestLevelWith "0" ALWAYS!} (correct examples are below)
-- aZone="InstanceName" to only allow this spell to trigger a CastBar in the specific (Main)Zone. (Not the minimap zone, but the big global Zone e.g. Stormwind, not Trade District! Example: aZone="Ahn'Qiraj"
-- blockZone="ZoneName" blocks the spell for the specified Zone (example: blockZone="Ahn'Qiraj" for 'Entangling Roots')
-- cpinterval=X, reduces spell duration by X for every ComboPoint lower than 5 (maximum); ALWAYS use with cpclass="CHARACTERCLASS"!

]]

	-- pls tell me at curse-gaming.com what you add here! Maybe I will add it to the official version then ;-) Thanks :D
	-- enter your spells here:

	-- Some EXAMPLES (remove '--' in front of the Spell's line to have a working detection ^^):

	-- Mage afflictions
	-- CEnemyCastBar_Afflictions["Pyroblast"] = {t=12, periodicdmg="true", icontex="Spell_Fire_Fireball02"};
	-- CEnemyCastBar_Afflictions["Fireball"] = {t=8, periodicdmg="true", icontex="Spell_Fire_FlameBolt"};
	-- CEnemyCastBar_Afflictions["Ignite"] = {t=4, periodicdmg="true", icontex="Spell_Fire_Incinerate"};

	-- Warrior afflictions (Remember renewed debuffs trigger NO combatlog message! NECB won't recognize it without combatlog messages!)
	-- CEnemyCastBar_Afflictions["Sunder Armor"] = {t=20, icontex="Ability_Warrior_Sunder"};
	-- CEnemyCastBar_Afflictions["Demoralizing Shout"] = {t=30, icontex="Ability_Warrior_WarCry"};


	CEnemyCastBar_Spells["YourSpell"] = { t=20.0, icontex="ValidTextureFile or leave blank/delete" }; --> PvP Spells

	CEnemyCastBar_Raids["YourSpell"] = { t=20.0, icontex="ValidTextureFile or leave blank/delete" }; --> Boss Spells/Cooldowns