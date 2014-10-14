-- 
-- Localisation for MobInfo
--
-- created by Skeeve on the 27th of July 2005
-- last update: 07-Aug-2005
--

--
-- German localization
--

if ( GetLocale() == "deDE" ) then

miSkinLoot = { };
miSkinLoot["Verdorbene Lederfetzen"]=1;
miSkinLoot["Leichtes Leder"]=1;
miSkinLoot["Mittleres Leder"]=1;
miSkinLoot["Schweres Leder"]=1;
miSkinLoot["Dickes Leder"]=1;
miSkinLoot["Unverw\195\188stliches Leder"]=1;

miSkinLoot["Leichter Balg"]=1;
miSkinLoot["Mittlerer Balg"]=1;
miSkinLoot["Schwerer Balg"]=1;
miSkinLoot["Dicker Balg"]=1;
miSkinLoot["Unverw\195\188stlicher Balg"]=1;

miSkinLoot["Schim\195\164renleder"]=1;
miSkinLoot["Teufelssaurierleder"]=1;
miSkinLoot["Frosts\195\164blerleder"]=1;
miSkinLoot["Kriegsb\195\164renleder"]=1;

miClothLoot = { };
miClothLoot["Leinenstoff"]=1;
miClothLoot["Wollstoff"]=1;
miClothLoot["Seidenstoff"]=1;
miClothLoot["Magierzwirn"]=1;
miClothLoot["Teufelsstoff"]=1;
miClothLoot["Runenstoff"]=1;
	
MI_DESCRIPTION = "F\195\188gt dem ToolTip umfangreiche Zusatzinformationen \195\188ber den Gegner hinzu";

MI_MOB_DIES_WITH_XP = "(.+) stirbt, Ihr bekommt (%d+) Erfahrung";
MI_MOB_DIES_WITHOUT_XP = "(.+) stirbt";
MI_PARSE_SPELL_DMG = "(.+) trifft Euch (.+). Schaden: (%d+)";	
MI_PARSE_COMBAT_DMG = "(.+) trifft Euch f\195\188r (%d+) Schaden";

MI_TXT_GOLD   = " Gold";
MI_TXT_SILVER = " Silber";
MI_TXT_COPPER = " Kupfer";

MI_TXT_CLASS        = "Klasse ";
MI_TXT_HEALTH       = "Lebenspunkte ";
MI_TXT_KILLS        = "Get\195\182tet ";
MI_TXT_DAMAGE       = "Schaden ";
MI_TXT_TIMES_LOOTED = "Gepl\195\188ndert ";
MI_TXT_EMPTY_LOOTS  = "Leere Loots ";
MI_TXT_TO_LEVEL     = "# bis Level ";
MI_TXT_QUALITY      = "Qualit\195\164t ";
MI_TXT_CLOTH_DROP   = "Stoff erhalten ";
MI_TXT_COIN_DROP    = "Geld (delta)";
MI_TEXT_ITEM_VALUE  = "Wert Items  (delta) ";
MI_TXT_MOB_VALUE    = "Gesamtwert (delta) ";
MI_TXT_COMBINED     = "Zusammengefasst: ";
--MI_TXT_COMBINED     = "Kombiniert: ";

MI_TXT_CONFIG_TITLE = "MobInfo-2 Optionen";

MI2_FRAME_TEXTS = {};
MI2_FRAME_TEXTS["MI2_FrmTooltipOptions"] = "Tooltip Options";
MI2_FRAME_TEXTS["MI2_FrmGeneralOptions"] = "General Options";
MI2_FRAME_TEXTS["MI2_FrmHealthOptions"]  = "Mob Health Options";


--
-- This section defines all buttons in the options dialog
--   text : the text displayed on the button
--   cmnd : the command which is executed when clicking the button
--          cmnd must not be given for the translated texts
--   help : the (short) one line help text for the button
--   info : additional multi line info text for button
--          info is displayed in the help tooltip below the "help" line
--          info is optional and can be omitted if not required
--

MI2_OPTIONS["MI2_OptShowClass"] = 
  { text = "Klasse anzeigen"; cmnd = "showclass";  help = "Klasseninfo zum Gegner"; }
  
MI2_OPTIONS["MI2_OptShowHealth"] = 
  { text = "Lebenspunkte anzeigen"; cmnd = "showhealth";  help = "Lebenspunkte des Gegners (aktuell/max)"; }
  
