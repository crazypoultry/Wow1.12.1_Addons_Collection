if ( GetLocale() == "deDE" ) then

-- Options Menue
CECB_status_txt = "EnemyCastBar Mod aktivieren";
CECB_pvp_txt = "|cffffffaaPvP/Allgemeine|r CastBars aktivieren";
 CECB_globalpvp_txt = "CastBars auch ohne Target zeigen";
 CECB_gains_txt = "Spelltypus 'gains' aktivieren";
  CECB_gainsonly_txt = "Nur 'gains' anzeigen";
 CECB_cdown_txt = "Einige CoolDownBars aktivieren";
  CECB_cdownshort_txt = "NUR kurze CDs anzeigen";
  CECB_usecddb_txt = "CoolDown Datenbank benutzen";
 CECB_spellbreak_txt = "KEINE CastBreaks in Raids";
CECB_pve_txt = "|cffffffaaPvE/Raid|r CastBars aktivieren";
 CECB_pvew_txt = "Sound abspielen bei 'Flash'";
CECB_afflict_txt = "|cffffffaaDebuffs|r anzeigen";
 CECB_globalfrag_txt = "'Mob Outs' ohne Ziel anzeigen";
 CECB_magecold_txt = "K\195\164lte + Verwundbarkeit anzeigen";
 CECB_solod_txt = "'Solo Debuffs' (Stuns) anzeigen";
  CECB_drtimer_txt = "'Diminishing Return' einbeziehen";
  CECB_classdr_txt = "Klassenspez. 'DRs' einbeziehen";
 CECB_sdots_txt = "Eigene DoTs \195\188berwachen";
 CECB_affuni_txt = "NUR Debuffs von RaidBossen zeigen";
CECB_parsec_txt = "Raid/Party/AddOnChat analysieren";
 CECB_broadcast_txt = "CastBars per AddOn Kanal senden";
CECB_targetm_txt = "Ziel w\195\164hlen mit LinksKlick auf Bars";
CECB_timer_txt = "Timer neben CastBars anzeigen";
CECB_tsize_txt = "Kleine Textgr\195\182\195\159e benutzen";
CECB_flipb_txt = "Aufbau der CastBars umdrehen";
CECB_flashit_txt = "CastBars gegen Ende 'flashen'";
CECB_showicon_txt = "Icon neben CastBars anzeigen";
CECB_scale_txt = "Skalierung: ";
CECB_alpha_txt = "Transparenz: ";
CECB_numbars_txt = "Max. Anzahl an CastBars: ";
CECB_space_txt = "Icongr\195\182\195\159e, Abstand der CastBars: ";
CECB_blength_txt = "Breite der CastBars ";
CECB_minimap_txt = "Position an der MiniMap: ";
CECB_throttle_txt = "AddOn Updates pro Sekunde: ";

CECB_status_tooltip = "Aktiviert/ Deaktiviert das Erscheinen von CastBars w\195\164hrend des Spielens und schaltet alle Events ab, um die CPU zu entlasten.";
CECB_pvp_tooltip = "Aktiviert die CastBars f\195\188r alle unterst\195\188tzten, herk\195\182mmlichen Spr\195\188che von Spielern.";
 CECB_globalpvp_tooltip = "Zeigt alle PvP CastBars in Reichweite des CombatLogs an, anstelle nur CastBars des aktuellen Ziels anzuzeigen.\n\n|cffff0000Warnung:|r Diese Einstellung kann zu sehr vielen CastBars f\195\188hren!\n\n|cffff0000Freund-/Feind-Erkennung funktioniert damit nicht!";
 CECB_gains_tooltip = "Aktiviert CastBars f\195\188r sogenannte 'gains'.\nDas sind Spr\195\188che wie 'Eisblock', 'Blutrausch' und Heilung \195\188ber Zeit (HoTs).";
  CECB_gainsonly_tooltip = "Zeigt auschlie\195\159lich 'Gains' an. Das Wirken von Zaubern wird ignoriert.";
 CECB_cdown_tooltip = "Aktiviert die CoolDown-Zeiten f\195\188r einige(!) Spr\195\188che, die CastZeiten haben oder sog. 'gains' sind.";
  CECB_cdownshort_tooltip = "Zeigt nur Cooldowns an, wenn diese 60 oder weniger Sekunden lang sind.";
  CECB_usecddb_tooltip = "Speichert alle erkannten CoolDowns in Combatlog-Reichweite ab und zeigt dynamisch die passenden CoolDowns f\195\188r das jeweilige Ziel an, falls die entsprechenden CoolDowns zuvor erkannt wurden.";
 CECB_spellbreak_tooltip = "Verhindert, dass Unterbrechungen von PvP(!) CastBars auch in Raids erkannt werden.\nDiese Option f\195\188hrt zu einer besseren Leistung und verhindert falsch erkannte Unterbrechungen in Raids.";
