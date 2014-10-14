--[[
--------------------------------------------------
	File: localization.de.lua
	Addon: Archaeologist
	Language: German
	Translation by: StarDust
	Last Update: 06/27/2006
--------------------------------------------------
]]--

Localization.RegisterAddonStrings("deDE", "Archaeologist", {

	PLAYER_GHOST 					= "Geist";
	PLAYER_WISP 					= "Verkleinert";
	PLAYER_DEAD					= "Tot";
	FEIGN_DEATH					= "Totgestellt";
	XP 						= "EP";
	HEALTH						= "Gesundheit";
	UNKNOWN						= "Unbekannt";

	ARCHAEOLOGIST_CONFIG_SEP			= "Arch\195\164ologe";
	ARCHAEOLOGIST_CONFIG_SEP_INFO			= "Einstellungen des Arch\195\164ologen";

	ARCHAEOLOGIST_FEEDBACK_STRING			= "%s ge\195\164ndert auf %s.";
	ARCHAEOLOGIST_NOT_A_VALID_FONT			= "%s ist keine g\195\188ltige Schriftart.";

	Default						= "Standard";
	GameFontNormal					= "SpielSchriftNormal";
	NumberFontNormal				= "ZahlenSchriftNormal";
	ItemTextFontNormal				= "GegenstandTextSchriftNormal";

	ARCHAEOLOGIST_ON				= "Ein";
	ARCHAEOLOGIST_OFF				= "Aus";
	ARCHAEOLOGIST_MOUSEOVER				= "Maus\195\156ber";

	ARCHAEOLOGIST_FEEDBACK_STRING			= "%s ist momentan auf %s gesetzt.";
	
	-- <= == == == == == == == == == == == == =>
	-- => Presets
	-- <= == == == == == == == == == == == == =>
	
	ARCHAEOLOGIST_CONFIG_PRESETS			= "Templates";
	ARCHAEOLOGIST_CONFIG_SET			= "Setzen";

	ARCHAEOLOGIST_CONFIG_VALUES_ON_BARS		= "Wertangaben auf den Leisten";
	ARCHAEOLOGIST_CONFIG_VALUES_NEXTTO_BARS		= "Wertangaben neben den Leisten";
	ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_BARS		= "Prozentangaben auf den Leiste";
	ARCHAEOLOGIST_CONFIG_PERCENTAGE_NEXTTO_BARS	= "Prozentangaben neben den Leiste";
	ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_VALUES_NEXTTO_BARS	= "Prozentangaben auf und\nWertangaben neben den Leiste";
	ARCHAEOLOGIST_CONFIG_VALUES_ON_PERCENTAGE_NEXTTO_BARS	= "Wertangaben auf und\nProzentangaben neben den Leiste";

	ARCHAEOLOGIST_CONFIG_PREFIXES_OFF		= "Alle Prefixe Aus";
	ARCHAEOLOGIST_CONFIG_PREFIXES_ON		= "Alle Prefixe Ein";
	ARCHAEOLOGIST_CONFIG_PREFIXES_DEFAULT		= "Alle Prefixe Standard";

	-- <= == == == == == == == == == == == == =>
	-- => Main/Player/Party/Pet/Target Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PLAYER_SEP			= "Eigenen Statusanzeige";
	ARCHAEOLOGIST_CONFIG_PARTY_SEP			= "Statusanzeigen der Gruppe";
	ARCHAEOLOGIST_CONFIG_PET_SEP			= "Statusanzeigen des Pet";
	ARCHAEOLOGIST_CONFIG_TARGET_SEP			= "Statusanzeigen des Ziels";

	ARCHAEOLOGIST_CONFIG_MAIN_SEP			= "Erfahrungs- & Rufanzeige";
	ARCHAEOLOGIST_CONFIG_PLAYER_SEP			= "Statusanzeigen des Spielers";
	ARCHAEOLOGIST_CONFIG_PARTY_SEP			= "Statusanzeigen der Gruppe";
	ARCHAEOLOGIST_CONFIG_PET_SEP			= "Statusanzeigen des Begleiters";
	ARCHAEOLOGIST_CONFIG_TARGET_SEP			= "Statusanzeigen des Ziels";
	ARCHAEOLOGIST_CONFIG_UNIT_SEP_INFO		= "Die meisten Angaben werden standardm\195\164\195\159ig angezeigt, wenn der Mauszeiger \195\188ber den entsprechenden Statusbalken bewegt wird.";
		
	ARCHAEOLOGIST_CONFIG_HP				= "Prim\195\164re Gesundheitsanzeige";
	ARCHAEOLOGIST_CONFIG_HP_INFO			= "Text der Gesundheit im Balken anzeigen. (Einstellungen: Ein, Aus, Maus\195\156ber)";
	ARCHAEOLOGIST_CONFIG_HP2			= "Sekund\195\164re Gesundheitsanzeige";
	ARCHAEOLOGIST_CONFIG_HP2_INFO			= "Text der Gesundheit neben dem Balken anzeigen. (Einstellungen: Ein, Aus, Maus\195\156ber)";
	ARCHAEOLOGIST_CONFIG_MP				= "Prim\195\164re Mana-/Wut-/Energie-Anzeige";
	ARCHAEOLOGIST_CONFIG_MP_INFO			= "Text des Mana, der Wut oder Energie im Balken anzeigen. (Einstellungen: Ein, Aus, Maus\195\156ber)";
	ARCHAEOLOGIST_CONFIG_MP2			= "Sekund\195\164re Mana-/Wut-/Energie-Anzeige";
	ARCHAEOLOGIST_CONFIG_MP2_INFO			= "Text des Mana, der Wut oder Energie neben dem Balken anzeigen. (Einstellungen: Ein, Aus, Maus\195\156ber)";
	ARCHAEOLOGIST_CONFIG_HPNOMAX			= "Maximum der Gesundheit verbergen";
	ARCHAEOLOGIST_CONFIG_HPNOMAX_INFO		= "Wenn aktiviert, wird das Maximum der Gesundheit nicht mit angezeigt sondern nur noch der momentane Wert.";
	ARCHAEOLOGIST_CONFIG_MPNOMAX			= "Maximum des Mana, Wut oder Energie verbergen";
	ARCHAEOLOGIST_CONFIG_MPNOMAX_INFO		= "Wenn aktiviert, wird das Maximum des Mana, der Wut oder Energie nicht mit angezeigt sondern nur noch der momentane Wert.";
	ARCHAEOLOGIST_CONFIG_HPVINVERT			= "Gesundheit invertieren";
	ARCHAEOLOGIST_CONFIG_HPVINVERT_INFO		= "Wenn aktiviert, wird die Anzeige der Gesundheit invertiert, sodass nicht die momentane sondern die fehlende (aufs Maximum) Gesundheit angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_HPPINVERT			= "Gesundheit in Prozent invertieren";
	ARCHAEOLOGIST_CONFIG_HPPINVERT_INFO		= "Wenn aktiviert, wird die Anzeige der Gesundheit in Prizent invertiert, sodass nicht die momentane sondern die fehlende (aufs Maximum) Gesundheit angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_MPVINVERT			= "Mana, Wut und Energie invertieren";
	ARCHAEOLOGIST_CONFIG_MPVINVERT_INFO		= "Wenn aktiviert, wird die Anzeige des Mana, Wut oder Energie invertiert, sodass nicht die momentane sondern die fehlende (aufs Maximum) Mana, Wut oder Energie angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_MPPINVERT			= "Mana, Wut und Energie in Prozent invertieren";
	ARCHAEOLOGIST_CONFIG_MPPINVERT_INFO		= "Wenn aktiviert, wird die Anzeige des Mana, Wut oder Energie in Prizent invertiert, sodass nicht die momentane sondern die fehlende (aufs Maximum) Mana, Wut oder Energie angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_HPNOPREFIX			= "Prefix 'Gesundheit' verbergen";
	ARCHAEOLOGIST_CONFIG_HPNOPREFIX_INFO		= "Wenn aktiviert, wird der Prefix 'Gesundheit' bei der Anzeige im Gesundheitsbalken ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_MPNOPREFIX			= "Prefix 'Mana', 'Wut' oder 'Energie' verbergen";
	ARCHAEOLOGIST_CONFIG_MPNOPREFIX_INFO		= "Wenn aktiviert, wird der Prefix 'Mana', 'Wut' oder 'Energie' bei der Anzeige im zweiten Balken (unter Gesundheit) ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_XPNOPREFIX			= "Prefix 'Erfahrung' verbergen";
	ARCHAEOLOGIST_CONFIG_XPNOPREFIX_INFO		= "Wenn aktiviert, wird der Prefix 'Erfahrung' im Erfahrungssbalken ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_CLASSICON			= "Klassen-Icon anzeigen";
	ARCHAEOLOGIST_CONFIG_CLASSICON_INFO		= "Wenn aktiviert, wird im Charakterfenster ein Icon gem\195\164\195\159 der Klasse des Spielers angezeigt.";
	ARCHAEOLOGIST_CONFIG_HPSWAP			= "Position der Gesundheitsanzeigen vertauschen";
	ARCHAEOLOGIST_CONFIG_HPSWAP_INFO		= "Wenn aktiviert, werden die Angaben der Gesundheit innerhalb und rechts neben den jeweiligen Balken (Prim\195\164r und Sekund\195\164r) vertauscht.";
	ARCHAEOLOGIST_CONFIG_MPSWAP			= "Position der Mana-, Wut- oder Energie-Anzeige vertauschen";
	ARCHAEOLOGIST_CONFIG_MPSWAP_INFO		= "Wenn aktiviert, werden die Angaben von Mana, Wut oder Energie innerhalb und rechts neben den jeweiligen Balken (Prim\195\164r und Sekund\195\164r) vertauscht.";

	ARCHAEOLOGIST_CONFIG_XP				= "Erfahrungsanzeige";
	ARCHAEOLOGIST_CONFIG_XP_INFO			= "Wenn aktiviert, wird die Erfahrung am Balken angezeigt. (Einstellungen: Ein, Aus, Maus\195\156ber)";
	ARCHAEOLOGIST_CONFIG_REP			= "Rufanzeige";
	ARCHAEOLOGIST_CONFIG_REP_INFO			= "Wenn aktiviert, wird der Ruf am Balken angezeigt. (Einstellungen: Ein, Aus, Maus\195\156ber)";
	ARCHAEOLOGIST_CONFIG_XPNOMAX			= "Maximalen Erfahrungswert nicht anzeigen";
	ARCHAEOLOGIST_CONFIG_XPNOMAX_INFO		= "Wenn aktiviert, wird der maximale Erfahrungswert im momentanen Level nicht angezeigt.";
	ARCHAEOLOGIST_CONFIG_REPNOMAX			= "Maximale Rufpunkte nicht anzeigen";
	ARCHAEOLOGIST_CONFIG_REPNOMAX_INFO		= "Wenn aktiviert, werden die maximalen Rufpunkte auf der momentanen Rufstufe nicht angezeigt.";
	ARCHAEOLOGIST_CONFIG_XPP			= "Erfahrung in Prozent anzeigen";
	ARCHAEOLOGIST_CONFIG_XPP_INFO			= "Wenn aktiviert, wird die Erfahrung am Balken in Prozent angezeigt.";
	ARCHAEOLOGIST_CONFIG_REPP			= "Ruf in Prozent anzeigen";
	ARCHAEOLOGIST_CONFIG_REPP_INFO			= "Wenn aktiviert, wird dder Ruf am Balken in Prozent angezeigt.";
	ARCHAEOLOGIST_CONFIG_XPV			= "Erfahrung als Wert anzeigen";
	ARCHAEOLOGIST_CONFIG_XPV_INFO			= "Wenn aktiviert, wird die Erfahrung am Balken als genauer Zahlenwert angezeigt.";
	ARCHAEOLOGIST_CONFIG_REPV			= "Ruf als Wert anzeigen";
	ARCHAEOLOGIST_CONFIG_REPV_INFO			= "Wenn aktiviert, wird der Ruf am Balken als genauer Zahlenwert angezeigt.";
	ARCHAEOLOGIST_CONFIG_XPPINVERT			= "Erfahrung in Prozent bis Levelaufstieg anzeigen";
	ARCHAEOLOGIST_CONFIG_XPPINVERT_INFO		= "Wenn aktiviert, wird die Erfahrung in Prozent bis zum Levelaufstieg angezeigt und nicht die momentane.";
	ARCHAEOLOGIST_CONFIG_REPPINVERT			= "Ruf in Prozent bis n\195\164chste Rufstufe anzeigen";
	ARCHAEOLOGIST_CONFIG_REPPINVERT_INFO		= "Wenn aktiviert, wird der Ruf in Prozent bis bis zur n\195\164chste Rufstufe angezeigt und nicht der momentane.";
	ARCHAEOLOGIST_CONFIG_XPVINVERT			= "Erfahrung als Wert bis Levelaufstieg anzeigen";
	ARCHAEOLOGIST_CONFIG_XPVINVERT_INFO		= "Wenn aktiviert, wird die Erfahrung als genauer Zahlenwert bis zum Levelaufstieg angezeigt und nicht die momentane.";
	ARCHAEOLOGIST_CONFIG_REPVINVERT			= "Ruf als Wert bis n\195\164chste Rufstufe anzeigen";
	ARCHAEOLOGIST_CONFIG_REPVINVERT_INFO		= "Wenn aktiviert, wird der Ruf als genauer Zahlenwert bis bis zur n\195\164chste Rufstufe angezeigt und nicht der momentane.";
	ARCHAEOLOGIST_CONFIG_XPNOPREFIX			= "Prefix 'Erfahrung' verbergen";
	ARCHAEOLOGIST_CONFIG_XPNOPREFIX_INFO		= "Wenn aktiviert, wird der Prefix 'Erfahrung' im Balken ausgeblendet und nur noch der Wert angezeigt.";
	ARCHAEOLOGIST_CONFIG_REPNOPREFIX		= "Prefix 'Fraktion' verbergen";
	ARCHAEOLOGIST_CONFIG_REPNOPREFIX_INFO		= "Wenn aktiviert, wird der Name der Fraktion im Rufbalken ausgeblendet und nur noch die Werte angezeigt.";


	-- <= == == == == == == == == == == == == =>
	-- => Alternate Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP		= "Sonstige Einstellungen";
	ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP_INFO		= "Sonstige Einstellungen";

	ARCHAEOLOGIST_CONFIG_HPCOLOR			= "Farbwechsel des Gesundheitsbalken aktivieren";
	ARCHAEOLOGIST_CONFIG_HPCOLOR_INFO		= "Wenn aktiviert, \195\164ndert der Gesundheitsbalken seine Farbe je weniger Gesundheit vorhanden ist.";

	ARCHAEOLOGIST_CONFIG_DEBUFFALT			= "Alternative Position der Debufficons";
	ARCHAEOLOGIST_CONFIG_DEBUFFALT_INFO		= "Wenn aktiviert, werden Debufficons des Pet und von Gruppenmitgliedern unter deren Bufficons angezeigt. Standardm\195\164\195\159ig werden jene neben dem jeweiligen Portraitfenster angezeigt.";

	ARCHAEOLOGIST_CONFIG_TBUFFALT			= "Buff-/Debuff-Icons in nur einer Reihen anordnen";
	ARCHAEOLOGIST_CONFIG_TBUFFALT_INFO		= "Wenn aktiviert, werden die Buff- und Debufficons des Ziels in nur jeweils einer Reihen mit maximal 16 Icons angeordnet und nicht in zwei zu jeweils 8.";

	ARCHAEOLOGIST_CONFIG_THPALT				= "Gesundheit des Ziels als Wert verbergen, wenn nicht verf\195\188gbar";
	ARCHAEOLOGIST_CONFIG_THPALT_INFO		= "Wenn aktiviert, wird die Anzeige der Gesundheit als Wert unterdr\195\188ckt wenn der richtige Wert nicht verf\195\188gbar ist. Standard: Anzeige in Prozent.";
	
	ARCHAEOLOGIST_CONFIG_MOBHEALTH			= "MobHealth2 f\195\188r Gesundheitsanzeige des Ziels verwenden";
	ARCHAEOLOGIST_CONFIG_MOBHEALTH_INFO		= "Verbirgt den normalen MobHealth2 Text und verwendet jenen anstelle des Textes f\195\188r die Gesundheitsanzeige im Zielfenster.";

	ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT		= "Klassenportrait verwenden";
	ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT_INFO		= "Wenn aktiviert, wird wenn m\195\182glich das Charakterportrait mit dem Klassenicon ersetzt.";

	-- <= == == == == == == == == == == == == =>
	-- => Font Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP		= "Schriftart Einstellungen";
	ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP_INFO		= "Erlaubt es die Schriftart und -gr\195\182\195\159e der Statustexte in den Balken festzulegen.";

	ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE		= "Schriftgr\195\182\195\159e des\nEigenen-/Ziel-Portraits";
	ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE_SLIDERTEXT   = "Schriftgr\195\182\195\159e";

	ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT		= "Schriftart des\nEigenen-/Ziel-Portraits";
	ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT_INFO		= "Schriftart des\nEigenen-/Ziel-Portraits";

	ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE		= "Schriftgr\195\182\195\159e des\nGruppen-/Pet-Portraits";
	ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE_SLIDERTEXT   = "Schriftgr\195\182\195\159e";

	ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT		= "Schriftart des\nGruppen-/Pet-Portraits";
	ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT_INFO		= "Schriftart des\nGruppen-/Pet-Portraits";

	ARCHAEOLOGIST_COLOR_CHANGED			= "|c%s%s Farbe ge\195\164ndert.|r";
	ARCHAEOLOGIST_COLOR_RESET			= "|c%s%s Farbe zur\195\188ckgesetzt.|r";

	ARCHAEOLOGIST_CONFIG_COLORPHP			= "Prim\195\164re Farbe der Gesundheit\n(Standard ist wei\195\159)";
	ARCHAEOLOGIST_CONFIG_COLORPHP_INFO		= "\195\132ndert die Farbe der prim\195\164ren Gesundheitsangabe.";
	ARCHAEOLOGIST_CONFIG_COLORPHP_RESET		= "Farbe zur\195\188cksetzen";
	ARCHAEOLOGIST_CONFIG_COLORPHP_RESET_INFO	= "Setzt die Farbe der prim\195\164ren Gesundheitsangabe zur\195\188ck.";

	ARCHAEOLOGIST_CONFIG_COLORPMP			= "Prim\195\164re Farbe des Mana, Wut oder Energie\n(Standard ist wei\195\159)";
	ARCHAEOLOGIST_CONFIG_COLORPMP_INFO		= "\195\132ndert die Farbe der prim\195\164ren Mana-,Wut,Energieangabe.";
	ARCHAEOLOGIST_CONFIG_COLORPMP_RESET		= "Farbe zur\195\188cksetzen";
	ARCHAEOLOGIST_CONFIG_COLORPMP_RESET_INFO	= "Setzt die Farbe der prim\195\164ren Mana-,Wut-,Energieangabe zur\195\188ck.";

	ARCHAEOLOGIST_CONFIG_COLORSHP			= "Sekund\195\164re Farbe der Gesundheit\n(Standard ist wei\195\159)";
	ARCHAEOLOGIST_CONFIG_COLORSHP_INFO		= "\195\132ndert die Farbe der sekund\195\164ren Gesundheitsangabe.";
	ARCHAEOLOGIST_CONFIG_COLORSHP_RESET		= "Farbe zur\195\188cksetzen";
	ARCHAEOLOGIST_CONFIG_COLORSHP_RESET_INFO	= "Setzt die Farbe der sekund\195\164ren Gesundheitsangabe zur\195\188ck.";

	ARCHAEOLOGIST_CONFIG_COLORSMP			= "Sekund\195\164re Farbe des Mana, Wut oder Energie\n(Standard ist wei\195\159)";
	ARCHAEOLOGIST_CONFIG_COLORSMP_INFO		= "\195\132ndert die Farbe der sekund\195\164ren Mana-,Wut,Energieangabe";
	ARCHAEOLOGIST_CONFIG_COLORSMP_RESET		= "Farbe zur\195\188cksetzen";
	ARCHAEOLOGIST_CONFIG_COLORSMP_RESET_INFO	= "Setzt die Farbe der sekund\195\164ren Mana-,Wut-,Energieangabe zur\195\188ck.";

	-- <= == == == == == == == == == == == == =>
	-- => Party Buff Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP		= "Buff-Einstellungen der Gruppe";
	ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP_INFO	= "Standardm\195\164\195\159ig werden 16 Bufficons und 16 Debufficons angezeigt.";

	ARCHAEOLOGIST_CONFIG_PBUFFS			= "Buffs von Gruppenmitgliedern verbergen";
	ARCHAEOLOGIST_CONFIG_PBUFFS_INFO		= "Wenn aktiviert, werden Buffs von Gruppenmitgliedern nur angezeigt wenn man den Mauszeiger \195\188ber deren Portraitfenster bewegt.";

	ARCHAEOLOGIST_CONFIG_PBUFFNUM			= "Anzahl der angezeigten Buffs";
	ARCHAEOLOGIST_CONFIG_PBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Buffs von Gruppenmitgliedern fest.";
	ARCHAEOLOGIST_CONFIG_PBUFFNUM_SLIDER_TEXT	= "Buffs";

	ARCHAEOLOGIST_CONFIG_PDEBUFFS			= "Debuffs von Gruppenmitgliedern verbergen";
	ARCHAEOLOGIST_CONFIG_PDEBUFFS_INFO		= "Wenn aktiviert, werden Debuffs von Gruppenmitgliedern nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_PDEBUFFNUM			= "Anzahl der angezeigten Debuffs";
	ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Debuffs von Gruppenmitglied fest.";
	ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_SLIDER_TEXT	= "Debuffs";

	-- <= == == == == == == == == == == == == =>
	-- => Party Pet Buff Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP		= "Buff-Einstellungen der Pets der Gruppe";
	ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP_INFO	= "Standardm\195\164\195\159ig werden 16 Bufficons und 16 Debufficons angezeigt.";

	ARCHAEOLOGIST_CONFIG_PPTBUFFS			= "Buffs der Pets von Gruppenmitgliedern verbergen";
	ARCHAEOLOGIST_CONFIG_PPTBUFFS_INFO		= "Wenn aktiviert, werden Buffs der Pets von Gruppenmitgliedern nur angezeigt wenn man den Mauszeiger \195\188ber deren Portraitfenster bewegt.";

	ARCHAEOLOGIST_CONFIG_PPTBUFFNUM			= "Anzahl der angezeigten Buffs";
	ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Buffs von Pets der Gruppenmitglieder fest.";
	ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_SLIDER_TEXT	= "Buffs";

	ARCHAEOLOGIST_CONFIG_PPTDEBUFFS			= "Debuffs der Pets von Gruppenmitgliedern verbergen";
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFS_INFO		= "Wenn aktiviert, werden Debuffs der Pets von Gruppenmitgliedern nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM		= "Anzahl der angezeigten Debuffs";
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Debuffs von Pets der Gruppenmitglieder fest.";
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_SLIDER_TEXT	= "Debuffs";

	-- <= == == == == == == == == == == == == =>
	-- => Pet Buff Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP		= "Buff-Einstellungen des Pet";
	ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP_INFO		= "Standardm\195\164\195\159ig werden 16 Bufficons und 4 Debufficons angezeigt.";

	ARCHAEOLOGIST_CONFIG_PTBUFFS			= "Buffs des Pet verbergen";
	ARCHAEOLOGIST_CONFIG_PTBUFFS_INFO		= "Wenn aktiviert, werden Buffs des Pet nur angezeigt wenn man den Mauszeiger \195\188ber dessen Portraitfenster bewegt.";

	ARCHAEOLOGIST_CONFIG_PTBUFFNUM			= "Anzahl der angezeigten Buffs";
	ARCHAEOLOGIST_CONFIG_PTBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Buffs des Pet fest.";
	ARCHAEOLOGIST_CONFIG_PTBUFFNUM_SLIDER_TEXT	= "Buffs";

	ARCHAEOLOGIST_CONFIG_PTDEBUFFS			= "Debuffs des Pet verbergen";
	ARCHAEOLOGIST_CONFIG_PTDEBUFFS_INFO		= "Wenn aktiviert, werden Debuffs des Pet nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM		= "Anzahl der angezeigten Debuffs";
	ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Debuffs des Pet fest.";
	ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_SLIDER_TEXT	= "Debuffs";

	-- <= == == == == == == == == == == == == =>
	-- => Target Buff Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP		= "Buff-Einstellungen des Ziels";
	ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP_INFO	= "Standardm\195\164\195\159ig werden 8 Bufficons und 16 Debufficons angezeigt.";

	ARCHAEOLOGIST_CONFIG_TBUFFS			= "Buffs des Ziels verbergen";
	ARCHAEOLOGIST_CONFIG_TBUFFS_INFO		= "Wenn aktiviert, werden Buffs des angew\195\164hlten Ziels nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_TBUFFNUM			= "Anzahl der angezeigten Buffs";
	ARCHAEOLOGIST_CONFIG_TBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Buffs des angew\195\164hlten Ziels fest.";
	ARCHAEOLOGIST_CONFIG_TBUFFNUM_SLIDER_TEXT	= "Buffs";

	ARCHAEOLOGIST_CONFIG_TDEBUFFS			= "Debuffs des Ziels verbergen";
	ARCHAEOLOGIST_CONFIG_TDEBUFFS_INFO		= "Wenn aktiviert, werden Debuffs des angew\195\164hlten Ziels nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_TDEBUFFNUM			= "Anzahl der angezeigten Debuffs";
	ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Debuffs des angew\195\164hlten Ziels fest.";
	ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_SLIDER_TEXT	= "Debuffs";

})