MI2_OPTIONS["MI2_OptShowDamage"] = 
  { text = "Mob Schaden anzeigen"; cmnd = "showdamage";  help = "Schadensbereich des Gegner (Min/Max)"; 
    info = "Der Schadensbereich wird pro Char separat berechnet." }
    
MI2_OPTIONS["MI2_OptShowCombined"] = 
  { text = "Zusammengefasst anzeigen"; cmnd = "showcombined";  help = "Zusammengefasste Level im Tooltip anzeigen";
    info = "Zeigt an, welche Mob Level zusammengefasst wurden.\nKann nur angezeigt werden wenn zusammenfassen aktiviert ist." }
  
MI2_OPTIONS["MI2_OptShowKills"] = 
  { text = "Get\195\182tet anzeigen"; cmnd = "showkills";  help = "Wie oft Du diesen Gegner get\195\182tet hast";
    info = "Anzahl get\195\182tet wird pro Char separat gez\195\164hlt." }
  
MI2_OPTIONS["MI2_OptShowLoots"] = 
  { text = "Anzahl gepl\195\188ndert anzeigen"; cmnd = "showloots"; help = "Wie oft Du diesen Gegner gepl\195\188ndert hast"; }
  
MI2_OPTIONS["MI2_OptShowEmpty"] = 
  { text = "Anzahl leere Loots anzeigen"; cmnd = "showempty";  help = "Die leeren Loots f\195\188r diesen Gegner (Anzahl/Prozent)";
    info = "Wird hochgez\195\164hlt wenn das Pl\195\188nderfenster des\nget\195\182teten Gegners leer ist." }
  
MI2_OPTIONS["MI2_OptShowXp"] = 
  { text = "Erfahrungspunkte anzeigen"; cmnd = "showxp";  help = "Die zuletzt vom Gegner erhaltenen Erfahrungspunkte";
    info = "Entspricht exakt den bei letzten Kill von diesem\nGegner erhaltenen Erfahrungspunkte\n(wird nicht f\195\188r graue Gegner angezeigt)" }
  
MI2_OPTIONS["MI2_OptShowNo2lev"] = 
  { text = "Anzahl bis Level anzeigen"; cmnd = "showno2lev";  help = "Anzahl zu t\195\182tender Gegner bis Levelaufstieg";
    info = "Zeigt, wie oft dieser Gegner get\195\182tet werden m\195\188sste,\num im Level aufzusteigen\n(wird nicht f\195\188r graue Gegner angezeigt)" }
      
MI2_OPTIONS["MI2_OptShowQuality"] = 
  { text = "Loot Qualit\195\164t anzeigen"; cmnd = "showquality";  help = "Qualit\195\164t der von diesem Gegner erhaltenen Gegenst\195\164nde";
    info = "Z\195\164hlt separat die erhaltenen Gegenst\195\164nde f\195\188r jede der\n5 Qualit\195\164tsstufen. Stufen ohne Gegenst\195\164nde werden nicht\nangezeigt. Die Prozentangabe entspricht der Wahrscheinlichkeit,\n als Loot einen Gegenstand der entsprechenden Kategorie zu erhalten.\n" }
  
MI2_OPTIONS["MI2_OptShowCloth"] = 
  { text = "Stoffz\195\164hler anzeigen"; cmnd = "showcloth";  help = "Wie oft der Gegner Stoff als Beute gegeben hat"; }
  
MI2_OPTIONS["MI2_OptShowCoin"] = 
  { text = "Geldwert anzeigen"; cmnd = "showcoin";  help = "Geldmenge die dieser Gegner im Mittel als Beute gibt";
    info = "Die Gesamtgeldbeute wird pro Gegner aufaddiert und\ndurch die Anzahl gepl\195\188ndert dividiert\n(wird nicht angezeigt wenn 0)" }
  
MI2_OPTIONS["MI2_OptShowIV"] = 
  { text = "Gegenstandswert anzeigen"; cmnd = "showiv";  help = "Gemittelter Wert der Beute Gegenst\195\164nde dieses Gegners";
    info = "Der Wert aller Beute Gegenst\195\164nde wird pro Gegner \naufaddiert und durch die Anzahl gepl\195\188ndert dividiert\n(wird nicht angezeigt wenn 0)" }
  
MI2_OPTIONS["MI2_OptShowTotal"] = 
  { text = "Gesamtgegnerwert anzeigen"; cmnd = "showtotal";  help = "Gemittelter Gesamtwert des Gegners (Geld+Gegenst\195\164nde)";
    info = "Dies ist die Summe aus gemitteltem Geldwert und\n gemitteltem Gegenstandswert." }
  