CECB_pve_tooltip = "Aktiviert die CastBars f\195\188r PvE/Raid-Encounter";
 CECB_pvew_tooltip = "Spielt einen 'Fump'-Sound ab, wenn eine Raid-CastBar anf\195\164ngt zu 'flashen'.";
CECB_afflict_tooltip = "Zeigt bewegungseinschr\195\164nkende Debuffs, wie z.B. 'Verwandlung' oder 'Kniesehne' an. Aktiviert zugleich viele Debuffs, die Bosse auf Spieler wirken k\195\182nnen, z.B. 'Brennendes Adrenalin'.";
 CECB_globalfrag_tooltip = "Erzeugt CastBars bei 'Mob Outs', selbst wenn es nicht das aktuelle Ziel ist.\n\n'Mob Outs' sind 'Untote fesseln', 'Verbannen', 'Verwandlung' etc.";
 CECB_magecold_tooltip = "Zeigt folgende K\195\164lte Effekte an:\n'Frostnova', 'Erfrierung', 'K\195\164lte', 'K\195\164ltekegel' und 'Frostblitz'.\nDar\195\188berhinaus werden auch Verwundbarkeiten (Schatten, Feuer, K\195\164lte) angezeigt.";
 CECB_solod_tooltip = "Zeigt eine Vielzahl von Bet\195\164ubungseffekten an. Aktiviert auch Schweigen-, Furcht-, Entwaffnen- und Aggro-Effekte!";
  CECB_drtimer_tooltip = "Ber\195\188cksichtigt den 'Diminishing Return' f\195\188r die gr\195\182\195\159te Stun-Gruppe, die den selben Timer benutzt.\nDiese besteht aus 3 Krieger-, 3 Druiden-, 1 Paladin- and 1 Schurken-Stun(s).\n\nZeigt einen Cooldown an bis die volle Stun-L\195\164nge erneut m\195\182glich ist.";
  CECB_classdr_tooltip = "Ber\195\188cksichtigt klassenspezifische 'Diminishing Returns' wie z.B. 'Kopfnuss' und 'Verwandlung'.\n\n|cffff0000Wird in der Regel nur gegen andere Spieler aktiv|r und wird nur der passenden Charakterklasse angezeigt.";
 CECB_sdots_tooltip = "Zeigt die Wirkungsdauer der eigens verursachten DoTs, wie z.B. |cffffffff'Verderbnis' |r-|cffffffff 'Schlangenbiss'|r an.\nDie CastBars erneuern sich nicht, wenn der DoT erneut gesprochen wird, bevor die Wirkungsdauer abl\195\164uft! |cffff0000\nAm besten erst am Ende der Dauer die DoTs erneuern, sonst wird der Timer verr\195\188ckt!|r\n\nDoTs, die zus\195\164tzlich einen Sofort-Schaden verursachen erneuern die CastBar und haben dieses Problem nicht (z.B. |cffffffff'Feuerbrand'|r)!";
 CECB_affuni_tooltip = "Schaltet zur besseren \195\156bersicht alle Debuffs ab, die nicht von RaidBossen stammen.";
