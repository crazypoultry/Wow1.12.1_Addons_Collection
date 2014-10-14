--Patchwerk
LVBM_PW_NAME			= "Patchwerk";
LVBM_PW_DESCRIPTION		= "Provides a timer for Patchwerk's enrage.";
LVBM_PW_OPTION1			= "Announce Hateful Strikes";
LVBM_PW_OPTION2			= "Show stats";
LVBM_PW_OPTION3			= "Show info frame";

LVBM_PW_ENRAGE_WARNING		= "*** Enrage in %s %s ***";
LVBM_PW_HS_ANNOUNCE		= "Hateful Strike --> %s [%s]";

LVBM_PW_YELL_1 			= "Patchwerk want to play!";
LVBM_PW_YELL_2 			= "Kel'thuzad make Patchwerk his avatar of war!";

LVBM_PW_HS_YOU_HIT		= "Patchwerk's Hateful Strike hits you for (%d+).(.*)";
LVBM_PW_HS_YOU_MISS		= "Patchwerk's Hateful Strike misses you.";
LVBM_PW_HS_YOU_DODGE		= "You dodge Patchwerk's Hateful Strike.";
LVBM_PW_HS_YOU_PARRY		= "You parry Patchwerk's Hateful Strike.";
LVBM_PW_HS_PARTY_HIT		= "Patchwerk's Hateful Strike hits ([^%s]+) for (%d+).(.*)";
LVBM_PW_HS_PARTY_MISS		= "Patchwerk's Hateful Strike missed ([^%s]+)."; 
LVBM_PW_HS_PARTY_DODGE		= "Patchwerk's Hateful Strike was dodged by ([^%s]+).";
LVBM_PW_HS_PARTY_PARRY		= "Patchwerk's Hateful Strike was parried by ([^%s]+).";

LVBM_PWSTATS_STATS		= "*** Patchwerk Stats ***";
LVBM_PWSTATS_STRIKES		= "Hateful Strikes: %s (%.0f%%)";
LVBM_PWSTATS_HITS		= "Hits: %s (%.0f%%)";
LVBM_PWSTATS_DODGES		= "Dodges: %s (%.0f%%)";
LVBM_PWSTATS_PARRIES		= "Parries: %s (%.0f%%)";
LVBM_PWSTATS_MISSES		= "Misses: %s (%.0f%%)";
LVBM_PWSTATS_AVG_DMG		= "Average damage per hit: %.0f";
LVBM_PWSTATS_MAX_HIT		= "Maximum hit: %s on %s";
LVBM_PWSTATS_PER_PLAYER		= "%s Hateful Strikes on %s (%s hits)";
LVBM_PWSTATS_NOT_AVAILABLE	= "Stats not available";


--Grobbulus
LVBM_GROBB_NAME				= "Grobbulus";
LVBM_GROBB_DESCRIPTION			= "Sets raid target icon (skull) on players that are afflicted by Mutating Injection. Only one player should enable announce and \"Set icon\".";
LVBM_GROBB_SEND_WHISPER			= "Send whisper";
LVBM_GROBB_SET_ICON			= "Set icon";

LVBM_GROBB_YOU_ARE_INJECTED		= "You are injected!";
LVBM_GROBB_INJECTED_WARNING		= "*** %s is injected ***";
LVBM_GROBB_INJECTED			= "Mutating Injection";

LVBM_GROBB_INJECTION_REGEXP		= "([^%s]+) (%w+) afflicted by Mutating Injection.";
LVBM_GROBB_INJECTION_FADES_REGEXP	= "Mutating Injection fades from ([^%s]+)%.";

LVBM_GROBB_CLOUD_POISON			= "Grobbulus casts Poison Cloud.";



--Gluth
LVBM_GLUTH_NAME				= "Gluth";
LVBM_GLUTH_DESCRIPTION			= "Announces Gluth's Fear, Frenzy and Decimate.";
LVBM_GLUTH_ANNOUNCE_FRENZY		= "Announce frenzy";

