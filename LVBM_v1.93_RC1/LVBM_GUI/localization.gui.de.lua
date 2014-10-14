---------------------------------------------------
-- La Vendetta BossMods GUI Language File        --
-- GUI by LV|Nitram                              --
--                                               --
-- Translations by:                              --
--   LV|Nitram  -> EN                            --
--   LV|Tandanu -> DE                            --
--   LV|Tandanu -> fixed typos                   --
---------------------------------------------------

--------------------
-- Translation DE --
--------------------

if( GetLocale() == "deDE" ) then

-- LVBM_GUI.lua for Bossmod List Frame (LVBMBossModListFrame)
LVBMGUI_TAB_1_TITLE_TEXT		= "Naxxramas Boss Mods";
LVBMGUI_TAB_2_TITLE_TEXT		= "Temple von Ahn'Qiraj Boss Mods";
LVBMGUI_TAB_3_TITLE_TEXT		= "Pechschwingenhort Boss Mods";
LVBMGUI_TAB_4_TITLE_TEXT		= "Geschmolzener Kern Boss Mods";
LVBMGUI_TAB_5_TITLE_TEXT		= "Zul'Gurub und Ahn'Qiraj Boss Mods";
LVBMGUI_TAB_6_TITLE_TEXT		= "Sonstige Boss Mods";

-- Tooltips
LVBMGUI_FRAMETAB_1_TT			= "Naxxramas Boss Mods";
LVBMGUI_FRAMETAB_1_TD			= "Eine Sammlung von unseren Boss Mods f\195\188r Naxxramas. W\195\164hle einen Encounter aus um mehr Optionen zu erhalten.";
LVBMGUI_FRAMETAB_2_TT			= "Tempel von Ahn'Qiraj Boss Mods";
LVBMGUI_FRAMETAB_2_TD			= "Eine Sammlung von unseren Boss Mods f\195\188r den Tempel von Ahn'Qiraj. W\195\164hle einen Encounter aus um mehr Optionen zu erhalten.";
LVBMGUI_FRAMETAB_3_TT			= "Pechschwingenhort Boss Mods";
LVBMGUI_FRAMETAB_3_TD			= "Eine Sammlung von unseren Boss Mods f\195\188r den Pechschwingenhort. W\195\164hle einen Encounter aus um mehr Optionen zu erhalten.";
LVBMGUI_FRAMETAB_4_TT			= "Geschmolzener Kern Boss Mods";
LVBMGUI_FRAMETAB_4_TD			= "Eine Sammlung von unseren Boss Mods f\195\188r den Geschmolzenen Kern. W\195\164hle einen Encounter aus um mehr Optionen zu erhalten.";
LVBMGUI_FRAMETAB_5_TT			= "Zul'Gurub und Ruinen von Ahn'Qiraj Boss Mods";
LVBMGUI_FRAMETAB_5_TD			= "Eine Sammlung von unseren Boss Mods f\195\188r den Zul'Gurub und die Ruinen von Ahn'Qiraj. W\195\164hle einen Encounter aus um mehr Optionen zu erhalten.";

LVBMGUI_DISABLE_ADDON			= "AddOn deaktivieren";
LVBMGUI_ENABLE_ADDON			= "AddOn aktivieren";
LVBMGUI_STOP_ADDON				= "AddOn stoppen";
LVBMGUI_DISABLE_ANNOUNCE		= "Ansagen deaktivieren";
LVBMGUI_ENABLE_ANNOUNCE			= "Ansagen aktivieren";
LVBMGUI_SHOW_DROPDOWNMENU		= "Mehr Optionen";
LVBMGUI_DROPDOWNMENU_TITLE		= "Boss Mod Men\195\188";

-- LVBMBossModFrame
LVBMGUI_HIDE_OPTIONS				= "<<< Optionen";
LVBMGUI_SHOW_OPTIONS				= "Optionen >>>";

-- Options Frame (LVBMOptionsFrame)
if( LVBM.VersionBeta ) then
	LVBMGUI_OPTIONS					= "LVBM v"..LVBM.Version.." - "..LVBM.VersionBeta;
else
	LVBMGUI_OPTIONS					= "Optionen (GUI v"..LVBMGUI_VERSION.." / Boss Mod v"..LVBM.Version..")";
end
LVBMGUI_SIDEFRAME_TAB1				= "Allgemein";
LVBMGUI_SIDEFRAME_TAB2				= "Bars";
LVBMGUI_SIDEFRAME_TAB3				= "Warnungen";
LVBMGUI_SIDEFRAME_TAB4				= "Extra";
LVBMGUI_SIDEFRAME_TAB5				= "Über";

