-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------
BINDING_NAME_DOHATE = "HateMe: HATE!";
BINDING_NAME_DOHURT = "HateYou: DPS!";

HateMe_ON                = "on";
HateMe_OFF               = "off";

HateMe_MACRO_ERROR       = "Please refer to the HateMe documentation for the correct command.";
HateMe_NO_HATE_SPELLS    = "No hate spells!";
HateMe_NOTHING_DONE      = "Nothing was done!";
HateMe_IMMUNE_FOUND      = " is immune to ";
HateMe_IMMUNE_SAVED      = "Immunity saved by HateMe. Use the '/HateMe clear' command to clear all immunities.";
HateMe_TEMP_IMMUNE_ERROR = "SWITCH targets! This one is temporarily IMMUNE.";

-- if you add a new attack... be sure to add it to the SpellToCast
-- the three core abilites for which this mod was made
HateMe_SPELL_REVENGE            = "Revenge";
HateMe_SPELL_OVERPOWER          = "Overpower";
HateMe_SPELL_EXECUTE            = "Execute";

--------------------------
-- Druid Stuff
--------------------------
HateMe_Druid                    = "Druid";

-- Druid Bear stuff
HateMe_SPELL_FAERIE_FIRE_BEAR   = "Faerie Fire (Bear)"; -- debuff but good for aggro
HateMe_SPELL_BASH               = "Bash"; -- stunn and debuff but good for aggro
HateMe_SPELL_SWIPE              = "Swipe"; -- hits multiple targers
HateMe_SPELL_MAUL               = "Maul"; -- default bear attack
HateMe_SPELL_GROWL              = "Growl"; -- taunt in bear form
HateMe_SPELL_DEMORALIZING_ROAR  = "Demoralizing Roar"; -- AoE Debuff in bear form
HateMe_SPELL_ENRAGE             = "Enrage";
HateMe_SPELL_RIP                = "Rip";

-- Druid Cat stuff
HateMe_SPELL_TIGER_FURY         = "Tiger's Fury";
HateMe_SPELL_SHRED              = "Shred";
HateMe_SPELL_RIP                = "Rip";
HateMe_SPELL_RAKE               = "Rake";
HateMe_SPELL_CLAW               = "Claw";


-- the rest of the fluff
HateMe_SPELL_BATTLE_SHOUT       = "Battle Shout"; --ended up being REALLY good for aggro if enough units affected
HateMe_SPELL_PUMMEL             = "Pummel"; --good for aggro... interups a spell
HateMe_SPELL_SHIELD_BASH        = "Shield Bash"; --good for aggro... interups a spell
HateMe_SPELL_CONCUSSION_BLOW    = "Concussion Blow"; -- stuns and debuff... but good for aggro
HateMe_SPELL_SUNDER_ARMOR       = "Sunder Armor"; -- debuff but VERY good for aggro
HateMe_SPELL_MORTAL_STRIKE      = "Mortal Strike"; -- debuff... but good for aggro
HateMe_SPELL_REND               = "Rend"; -- debuff... but good for aggro
HateMe_SPELL_WHIRLWIND          = "Whirlwind"; -- hits multkple targets
HateMe_SPELL_SHIELD_BLOCK       = "Shield Block"; -- helps setup revenge!
HateMe_SPELL_MOCKING_BLOW       = "Mocking Blow"; -- taunt in battle stance
HateMe_SPELL_TAUNT              = "Taunt"; -- taunt in defensive stance
HateMe_SPELL_HEROIC_STRIKE      = "Heroic Strike"; -- the most basic rage attack possible
HateMe_SPELL_DEMORALIZING_SHOUT = "Demoralizing Shout"; -- AoE debuff warrior
HateMe_SPELL_BLOODRAGE          = "Bloodrage"; -- get some rage!!!!
HateMe_SPELL_CLEAVE             = "Cleave"; -- this attacks the enemy + one add
HateMe_SPELL_THUNDER_CLAP       = "Thunder Clap"; -- AoE Debuff to slow things down... icnluding attacks
HateMe_SPELL_HAMSTRING          = "Hamstring"; -- this slows a runner away
HateMe_SPELL_SWEEPING_STRIKES   = "Sweeping Strikes"; -- a local buff that adds the ability to hot adds
HateMe_SPELL_SLAM               = "Slam"; -- 1.5 second cast... damamge atack
HateMe_SPELL_BLOODTHIRST        = "Bloodthirst"; -- nice damage buff
HateMe_SPELL_PIERCING_HOWL      = "Piercing Howl"; -- AoE debuff... stunns
HateMe_SPELL_SHIELD_SLAM        = "Shield Slam"; -- this is the special 31 point attack... LOTS of aggro
HateMe_SPELL_BERSERKER_RAGE     = "Berserker Rage"; -- 30 secdon cooldown buff... increases daammge and takenf dmg


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- spells that I don't think will work out
--
-- Intercept (Charge Attack) this is a charge attack... and could cause a wipe
-- Charge (charge Attack) this is a charge attack... and only can only be used to open battle
-- Intimidating Shout (AoE fear) this can cause a wipe if not used properly
-- Recklessness (Self Buff) this has a long cooldown
-- Shield Wall (Self buff) this has a long cooldown
-- Retaliation (Self buff) this has a long cooldown
-- Death Wish (Self buff) this has a long cooldown
-- Last Stand (Self Buff) this has a long cooldown
-- Disarm (Debuff) this has a 1 minute cooldown... and tends to have only a special useage
-------------------------------------------------------------------------------