LVBM_GLUTH_DECIMATE_WARN1		= "*** Decimate in 2 min ***";
LVBM_GLUTH_DECIMATE_WARN2		= "*** Decimate - next in 2 minutes ***";
LVBM_GLUTH_DECIMATE_1MIN_WARNING	= "*** Decimate in 1 minute ***";
LVBM_GLUTH_DECIMATE_SOON_WARNING	= "*** Decimate soon ***";
LVBM_GLUTH_DECIMATE_WARNING		= "*** Decimate in ~%s sec ***"
LVBM_GLUTH_FEAR_WARNING			= "*** Fear - next in 20 sec ***";
LVBM_GLUTH_FEAR_5SEC_WARNING		= "*** Fear in 5 sec ***";

LVBM_GLUTH_DECIMATE_REGEXP		= "Gluth's Decimate hits ([^%s]+) for (%d+).";
LVBM_GLUTH_FEAR_REGEXP			= "(%w+) is afflicted by Terrifying Roar.";
LVBM_GLUTH_FRENZY			= "%s goes into a frenzy!"
LVBM_GLUTH_FRENZY_ANNOUNCE		= "*** Frenzy ***";
LVBM_GLUTH_GLUTH			= "Gluth";

LVBM_SBT["Fear"]			= "Fear";
LVBM_SBT["Decimate"]			= "Decimate";


--Razuvious
LVBM_IR_NAME				= "Instructor Razuvious";
LVBM_IR_DESCRIPTION			= "Provides a timer for Razuvious' Disrupting Shout.";
LVBM_IR_SHOW_10SEC_WARNING		= "Show 10 sec warning";

LVBM_IR_TIMER_UPDATED			= "Timer updated";
LVBM_IR_SHOUT_WARNING			= "*** Disrupting Shout in %s sec ***"

LVBM_IR_SPELL_1				= "Disrupting Shout";
LVBM_IR_YELL_1				= "The time for practice is over! Show me what you have learned!";
LVBM_IR_YELL_2				= "Sweep the leg... Do you have a problem with that?";
LVBM_IR_YELL_3				= "Do as I taught you!";
LVBM_IR_YELL_4				= "Show them no mercy!";

LVBM_SBT["Disruption Shout"]		= "Disrupting Shout";


--Noth the Plaguebringer
LVBM_NTP_NAME				= "Noth the Plaguebringer";
LVBM_NTP_DESCRIPTION			= "Provides timers for Noth's Teleport and Blink.";
LVBM_NTP_OPTION_WARN_SPAWN 		= "Announce adds";
LVBM_NTP_OPTION_WARN_CURSE 		= "Announce curse";

LVBM_NTP_BACK_WARNING			= "*** Noth is back (%s sec) - fight him ***";
LVBM_NTP_TELEPORT_WARNING		= "*** %s sec until teleport ***";
LVBM_NTP_NOTH_GAINS_BLINK		= "*** Blink ***";
LVBM_NTP_BLINK_5SEC_WARNING		= "*** Blink in ~5 sec ***";
LVBM_NTP_BLINK_0SEC_WARNING		= "*** Blink ready - stop ranged dps ***";
LVBM_NTP_TELEPORT_10SEC_WARNING		= "*** Teleport in 10 sec ***"
LVBM_NTP_BACK_10SEC_WARNING		= "*** 10 sec until he comes back ***";
LVBM_NTP_ADD_WARNING			= "*** Adds in 5 seconds ***";
LVBM_NTP_CURSE_WARNING			= "*** Curse ***";
LVBM_NTP_NEXT_WAVE_SOON			= "*** 10 sec until next wave ***";

LVBM_NTP_SPELL_1 			= "Noth the Plaguebringer gains Blink.";
LVBM_NTP_CURSE_AFFLICT 			= "Curse of the Plaguebringer"; -- AOE curse
LVBM_NTP_ADDS_SPAWN 			= "Rise, my soldiers!"; -- Adds spawn
LVBM_NTP_YELL_START1 			= "Die, trespasser!";
LVBM_NTP_YELL_START2 			= "Glory to the master!";
LVBM_NTP_YELL_START3 			= "Your life is forfeit!";

LVBM_SBT["Teleport to Balcony"]		= "Teleport to balcony";
LVBM_SBT["Teleport back"]		= "Teleport back";
LVBM_SBT["Blink"]			= "Blink";


--Heigan the Unclean
LVBM_HTU_NAME			= "Heigan the Unclean";
LVBM_HTU_DESCRIPTION		= "Provides a timer for Heigan's Teleport.";

