if ( GetLocale() == "enUS" or GetLocale() == "enGB" ) then

-- Options Menue
CECB_status_txt = "EnemyCastBar Mod activated";
CECB_pvp_txt = "|cffffffaaPvP/Common|r CastBars activated";
 CECB_globalpvp_txt = "Show CastBars even w/o Target";
 CECB_gains_txt = "Spelltype 'gains' activated";
  CECB_gainsonly_txt = "Only show 'gains'";
 CECB_cdown_txt = "Some CoolDownBars activated";
  CECB_cdownshort_txt = "ONLY show short CDs";
  CECB_usecddb_txt = "Use a CoolDown Database";
 CECB_spellbreak_txt = "NO CastBreaks in Raids";
CECB_pve_txt = "|cffffffaaPvE/Raid|r Castbars activated";
 CECB_pvew_txt = "Play sound on flash";
CECB_afflict_txt = "Show |cffffffaaDebuffs";
 CECB_globalfrag_txt = "Show 'Mob Outs' even w/o Target";
 CECB_magecold_txt = "Show Cold + Vulnerability effects";
 CECB_solod_txt = "Show 'Solo Debuffs' (Stuns)";
  CECB_drtimer_txt = "Consider 'Diminishing Return'";
  CECB_classdr_txt = "Consider class specific 'DRs'";
 CECB_sdots_txt = "Observe own DoTs";
 CECB_affuni_txt = "ONLY show Debuffs from RaidBosses";
CECB_parsec_txt = "Parse AddOn/Raid/PartyChat";
 CECB_broadcast_txt = "Broadcast CBs via AddOn Channel";
CECB_targetm_txt = "Target on BarLeftClick";
CECB_timer_txt = "Show Timer next to CastBars";
CECB_tsize_txt = "Small textfont for CastBars";
CECB_flipb_txt = "Flip over CastBars";
CECB_flashit_txt = "'Flash' CastBars at their end";
CECB_showicon_txt = "Show Icon next to CastBars";
CECB_scale_txt = "Scaling: ";
CECB_alpha_txt = "Alphablending: ";
CECB_numbars_txt = "Max. number of CastBars: ";
CECB_space_txt = "Iconsize, Distance of CastBars: ";
CECB_blength_txt = "Width of the CastBars ";
CECB_minimap_txt = "Position at the MiniMap: ";
CECB_throttle_txt = "AddOn Updates per Second: ";

CECB_status_tooltip = "Activates/ Deactivates the appearing of CastBars while gaming and switches off all Events to reduce CPU load.";
CECB_pvp_tooltip = "Activates CastBars for all supported, common spells of players.";
 CECB_globalpvp_tooltip = "Shows all PvP CastBars in range of your CombatLog, instead of only showing the CastBars of your actual target.\n\n|cffff0000Warning:|r This setting may result in very many CastBars displayed at once!\n\n|cffff0000Friend/Foe Detection does not work with this!";
 CECB_gains_tooltip = "Activates CastBars for 'gains'.\nThose are spells like 'Iceblock', 'Bloodrage' and Heal over Time (HoTs).";
  CECB_gainsonly_tooltip = "Only Gains will be displayed. Casts will be ignored.";
 CECB_cdown_tooltip = "Activates the CoolDown-Times for some(!) spells, which have casttimes or are 'gains'.";
  CECB_cdownshort_tooltip = "Only shows Cooldowns if their duration is 60 or less seconds.";
  CECB_usecddb_tooltip = "Stores all recognized CoolDowns in Combatlog-Range into a Database and dynamically triggers the fitting CoolDowns for the selected target, in case the special CoolDowns were detected before.";
 CECB_spellbreak_tooltip = "Prevents the detection of PvP(!) Spell Interruptions in Raids.\nThis options improves performance and prevents wrongly detected Spell Interrupts in raids.";
CECB_pve_tooltip = "Activates CastBars for PvE/Raid-Encounters";
 CECB_pvew_tooltip = "Plays a 'Fump'-Sound when a Raid CastBar begins to flash.";