HateMe_INVENTORY_SHIELD = "Shield";

HateMe_BEAR1     = "Bear Form";
HateMe_BEAR2     = "Dire Bear Form";
HateMe_CAT       = "Cat Form";
HateMe_DEFENSIVE = "Defensive Stance";
HateMe_BATTLE    = "Battle Stance";
HateMe_BERSERKER = "Berserker Stance";
-------------------------------------------------------------------------------

-- Other peoples spells to keep track of
HateMe_SPELL_BANISH						= "Banish"; -- Warlock spell
HateMe_SPELL_DIVINE_PROTECTION			= "Divine Protection"; -- Paly spell
HateMe_SPELL_BLESSING_OF_FREEDOM		= "Blessing of Freedom"; -- Paly spell
HateMe_BUFF_FREE_ACTION        		    = "Free Action"; -- From Free Action potion
HateMe_BUFF_IMMUNE_ROOT                 = "Immune Root"; -- From Spider Belt


-------------------------------------------------------------------------------

-- Command responses

HateMe_REND_ON           = HateMe_SPELL_REND.." will be used";
HateMe_REND_OFF          = HateMe_SPELL_REND.." will not be used";
HateMe_TAUNT_ON          = HateMe_SPELL_TAUNT.." will be used";
HateMe_TAUNT_OFF         = HateMe_SPELL_TAUNT.." will not be used";
HateMe_SUNDER_ON         = HateMe_SPELL_SUNDER_ARMOR.." will now be used past 5";
HateMe_SUNDER_OFF        = HateMe_SPELL_SUNDER_ARMOR.." now stop at 5";
HateMe_HS_ON             = HateMe_SPELL_HEROIC_STRIKE.." will now be used between "..HateMe_SPELL_SUNDER_ARMOR;
HateMe_HS_OFF            = HateMe_SPELL_HEROIC_STRIKE.." will not be used while "..HateMe_SPELL_SUNDER_ARMOR.." can still be used";
HateMe_BS_ON             = HateMe_SPELL_BATTLE_SHOUT.." is optimized!";
HateMe_BS_OFF            = HateMe_SPELL_BATTLE_SHOUT.." will buff when you are not buffed.";
HateMe_TEST_ON           = "Test Mode entered";
HateMe_TEST_OFF          = "End Test Mode";
HateMe_IMMUNE_ON         = "Immune Checking On!";
HateMe_IMMUNE_OFF        = "Immune Checking Off!  HateMe will continue to attempt moves even if the target is immune.";
HateMe_CLEAR_IMMUNE      = "All immunities cleared!";
HateMe_CLEAR_RUNNERS     = "All runners cleared!";

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------
if ( GetLocale() == "deDE" ) then

-- put german stuff here

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- French localization
-------------------------------------------------------------------------------
elseif ( GetLocale() == "frFR" ) then

-- put german stuff here

-------------------------------------------------------------------------------
end