LVBM_HTU_TELEPORT_WARNING	= "*** Teleport in %s seconds ***";
LVBM_HTU_TELEPORT_BACK_WARNING	= "*** Teleport back in %s seconds ***";

LVBM_HTU_YELL_START1 		= "You... are next.";
LVBM_HTU_YELL_START2 		= "I see you...";
LVBM_HTU_YELL_START3 		= "You are mine now.";

LVBM_SBT["Teleport"]		= "Teleport";
LVBM_SBT["Teleport Back"]	= "Teleport Back";


--Anub'Rekhan
LVBM_AR_NAME			= "Anub'Rekhan";
LVBM_AR_DESCRIPTION		= "Provides a timer for Anub'Rekhan's Locust Swarm.";

LVBM_AR_LOCUST_WARNING		= "*** Locust Swarm in ~%s sec ***";
LVBM_AR_LOCUST_SOON_WARNING	= "*** Locust Swarm soon ***";
LVBM_AR_LOCUST_INC_WARNING	= "*** Locust Swarm is casting - 3 sec ***";
LVBM_AR_GAIN_LOCUST_WARNING	= "*** Locust Swarm now - 20 sec ***";
LVBM_AR_LOCUST_END_WARNING	= "*** Locust Swarm ends in %s sec ***";

LVBM_AR_YELL_1 			= "There is no way out.";
LVBM_AR_YELL_2 			= "Just a little taste...";	
LVBM_AR_YELL_3 			= "Yes, run! It makes the blood pump faster!";
LVBM_AR_CAST_LOCUST_SWARM 	= "Anub'Rekhan begins to cast Locust Swarm.";
LVBM_AR_GAIN_LOCUST_SWARM 	= "Anub'Rekhan gains Locust Swarm.";

LVBM_SBT["Locust Swarm"]	= "Locust Swarm";
LVBM_SBT["Locust Swarm Cast"]	= "Locust Swarm Cast";


--Grand Widow Faerlina
LVBM_GWF_NAME			= "Grand Widow Faerlina";
LVBM_GWF_DESCRIPTION		= "Provides a timer for Grand Widow Faerlina's enrage.";

LVBM_GWF_ENRAGE_WARNING1	= "*** Enrage - next in 60 sec ***";
LVBM_GWF_ENRAGE_WARNING2	= "*** Enrage in ~%s sec ***";
LVBM_GWF_ENRAGE_CD_READY	= "*** Enrage cooldown ready ***";
LVBM_GWF_EMBRACE_WARNING	= "*** Widow's Embrace ends in %s sec ***";
LVBM_GWF_NEXT_ENRAGE_IN		= "*** Next enrage in %s sec ***";

LVBM_GWF_YELL_1			= "You cannot hide from me!";
LVBM_GWF_YELL_2			= "Slay them in the master's name!";
LVBM_GWF_YELL_3			= "Run while you still can!";
LVBM_GWF_YELL_4			= "Kneel before me, worm!";
LVBM_GWF_DEBUFF			= "Grand Widow Faerlina is afflicted by Widow's Embrace.";
LVBM_GWF_GAIN_ENRAGE		= "Grand Widow Faerlina gains Enrage.";

LVBM_SBT["Enrage"]		= "Enrage";
LVBM_SBT["Widow's Embrace"]	= "Widow's Embrace";


--Maexxna
LVBM_MAEXXNA_NAME			= "Maexxna";
LVBM_MAEXXNA_DESCRIPTION		= "Provides timers for Maexxna's Web Spray and spider adds.";
LVBM_MAEXXNA_YELL_ON_WRAP		= "Yell when web wrapped";

LVBM_MAEXXNA_WEB_WRAP_YELL		= "%s is web wrapped. Group %s.";
LVBM_MAEXXNA_WRAP_WARNING		= "*** %s is wrapped ***";
LVBM_MAEXXNA_SPRAY_WARNING		= "*** Web Spray in %s sec ***";
LVBM_MAEXXNA_SPIDER_WARNING		= "*** Spiders in %s sec ***";
LVBM_MAEXXNA_SPIDERS_SPAWNED		= "*** Spiders spawned ***";