CECB_timer_tooltip = "Zeigt die Restzeit der CastBars zus\195\164tzlich als Nummer an.";
CECB_targetm_tooltip = "Erlaubt es, den Mob von dem die CastBar stammt mit einem LinksKlick auf die CastBar anzuw\195\164hlen.";
CECB_parsec_tooltip = "Alle Benutzer, die diese Option aktivieren, erhalten eine CastBar auf dem Bildschirm, wenn im Raid-/Party-/AddOn-Kanal am Anfang folgende Befehle mit Zeitangaben auftauchen: '|cffffffff.countmin|r', '|cffffffff.countsec|r', '|cffffffff.repeat|r' oder '|cffffffff.stopcount|r' (s. Hilfe).\n\nBeispiel:\n|cffffffff.countsec 45 Bis Spawn|r\n\nAnstelle von:\n|cffffffff/necb countsec 45 Bis Spawn";
CECB_broadcast_tooltip = "Raidspr\195\188che und Debuffs werden \195\188ber den AddOn Kanal ausgetauscht.\nFunktioniert nur, wenn Sender und Empf\195\164nger die selbe Sprache benutzen!|cffff0000\n\nACHTUNG:|r Diese Option sollten nur wenige, gezielte Spieler im Raid benutzen!\nPvP Spr\195\188che werden nicht \195\188bertragen.";
CECB_tsize_tooltip = "Verkleinert die Textgr\195\182\195\159e, so da\195\159 mehr Zeichen in die CastBars passen.";
CECB_flipb_tooltip = "Dreht die Richtung in der sich mehrere CastBars aufbauen um.\nNormal: Von unten nach oben.\nEingeschaltet: Von oben nach unten.";
CECB_flashit_tooltip = "CastBars mit einer Gesamtanzeigedauer von wenigstens 20 Sekunden fangen bei 20% Restdauer an zu 'flashen'.\nAber fr\195\188hestens 10 Sekunden vor Ende beginnt dieser Effekt.";
CECB_showicon_tooltip = "Zeigt das Spruch-Icon neben der CastBar an.\n\nDie Gr\195\182\195\159e passt sich der Einstellung 'Icongr\195\182\195\159e, Abstand der CastBars' an.";
CECB_scale_tooltip = "Erlaubt eine Gr\195\182\195\159enanpassung der CastBars von 30 bis 130 Prozent.";
CECB_alpha_tooltip = "Erlaubt es, die Transparenz der CastBars zu justieren.";
CECB_numbars_tooltip = "Gibt die maximale Anzahl an CastBars an, die auf dem Bildschirm zugelassen sind.";
CECB_space_tooltip = "Gibt den Platz zwischen den CastBars an.\n(Standard ist 20)";
CECB_blength_tooltip = "Gibt die zus\195\164tzliche Breite der CastBars an.\n(Standard ist 0)";
CECB_minimap_tooltip = "Bewegt den NECB Knopf an der MiniMap.\n\nNach ganz links schieben, um den Button auszuschalten!";
CECB_throttle_tooltip = "Setzt die Aktualisierungen pro Sekunde f\195\188r die CastBars, das Men\195\188 und die FPS Bar.\nMehr Updates verbrauchen mehr CPU Leistung!";
CECB_fps_tooltip = "Erzeugt ein eigenst\195\164ndiges Dublikat des FPS-Balkens zur freien Platzierung.";


CECB_menue_txt = "Optionen";
CECB_menuesub1_txt = "Welche CastBars anzeigen?";
CECB_menuesub2_txt = "Aussehen der CastBars/ Sonstiges";
CECB_menue_reset = "Standard";
CECB_menue_help = "Hilfe";
CECB_menue_colors = "Farben";
CECB_menue_mbar = "Bewegl. Bar";
--CECB_menue_close = "Schlie\195\159en";
CECB_menue_rwarning = "|cffff0000WARNUNG!|r\n\nAlle Werte und Positionen werden auf \ndie Standardwerte zur\195\188ckgesetzt!\n\nWillst du wirklich einen vollen Reset?";
CECB_menue_ryes = "Ja";
CECB_menue_rno = "NEIN!";
CECB_minimapoff_txt = "aus";


end