MI2_OPTIONS["MI2_OptShowBlankLines"] = 
  { text = "Leerzeilen anzeigen"; cmnd = "showblanklines";  help = "Im Tooltip leere Trennzeilen anzeigen";
    info = "Leere Trennzeilen sollen die Lesbarkeit des Tooltips erh\195\182hen." }
  
MI2_OPTIONS["MI2_OptSaveAllValues"] = 
  { text = "Alle Werte Speichern"; cmnd = "saveallvalues";  help = "Immer alle Werte berechnen und speichern";
    info = "Werden alle Werte berechnet und gespeichert\nso k\195\182nnen sie sofort angezeigt werden wenn die\nAnzeigeoptionen ver\195\164ndert werden. Wenn nicht werden\n nur die angezeigten Werte berechnet und gespeichert." }
  
MI2_OPTIONS["MI2_OptCombinedMode"] = 
  { text = "Gleiche Mobs Zusammenfassen"; cmnd = "combinedmode";  help = "Zusammenfassen der Daten f\195\188r Gegner gleichen Namens";
    info = "Die Daten von Gegner die sich nur im Level unterscheiden\n werden kombiniert und gemeinsam angezeigt. Ein entsprechender\nHinweis erscheint im Tooltip." }
  
MI2_OPTIONS["MI2_OptKeypressMode"] = 
  { text = "MobInfo nur wenn ALT gedr\195\188ckt"; cmnd = "keypressmode";  help = "Gegnerinfo nur bei gedr\195\188ckter ALT Taste im Tooltip"; }
  
MI2_OPTIONS["MI2_OptClearOnExit"] = 
  { text = "Daten l\195\182schen bei Logout"; cmnd = "clearonexit";  help = "Bei Logout werden alle Gegnerdaten gel\195\182scht"; }

MI2_OPTIONS["MI2_OptDisableHealth"] = 
  { text = "Mob Health Deaktivieren"; cmnd = "disablehealth"; help = "Deaktivieren der integrierten MobHealth Funktionalit\195\164t";
    info = "Die integrierte MobHealth Funktionalität wird vollst\195\164ndig abgeschaltet.\nDies ist z.B. notwendig um andere externe MobHealth Tools zu verwenden."; }
  
MI2_OPTIONS["MI2_OptStableMax"] = 
  { text = "Stabiles Gesundheitsmaximum"; cmnd = "stablemax";  help = "Das Gesundheitsmaximum im Zielportr\195\164t bleibt stabil";
    info = "When aktiviert wird die Anzeige des Gesundheitsmaximum\nw\195\164rend eines Kampfes nicht ver\195\164ndert, obwohl die Berechnung weiterl\195\164uft."; }
  
MI2_OPTIONS["MI2_OptShowPercent"] = 
  { text = "Prozent anzeigen"; cmnd = "showpercent";  help = "Prozenzangabe zu Gesundheit/Mana hinzuf\195\188gen"; }
  
MI2_OPTIONS["MI2_OptHealthPosX"] = 
  { text = "Horizontale Position"; cmnd = "healthposx";  help = "Einstellen der horizontalen Gesunfheit/Mana Position"; }

MI2_OPTIONS["MI2_OptHealthPosY"] = 
  { text = "Vertikale Position"; cmnd = "healthposy";  help = "Einstellen der vertikalen Gesunfheit/Mana Position"; }

MI2_OPTIONS["MI2_OptManaDistance"] = 
  { text = "Mana Abstand"; cmnd = "manadistance";  help = "Einstellen des Abstands von Gesundheit/Mana"; }

MI2_OPTIONS["MI2_OptAllOn"] = 
  { text = "Alles ein"; cmnd = "allon";  help = "Schaltet alle Tooltip Infos ein"; }
  
MI2_OPTIONS["MI2_OptAllOff"] = 
  { text = "Alles Aus"; cmnd = "alloff";  help = "Schaltet alle Tooltip Infos aus"; }
  
MI2_OPTIONS["MI2_OptMinimal"] = 
  { text = "Minimal"; cmnd = "minimal";  help = "Zeigt nur minimale Tolltip Infos"; }
  
MI2_OPTIONS["MI2_OptDefault"] = 
  { text = "Default"; cmnd = "default";  help = "Zeigt eine typische Auswahl n\195\188tzlicher Tooltip Infos"; }
  
MI2_OPTIONS["MI2_OptBtnDone"] = 
  { text = "Fertig"; cmnd = "";  help = "MonInfo Optionsfenster schliessen";}

end