LVBM_MAEXXNA_WEB_SPRAY			= "Web Spray";
LVBM_MAEXXNA_MAEXXNA			= "Maexxna";
LVBM_MAEXXNA_WEB_WRAP_REGEXP		= "([^%s]+) (%w+) afflicted by Web Wrap.";

LVBM_SBT["Web Spray"]			= "Web Spray";
LVBM_SBT["Spider Spawn"]		= "Spider Spawn";
	

--Gothik the Harvester
LVBM_GOTH_NAME				= "Gothik the Harvester";
LVBM_GOTH_DESCRIPTION			= "Provides timers for his adds and announces their death.";

LVBM_GOTH_PHASE2_WARNING		= "*** Gothik inc ***";
LVBM_GOTH_PHASE2_INC_WARNING		= "*** Phase 2 in %s %s ***";
LVBM_GOTH_DEAD_WARNING			= "*** %s dead ***";
LVBM_GOTH_INC_WARNING			= "*** %s in %s sec ***";
LVBM_GOTH_WAVE_INC_WARNING1		= "*** Wave %s/18 in 3 sec - %s %s  ***";
LVBM_GOTH_WAVE_INC_WARNING2		= "*** Wave %s/18 in 3 sec - %s %s and %s %s ***";
LVBM_GOTH_WAVE_INC_WARNING3		= "*** Wave %s/18 in 3 sec - %s %s, %s %s and %s %s ***";

LVBM_GOTH_YELL_START1			= "Foolishly you have sought your own demise."
LVBM_GOTH_PHASE2_YELL			= "I have waited long enough. Now you face the harvester of souls.";

LVBM_GOTH_RIDER				= "Unrelenting Rider";
LVBM_GOTH_RIDER_SHORT			= "Rider";
LVBM_GOTH_KNIGHT			= "Unrelenting Deathknight";
LVBM_GOTH_KNIGHT_SHORT			= "Deathknight";
LVBM_GOTH_KNIGHTS_SHORT			= "Deathknights";
LVBM_GOTH_TRAINEE			= "Unrelenting Trainee";
LVBM_GOTH_TRAINEE_SHORT			= "Trainees";

-- FourHorsemen
LVBM_FOURHORSEMEN_NAME				= "Four Horsemen";
LVBM_FOURHORSEMEN_INFO				= "Provides timers for the Four Horseman fight";
LVBM_FOURHORSEMEN_SHOW_5SEC_MARK_WARNING	= "Show 5 sec warning for marks";
LVBM_FOURHORSEMEN_THANE				= "Thane Korth'azz";
LVBM_FOURHORSEMEN_LADY				= "Lady Blaumeux";
LVBM_FOURHORSEMEN_MOGRAINE			= "Highlord Mograine";
LVBM_FOURHORSEMEN_ZELIEK			= "Sir Zeliek";
LVBM_FOURHORSEMEN_REAL_NAME			= "Four Horsemen";

LVBM_FOURHORSEMEN_MARK_EXPR			= "afflicted by Mark of"; 	-- Is afflicted .. hmm You are affl...
LVBM_FOURHORSEMEN_MARK_INFOMESSAGE		= "Client out of sync, synced with other players to Mark #";
LVBM_FOURHORSEMEN_MARK_ANNOUNCE			= "*** Mark #%d ***";
LVBM_FOURHORSEMEN_MARK_WARNING			= "*** Mark #%d in 5 sec ***";

LVBM_FOURHORSEMEN_METEOR_EXPR			= "Thane Korth'azz's Meteor hits ([^%s]+) for (%d+) Fire damage%.";
LVBM_FOURHORSEMEN_METEOR_ANNOUNCE		= "*** Meteor ***";

LVBM_FOURHORSEMEN_VOID_EXPR			= "Lady Blaumeux casts Void Zone.";
LVBM_FOURHORSEMEN_VOID_ANNOUNCE			= "Void Zone";
LVBM_FOURHORSEMEN_VOID_WHISPER			= "Void Zone on you!";
LVBM_FOURHORSEMEN_VOID_ALLWAYS_INFO		= "Always use Special Warning on Void Zone";