-- LVBMOptionsFramePage1
LVBMGUI_TITLE_SYNCSETTINGS			= "Synchronizations Setup";
LVBMGUI_TITLE_MINIMAPBUTTON			= "Minimap Button Setup";
LVBMGUI_TITLE_AGGROALERT			= "Aggro Alarm Einstellungen";
LVBMGUI_CHECKBOX_SYNC_ENABLE			= "Synchronization aktivieren";
LVBMGUI_BUTTON_VERSION_CHECK			= "Versions Check";
LVBMGUI_BUTTON_VERSION_CHECK_FAILD		= "Keine anderen Vendetta Boss Mods gefunden";
LVBMGUI_BUTTON_STATUSBAR_SYNCINFO		= "Status Bar Info";
LVBMGUI_BUTTON_STATUSBAR_SYNCINFO_FAILD 	= "Keine Bars gefunden.";
LVBMGUI_SLIDER_MINIMAP_1			= "Position";
LVBMGUI_SLIDER_MINIMAP_2			= "Radius";
LVBMGUI_CHECKBOX_MINIMAP			= "Minimap Button anzeigen";
LVBMGUI_CHECKBOX_AGGROALERT_ENABLE		= "Aggro Alarm aktivieren";
LVBMGUI_BUTTON_AGGROALERT_TEST			= "Aggro Alarm testen";
LVBMGUI_BUTTON_AGGROALERT_RESET			= "Einstellungen resetten";
LVBMGUI_BUTTON_AGGROALERT_RESET_DONE		= "Aggro Alarm Einstellungen erfolgreich zurückgesetzt";
LVBMGUI_CHECKBOX_AGGROALERT_PLAYSOUND		= "Sound bei Aggro abspielen";
LVBMGUI_CHECKBOX_AGGROALERT_FLASH		= "Flash bei Aggro";
LVBMGUI_CHECKBOX_AGGROALERT_SHAKE		= "Shake bei Aggro";
LVBMGUI_CHECKBOX_AGGROALERT_SPECIALTEXT		= "Special Warning anzeigen";
LVBMGUI_CHECKBOX_AGGROALERT_LOCALWARNING	= "Lokale Warnung anzeigen";
LVBMGUI_BUTTON_MOVEABLEBAR			= "Bewegbare Bar";
LVBMGUI_BUTTON_DEFAULTS				= "Standard";

-- LVBMOptionsFramePage2
LVBMGUI_TITLE_STATUSBARS 			= "Status Bar Timer Setup";
LVBMGUI_TITLE_PIZZATIMER			= "\"Pizza Timer\" erstellen";
LVBMGUI_CHECKBOX_STATUSBAR_ENABLE		= "Status Bars aktivieren";
LVBMGUI_CHECKBOX_STATUSBAR_FILLUP		= "Status Bars auffüllen";
LVBMGUI_CHECKBOX_STATUSBAR_FLIPOVER		= "Status Bars nach oben aufbauen";
LVBMGUI_EDITBOX_PIZZATIMER_TEXT			= "Name";
LVBMGUI_EDITBOX_PIZZATIMER_MIN			= "Minuten";
LVBMGUI_EDITBOX_PIZZATIMER_SEC			= "Sekunden";
LVBMGUI_CHECKBOX_PIZZATIMER_BROADCAST		= "Timer zum Raid broadcasten";
LVBMGUI_BUTTON_PIZZATIMER_START			= "Timer Starten";

-- LVBMOptionsFramePage3
LVBMGUI_TITLE_RAIDWARNING			= "Raid Warnungen";
LVBMGUI_TITLE_SELFWARNING			= "Lokale Warnungen"; 
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_1		= "RaidWarning (default Sound)";
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_2		= "BellTollNightElf (CT_Raid Sound)";
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_3		= "Sound deaktivieren";
LVBMGUI_DROPDOWN_RAIDWARNING_INFO_DISABLED	= "Raid Warnungs Sound deaktiviert";
LVBMGUI_RAIDWARNING_EXAMPLE			= "*** Beispiels Raid Warnung ***";
LVBMGUI_BUTTON_SOUND_TEST			= "Sound testen";
LVBMGUI_BUTTON_SHOW_EXAMPLE			= "Beispiel anzeigen";
LVBMGUI_BUTTON_RAIDWARNING_RESET		= "Frame resetten";
LVBMGUI_BUTTON_RAIDWARNING_RESET_DONE		= "Einstellungen erfolgreich zurückgesetzt";

