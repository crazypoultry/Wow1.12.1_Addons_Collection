if (GetLocale() == "deDE") then
	-- 1. Lucifron
	LVBM_LUCIFRON_INFO					= "Sagt Lucifrons Fluch und Drohende Verdammnis an.";
	LVBM_LUCIFRON_CURSE_SOON_WARNING	= "*** Fluch in %s Sek ***";
	LVBM_LUCIFRON_DOOM_SOON_WARNING		= "*** Drohende Verdammnis in %s Sek ***";
	LVBM_LUCIFRON_CURSE_WARNING			= "*** Fluch - n\195\164chster in 20 Sek ***";
	LVBM_LUCIFRON_DOOM_WARNING			= "*** Drohende Verdammnis - n\195\164chste in 20 Sek ***";
	LVBM_LUCIFRON_CURSE_REGEXP			= "(%w+) ist von Lucifrons Fluch betroffen.";
	LVBM_LUCIFRON_DOOM_REGEXP			= "(%w+) ist von Drohende Verdammnis betroffen.";
	
	-- 2. Magmadar
	LVBM_MAGMADAR_INFO				= "Sagt Magmadars Fear und Frenzy an.";
	LVBM_MAGMADAR_ANNOUNCE_FRENZY	= "Frenzy ansagen";
	LVBM_MAGMADAR_FRENZY_WARNING	= "*** Frenzy ***";
	LVBM_MAGMADAR_FEAR_WARNING1		= "*** Fear - n\195\164chstes in 30 Sekunden ***";
	LVBM_MAGMADAR_FEAR_WARNING2		= "*** Fear in 5 Sek ***";
	LVBM_MAGMADAR_FRENZY 			= "%s goes into a killing frenzy!";
	LVBM_MAGMADAR_FEAR				= "(%w+) ist von Panik betroffen.";
	
	-- 3. Gehennas
	LVBM_GEHENNAS_INFO				= "Sagt Gehennas Fluch an.";
	LVBM_GEHENNAS_CURSE_SOON_WARN	= "*** Fluch in %s Sekunden ***";
	LVBM_GEHENNAS_CURSE_WARNING		= "*** Fluch - n\195\164chster in 30 Sek ***";	
	LVBM_GEHENNAS_CURSE_REGEXP		= "(%w+) ist von Gehennas Fluch betroffen.";
	
	-- 4. Garr
	-- (hmm??)
	
	-- 5. Geddon
	LVBM_BARON_INFO 			= "Sagt Geddons Lebende Bombe an.";
	LVBM_BARON_SEND_WHISPER		= "Whisper verschicken";
	LVBM_BARON_SET_ICON			= "Icon setzen";
	LVBM_BARON_BOMB_WHISPER		= "Du bist die Bombe!";
	LVBM_BARON_BOMB_WARNING    	= "*** %s ist die Bombe ***";
	LVBM_BARON_BOMB_REGEXP	 	= "([^%s]+) (%w+) von Lebende Bombe betroffen.";
	
	-- 6. Shazzrah
	LVBM_SHAZZRAH_INFO					= "Sagt Shazzrahs Fluch und Magie d\195\164mpfen  an.";
--	LVBM_SHAZZRAH_BLINK_WARN1			= "*** Blink - next in 30 sec ***";
--	LVBM_SHAZZRAH_BLINK_WARN2			= "*** Blink in %s sec ***";
	LVBM_SHAZZRAH_DEADEN_WARN			= "*** Magie d\195\164mpfen ***";
	LVBM_SHAZZRAH_CURSE_WARNING			= "*** Fluch - n\195\164chster in 20 Sek ***";
	LVBM_SHAZZRAH_CURSE_SOON_WARNING	= "*** Fluch in %s Sekunden ***";
--	LVBM_SHAZZRAH_BLINK		 			= "Shazzrah gains Blink.";
	LVBM_SHAZZRAH_DEADEN_MAGIC			= "Shazzrah bekommt 'Magie d\195\164mpfen'.";
	LVBM_SHAZZRAH_CURSE_REGEXP			= "(%w+) ist von Shazzrahs Fluch betroffen.";
	
	-- 7. Sulfuron
	-- (hmm?)
	
	-- 8. Golemagg
	-- (hmm?)
	
	-- 9. Majordomo
	LVBM_DOMO_NAME				= "Majordomus Executus";
	LVBM_DOMO_INFO 				= "Sagt sein Schadenschild und Magiereflexion an.";
	LVBM_DOMO_SHIELD_WARNING1 	= "*** %s f\195\188r 10 sec ***";
	LVBM_DOMO_SHIELD_WARNING2	= "*** %s in %s Sek ***";
	LVBM_DOMO_SHIELD_FADED		= "*** %s geschwunden ***";
	LVBM_DOMO_DAMAGE_SHIELD		= "Schadenschild";
	LVBM_DOMO_MAGIC_REFLECTION	= "Magiereflexion";
	LVBM_DOMO_GAIN_MAGIC		= "Feuerschuppen(%w+) bekommt 'Magiereflexion'.";
	LVBM_DOMO_GAIN_DAMAGE		= "Feuerschuppen(%w+) bekommt 'Schadenschild'.";
	LVBM_DOMO_FADE_MAGIC 		= "Magiereflexion schwindet von";
	LVBM_DOMO_FADE_DAMAGE	 	= "Schadenschild schwindet von";
	
	-- 10. Ragnaros
	LVBM_RAGNAROS_INFO			= "Sagt Ragnaros Zorn des Ragnaros und Untertauchen an.";
	LVBM_RAGNAROS_EMERGED		= "*** Ragnaros ist aufgetaucht - 3 Minuten bis zum Untertauchen ***";
	LVBM_RAGNAROS_SUBMERGE_WARN	= "*** Untertauchen in %s %s ***";
	LVBM_RAGNAROS_SUBMERGED		= "*** Ragnaros ist f\195\188r 90 Sekunden untergetaucht ***";
	LVBM_RAGNAROS_EMERGE_WARN	= "*** Auftauchen in %s %s ***";
	LVBM_RAGNAROS_WRATH_WARN1	= "*** Zorn des Ragnaros - n\195\164chster in 30 Sek ***";
	LVBM_RAGNAROS_WRATH_WARN2	= "*** Zorn des Ragnaros in %s Sek ***";
	LVBM_RAGNAROS_HITS			= "Ragnaros ([hitscr]+) ([^%s]+) for (%d+)";
	LVBM_RAGNAROS_WRATH	 		= "SPÜRT DIE FLAMMEN VON SULFURON!";
	LVBM_RAGNAROS_SUBMERGE 		= nil;
end