LVBM_FOURHORSEMEN_SHIELDWALL_EXPR		= "(.*) gains Shield Wall.";
LVBM_FOURHORSEMEN_SHIELDWALL_ANNOUNCE		= "*** %s: Shield Wall for 20 sec ***";
LVBM_FOURHORSEMEN_SHIELDWALL_FADE		= "*** Shield Wall fades from %s ***";

LVBM_FOURHORSEMEN_WHISPER_INFO			= "Whisper players in Void Zonse";

LVBM_FOURHORSEMEN_TAUNTRESIST_INFO		= "Inform about taunt resists";
LVBM_FOURHORSEMEN_TAUNTRESIST_TAUNT		= "Taunt";
LVBM_FOURHORSEMEN_TAUNTRESIST_MOKING		= "Mocking Blow";
LVBM_FOURHORSEMEN_TAUNTRESIST_CSHOUT		= "Challenging Shout";
LVBM_FOURHORSEMEN_TAUNTRESIST_RESIST		= "resist";
LVBM_FOURHORSEMEN_TAUNTRESIST_PARRY		= "parry";
LVBM_FOURHORSEMEN_TAUNTRESIST_DODGE		= "dodge";
LVBM_FOURHORSEMEN_TAUNTRESIST_MISS		= "miss";
LVBM_FOURHORSEMEN_TAUNTRESIST_BLOCK		= "block";
LVBM_FOURHORSEMEN_TAUNTRESIST_SELFWARN		= "TAUNT FAILED";
LVBM_FOURHORSEMEN_TAUNTRESIST_MESSAGE		= "--> Taunt failed! <--";

--Thaddius
LVBM_THADDIUS_NAME			= "Thaddius";
LVBM_THADDIUS_DESCRIPTION		= "Provides timers for his Enrage and Polarity Shift.";
LVBM_THADDIUS_WARN_NOT_CHANGED		= "Warn when your polarity did not change";
LVBM_THADDIUS_ALT_STRATEGY		= "Alternative strategy (show left/right warnings)";
LVBM_THADDIUS_WARN_POWERSURGE		= "Warn for Stalagg's Power Surge (200% attack speed)";
LVBM_THADDIUS_FIX_LAG           = "Reduce combat log range to prevent lags"

LVBM_THADDIUS_ENRAGE_WARNING		= "*** Enrage in %s %s ***";
LVBM_THADDIUS_POL_SHIFT			= "*** Polarity Shift ***";
LVBM_THADDIUS_SURGE_WARNING		= "*** Power Surge ***";
LVBM_THADDIUS_POL_WARNING		= "*** Polarity Shift in %s sec ***";
LVBM_THADDIUS_PHASE_2_SOON		= "*** Phase 2 in 4 seconds ***";
LVBM_THADDIUS_CHARGE_CHANGED		= "Charge changed to %s!";
LVBM_THADDIUS_CHARGE_NOT_CHANGED	= "Charge not changed";
LVBM_THADDIUS_RIGHT			= "Right!";
LVBM_THADDIUS_LEFT			= "Left!";

LVBM_THADDIUS_GAINS_SURGE		= "Stalagg gains Power Surge.";
LVBM_THADDIUS_CAST_POL			= "Thaddius begins to cast Polarity Shift.";
LVBM_THADDIUS_POL_REGEXP		= "You are afflicted by (%w+) Charge.";
LVBM_THADDIUS_YELL_START1		= "Kill...";
LVBM_THADDIUS_YELL_START2		= "Eat... your... bones...";
LVBM_THADDIUS_YELL_START3		= "Break... you!!";
LVBM_THADDIUS_YELL_POL			= "Now you feel pain...";
LVBM_THADDIUS_ENRAGE			= "goes into a berserker rage!";
LVBM_THADDIUS_TESLA_EMOTE		= "%s overloads!";
LVBM_THADDIUS_TESLA_COIL		= "Tesla Coil";
LVBM_THADDIUS_THADDIUS			= "Thaddius";
LVBM_THADDIUS_POSITIVE			= "Positive";
LVBM_THADDIUS_NEGATIVE			= "Negative";

