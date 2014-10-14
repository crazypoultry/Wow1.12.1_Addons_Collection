-- http://www.allegro-c.de/unicode/zcodes.htm
--
-- ä = \195\164
-- Ä = \195\132
-- ö = \195\182
-- Ö = \195\150
-- ü = \195\188
-- Ü = \195\156
-- ß = \195\159


if GetLocale() == "deDE" then
	--Skeram
	LVBM_SKERAM_NAME		= "Prophet Skeram";
	LVBM_SKERAM_DESCRIPTION	= "Warnt vor Skerams Arkaner Explosion und Gedankenkontrolle.";
	
	LVBM_SKERAM_AE	= "*** Arkane Explosion ***";
	LVBM_SKERAM_MC	= "*** %s ist \195\188bernommen ***";
	
	LVBM_SKERAM_CAST_SPELL_AE			= "Der Prophet Skeram beginnt Arkane Explosion zu wirken.";
	LVBM_SKERAM_MIND_CONTROL_TEXTURE	= "Spell_Shadow_Charm";
	LVBM_SKERAM_MIND_CONTROL_DEBUFF		= "Wahre Erf\195\188llung";	

	-- 2. Three Bugs (Vem & Co)
	LVBM_THREEBUGS_NAME			= "Drei KÃ¤fer - Vem, Yauj and Kri";
	LVBM_THREEBUGS_VEM			= "Vem";
	LVBM_THREEBUGS_YAUJ			= "Prinzessin Yauj";
	LVBM_THREEBUGS_KRI			= "Lord Kri";
	LVBM_THREEBUGS_VEM			= "Vem";
	LVBM_THREEBUGS_REAL_NAME	= "Drei KÃ¤fer";
	LVBM_THREEBUGS_FEAR_EXPR		= "(.+) (.+) betroffen von Furcht.";
	LVBM_THREEBUGS_FEAR_ANNOUNCE		= "*** Yauj Fear in %d Sek ***";
	LVBM_THREEBUGS_CASTHEAL_EXPR		= "Yauj beginngt GroÃŸe Heilung zu wirken.";
	LVBM_THREEBUGS_CASTHEAL_ANNOUNCE	= "*** Yauj zaubert Heilung, jetzt Unterbrechen ***";
	LVBM_SBT["Great Heal Cast"] 		= "GroÃŸe Heilung";	
	
	--Sartura
	LVBM_SARTURA_NAME			= "Schlachtwache Sartura"
	LVBM_SARTURA_DESCRIPTION	= "Stellt einen Timer f\195\188r Sarturas Wirbelwind zur Verf\195\188gung"
	
	LVBM_SARTURA_ANNOUNCE_WHIRLWIND	= "*** Wirbelwind ***"
	LVBM_SARTURA_WHIRLWIND_FADED	= "*** Wirbelwind ausgelaufen - stunnen! ***"
	
	LVBM_SARTURA_GAIN_WHIRLWIND		= "Schlachtwache Sartura bekommt Wirbelwind.";
	LVBM_SARTURA_WHIRLWIND_FADES	= "Wirbelwind schwindet von Schlachtwache Sartura.";
	LVBM_SARTURA_ENRAGE			= "%s wird w\195\188tend";
	LVBM_SARTURA_SARTURA		= "Schlachtwache Sartura";
	
	LVBM_SBT["Whirlwind"] = "Wirbelwind";
	
	--Fankriss
	LVBM_FANKRISS_NAME			= "Fankriss der Unnachgiebige"
	LVBM_FANKRISS_DESCRIPTION	= "Sagt den Spawn der W\195\188rner an."
	
	LVBM_FANKRISS_SPAWN_WARNING	= "*** Wurm gespawned ***"
	
	LVBM_FANKRISS_WORM_SPAWNED	= "Fankriss der Unnachgiebige wirkt Wurm beschw\195\182ren.";

	--Huhuran
	LVBM_HUHURAN_NAME				= "Prinzessin Huhuran";
	LVBM_HUHURAN_DESCRIPTION		= "Stellt einen Timer f\195\188r Huhurans Wyvern Sting zur Verf\195\188gung und warnt vor Frenzy.";
	LVBM_HUHURAN_ANNOUNCE_FRENZY	= "Frenzy ansagen";
	
	LVBM_HUHURAN_WYVERN_WARNING	= "*** Stich des Fl\195\188geldrachens in ~5 Sek ***";
	
	LVBM_HUHURAN_WYVERN_REGEXP	= "(%w+) ist von Stich des Fl\195\188geldrachens betroffen.";
	LVBM_HUHURAN_FRENZY			= "%s ger\195\164t in Raserei!";
	LVBM_HUHURAN_HUHURAN		= "Prinzessin Huhuran";
	
	LVBM_SBT["Wyvern Sting Cooldown"] = "Stich des Fl\195\188geldrachens Cooldown";
	
	
	--Defenders
	LVBM_DEFENDER_NAME			= "Verteidiger des Anubisath";
	LVBM_DEFENDER_DESCRIPTION	= "Warnt vor Explosion und Seuche.";
	LVBM_DEFENDER_WHISPER		= "Whisper verschicken";
	LVBM_DEFENDER_PLAGUE		= "Seuche ansagen";
	
	LVBM_DEFENDER_ANNOUNCE_EXPLODE	= "*** Explosion ***";
	LVBM_DEFENDER_ANNOUNCE_PLAGUE	= "*** %s hat die Seuche ***";
	LVBM_DEFENDER_WHISPER_PLAGUE	= "Du hast die Seuche!";
	LVBM_DEFENDER_PLAGUE_WARNING	= "Seuche";
	
	LVBM_DEFENDER_GAIN_EXPLODE	= "Verteidiger des Anubisath bekommt 'Explodieren'.";
	LVBM_DEFENDER_PLAGUE_REGEXP	= "([^%s]+) (%w+) von Seuche betroffen.";
	
	LVBM_SBT["Explode"]	= "Explosion";
	
	
	--Twin Emperors
	LVBM_TWINEMPS_NAME		= "Zwillings Imperatoren";
	LVBM_TWINEMPS_DESCRIPTION	= "Stellt Timer f\195\188r die Zwillings Imperatoren zur Verf\195\188gung."
	
	LVBM_TWINEMPS_TELEPORT_WARNING	= "*** Teleport in %s Sek ***";
	LVBM_TWINEMPS_ENRAGE_WARNING	= "*** Enrage in %s %s ***";

	LVBM_TWINEMPS_TELEPORT_ANNOUNCE	= "*** Teleport ***";
	
	LVBM_TWINEMPS_CAST_SPELL_1	= "Imperator Vek'lor wirkt Zwillingsteleport.";
	LVBM_TWINEMPS_CAST_SPELL_2	= "Imperator Vek'nilash wirkt Zwillingsteleport.";
	LVBM_TWINEMPS_VEKNILASH		= "Imperator Vek'nilash";
	LVBM_TWINEMPS_VEKLOR		= "Imperator Vek'lor";

	LVBM_TWINEMPS_EXPLODE_EXPR 	= "(.+) bekommt 'K\195\164fer explodieren lassen'.";
	LVBM_TWINEMPS_EXPLODE_ANNOUNCE 	= "*** K\195\164fer Bombe - lauf weg ***";
	
	LVBM_SBT["Enrage"]		= "Enrage";
	LVBM_SBT["Teleport"]		= "Teleport";
	
	
	--Ouro
	LVBM_OURO_NAME			= "Ouro";
	LVBM_OURO_DESCRIPTION	= "Stellt Timer f\195\188r Ouro zur Verf\195\188gung.";
	
	LVBM_OURO_SWEEP_SOON_WARNING		= "*** Feger in ~5 Sek ***";
	LVBM_OURO_BLAST_SOON_WARNING		= "*** Sandsto\195\159 in ~5 Sek ***";
	LVBM_OURO_SWEEP_WARNING				= "*** Feger in 1 Sek ***";
	LVBM_OURO_BLAST_WARNING				= "*** Sandsto\195\159 in 2 Sek ***";
	LVBM_OURO_SUBMERGED_WARNING			= "*** Ouro ist f\195\188r 30 Sek untergetaucht ***";
	LVBM_OURO_EMERGE_SOON_WARNING		= "*** ~5 Sekunden bis Ouro auftaucht ***";
	LVBM_OURO_EMERGED_WARNING			= "*** Ouro ist aufgetaucht - 3 Minuten bis zum Untertauchen ***";
	LVBM_OURO_POSSIBLE_SUBMERGE_WARNING	= "*** Ouro taucht vielleicht in 10 Sekunden unter ***";
	LVBM_OURO_SUBMERGE_WARNING			= "*** %s Sekunden bis Ouro untertaucht ***";
	
	LVBM_OURO_CAST_SWEEP		= "Ouro begins to cast Sweep.";
	LVBM_OURO_CAST_SAND_BLAST	= "Ouro begins to perform Sand Blast.";
	LVBM_OURO_DIRT_MOUND_QUAKE	= "Dirt Mound's Quake";
	LVBM_OURO_ENRAGE			= "%s goes into a berserker rage!";
	LVBM_OURO_OURO				= "Ouro";
	
	LVBM_SBT["Submerge"]		= "Untertauchen";
	LVBM_SBT["Emerge"]			= "Auftauchen";
	LVBM_SBT["Sand Blast"]		= "Sandsto\195\159";
	LVBM_SBT["Sand Blast Cast"]	= "Sandsto\195\159 Cast";
	LVBM_SBT["Sweep"]			= "Feger"
	LVBM_SBT["Sweep Cast"]		= "Feger Cast";
	
	
	--CThun
	LVBM_CTHUN_NAME				= "C'Thun"
	LVBM_CTHUN_DESCRIPTION			= "Stellt Timer f\195\188r Tentakel zur Verf\195\188gung und sagt die Ziele vons Dark Glare an. Jeder au\195\159er dem 'Main Tank' (= die Person, die als erstes rein l\195\164uft) sollte Ansagen deaktivieren.";
	LVBM_CTHUN_SLASHHELP1			=  "/cthun start - startet die Timer";
	LVBM_CTHUN_RANGE_CHECK			= "Reichweiten Check";
	LVBM_CTHUN_RANGE_CHECK_PHASE2		= "Reichweiten Check auch in Phase2"

	LVBM_CTHUN_SMALL_EYE_WARNING		= "*** Augententakel in %s Sek ***";
	LVBM_CTHUN_DARK_GLARE_WARNING		= "*** Dunkles Starren in %s Sek ***";
	LVBM_CTHUN_DARK_GLARE_ON_GROUP		= "*** Dunkles Starren auf Gruppe ";
	LVBM_CTHUN_DARK_GLARE_ON_YOU		= "Dunkles Starren auf dir!";
	LVBM_CTHUN_DARK_GLARE_TIMER_FAILED	= "Dunkles Starren Timer Anpassung fehlgeschlagen.";
	LVBM_CTHUN_DARK_GLARE_END_WARNING	= "*** Dunkles Starren endet in 5 Sek ***";
	LVBM_CTHUN_GIANT_CLAW_WARNING		= "*** Riesiges Klauententakel in 10 Sek ***";
	LVBM_CTHUN_GIANT_AND_EYES_WARNING	= "*** Riesiges %stentakel und Augententakel in 10 Sek ***";
	LVBM_CTHUN_WEAKENED_WARNING			= "*** C'Thun ist geschw\195\164cht - 45 Sek ***";
	LVBM_CTHUN_WEAKENED_ENDS_WARNING	= "*** Noch %s Sekunden ***";
	LVBM_CTHUN_DARK_GLARE				= "Dunkles Starren";
	LVBM_CTHUN_EYE_BEAM					= "Eye Beam";
	
	LVBM_CTHUN_EYE_OF_CTHUN	= "Auge von C'Thun";
	LVBM_CTHUN_CLAW			= "Klauen";
	LVBM_CTHUN_EYE			= "Augen";
	LVBM_CTHUN_DIES			= "Auge von C'Thun stirbt.";
	LVBM_CTHUN_WEAKENED		= "%s ist geschw\195\164cht!";
	
	LVBM_SBT["Dark Glare"]			= "Dunkles Starren";
	LVBM_SBT["Dark Glare End"]		= "Dunkles Starren Ende";
	LVBM_SBT["Eye Tentacles"]		= "Augententakel";
	LVBM_SBT["Giant Eye Tentacle"]	= "Riesiges Augententakel";
	LVBM_SBT["Giant Claw Tentacle"]	= "Riesiges Klauententakel";
	
	--Viscidus
	LVBM_VISCIDUS_NAME			= "Viscidus";
	LVBM_VISCIDUS_DESCRIPTION	= "Z\195\164hlt Frost und Nahkampf Treffer auf Viscidus.";
	LVBM_VISCIDUS_SLASHHELP1	= "/Viscidus mt name - stellt den Main Tank ein um Spam zu vermeiden.";
	LVBM_VISCIDUS_MT_SET		= "Main Tank gesetzt auf: ";
	LVBM_VISCIDUS_MT_NOT_SET1	= "Main Tank nicht gesetzt! Die Toxin Warnung wird den Main Tank alle 15 Sekunden whispern!";
	LVBM_VISCIDUS_MT_NOT_SET2	= "Verwende '/viscidus mt name' um den Main Tank einzustellen.";
	
	LVBM_VISCIDUS_TOXIN_ON				= "*** Toxin auf ";
	LVBM_VISCIDUS_TOXIN_ON_YOU			= "Toxin auf dir!";
	LVBM_VISCIDUS_FREEZE_WARNING		= "*** Einfrieren %s/3 ***";
	LVBM_VISCIDUS_FROZEN_WARNING		= "*** Einfrieren 3/3 - eingefroren f\195\188r 15 sek ***";
	LVBM_VISCIDUS_SHATTER_WARNING		= "*** Zerspringen %s/3 ***";
	LVBM_VISCIDUS_FROZEN_LEFT_WARNING	= "*** Noch %s Sekunden ***";
	LVBM_VISCIDUS_FROST_HITS			= "Frost Treffer: ";
	LVBM_VISCIDUS_FROST_HITS_WARNING	= "*** %s Frost Treffer ***";
	LVBM_VISCIDUS_MELEE_HITS			= "Nahkampf Treffer: ";
	LVBM_VISCIDUS_MELEE_HITS_WARNING	= "*** %s Nahkampf Treffer ***";
	
	LVBM_VISCIDUS_SLOW_1	= "wird langsamer!";
	LVBM_VISCIDUS_SLOW_2	= "friert ein!";
	LVBM_VISCIDUS_SLOW_3	= "ist tiefgefroren!";
--	LVBM_VISCIDUS_SHATTER_1	= ""; --emote?
	LVBM_VISCIDUS_SHATTER_2	= "ist kurz davor, zu zerspringen!";
	LVBM_VISCIDUS_VISCIDUS	= "Viscidus";
	
	LVBM_SBT["Frozen"]	= "Eingefroren";
end