CECB_afflict_tooltip = "Shows immobilizing Debuffs, e.g. '(Polymorph)' or 'Harmstring'. Simultaneously activates many Debuffs of bosses which can be cast on players, e.g. 'Burning Adrenaline'.";
 CECB_globalfrag_tooltip = "Shows CastBars at 'Mob Outs', even if the affected Mob is not your current target.\n\n'Mob Outs' are 'Shackle Undead', 'Banish', 'Polymorph' etc.";
 CECB_magecold_tooltip = "Shows the following cold effects:\n'Frost Nova', 'Frostbite', 'Chilled', 'Cone of Cold' and 'Frostbolt'.\nAdditionally vulnerabilities (cold, fire, shadow) will be displayed.";
 CECB_solod_tooltip = "Shows many Stuns. Also activates silenced, fear, disarm and threat effects!";
  CECB_drtimer_tooltip = "Considers 'Diminishing Return' for the biggest stun-family which use the same timer.\nThese are 3 Warrior, 3 Druid, 1 Paladin and 1 Rogue stun(s).\n\nYou will see a bar counting down the 20 seconds until you will be able to afflict the full stun length again.";
  CECB_classdr_tooltip = "Considers class specific 'Diminishing Returns' like 'Sap' and 'Polymorph'.\n\n|cffff0000Usually these timers are only active against other Players|r and are only displayed for the matching character class.";
 CECB_sdots_tooltip = "Shows the duration of your DoTs (e.g. |cffffffff'Corruption' |r-|cffffffff 'Serpent Sting'|r).\nThe CastBars won't renew if the DoT is casted again before the duration ran out! |cffff0000\nAt best, renew the DoT at the very end of its duration or the timer becomes crazy!|r\n\nDoTs which additionally afflict instant damage will renew the CastBar and do not have this problem (e.g |cffffffff'Immolate'|r)!";
 CECB_affuni_tooltip = "Switches off all Debuffs, which do not come from RaidBosses, to have a better overview.";
CECB_timer_tooltip = "Additionally shows an digital Timer beneath the CastBars.";
CECB_targetm_tooltip = "The Mob, the CastBar came from, may be targeted by a LeftClick on the CastBar through this option.";
CECB_parsec_tooltip = "All Users who enable this option, receive a CastBar on their screen, if one of the following commands with a set time appears at the beginning of the Raid-/Party-/AddOn-Channel: '|cffffffff.countmin|r', '|cffffffff.countsec|r', '|cffffffff.repeat|r' or '|cffffffff.stopcount|r' (s. Help).\n\nExample:\n|cffffffff.countsec 45 Until Spawn|r\n\nInstead of:\n|cffffffff/necb countsec 45 Until Spawn";
CECB_broadcast_tooltip = "Raidspells and Debuffs will be broadcasted through the AddOn Channel.\nThis only works if sender and receiver use the same language!\n\n|cffff0000ATTENTION:|r This option should only be enable by some few, selected Players of the Raid!\nPvP Spells won't be transmitted.";
CECB_tsize_tooltip = "Lowers the size of the textfont to allow more letters in the castbars.";
CECB_flipb_tooltip = "Turns the direction in which CastBars appear around.\nNormal: From button up.\nActivated: From top down.";
CECB_flashit_tooltip = "CastBars with a Totaltime of at least 20 Sekunden, begin to 'flash' after 20% of the bar is left.\nBut at maximum the last 10 seconds are 'flashed'.";
CECB_showicon_tooltip = "Displays the proper spell icon next to the Castbar.\n\nThe size will automatically fit to the 'Iconsize, Distance of CastBars' setting.";
CECB_scale_tooltip = "Does allow to change the size of the CastBars from 30 till 130 percent.";
CECB_alpha_tooltip = "Does allow to change the transparency of the CastBars.";
CECB_numbars_tooltip = "Sets the maximum allowed CastBars on your screen.";
CECB_space_tooltip = "Sets the space between CastBars.\n(default is 20)";
CECB_blength_tooltip = "Sets the additional CastBar width.\n(Standard = 0)";
CECB_minimap_tooltip = "Moves the NECB Button around the MiniMap. \n\nMove to the very left to disable the button!";
CECB_throttle_tooltip = "Sets the updates per second for CastBars, the menue and the FPS Bar.\nMore updates will require more CPU Power!";
CECB_fps_tooltip = "Creates a standalone clone of the FPS Bar which can be placed freely.";


CECB_menue_txt = "Options";
CECB_menuesub1_txt = "Which CastBars to show?";
CECB_menuesub2_txt = "Appearance of CastBars/ Other";
CECB_menue_reset = "Defaults";
CECB_menue_help = "Help";
CECB_menue_colors = "Colors";
CECB_menue_mbar = "Movable Bar";
--CECB_menue_close = "Close";
CECB_menue_rwarning = "|cffff0000WARNING!|r\n\nAll values and positions will be restored \nto 'factory defaults'!\n\nDo you really want a complete reset?";
CECB_menue_ryes = "Yes";
CECB_menue_rno = "NO!";
CECB_minimapoff_txt = "off";


end