-- Phase1
LVBM_THADDIUS_PHASE1_YELL1 		= "Stalagg crush you!";
LVBM_THADDIUS_PHASE1_YELL2 		= "Feed you to master!";
LVBM_THADDIUS_PHASE1_ANNOUNCE		= "*** Phase 1 ***";
LVBM_THADDIUS_SURGE_EXPR		= "Stalagg gains Power Surge.";
LVBM_THADDIUS_SURGE_ANNOUNCE		= "*** Power Surge for 10 sec ***";
LVBM_THADDIUS_THROW_ANNOUNCE		= "*** MT thrown ***";
LVBM_THADDIUS_THROW_ANNOUNCE_SOON	= "*** MT throw in %s sec ***";
LVBM_THADDIUS_PLATFORM_EXPR		= "loses its link!";
LVBM_THADDIUS_PLATFORM_ANNOUNCE		= "*** Warning - Add leaves the platform ***";


--Loatheb
LVBM_LOATHEB_NAME				= "Loatheb";
LVBM_LOATHEB_DESCRIPTION			= "Announces Loatheb's Inevitable Doom and shows heal cooldowns. Use /loatheb setup or /loatheb config to setup your heal rotation, announcing healers does not work if you did not setup a heal rotation. Setting a healer's sort ID to 0 will remove him from the list. To re-add him use /loa undelete.";
LVBM_LOATHEB_ANNOUNCE_SPORES			= "Announce spores";
--LVBM_LOATHEB_ANNOUNCE_SPORES_BACKWARDS		= "Announce spores to Groups Backwards";
LVBM_LOATHEB_HEAL_RAID				= "Announce heals to raid chat";
LVBM_LOATHEB_HEAL_RAID_WARN			= "Announce heals to raid warning chat";
LVBM_LOATHEB_HEAL_WHISPER			= "Send whisper to next healer";
LVBM_LOATHEB_ANNOUNCE_POT_OPTION		= "Announce consumables";
LVBM_LOATHEB_SPECIALWARN_POT_OPTION		= "Show special warning when you have to use consumables";
LVBM_LOATHEB_HEAL_SHOW_AUTO			= "Show heal info frame when Loatheb is pulled";
LVBM_LOATHEB_HEAL_SHOW_NOW			= "Show heal info frame";
LVBM_LOATHEB_HEAL_SETUP				= "Setup heal rotation";
LVBM_LOATHEB_NO_BC_INFO				= "You are not raid leader or promoted. Your changes will not be broadcasted to the raid and broadcasted settings will overwrite yours.";
LVBM_LOATHEB_NO_CD				= "No cooldown";
LVBM_LOATHEB_SET_HEAL_ROTATION			= "Save & sync";
LVBM_LOATHEB_SET_HEAL_ROTATION_NO_BC		= "Save";
LVBM_LOATHEB_SHADOW_PROT_POT			= "Shadow Protection Potion"
LVBM_LOATHEB_BANDAGE				= "Bandage";
LVBM_LOATHEB_HEALTHSTONE			= "Healthstone";

LVBM_LOATHEB_DOOM_WARNING		= "*** Inevitable Doom #%s in %s sec ***";
LVBM_LOATHEB_DOOM_NOW			= "*** Inevitable Doom #%s - next in %s sec ***";
LVBM_LOATHEB_DECURSE_NOW		= "*** Curses removed - next in 30 sec ***";
LVBM_LOATHEB_DECURSE_WARNING		= "*** Remove Curse in %s sec ***";
LVBM_LOATHEB_SPORE_SPAWNED		= "*** Spore %d spawned ***";
LVBM_LOATHEB_POT_ANNOUNCE		= "*** %s now! ***";
LVBM_LOATHEB_POT_WARNING		= "Use %s now!";
LVBM_LOATHEB_HEAL_WARNING		= "Heal #%s done - next: %s";
LVBM_LOATHEB_YOU_ARE_NEXT		= "You are next!";
LVBM_LOATHEB_YOU_ARE_SOON		= "Get ready to heal!";

LVBM_LOATHEB_DOOM_REGEXP		= "([^%s]+) (%w+) afflicted by Inevitable Doom.";
LVBM_LOATHEB_REMOVE_CURSE		= "Loatheb casts Remove Curse on Loatheb.";
LVBM_LOATHEB_HEAL_REGEXP		= "([^%s]+) (%w+) afflicted by Corrupted Mind.";
LVBM_LOATHEB_SUMMON_SPORE		= "Loatheb casts Summon Spore.";
LVBM_LOATHEB_LOATHEB			= "Loatheb";

