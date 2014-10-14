--Language Localization-----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

ALLSA_VERSION = "0.06e-11200";

--English--------------------------------------------------
-----------------------------------------------------------
if (GetLocale() == "enUS") then
	ALLSA_TEXT_WELCOME = "AllShot Alert v"..ALLSA_VERSION.." Loaded |cff628296(/allsa for options)";
	ALLSA_TEXT_SLASHCOMMAND1 = "|cff628296/allsa on|off|cffffffff -Turn allsa on and off";
	ALLSA_TEXT_SLASHCOMMAND2 = "|cff628296/allsa toggle|cffffffff -Toggles allsa on/off";
	ALLSA_TEXT_SLASHCOMMAND3 = "|cff628296/allsa status|cffffffff -Shows allsa's status";
	ALLSA_TEXT_SLASHCOMMAND4 = "|cff628296/allsa soundon[|cffffffffson|cff628296]|soundoff[|cffffffffsoff|cff628296]|cffffffff -Turns the sound notification on/off";
	ALLSA_TEXT_SLASHCOMMAND5 = "|cff628296/allsa sound0[|cffffffffs0|cff628296]|sound1[|cffffffffs1|cff628296]|cffffffff -Selects the sound file to use (0 default)";
	ALLSA_TEXT_SLASHCOMMAND6 = "|cff628296/allsa messageon[|cffffffffmon|cff628296]|messageoff[|cffffffffmoff|cff628296]|cffffffff -Turns the displayed message on/off";
	ALLSA_TEXT_SLASHCOMMAND7 = "|cff628296/allsa options[|cffffffffoption|cff628296]|cffffffff -Opens the allsa Options Menu";
	ALLSA_TEXT_SLASHCOMMAND8 = "|cff628296/allsa record|cffffffff -Displays your record crit information";
	ALLSA_TEXT_SLASHCOMMAND9 = "|cff628296/allsa |cffff0000reset|cffffffff -Resets record crit information";

	ALLSA_TEXT_ALLSA_OFF = "AllShot Alert is now: |cff800000-OFF-";
	ALLSA_TEXT_ALLSA_ON = "AllShot Alert is now: |cff628296-ON-";
	
	ALLSA_TEXT_MESSAGE_OFF = "AllShot Alert's Message is now: |cff800000-OFF-";
	ALLSA_TEXT_MESSAGE_ON = "AllShot Alert's Message is now: |cff628296-ON-";
	
	ALLSA_TEXT_SOUND_OFF = "AllShot Alert's Sound is now: |cff800000-OFF-";
	ALLSA_TEXT_SOUND_ON = "AllShot Alert's Sound is now: |cff628296-ON-";

	ALLSA_TEXT_SOUNDFILE_0 = "AllShot Alert's Sound File is now: |cff800000-0 Default-";
	ALLSA_TEXT_SOUNDFILE_1 = "AllShot Alert's Sound File is now: |cff628296-1 Headshot-";
	
	ALLSA_TEXT_ALLSA_STOFF = "AllShot Alert is: |cff800000-OFF-";
	ALLSA_TEXT_ALLSA_STON = "AllShot Alert is: |cff628296-ON-";
	
	ALLSA_TEXT_MESSAGE_STOFF = "AllShot Alert's Message is: |cff800000-OFF-";
	ALLSA_TEXT_MESSAGE_STON = "AllShot Alert's Message is: |cff628296-ON-";
	
	ALLSA_TEXT_SOUND_STOFF = "AllShot Alert's Sound is: |cff800000-OFF-";
	ALLSA_TEXT_SOUND_STON = "AllShot Alert's Sound is: |cff628296-ON-";

	ALLSA_TEXT_ERROR = "|cff800000AllShot Variables Not Loaded - Using Defaults";
	ALLSA_TEXT_NEWRECORD = "New Record added to AllShot Alert";
	ALLSA_TEXT_RESET = "|cffff0000Resetting AllShot Alert data";
	ALLSA_TEXT_VARIABLES = "Loading AllShot Variables";

	ALLSA_L_YOU = "Your";
	ALLSA_L_YOU1 = "You";

	ALLSA_ASHOT_CRIT1 = "(.+) crit (.+) for (.+).";

	ALLSA_ASHOT_HCRIT2 = "(.+) Aimed Shot crits (.+) for (.+).";
	ALLSA_ASHOT_HCRIT3 = "(.+) Multi(.)Shot crits (.+) for (.+).";
	ALLSA_ASHOT_HCRIT4 = "(.+) Auto Shot crits (.+) for (.+).";
	ALLSA_ASHOT_HCRIT5 = "(.+) Wing Clip crits (.+) for (.+).";
	ALLSA_ASHOT_HCRIT6 = "(.+) Arcane Shot crits (.+) for (.+).";
	ALLSA_ASHOT_HCRIT7 = "(.+) Counterattack crits (.+) for (.+).";
	ALLSA_ASHOT_HCRIT8 = "(.+) Mongoose Bite crits (.+) for (.+).";
	ALLSA_ASHOT_HCRIT9 = "(.+) Raptor Strike crits (.+) for (.+).";

	ALLSA_ASHOT_LCRIT2 = "(.+) Shadow Bolt crits (.+) for (.+) Shadow damage.";
	ALLSA_ASHOT_LCRIT3 = "(.+) Shadowburn crits (.+) for (.+) Shadow damage.";
	ALLSA_ASHOT_LCRIT4 = "(.+) Searing Pain crits (.+) for (.+) Fire damage.";
	ALLSA_ASHOT_LCRIT5 = "(.+) Soul Fire crits (.+) for (.+) Fire damage.";
	ALLSA_ASHOT_LCRIT6 = "(.+) Death Coil crits (.+) for (.+).";
	ALLSA_ASHOT_LCRIT7 = "(.+) Conflagrate crits (.+) for (.+) Fire damage.";
	ALLSA_ASHOT_LCRIT8 = "(.+) Immolate crits (.+) for (.+) Fire damage.";

	ALLSA_ASHOT_PCRIT2 = "(.+) Judgement crits (.+) for (.+).";
	ALLSA_ASHOT_PCRIT3 = "(.+) Holy Shock crits (.+) for (.+).";
	ALLSA_ASHOT_PCRIT4 = "(.+) Exorcism crits (.+) for (.+).";
	ALLSA_ASHOT_PCRIT5 = "(.+) Holy Wrath crits (.+) for (.+).";
	ALLSA_ASHOT_PCRIT6 = "(.+) Hammer of Wrath crits (.+) for (.+) Holy damage.";

	ALLSA_ASHOT_ICRIT2 = "(.+) Smite crits (.+) for (.+) Holy damage.";
	ALLSA_ASHOT_ICRIT3 = "(.+) Mind Blast crits (.+) for (.+) Shadow damage.";
	ALLSA_ASHOT_ICRIT4 = "(.+) Holy Fire crits (.+) for (.+) Fire damage.";
	ALLSA_ASHOT_ICRIT5 = "(.+) Mind Flay crits (.+) for (.+) Shadow damage.";
	ALLSA_ASHOT_ICRIT6 = "(.+) Shadow Word: Pain crits (.+) for (.+) Shadow damage.";
	ALLSA_ASHOT_ICRIT7 = "(.+) Starshards crits (.+) for (.+) Arcane damage.";
	ALLSA_ASHOT_ICRIT8 = "(.+) Vampiric Embrace crits (.+) for (.+) Shadow damage.";
	ALLSA_ASHOT_ICRIT9 = "(.+) Holy Nova crits (.+) for (.+) Holy damage.";

	ALLSA_ASHOT_MCRIT2 = "(.+) Frost Bolt crits (.+) for (.+) Frost damage.";
	ALLSA_ASHOT_MCRIT3 = "(.+) Arcane Explosion crits (.+) for (.+) Arcane damage.";
	ALLSA_ASHOT_MCRIT4 = "(.+) Arcane Missiles crits (.+) for (.+) Arcane damage.";
	ALLSA_ASHOT_MCRIT5 = "(.+) Fireball crits (.+) for (.+) Fire damage.";
	ALLSA_ASHOT_MCRIT6 = "(.+) Fire Blast crits (.+) for (.+) Fire damage.";
	ALLSA_ASHOT_MCRIT7 = "(.+) Pyroblast crits (.+) for (.+) Fire damage.";
	ALLSA_ASHOT_MCRIT8 = "(.+) Flamestrike crits (.+) for (.+) Fire damage.";
	ALLSA_ASHOT_MCRIT9 = "(.+) Cone of Cold crits (.+) for (.+) Frost damage.";
	ALLSA_ASHOT_MCRIT10 = "(.+) Frost Nova crits (.+) for (.+) Frost damage.";

	ALLSA_ASHOT_RCRIT2 = "(.+) Eviscerate crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT3 = "(.+) Backstab crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT4 = "(.+) Slice and Dice crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT5 = "(.+) Kidney Shot crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT6 = "(.+) Gouge crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT7 = "(.+) Sinister Strike crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT8 = "(.+) Riposte crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT9 = "(.+) Kick crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT10 = "(.+) Ghostly Strike crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT11 = "(.+) Ambush crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT12 = "(.+) Rupture crits (.+) for (.+).";
	ALLSA_ASHOT_RCRIT13 = "(.+) Cheap Shot crits (.+) for (.+).";

	ALLSA_ASHOT_WCRIT2 = "(.+) Cleave crits (.+) for (.+).";
	ALLSA_ASHOT_WCRIT3 = "(.+) Execute crits (.+) for (.+).";
	ALLSA_ASHOT_WCRIT4 = "(.+) Slam crits (.+) for (.+).";
	ALLSA_ASHOT_WCRIT5 = "(.+) Bloodthirst crits (.+) for (.+).";
	ALLSA_ASHOT_WCRIT6 = "(.+) Heroic Strick crits (.+) for (.+).";
	ALLSA_ASHOT_WCRIT7 = "(.+) Rend crits (.+) for (.+).";
	ALLSA_ASHOT_WCRIT8 = "(.+) Overpower crits (.+) for (.+).";
	ALLSA_ASHOT_WCRIT9 = "(.+) Deep Wounds crits (.+) for (.+).";
	ALLSA_ASHOT_WCRIT10 = "(.+) Mortal Strike crits (.+) for (.+).";
	ALLSA_ASHOT_WCRIT11 = "(.+) Shield Slam crits (.+) for (.+).";

	ALLSA_ASHOT_SCRIT2 = "(.+) Lightning Bolt crits (.+) for (.+) Nature damage.";
	ALLSA_ASHOT_SCRIT3 = "(.+) Earth Shock crits (.+) for (.+) Nature damage.";
	ALLSA_ASHOT_SCRIT4 = "(.+) Frost Shock crits (.+) for (.+) Frost damage.";
	ALLSA_ASHOT_SCRIT5 = "(.+) Flame Shock crits (.+) for (.+) Fire damage.";
	ALLSA_ASHOT_SCRIT6 = "(.+) Chain Lightning crits (.+) for (.+) Nature damage.";

	ALLSA_ASHOT_DCRIT2 = "(.+) Maul crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT3 = "(.+) Bash crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT4 = "(.+) Swipe crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT5 = "(.+) Claw crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT6 = "(.+) Rip crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT7 = "(.+) Shred crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT8 = "(.+) Rake crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT9 = "(.+) Ferocious Bite crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT10 = "(.+) Ravage crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT11 = "(.+) Pounce crits (.+) for (.+).";
	ALLSA_ASHOT_DCRIT12 = "(.+) Wrath crits (.+) for (.+) Nature damage.";
	ALLSA_ASHOT_DCRIT13 = "(.+) Moonfire crits (.+) for (.+) Nature damage.";
	ALLSA_ASHOT_DCRIT14 = "(.+) Starfire crits (.+) for (.+) Nature damage.";

end