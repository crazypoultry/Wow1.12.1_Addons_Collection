
-- 1. Kurinaxx
LVBM_KURINAXX_NAME	= "Kurinaxx";

-- 2. General Rajaxx
LVBM_RAJAXX_NAME		= "General Rajaxx";
LVBM_RAJAXX_INFO		= "Warns for incoming waves and General Rajaxx.";
LVBM_RAJAXX_WAVE1_EXPR		= "They come now. Try not to get yourself killed, young blood.";
LVBM_RAJAXX_WAVE3_EXPR		= "The time of our retribution is at hand! Let darkness reign in the hearts of our enemies!";
LVBM_RAJAXX_WAVE4_EXPR		= "No longer will we wait behind barred doors and walls of stone! No longer will our vengeance be denied! The dragons themselves will tremble before our wrath!";
LVBM_RAJAXX_WAVE5_EXPR		= "Fear is for the enemy! Fear and death!";
LVBM_RAJAXX_WAVE6_EXPR		= "Staghelm will whimper and beg for his life, just as his whelp of a son did! One thousand years of injustice will end this day!";
LVBM_RAJAXX_WAVE7_EXPR		= "Fandral! Your time has come! Go and hide in the Emerald Dream and pray we never find you!";
LVBM_RAJAXX_WAVE8_EXPR		= "Impudent fool! I will kill you myself!";
LVBM_RAJAXX_WAVE_ANNOUNCE 	= "*** Wave %d/8 incoming ***";
LVBM_RAJAXX_WAVE_RAJAXX		= "*** General Rajaxx incoming ***";
LVBM_RAJAXX_KILL_EXPR		= "^Kill ([^%s]+)!";
LVBM_RAJAXX_KILL_ANNOUNCE	= "*** %s needs HEAL ***";

-- 3. Moam
LVBM_MOAM_NAME			= "Moam"
LVBM_MOAM_INFO			= "Provides a timer for Moam's Stone Form.";
LVBM_MOAM_COMBAT_START		= "%s senses your fear.";
LVBM_MOAM_STONE_ANNOUNCE_TIME	= "*** %d sec until Stone Form ***";
LVBM_MOAM_STONE_GAIN		= "%s drains your mana and turns to stone.";
LVBM_MOAM_STONE_ANNOUNCE_FADE	= "*** %d sec until Stone Form  ends ***";
LVBM_MOAM_STONE_FADE_EXPR	= "^Energize fades from Moam%.";
LVBM_MOAM_STONE_FADE_ANNOUNCE	= "*** Stone Form faded ***";

-- 4. Buru the Gorger
LVBM_BURU_NAME			= "Buru the Gorger";
LVBM_BURU_INFO 			= "Displays warnings when he watches someone.";
LVBM_BURU_WHISPER_INFO		= "Send whisper";
LVBM_BURU_WHISPER_TEXT		= "You are being watched! Run!";
LVBM_BURU_SETICON_INFO		= "Set icon";
LVBM_BURU_EYE_EXPR		= "sets eyes on ([^%s]+)!";
LVBM_BURU_EYE_ANNOUNCE 		= "*** %s is being watched ***";
LVBM_BURU_EYE_SELFWARNING	= "Your are being watched!";

-- 5. Ayamiss the Hunter
LVBM_AYAMISS_NAME		= "Ayamiss the Hunter";
LVBM_AYAMISS_INFO 		= "Displays a warning when somebody is being sacrificed.";
LVBM_AYAMISS_SACRIFICE_EXPR 	= "([^%s]+) (%w+) afflicted by Paralyze";
LVBM_AYAMISS_SACRIFICE_ANNOUNCE	= "*** %s is being sacrificed ***";

-- 6. Ossirian the Unscarred
LVBM_OSSIRIAN_NAME		= "Ossirian the Unscarred";
LVBM_OSSIRIAN_INFO		= "Displays warnings for Ossirian the Unscarred when he is weakened and supreme.";
LVBM_OSSIRIAN_CURSE_INFO	= "Announce curse";
LVBM_OSSIRIAN_CURSE_EXPR 	= "([^%s]+) is afflicted by Curse of Tongues.";
LVBM_OSSIRIAN_CURSE_ANNOUNCE	= "*** Curse - next in 25 sec ***";
LVBM_OSSIRIAN_CURSE_PREANNOUNCE	= "*** Next curse in ~5 sec ***";
LVBM_OSSIRIAN_WEAK_ANNOUNCE	= "*** %s vulnerability for 45 sec ***";
LVBM_OSSIRIAN_WEAK_EXPR		= "^Ossirian the Unscarred is afflicted by (.+) Weakness%.$";
LVBM_OSSIRIAN_WEAK_RUNOUT	= "*** Supreme Mode in %d seconds ***";
LVBM_OSSIRIAN_SUPREME_EXPR	= "Ossirian the Unscarred gains Strength of Ossirian.";
LVBM_OSSIRIAN_SUPREME_ANNOUNCE	= "*** Supreme Mode ***";
LVBM_OSSIRIAN_DEATH_EXPR	= "I...have...failed.";


-- Anubisath Guardians  (Ossirian)
LVBM_GUARDIAN_NAME 			= "Anubisath Guardians";
LVBM_GUARDIAN_INFO 			= "Warns for the Anubisath Guardians abilitys.";
LVBM_GUARDIAN_SUMMON_INFO		= "Warn on Summon (Warrior/Swarmguard)";
LVBM_GUARDIAN_THUNDERCLAP_EXPR	 	= "^Anubisath Guardian's Thunderclap hits ([^%s]+) for %d+%.";
LVBM_GUARDIAN_THUNDERCLAP_ANNOUNCE	= "*** Thunderclap ***";
LVBM_GUARDIAN_EXPLODE_EXPR	 	= "Anubisath Guardian gains Explode.";
LVBM_GUARDIAN_EXPLODE_ANNOUNCE		= "*** Explode ***";
LVBM_GUARDIAN_ENRAGE_EXPR		= "Anubisath Guardian gains Enrage.";
LVBM_GUARDIAN_ENRAGE_ANNOUNCE		= "*** Enrage ***";

LVBM_GUARDIAN_PLAGUE_EXPR		= "^([^%s]+) ([^%s]+) afflicted by Plague%.$";
LVBM_GUARDIAN_PLAGUE_ANNOUNCE		= "*** %s has the Plague ***";
LVBM_GUARDIAN_PLAGUE_WHISPER		= "You have the Plague! move away!";

LVBM_GUARDIAN_SUMMONGUARD_EXPR 		= "Anubisath .* casts Summon Anubisath Swarmguard.";
LVBM_GUARDIAN_SUMMONEDGUARD_ANNOUNCE	= "*** Swarmguard Summoned ***";
LVBM_GUARDIAN_SUMMONWARRIOR_EXPR 	= "Anubisath .* casts Summon Anubisath Warrior.";
LVBM_GUARDIAN_SUMMONEDWARRIOR_ANNOUNCE	= "*** Warrior Summoned ***";



