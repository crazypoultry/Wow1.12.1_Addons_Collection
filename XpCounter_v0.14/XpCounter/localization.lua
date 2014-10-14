-- Localisation for XpBar (def. locale is English)
-- Contibute your localisations to brutus@ainfos.de
--
-- à(Ã ) á(Ã¡) â(Ã¢) ã(Ã£) ä(Ã¤) æ(Ã¦) ç(Ã§) è(Ã¨) é(Ã©) ê(Ãª) ë(Ã«) î(Ã®) ï(Ã¯) ò(Ã²) ó(Ã³) ô(Ã´) õ(Ãµ) ö(Ã¶) ù(Ã¹) ú(Ãº) û(Ã») ü(Ã¼) '(â€™)
-- 
-- deDE - Thugz [IDF]

if (GetLocale() == "deDE") then

	XpCounter_msg_Loaded = "XpCounter v%s [%s] geladen (/xpcounter)."
	XpCounter_msg_CreateProfile = "Neues Profil erstellt (%s)."
	XpCounter_msg_UpdateProfile = "Profil aktualisiert (%s)."
	XpCounter_msg_DeleteOldProfile = "Altes Profil gelÃ¶scht (%s)."
	XpCounter_msg_Time = "Bewertete Spielzeit bislang: %s Stunden %s Minuten."
	XpCounter_msg_Cmd_Show = "Fenster wird jetzt angezeigt."
	XpCounter_msg_Cmd_Hide = "Fenster wird nicht mehr angezeigt."
	XpCounter_msg_Cmd_Lock = "Fenster ist gesperrt."
	XpCounter_msg_Cmd_Unlock = "Fenster wird nicht mehr gesperrt."
	XpCounter_msg_Cmd_Reset = "XP ZÃ¤hler wurde zurÃ¼ckgesetzt."
	XpCounter_msg_Cmd_Update = "Daten wurden aktualisiert."
	XpCounter_msg_Cmd_Tooltip_on = "Tooltip wird angezeigt."
	XpCounter_msg_Cmd_Tooltip_off = "Tooltip Anzeige ausgestellt."
	XpCounter_msg_Cmd_Overlay_Tooltip_on = "Tooltip wird fÃ¼r's Overlay angezeigt."
	XpCounter_msg_Cmd_Overlay_Tooltip_off = "Tooltip Anzeige fÃ¼r's Overlay deaktiviert."
	XpCounter_msg_Cmd_Anchor_Overerlay_Tooltip_on = "Overlay Tooltip verankert."
	XpCounter_msg_Cmd_Anchor_Overerlay_Tooltip_off = "Overlay Tooltip nicht verankert."
	XpCounter_msg_Cmd_Anchor_Overerlay_SetText = "Overlay Text gesetzt: %s"
	
	-- xp, xpmax, xpproc, xpleft, xprest, hours, minutes, xpcount, epm, kills, avg_kill_xp, kills_left, lvlup_hours, lvlup_minutes
	
	XpCounter_msg_ToolTip = "|cffffcc00XpBar\n\n|cff888888XP: |cffffffff%s |cff888888von |cffffffff%s |cff888888(|cffffffff%s |cff888888%%)\n|cff888888XP zum Aufstieg: |cffffcc00%s\n|cff888888Bonus XP: |cffffffff%s\n\n|cff888888Zeit: |cffffffff%s |cff888888Stunden |cffffffff%s |cff888888Minuten\n|cff888888XP gesammt: |cffffffff%s\n|cff888888EPH / EPM: |cffffcc00%s |cff888888/ |cffffcc00%s\n\n|cff888888Kills: |cffffffff%s |cff888888(ca |cffffffff%s |cff888888XP pro Kill)\n|cff888888Kills bis LevelUp: |cffffcc00%s\n\n|cff888888Zeit bis LevelUp: ~ |cffffffff%s |cff888888Stunden |cffffffff%s |cff888888Minuten"
	
	XpCounter_msg_Help = { "Kommandos (|cffffcc00/xpc |cff666666KOMMANDO|cffffffff):" , 
						   "[show] XP Fenster anzeigen", 
						   "[hide] XP Fenster ausblenden",
						   "[lock] XP Fenster sperren", 
						   "[unlock] XP Fenster entsperren",
						   "[reset] XP und ZeitzÃ¤hler zurÃ¼cksetzen",
						   "[update] Berechnet alle Angaben neu.",
						   "[tooltip_show] Anzeige des Tooltips fÃ¼r die XP Leiste an/aus.",
						   "[tooltip_show_overlay] Anzeige des Tooltips fÃ¼r's Overlay an/aus.",
						   "[tooltip_anchor_overlay] Tooltip an den Mauszeiger binden.",
						   "[set_overlay_text] (|cff888888sot|cffffffff) Setzt das Overlay-Format.",
						   "[set_overlay_text_help] (|cff888888sot_help|cffffffff) Zeigt Hilfe zur Overlayformatierung an."
						 }
	
	XpCounter_msg_Help_Format_Overlay = {	"[xp_act] Aktuelle XP ", 
											"[xp_max] Max XP auf diesem Level", 
											"[xp_perc] XP bis zum LevelUp in Prozent", 
											"[xp_left] XP bis zum LevelUp", 
											"[xp_rested] Bonus XP", 
											"[xp] gesammelte XP", 
											"[time_played] gespielte Zeit", 
											"[time_left] Geschätzte Zeit bis zum LevelUp", 
											"[eph] XP pro Stunde", 
											"[epm] XP pro Minute"
										}

