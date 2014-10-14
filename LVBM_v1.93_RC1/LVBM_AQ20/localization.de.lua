-- http://www.allegro-c.de/unicode/zcodes.htm
--
-- ‰ = \195\164
-- ƒ = \195\132
-- ˆ = \195\182
-- ÷ = \195\150
-- ¸ = \195\188
-- ‹ = \195\156
-- ﬂ = \195\159



if (GetLocale() == "deDE") then
	-- 1. Kurinaxx (hmm?)

	-- 2. General Rajaxx
	LVBM_RAJAXX_INFO		= "Zeigt Warnungen f\195\188r die Gegner Wellen des General Rajaxx.";
	LVBM_RAJAXX_WAVE1_EXPR		= "Hier kommen sie. Bleibt am Leben, Welpen.";
	LVBM_RAJAXX_WAVE3_EXPR		= "Die Zeit der Vergeltung ist gekommen";
	LVBM_RAJAXX_WAVE4_EXPR		= "Wir werden nicht l\195\164nger";
	LVBM_RAJAXX_WAVE5_EXPR		= "Wir kennen keine Furcht";
	LVBM_RAJAXX_WAVE6_EXPR		= "Staghelm wird winseln und um sein Leben betteln";
	LVBM_RAJAXX_WAVE7_EXPR		= "Fandral! Deine Zeit ist gekommen";
	LVBM_RAJAXX_WAVE8_EXPR		= "Unversch\195\164mter Narr! Ich werde Euch";
	LVBM_RAJAXX_WAVE_ANNOUNCE 	= "*** Welle %d/8 kommt nun ***";
	LVBM_RAJAXX_WAVE_RAJAXX		= "*** General Rajaxx kommt nun ***";
	LVBM_RAJAXX_KILL_EXPR		= "T\195\182te ([^%s]+)!";
	LVBM_RAJAXX_KILL_ANNOUNCE	= "*** %s braucht heilung ***";

	-- 3. Moam
	LVBM_MOAM_INFO			= "Zeigt Warnungen f\195\188r die Phasen von Moam an.";
	LVBM_MOAM_COMBAT_START		= "%s sp\195\188rt Eure Angst.";
	LVBM_MOAM_STONE_ANNOUNCE_TIME	= "*** %d Sek bis zur Steinform ***";
	LVBM_MOAM_STONE_GAIN		= "%s entzieht Euch Euer Mana und versteinert Euch.";
	LVBM_MOAM_STONE_ANNOUNCE_FADE	= "*** %d Sek bis zum Steinform ende ***";
	LVBM_MOAM_STONE_FADE_EXPR	= "Energiezufuhr schwindet von Moam.";
	LVBM_MOAM_STONE_FADE_ANNOUNCE	= "*** Steinform schwindet ***";

	-- 4. Buru the Gorger
	LVBM_BURU_INFO 			= "Zeigt Warnungen wenn Buru jemanden beobachtet.";
	LVBM_BURU_WHISPER_INFO		= "Fl\195\188stere dem Spieler";
	LVBM_BURU_WHISPER_TEXT		= "Du wirst beobachtet! Lauf!";
	LVBM_BURU_SETICON_INFO		= "Setze Schlachtzug Symbol";
	LVBM_BURU_EYE_EXPR		= "beh\195\164lt (.+) im Blickfeld!";
	LVBM_BURU_EYE_ANNOUNCE 		= "*** %s wird beobachtet ***";
	LVBM_BURU_EYE_SELFWARNING	= "Du wirst beobachtet!";
	
	-- 5. Ayamiss the Hunter
	LVBM_AYAMISS_INFO 		= "Zeigt Warnungen wenn jemand von Ayamiss dem Hunter geopfert wird.";
	LVBM_AYAMISS_SACRIFICE_EXPR 	= "([^%s]+) (%w+) von Paralisieren betroffen.";
	LVBM_AYAMISS_SACRIFICE_ANNOUNCE	= "*** %s wird geopfert ***";

	-- 6. Ossirian the Unscarred
	LVBM_OSSIRIAN_INFO		= "Zeigt Warnungen wenn Ossiran geschw\195\164cht oder gest\195\164rkt wird.";
	LVBM_OSSIRIAN_CURSE_INFO	= "Fluch Ank\195\188ndigen";
	LVBM_OSSIRIAN_CURSE_EXPR 	= "([^%s]+) is von Fluch der Zungen betroffen.";
	LVBM_OSSIRIAN_CURSE_ANNOUNCE	= "*** Fluch - n\195\164chster in 25 sek ***";
	LVBM_OSSIRIAN_CURSE_PREANNOUNCE	= "*** Fluch in etwa 5 sec ***";
	LVBM_OSSIRIAN_WEAK_ANNOUNCE	= "*** %s verwundbarkeit for 45 sek ***";
	LVBM_OSSIRIAN_WEAK_EXPR		= "Ossirian der Narbenlose ist von (.*)schw\195\164che betroffen.";
	LVBM_OSSIRIAN_WEAK_RUNOUT	= "*** St\195\164rke des Ossirian in %d seconds ***";
	LVBM_OSSIRIAN_SUPREME_EXPR	= "Ossirian der Narbenlose bekommt 'St\195\164rke des Ossirian'.";
	LVBM_OSSIRIAN_SUPREME_ANNOUNCE	= "*** St\195\164rke des Ossirian ***";
	LVBM_OSSIRIAN_DEATH_EXPR	= "Ich... habe... versagt.";


	-- Anubisath Guardians  (Ossirian)
	LVBM_GUARDIAN_INFO 			= "Zeigt Warnungen f√ºr die F√§higkeiten der Anubisath W√§chter.";
	LVBM_GUARDIAN_SUMMON_INFO		= "Warnung wenn Krieger/Schwarmwachen beschworen werden";
	LVBM_GUARDIAN_THUNDERCLAP_EXPR	 	= "Besch√ºtzer des Anubisath's Donnerknall trifft (.*) f√ºr (%d) .*";
	LVBM_GUARDIAN_THUNDERCLAP_ANNOUNCE	= "*** Donnerknall ***";
	LVBM_GUARDIAN_EXPLODE_EXPR	 	= "Besch√ºtzer des Anubisath bekommt 'Explodieren'.";
	LVBM_GUARDIAN_EXPLODE_ANNOUNCE		= "*** Explodieren ***";
	LVBM_GUARDIAN_ENRAGE_EXPR		= "Besch√ºtzer des Anubisath bekommt 'Wutanfall'.";
	LVBM_GUARDIAN_ENRAGE_ANNOUNCE		= "*** Wutanfall ***";

	LVBM_GUARDIAN_PLAGUE_EXPR		= "^([^%s]+) ([^%s]+) von Seuche betroffen%.";
	LVBM_GUARDIAN_PLAGUE_ANNOUNCE		= "*** %s hat die Seuche ***";
	LVBM_GUARDIAN_PLAGUE_WHISPER		= "Du hast die Seuche! lauf weg!";

	LVBM_GUARDIAN_SUMMONGUARD_EXPR 		= "Besch√ºtzer des Anubisath wirkt Schwarmwache des Anubisath beschw√∂ren.";
	LVBM_GUARDIAN_SUMMONEDGUARD_ANNOUNCE	= "*** Swarmguard Summoned ***";
	LVBM_GUARDIAN_SUMMONWARRIOR_EXPR 	= "Besch√ºtzer des Anubisath wirkt Krieger des Anubisath beschw√∂ren.";
	LVBM_GUARDIAN_SUMMONEDWARRIOR_ANNOUNCE	= "*** Warrior Summoned ***";

end