-- LVBMOptionsFramePage4
LVBMGUI_TITLE_SPECIALWARNING			= "Special Warnings einstellen";
LVBMGUI_TITLE_SHAKESCREEN			= "Screen Shake Effekte einstellen";
LVBMGUI_TITLE_FLASHEFFECT			= "Flash Effekte einstellen";
LVBMGUI_CHECKBOX_SPECWARNING_ENABLE		= "Special Warnings aktivieren";
LVBMGUI_BUTTON_SPECWARNING_TEST			= "Test Warnung";
LVBMGUI_BUTTON_SPECWARNING_EXAMPLE		= "Test Nachricht :)";
LVBMGUI_SLIDER_SPECWARNING_DURATION		= "Dauer";
LVBMGUI_SLIDER_SPECWARNING_FADETIME		= "Ausblende Dauer";
LVBMGUI_SLIDER_SPECWARNING_TEXTSIZE		= "Schriftgröße";
LVBMGUI_CHECKBOX_SHAKESCREEN_ENABLE		= "Screen Shake Effekte aktivieren";
LVBMGUI_BUTTON_SHAKESCREEN_TEST			= "Shake testen";
LVBMGUI_SLIDER_SHAKESCREEN_DURATION		= "Dauer";
LVBMGUI_SLIDER_SHAKESCREEN_INTENSITY		= "Stärke";
LVBMGUI_CHECKBOX_FLASHEFFECT_ENABLE		= "Flash Effekte aktivieren";
LVBMGUI_BUTTON_FLASHEFFECT_TEST			= "Flash testen";
LVBMGUI_SLIDER_FLASHEFFECT_DURATION		= "Dauer";
LVBMGUI_SLIDER_FLASHEFFECT_FLASHES		= "Anzahl";



-- Translations added v1.05
LVBMGUI_DISTANCE_FRAME_TITLE		= "Distanz";
LVBMGUI_DISTANCE_FRAME_TEXT		= "Zu nah:";

LVBMGUI_INFOFRAME_TOOLTIP_TITLE		= "Info Frame";
LVBMGUI_INFOFRAME_TOOLTIP_TEXT		= "Rechtsklick zum Bewegen\nShift + Rechtsklick zum schließen";

LVBMGUI_STATUSBAR_WIDTH_SLIDER		= "Bar Breite";
LVBMGUI_STATUSBAR_SCALE_SLIDER		= "Bar Skalierung";

LVBMGUI_BUTTON_RANGECHECK		= "Range Check";
LVBMGUI_TOOLTIP_RANGECHECK_TITLE	= "Range Check";
LVBMGUI_TOOLTIP_RANGECHECK_TEXT		= "Startet einen Range Check der alle Spieler anzeigt, die weiter als 30 Meter von dir entfernt stehen.";

LVBMGUI_BUTTON_DISTANCEFRAME		= "Distanz Frame";
LVBMGUI_TOOLTIP_DISTANCEFRAME_TITLE	= "Distanz Frame";
LVBMGUI_TOOLTIP_DISTANCEFRAME_TEXT	= "Zeigt oder versteckt ein Distanz Check Frame, welches alle Spieler anzeigt die zu nah bei dir stehen (10 Meter). Dieses Frame ist nützlich für Encounter wie C'Thun oder Huhuran.";


-- Translations added v1.10
LVBMGUI_SIDEFRAME_TAB5				= "Sonstiges";
LVBMGUI_SIDEFRAME_TAB6				= "Über";

LVBMGUI_SLIDER_STATUSBAR_COUNT			= "Anzahl an Bars";
LVBMGUI_DROPDOWN_STATUSBAR_DESIGN_1		= "Klassisches Design";
LVBMGUI_DROPDOWN_STATUSBAR_DESIGN_2		= "Moderner Stil";
LVBMGUI_DROPDOWN_STATUSBAR_EXAMPLE_BAR		= "Beispiels Bar";

LVBMGUI_TITLE_AUTORESPOND			= "Auto beantworten Einstellungen";
LVBMGUI_CHECKBOX_AUTORESPOND_ENABLE		= "Whisper während Boss Fights automatisch beantworten";
LVBMGUI_CHECKBOX_AUTORESPOND_SHOW_WHISPERS	= "Whisper während dem Kampf anzeigen";
LVBMGUI_CHECKBOX_AUTORESPOND_INFORM_USER	= "Mich über automatisch beantwortete Whisper informieren";
LVBMGUI_CHECKBOX_AUTORESPOND_HIDE_REPLY		= "Automatische Antworten verstecken";

LVBMGUI_EDITBOX_AUTORESPOND_TITLE		= "Nachricht die während Boss Fights verschickt wird";
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_HEADER	= "Die folgenden Zeichen werden\nautomatisch ersetzt:";
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT1	= {"%P", "Dein Name"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT2	= {"%B", "Boss Name"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT3	= {"%HP", "Boss HP"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT4	= {"%ALIVE", "Lebende Raid Member"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT5	= {"%RAID", "Raid Member"};


end -- Locale



