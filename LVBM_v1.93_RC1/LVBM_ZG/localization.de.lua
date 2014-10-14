if (GetLocale() == "deDE") then
	
	-- 1. High Priestess Jeklik
	LVBM_JEKLIK_INFO		= "Zeigt Warnung f\195\188r Hohepriesterin Jeklik an, wenn sie Flederm\195\164use herbeiruft oder Heilung wirkt.";
	LVBM_JEKLIK_BOMBBATS_EXPR	= "I command you to rain fire down upon these invaders!$";
	LVBM_JEKLIK_BOMBBATS_ANNOUNCE	= "*** Bomben Flederm\195\164use ***";
	LVBM_JEKLIK_CASTHEAL_EXPR	= "%s begins to cast a Great Heal!";
	LVBM_JEKLIK_CASTHEAL_ANNOUNCE	= "*** Heilung ***";
	LVBM_JEKLIK_BATS_EXPR		= "%s emits a deafening shriek!";
	LVBM_JEKLIK_BATS_ANNOUNCE	= "*** Flederm\195\164use ***";
	
	-- 2. High Priest Venoxis
	LVBM_VENOXIS_INFO		= "Sagt seinen Erneuern Buff an.";
	LVBM_VENOXIS_RENEW_EXPR		= "Hohepriester Venoxis bekommt 'Erneuern'.";
	LVBM_VENOXIS_RENEW_ANNOUNCE	= "*** Erneuern ***";
	LVBM_VENOXIS_TRANSFORM_EXPR	= "Let the coils of hate unfurl!";
	LVBM_VENOXIS_TRANSFORM_ANNOUNCE = "*** Phase 2 - auf das Gift aufpassen! ***";
	
	-- 3. High Priestess Mar'li
	LVBM_MARLI_INFO			= "Zeigt Warnungen f\195\188r Hohepriesterin Mar'lis Spinnen.";
	LVBM_MARLI_SPIDER_EXPR		= "Helft mir, meine Brut!";
	LVBM_MARLI_SPIDER_ANNOUNCE	= "*** Spinnen gespawned ***";
	
	-- Bloodlord Mandokir
	LVBM_MANDOKIR_INFO		= "Warnt Spieler, die von Blutf\195\188rst Mandokir beobachtet werden.";
	LVBM_MANDOKIR_WATCH_EXPR	= "([^%s]+)! Ich behalte Euch im Auge!";
	LVBM_MANDOKIR_WATCH_ANNOUNCE	= "*** %s wird beobachtet ***";
	LVBM_MANDOKIR_SETICON_INFO	= "Icon setzen";
	LVBM_MANDOKIR_WHISPER_INFO	= "Whisper verschicken";
	LVBM_MANDOKIR_WHISPER_TEXT	= "Du wirst beobachtet!";
	LVBM_MANDOKIR_SELFWARN		= "Du wirst beobachtet!";
	
	-- Thekal - eg heal ability
	
	-- High Priestess Arlokk
	LVBM_ARLOKK_INFO		= "Zeigt Warnungen an wenn Hohepriesterin Arlokk einen Spieler markiert.";
	LVBM_ARLOKK_MARK_EXPR		= "Labt euch an ([^%s]+), meine ([^%s]+)!";
	LVBM_ARLOKK_MARK_ANNOUNCE	= "*** %s ist markiert - heilt ihn ***";
	
	-- Hakkar
	LVBM_HAKKAR_INFO		= "Zeigt Warnungen f\195\188r Hakkars Life Drain an.";
	LVBM_HAKKAR_SUFFERLIFE_EXPR	= "Hakkar erleidet (%d+) Naturschaden von (.+) %(durch Bluttrinker%)";
	LVBM_HAKKAR_SUFFERLIFE_ANNOUNCE	= "*** %d Sek bis Life Drain ***";
	LVBM_HAKKAR_SUFFERLIFE_NOW	= "*** Life Drain - n\195\164chstes in 90 Sekunden ***";
	
	-- Jin'do the Hexxer
	LVBM_JINDO_INFO				= "Zeigt Warnungen f\195\188r Jin'do der Verhexer Fluch und Totems an.";
	LVBM_JINDO_HEAL_TOTEM_INFO		= "Heilungs Totems ansagen";
	LVBM_JINDO_MC_TOTEM_INFO		= "Mind Control Totems ansagen";
	LVBM_JINDO_CURSE_EXPR			= "([^%s]+) (%w+) von Irrbilder von Jin'do betroffen.";
	LVBM_JINDO_CURSE_SELF_ANNOUNCE		= "Du bist verflucht!";
	LVBM_JINDO_CURSE_ANNOUNCE		= "*** %s ist verflucht - nicht dispellen! ***";
	LVBM_JINDO_HEAL_TOTEM_WARNING		= "*** Heilungs Totem ***";
	LVBM_JINDO_MC_TOTEM_WARNING		= "*** Mind Control Totem ***";
	LVBM_JINDO_WHISPER_INFO			= "Whisper verschicken";
	LVBM_JINDO_WHISPER_TEXT			= "Du bist verflucht! T\195\182te die Schatten!";
	LVBM_JINDO_HEAL_TOTEM			= "Jin'do der Verhexer wirkt M\195\164chtiger Heilungszauberschutz.";
	LVBM_JINDO_MIND_CONTROL_TOTEM		= "Jin'do der Verhexer wirkt Totem der Gehirnw\195\164sche beschw\195\182ren.";

end
