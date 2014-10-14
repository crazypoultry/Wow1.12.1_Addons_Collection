if GetLocale() == "deDE" then
	--Patchwerk
	LVBM_PW_NAME		= "Flickwerk";
	LVBM_PW_DESCRIPTION	= "Stellt einen Timer f\195\188r seinen Enrage zur Verf\195\188gung.";
	LVBM_PW_OPTION1		= "Hasserf\195\188llter Sto\195\159 ansagen";
	LVBM_PW_OPTION2		= "Stats anzeigen";
	
	LVBM_PW_ENRAGE_WARNING	= "*** Enrage in %s %s ***";
	LVBM_PW_HS_ANNOUNCE	= "Hasserf\195\188llter Sto\195\159 --> %s [%s]";
	--thx 2 leidenschafft
	LVBM_PW_YELL_1 		= "Flickwerk spielen m\195\182chte!";
	LVBM_PW_YELL_2 		= "Kel'thuzad macht Flickwerk zu seinem Abgesandten von Krieg!";	
  
	LVBM_PW_HS_YOU_HIT		= "Flickwerk trifft Euch %(mit Hasserf\195\188llter Sto\195\159%). Schaden: (%d+).(.*)";
	LVBM_PW_HS_YOU_MISS		= "Flickwerk greift an %(mit Hasserf\195\188llter Sto\195\159%) und verfehlt Euch.";
	LVBM_PW_HS_YOU_DODGE		= "Flickwerks Hasserf\195\188llter Sto\195\159 wurde ausgewichen.";
	LVBM_PW_HS_YOU_PARRY		= "Hasserf\195\188llter Sto\195\159 von Flickwerk wurde pariert.";
	LVBM_PW_HS_PARTY_HIT		= "Flickwerks Hasserf\195\188llter Sto\195\159 trifft ([^%s]+) f\195\188r (%d+) Schaden.(.*)";
	LVBM_PW_HS_PARTY_MISS		= "Hasserf\195\188llter Sto\195\159 von Flickwerk verfehlt ([^%s]+)."; 
	LVBM_PW_HS_PARTY_DODGE		= "([^%s]+) ist Hasserf\195\188llter Sto\195\159 von Flickwerk ausgewichen.";
	LVBM_PW_HS_PARTY_PARRY		= "Hasserf\195\188llter Sto\195\159 von Flickwerk wurde von ([^%s]+) pariert.";
	
	LVBM_PWSTATS_STATS		= "*** Flickwerk Stats ***";
	LVBM_PWSTATS_STRIKES		= "Hasserfüllte Stöße: %s (%.0f%%)";
	LVBM_PWSTATS_HITS		= "Treffer: %s (%.0f%%)";
	LVBM_PWSTATS_DODGES		= "Ausgewichen: %s (%.0f%%)";
	LVBM_PWSTATS_PARRIES		= "Parriert: %s (%.0f%%)";
	LVBM_PWSTATS_MISSES		= "Verfehlt: %s (%.0f%%)";
	LVBM_PWSTATS_AVG_DMG		= "Durchschnittlicher Schaden pro Treffer: %.0f";
	LVBM_PWSTATS_MAX_HIT		= "Höchster Treffer: %s auf %s";
	LVBM_PWSTATS_PER_PLAYER		= "%s Hasserfüllte Stöße auf %s (%s Treffer)";
	LVBM_PWSTATS_NOT_AVAILABLE	= "Stats nicht verfügbar";
	
	
	--Grobbulus
	LVBM_GROBB_NAME				= "Grobbulus";
	LVBM_GROBB_DESCRIPTION			= "Setzt ein Icon (Totenkopf) auf Spieler, die von Mutierende Injektion betroffen sind. Nur ein Spieler sollte ansagen und \"Icon setzen\" aktivieren.";
	LVBM_GROBB_SEND_WHISPER			= "Whisper verschicken";
	LVBM_GROBB_SET_ICON			= "Icon setzen";
	
	LVBM_GROBB_YOU_ARE_INJECTED		= "Du bist von Mutierende Injektion betroffen!";
	LVBM_GROBB_INJECTED_WARNING		= "*** %s ist von Mutierende Injektion betroffen ***"
	LVBM_GROBB_INJECTED			= "Mutierende Injektion";
	
	LVBM_GROBB_INJECTION_REGEXP		= "([^%s]+) (%w+) von Mutierende Injektion betroffen.";
	LVBM_GROBB_INJECTION_FADES_REGEXP	= "Mutierende Injektion schwindet von ([^%s]+)%.";
	
	
	--Gluth
	LVBM_GLUTH_NAME				= "Gluth";
	LVBM_GLUTH_DESCRIPTION			= "Sagt Fear, Frenzy und Dezimieren an.";
	LVBM_GLUTH_ANNOUNCE_FRENZY		= "Frenzy ansagen";
	
	LVBM_GLUTH_DECIMATE_WARN1		= "*** Dezimieren in 2 Minuten ***";
	LVBM_GLUTH_DECIMATE_WARN2		= "*** Dezimieren - n\195\164chstes in 2 Minuten ***";
	LVBM_GLUTH_DECIMATE_1MIN_WARNING	= "*** Dezimieren in 1 Minute ***";
	LVBM_GLUTH_DECIMATE_SOON_WARNING	= "*** Dezimieren bald ***";
	LVBM_GLUTH_DECIMATE_WARNING		= "*** Dezimieren in ~%s Sek ***"
	LVBM_GLUTH_FEAR_WARNING			= "*** Fear - n\195\164chstes in 20 Sek ***";
	LVBM_GLUTH_FEAR_5SEC_WARNING		= "*** Fear in 5 Sekunden ***";
	
	LVBM_GLUTH_DECIMATE_REGEXP		= "Gluths Dezimieren trifft ([^%s]+) f\195\188r (%d+) Schaden.";
	LVBM_GLUTH_FEAR_REGEXP			= "(%w+) ist von Erschreckendes Gebr\195\188ll betroffen.";
	LVBM_GLUTH_FRENZY			= "%s ger\195\164t in Raserei!"
	LVBM_GLUTH_GLUTH			= "Gluth";
	
	LVBM_SBT["Fear"]			= "Fear";
	LVBM_SBT["Decimate"]			= "Dezimieren";
	
	
	--Razuvious
	LVBM_IR_NAME			= "Instrukteur Razuvious";
	LVBM_IR_DESCRIPTION		= "Stellt einen Timer f\195\188r Disrupting Shout zur Verf\195\188gung.";
	LVBM_IR_SHOW_10SEC_WARNING	= "10 Sekunden Warning anzeigen";
	
	LVBM_IR_TIMER_UPDATED		= "Timer aktualisiert";
	LVBM_IR_SHOUT_WARNING		= "*** Disrupting Shout in %s Sek ***"
	
	LVBM_IR_SPELL_1			= "Unterbrechungsruf";
	
	LVBM_SBT["Disruption Shout"]	= "Disrupting Shout";
	
	
	--Noth the Plaguebringer
	LVBM_NTP_NAME			= "Noth der Seuchenf\195\188rst";
	LVBM_NTP_DESCRIPTION		= "Stellt Timer f\195\188r Blinzeln und Teleport zur Verf\195\188gung.";
	
	LVBM_NTP_BACK_WARNING		= "*** Noth ist zur\195\188ck (%s Sek) ***";
	LVBM_NTP_TELEPORT_WARNING	= "*** %s Sek bis Teleport ***";
	LVBM_NTP_NOTH_GAINS_BLINK	= "*** Blinzeln ***";
	LVBM_NTP_BLINK_5SEC_WARNING	= "*** Blinzeln in ~5 Sek ***";
	LVBM_NTP_TELEPORT_10SEC_WARNING	= "*** Teleport in 10 Sek ***"
	LVBM_NTP_BACK_10SEC_WARNING	= "*** 10 Sek bis er zur\195\188ck kommt ***";
	
	LVBM_NTP_SPELL_1 		= "Noth der Seuchenf\195\188rst bekommt 'Blinzeln'.";
	LVBM_NTP_YELL_START1 		= "Stirb, Eindringling!";
	LVBM_NTP_YELL_START2 		= "Ehre unserem Meister!";
	LVBM_NTP_YELL_START3 		= "Euer Leben ist verwirkt!";
	
	LVBM_SBT["Teleport to Balcony"]	= "Teleport zum Balkon";
	LVBM_SBT["Teleport back"]	= "Teleport zur\195\188ck";
	LVBM_SBT["Blink"]		= "Blinzeln";
	
	
	--Heigan the Unclean
	LVBM_HTU_NAME			= "Heigan der Unsaubere";
	LVBM_HTU_DESCRIPTION		= "Stellt Timer f\195\188r seinen Teleport zur Verf\195\188gung.";
	
	LVBM_HTU_TELEPORT_WARNING	= "*** Teleport in %s Sekunden ***";
	LVBM_HTU_TELEPORT_BACK_WARNING	= "*** Teleport zur\195\188ck in %s Sekunden ***";
	
	LVBM_HTU_YELL_START1 		= "Ihr seid.... als n\195\164chstes dran.";
	LVBM_HTU_YELL_START2 		= "Ihr entgeht mir nicht...";
	LVBM_HTU_YELL_START3 		= "Ihr geh\195\182rt mir...";
	
	LVBM_SBT["Teleport"]		= "Teleport";
	LVBM_SBT["Teleport back"]	= "Teleport zur\195\188ck";
	
	
	--Anub'Rekhan
	LVBM_AR_NAME			= "Anub'Rekhan";
	LVBM_AR_DESCRIPTION		= "Stellt Timer f\195\188r Heuschreckenschwarm zur Verf\195\188gung.";
	
	LVBM_AR_LOCUST_WARNING		= "*** Heuschreckenschwarm in ~%s Sek ***";
	LVBM_AR_LOCUST_SOON_WARNING	= "*** Heuschreckenschwarm bald ***";
	LVBM_AR_LOCUST_INC_WARNING	= "*** Heuschreckenschwarm inc - 3 Sek ***";
	LVBM_AR_GAIN_LOCUST_WARNING	= "*** Heuschreckenschwarm jetzt - 20 Sek ***";
	LVBM_AR_LOCUST_END_WARNING	= "*** Heuschreckenschwarm endet in %s Sek ***";
	
	LVBM_AR_YELL_1 			= "Es gibt kein Entkommen."; 
	LVBM_AR_YELL_2 			= "Nur einmal kosten..."; 
	LVBM_AR_YELL_3 			= "Rennt! Das bringt das Blut in Wallung!"; 
	LVBM_AR_GAIN_LOCUST_SWARM 	= "Anub'Rekhan bekommt 'Heuschreckenschwarm'."; 
	LVBM_AR_CAST_LOCUST_SWARM 	= "Anub'Rekhan beginnt Heuschreckenschwarm zu wirken."
	
	LVBM_SBT["Locust Swarm"]	= "Heuschreckenschwarm";
	LVBM_SBT["Locust Swarm Cast"]	= "Heuschreckenschwarm Cast";
	
	
	--Grand Widow Faerlina
	LVBM_GWF_NAME			= "Gro\195\159witwe Faerlina";
	LVBM_GWF_DESCRIPTION		= "Stellt Timer f\195\188r ihren Enrage zur Verf\195\188gung.";
	
	LVBM_GWF_ENRAGE_WARNING1	= "*** Enrage - n\195\164chster in 60 Sek ***";
	LVBM_GWF_ENRAGE_WARNING2	= "*** Enrage in ~%s Sek ***";
	LVBM_GWF_ENRAGE_CD_READY	= "*** Enrage Cooldown abgelaufen ***"
	LVBM_GWF_EMBRACE_WARNING	= "*** Umarmung der Witwe endet in %s Sek ***"

	LVBM_GWF_YELL_1			= "Ihr k\195\182nnt Euch nicht vor mir verstecken!"; 
	LVBM_GWF_YELL_2 		= "T\195\182tet sie im Namen des Meisters!"; 
	LVBM_GWF_YELL_3 		= "Flieht, solange ihr noch k\195\182nnt." --satzzeichen? ist da wirklich ein punkt? im englischen ausrufezeichen...komisch?
	LVBM_GWF_YELL_4 		= "Kniet nieder, Wurm!";
	LVBM_GWF_DEBUFF 		= "Gro\195\159witwe Faerlina ist von Umarmung der Witwe betroffen.";
	LVBM_GWF_GAIN_ENRAGE		= "Gro\195\159witwe Faerlina bekommt 'Wutanfall'.";

	LVBM_SBT["Enrage"]		= "Enrage";
	LVBM_SBT["Widow's Embrace"]	= "Umarmung der Witwe";
	
	--Maexxna
	LVBM_MAEXXNA_NAME		= "Maexxna";
	LVBM_MAEXXNA_DESCRIPTION	= "Stellt Timer f\195\188r ihr Gespinstschauer und die Spinnen Adds zur Verf\195\188gung.";
	LVBM_MAEXXNA_YELL_ON_WRAP	= "Schreien, wenn genetzt";
	
	LVBM_MAEXXNA_WEB_WRAP_YELL	= "%s ist eingenetzt. Gruppe %s.";
	LVBM_MAEXXNA_WRAP_WARNING	= "*** %s ist eingenetzt ***";
	LVBM_MAEXXNA_SPRAY_WARNING	= "*** Gespinstschauer in %s Sek ***";
	LVBM_MAEXXNA_SPIDER_WARNING	= "*** Spinnen in %s Sek ***";
	LVBM_MAEXXNA_SPIDERS_SPAWNED	= "*** Spinnen gespawned ***";
	
	LVBM_MAEXXNA_WEB_SPRAY		= "Gespinstschauer";
	LVBM_MAEXXNA_MAEXXNA		= "Maexxna";
	LVBM_MAEXXNA_WEB_WRAP_REGEXP	= "([^%s]+) (%w+) von Fangnetz betroffen.";
	
	LVBM_SBT["Web Spray"]		= "Gespinstschauer";
	LVBM_SBT["Spider Spawn"]	= "Spinnen Adds";
	
	--Gothik the Harvester
	LVBM_GOTH_NAME			= "Gothik der Seelenj\195\164ger";
	LVBM_GOTH_DESCRIPTION		= "Stellt Timer f\195\188r seine Adds zur Verf\195\188gung und sagt deren Tod an.";
	
	LVBM_GOTH_PHASE2_WARNING	= "*** Gothik inc ***";
	LVBM_GOTH_PHASE2_INC_WARNING	= "*** Phase 2 in %s %s ***";
	LVBM_GOTH_DEAD_WARNING		= "*** %s tot ***";
	LVBM_GOTH_INC_WARNING		= "*** %s in %s Sek ***";
	LVBM_GOTH_WAVE_INC_WARNING1	= "*** Welle %s/18 in 3 Sek - %s %s  ***";
	LVBM_GOTH_WAVE_INC_WARNING2	= "*** Welle %s/18 in 3 Sek - %s %s und %s %s ***";
	LVBM_GOTH_WAVE_INC_WARNING3	= "*** Welle %s/18 in 3 Sek - %s %s, %s %s and %s %s ***";
	
	LVBM_GOTH_YELL_START1		= "Ihr Narren habt euren eigenen Untergang heraufbeschworen."
	LVBM_GOTH_PHASE2_YELL		= "I have waited long enough. Now you face the harvester of souls.";
	
	LVBM_GOTH_RIDER			= "Unerbittlicher Reiter";
	LVBM_GOTH_RIDER_SHORT		= "Reiter";
	LVBM_GOTH_KNIGHT		= "Unerbittlicher Todesritter";
	LVBM_GOTH_KNIGHT_SHORT		= "Todesritter";
	LVBM_GOTH_KNIGHTS_SHORT		= "Todesritter";
	LVBM_GOTH_TRAINEE		= "Unerbittlicher Lehrling";
	LVBM_GOTH_TRAINEE_SHORT		= "Lehrlinge";
	
	LVBM_SBT["Phase 2"] 		= "Phase 2";
	LVBM_SBT["Trainees"]		= "Lehrlinge";
	LVBM_SBT["Deathknight"]		= "Todesritter";
	LVBM_SBT["Rider"]		= "Reiter";

	-- Sapphiron
	LVBM_SAPPHIRON_NAME 			= "Saphiron";
	LVBM_SAPPHIRON_INFO			= "Stellt Timer für den Sapphiron Kampf bereit.";

	LVBM_SAPPHIRON_YELL_INFO		= "Schreien wenn man zu Eis erstarrt";
	LVBM_SAPPHIRON_YELL_ANNOUNCE		= "Ich bin ein Eisblock, stellt euch hinter mich!";

	LVBM_SAPPHIRON_LIFEDRAIN_EXPR1		= "von Lebenssauger betroffen";
	LVBM_SAPPHIRON_LIFEDRAIN_EXPR2		= "Lebenssauger wurde von .+ widerstanden";
	LVBM_SAPPHIRON_LIFEDRAIN_ANNOUNCE	= "*** Lebenssauger - nächster in ~24 Sek ***";
	LVBM_SAPPHIRON_LIFEDRAIN_WARN		= "*** Lebenssauger in %d Sek ***";

	LVBM_SAPPHIRON_DEEPBREATH_EXPR		= "atmet tief ein...";
	LVBM_SAPPHIRON_DEEPBREATH_ANNOUNCE	= "*** Frostatem ***";

	LVBM_SAPPHIRON_FROSTBOLT_GAIN_EXPR	= "Ihr seid von Eisblitz betroffen";
	LVBM_SAPPHIRON_FROSTBOLT_FADE_EXPR	= "Eisblitz schwindet von Euch";

	LVBM_SAPPHIRON_ENRAGE_ANNOUNCE		= "*** Enrage in %d Sek ***";


	-- Kel'Thuzad
	LVBM_KELTHUZAD_NAME			= "Kel'Thuzad";
	LVBM_KELTHUZAD_INFO			= "Warnt vor den verschiedenen Kampfphasen und Angriffen von Kel'Thuzad.";

	LVBM_KELTHUZAD_PHASE1_EXPR		= "Diener, J\195\188nger, Soldaten der eisigen Finsternis! Folgt dem Ruf von Kel'Thuzad!";
	LVBM_KELTHUZAD_PHASE1_ANNOUNCE		= "*** Phase 1 ***";
	LVBM_KELTHUZAD_PHASE2_EXPR		= "Fleht um Gnade!";
	LVBM_KELTHUZAD_PHASE2_ANNOUNCE		= "*** Phase 2 - Kel'Thuzad kommt ***";
	LVBM_KELTHUZAD_PHASE3_EXPR		= "Meister, helft mir!";
	LVBM_KELTHUZAD_PHASE3_ANNOUNCE		= "*** Phase 3 - Wächter in ~15 sec ***";

	LVBM_KELTHUZAD_MC_EXPR1			= "Eure Seele gehört jetzt mir!";
	LVBM_KELTHUZAD_MC_EXPR2			= "Es gibt kein Entkommen!";
	LVBM_KELTHUZAD_MC_ANNOUNCE		= "*** Gedankenkontrolle ***";
	LVBM_KELTHUZAD_GUARDIAN_EXPR		= "Also gut. Erhebt euch, Krieger der eisigen Weiten! Ich befehle euch zu kämpfen, zu töten und für euren Meister zu sterben! Lasst keinen am Leben!";
	LVBM_KELTHUZAD_GUARDIAN_ANNOUNCE	= "*** Wächter in ~10 sec ***";
	LVBM_KELTHUZAD_FISSURE_EXPR		= "Kel'Thuzad wirkt Schattenspalt.";
	LVBM_KELTHUZAD_FISSURE_ANNOUNCE		= "*** Schattenspalt ***";
	LVBM_KELTHUZAD_FROSTBLAST_EXPR		= "^([^%s]+) ([^%s]+) von Frostschlag betroffen";
	LVBM_KELTHUZAD_FROSTBLAST_ANNOUNCE	= "*** Frostschlag ***";
	LVBM_KELTHUZAD_DETONATE_EXPR		= "^([^%s]+) ([^%s]+) von Detonierendes Mana betroffen";
	LVBM_KELTHUZAD_DETONATE_ANNOUNCE	= "*** Detonierendes Mana - %s ***";
	LVBM_KELTHUZAD_DETONATE_SELFWARN	= "Du bist die Bombe!";
	LVBM_KELTHUZAD_DETONATE_WHISPER		= "Du bist die Bombe! Lauf!";


	--Thaddius
	LVBM_THADDIUS_NAME			= "Thaddius";
	LVBM_THADDIUS_DESCRIPTION		= "Stellt Timer für seinen Enrage und \"Polarity Shift\" zur Verfügung.";
	LVBM_THADDIUS_WARN_NOT_CHANGED		= "Warnen auch wenn sich die Polarität nicht ändert";
	LVBM_THADDIUS_ALT_STRATEGY		= "Alternativ Strategie (zeigt rechts/links Warnungen)";
		
	LVBM_THADDIUS_ENRAGE_WARNING		= "*** Enrage in %s %s ***";
	LVBM_THADDIUS_POL_SHIFT			= "*** Polaritätsveränderung ***";
	LVBM_THADDIUS_SURGE_WARNING		= "*** Power Surge ***";
	LVBM_THADDIUS_POL_WARNING		= "*** Polaritätsveränderung in %s Sek ***";
	LVBM_THADDIUS_PHASE_2_SOON		= "*** Phase 2 in 4 Sekunden ***";
	LVBM_THADDIUS_CHARGE_CHANGED		= "Aufladung geändert zu %s!";
	LVBM_THADDIUS_CHARGE_NOT_CHANGED	= "Aufladung nicht geändert";
	LVBM_THADDIUS_RIGHT			= "Rechts!";
	LVBM_THADDIUS_LEFT			= "Links!";

	LVBM_THADDIUS_GAINS_SURGE		= "Stalagg bekommt 'Energieschub'.";
	LVBM_THADDIUS_CAST_POL			= "Thaddius beginnt Polarit\195\164tsver\195\164nderung zu wirken.";
	LVBM_THADDIUS_POL_REGEXP		= "Ihr seid von ([^%s]+) Ladung betroffen";
	LVBM_THADDIUS_YELL_START1		= "Töten...";
	LVBM_THADDIUS_YELL_START2		= "Eure... Knochen... zermalmen...";
	LVBM_THADDIUS_YELL_START3		= "Euch... zerquetschen!";
	LVBM_THADDIUS_YELL_POL			= "Jetzt spürt ihr den Schmerz...";
	LVBM_THADDIUS_ENRAGE			= "verfällt in Berserkerwut";
	LVBM_THADDIUS_TESLA_EMOTE		= " %s überädt";
	LVBM_THADDIUS_TESLA_COIL		= "Teslaspule";
	LVBM_THADDIUS_THADDIUS			= "Thaddius";
	LVBM_THADDIUS_POSITIVE			= "Positiv";
	LVBM_THADDIUS_NEGATIVE			= "Negativ";

	-- Phase1
	LVBM_THADDIUS_PHASE1_YELL1 		= "Stalagg zerquetschen!";
	LVBM_THADDIUS_PHASE1_YELL2 		= "Verfüttere euch an Meister!";
	LVBM_THADDIUS_PHASE1_ANNOUNCE		= "*** Phase 1 ***";
	LVBM_THADDIUS_SURGE_EXPR		= "Stalagg bekommt 'Energieschub'.";
	LVBM_THADDIUS_SURGE_ANNOUNCE		= "*** Energieschub für 10 Sek ***";
	LVBM_THADDIUS_THROW_ANNOUNCE		= "*** MT geworfen ***";
	LVBM_THADDIUS_THROW_ANNOUNCE_SOON	= "*** MT wird in %s Sek geworfen ***";
	LVBM_THADDIUS_PLATFORM_EXPR		= "verliert die Verbindung!";
	LVBM_THADDIUS_PLATFORM_ANNOUNCE		= "*** Warning - Add leaves the platform ***";

	LVBM_SBT["Enrage"]			= "Enrage";
	LVBM_SBT["Polarity Shift"]		= "Polaritätsveränderung";
	LVBM_SBT["Polarity Shift cast"]		= "Polaritätsveränderung Zauber";


	-- FourHorsemen
	LVBM_FOURHORSEMEN_NAME				= "Four Horsemen";
	LVBM_FOURHORSEMEN_INFO				= "Stellt Timer für den 4H Kampf zur Verfügung.";
	LVBM_FOURHORSEMEN_SHOW_5SEC_MARK_WARNING	= "Zeige 5 Sekunden Mark Warnung";

	LVBM_FOURHORSEMEN_THANE				= "Thane Korth'azz";
	LVBM_FOURHORSEMEN_LADY				= "Lady Blaumeux";
	LVBM_FOURHORSEMEN_MOGRAINE			= "Highlord Mograine";
	LVBM_FOURHORSEMEN_ZELIEK			= "Sir Zeliek";

	LVBM_FOURHORSEMEN_REAL_NAME			= "Four Horsemen";
	
	LVBM_FOURHORSEMEN_MARK_EXPR			= "von Mal von (.+) betroffen";
	LVBM_FOURHORSEMEN_MARK_ANNOUNCE			= "*** Mark #%d ***";
	LVBM_FOURHORSEMEN_MARK_WARNING			= "*** Mark #%d in 5 Sek ***";
	
	LVBM_FOURHORSEMEN_METEOR_EXPR			= "Thane Korth'azzs Meteor trifft (.+) für (%d+) Feuerschaden%.";
	LVBM_FOURHORSEMEN_METEOR_ANNOUNCE		= "*** Meteor ***";
	
	LVBM_FOURHORSEMEN_VOID_EXPR			= "Lady Blaumeux wirkt Zone der Leere.";
	LVBM_FOURHORSEMEN_VOID_ANNOUNCE			= "Zone der Leere";
	LVBM_FOURHORSEMEN_VOID_WHISPER			= "Du stehst in der 'Zone der Leere'!";
	LVBM_FOURHORSEMEN_VOID_ALLWAYS_INFO		= "Zeige immer eine Spezial Warnung bei Void Zonen";
	
	LVBM_FOURHORSEMEN_SHIELDWALL_EXPR		= "(.*) bekommt 'Schildwall'.";
	LVBM_FOURHORSEMEN_SHIELDWALL_ANNOUNCE		= "*** %s: Schildwall für 20 Sek ***";
	LVBM_FOURHORSEMEN_SHIELDWALL_FADE		= "*** Schildwall schwindet von %s ***";	

	LVBM_FOURHORSEMEN_TAUNTRESIST_INFO		= "Informiere über Spott Fehlschläge";
	LVBM_FOURHORSEMEN_TAUNTRESIST_TAUNT		= "Spott";
	LVBM_FOURHORSEMEN_TAUNTRESIST_MOKING		= "Spöttischer Schlag";
	LVBM_FOURHORSEMEN_TAUNTRESIST_CSHOUT		= "Herausforderungsruf";
	LVBM_FOURHORSEMEN_TAUNTRESIST_RESIST		= "widerstanden";
	LVBM_FOURHORSEMEN_TAUNTRESIST_PARRY		= "pariert";
	LVBM_FOURHORSEMEN_TAUNTRESIST_DODGE		= "ausgewichen";
	LVBM_FOURHORSEMEN_TAUNTRESIST_MISS		= "verfehlt";
	LVBM_FOURHORSEMEN_TAUNTRESIST_BLOCK		= "geblockt";
	LVBM_FOURHORSEMEN_TAUNTRESIST_SELFWARN		= "SPOTT FEHLGESCHLAGEN";
	LVBM_FOURHORSEMEN_TAUNTRESIST_MESSAGE		= "--> Spott fehlgeschlagen! <--";

end