else

	XpCounter_msg_Loaded = "XpCounter v%s [%s] loaded (/xpcounter)."
	XpCounter_msg_Time = "Accounted Playtime so far: %s Hours %s Minutes."
	XpCounter_msg_CreateProfile = "New Profile created (%s)."
	XpCounter_msg_UpdateProfile = "Profile updated (%s)."
	XpCounter_msg_DeleteOldProfile	= "Old Profile deleted (%s)."
	XpCounter_msg_Cmd_Show = "OSD visible."
	XpCounter_msg_Cmd_Hide = "OSD hidden."
	XpCounter_msg_Cmd_Lock = "OSD locked."
	XpCounter_msg_Cmd_Unlock = "OSD unlocked."
	XpCounter_msg_Cmd_Reset = "Reset XP counter."
	XpCounter_msg_Cmd_Update = "Update successful."
	XpCounter_msg_Cmd_Tooltip_on = "Show Tooltip: ON"
	XpCounter_msg_Cmd_Tooltip_off = "Show Tooltip: OFF"	
	XpCounter_msg_Cmd_Overlay_Tooltip_on = "Display Tooltip for overlay: ON"
	XpCounter_msg_Cmd_Overlay_Tooltip_off = "Display Tooltip for overlay: OFF"
	XpCounter_msg_Cmd_Anchor_Overerlay_Tooltip_on = "Overlay Tooltip Anchor: ON"
	XpCounter_msg_Cmd_Anchor_Overerlay_Tooltip_off = "Overlay Tooltip Anchor: OFF"
	XpCounter_msg_Cmd_Anchor_Overerlay_SetText = "Overlay text set: %s"	
	
	-- xp, xpmax, xpproc, xpleft, xprest, hours, minutes, xpcount, epm, kills, avg_kill_xp, kills_left, lvlup_hours, lvlup_minutes
	
	XpCounter_msg_ToolTip = "|cffffcc00XpBar\n\n|cff888888XP: |cffffffff%s |cff888888of |cffffffff%s |cff888888(|cffffffff%s |cff888888%%)\n|cff888888XP to LevelUp: |cffffcc00%s\n|cff888888Bonus XP: |cffffffff%s\n\n|cff888888Time: |cffffffff%s Hours |cffffffff%s |cff888888Minutes\n|cff888888XP total: |cffffffff%s\n|cff888888EPH / EPM: |cffffcc00%s |cff888888/ |cffffcc00%s\n\n|cff888888Kills: |cffffffff%s |cff888888(~ |cffffffff%s |cff888888XP pro Kill)\n|cff888888Kills till LevelUp: |cffffcc00%s\n\n|cff888888Time to LevelUp: ~ |cffffffff%s Hours |cffffffff%s Minutes"

	XpCounter_msg_Help = { "Commands (|cffffcc00/xpc |cff666666COMMANDO|cffffffff):", 
						   "[show] show XP Overlay", 
						   "[hide] hide XP Overlay", 
						   "[lock] lock XP Overlay", 
						   "[unlock] unlock XP Overlay", 
						   "[reset] Reset XP and time counter", 
						   "[update] updates all gathered Information.", 
						   "[tooltip_show] toggels tooltip display for the XP bar.", 
						   "[tooltip_show_overlay] toggels tooltip display for the overlay window.", 
						   "[tooltip_anchor_overlay] binds the tooltip on the cursor.",
						   "[set_overlay_text] (|cff888888sot|cffffffff) sets the format of the overlay.",
						   "[set_overlay_text_help] (|cff888888sot_help|cffffffff) shows help on formating the overlay." }

	XpCounter_msg_Help_Format_Overlay = {	"[xp_act] Actual XP value", 
											"[xp_max] Max XP on this level", 
											"[xp_perc] XP to level up in percent", 
											"[xp_left] XP needed to level up", 
											"[xp_rested] Bonus XP left", 
											"[xp] XP gathered", 
											"[time_played] Time played", 
											"[time_left] Estimated time to level up", 
											"[eph] XP per hour", 
											"[epm] XP per minute"
										}
end