LVBM_SBT["Inevitable Doom"]		= "Inevitable Doom";


-- Sapphiron
LVBM_SAPPHIRON_NAME 			= "Sapphiron";
LVBM_SAPPHIRON_INFO			= "Warns for Ice Bomb, Life Drain and Enrage.";

LVBM_SAPPHIRON_YELL_INFO		= "Yell when afflicted by Ice Block";
LVBM_SAPPHIRON_YELL_ANNOUNCE		= "I'm an Ice Block, stay behind me!";

LVBM_SAPPHIRON_LIFEDRAIN_EXPR1		= "afflicted by Life Drain";
LVBM_SAPPHIRON_LIFEDRAIN_EXPR2		= "Life Drain was resisted by";
LVBM_SAPPHIRON_LIFEDRAIN_ANNOUNCE	= "*** Life Drain - next in ~24 sec ***";
LVBM_SAPPHIRON_LIFEDRAIN_WARN		= "*** Life Drain in %d sec ***";

LVBM_SAPPHIRON_DEEPBREATH_EXPR		= "takes in a deep breath...";
LVBM_SAPPHIRON_DEEPBREATH_ANNOUNCE	= "*** Ice Bomb Incoming ***";

LVBM_SAPPHIRON_FROSTBOLT_GAIN_EXPR	= "You are afflicted by Icebolt";
LVBM_SAPPHIRON_FROSTBOLT_FADE_EXPR	= "Icebolt fades from you";

LVBM_SAPPHIRON_ENRAGE_ANNOUNCE		= "*** Enrage in %d sec ***";


-- Kel'Thuzad
LVBM_KELTHUZAD_NAME			= "Kel'Thuzad";
LVBM_KELTHUZAD_INFO			= "Announces phases and abilities of the Kel'Thuzad boss fight.";

LVBM_KELTHUZAD_RANGECHECK		= "Show distance frame during phase 2 and 3";

LVBM_KELTHUZAD_PHASE1_EXPR		= "Minions, servants, soldiers of the cold dark! Obey the call of Kel'Thuzad!";
LVBM_KELTHUZAD_PHASE1_ANNOUNCE		= "*** Phase 1 ***";
LVBM_KELTHUZAD_PHASE2_EXPR		= "Pray for mercy!";
LVBM_KELTHUZAD_PHASE2_ANNOUNCE		= "*** Phase 2 - Kel'Thuzad engaged ***";
LVBM_KELTHUZAD_PHASE3_EXPR		= "Master, I require aid!";
LVBM_KELTHUZAD_PHASE3_ANNOUNCE		= "*** Phase 3 - Guardians in ~15 sec ***";

LVBM_KELTHUZAD_MC_EXPR1			= "Your soul is bound to me, now!";
LVBM_KELTHUZAD_MC_EXPR2			= "There will be no escape!";
LVBM_KELTHUZAD_MC_ANNOUNCE		= "*** Mind Control ***";
LVBM_KELTHUZAD_GUARDIAN_EXPR		= "Very well. Warriors of the frozen wastes, rise up! I command you to fight, kill and die for your master! Let none survive!";
LVBM_KELTHUZAD_GUARDIAN_ANNOUNCE	= "*** Guardians in ~10 sec ***";
LVBM_KELTHUZAD_FISSURE_EXPR		= "Kel'Thuzad casts Shadow Fissure.";
LVBM_KELTHUZAD_FISSURE_ANNOUNCE		= "*** Shadow Fissure ***";
LVBM_KELTHUZAD_FROSTBLAST_EXPR		= "^(.+) (.+) afflicted by Frost Blast";
LVBM_KELTHUZAD_FROSTBLAST_ANNOUNCE	= "*** Frost Blast ***";
LVBM_KELTHUZAD_DETONATE_EXPR		= "^([^%s]+) ([^%s]+) afflicted by Detonate Mana.";
LVBM_KELTHUZAD_DETONATE_ANNOUNCE	= "*** Detonate Mana - %s ***";
LVBM_KELTHUZAD_DETONATE_SELFWARN	= "You are the Bomb!";
LVBM_KELTHUZAD_DETONATE_WHISPER		= "You are the Bomb! Run away!";
