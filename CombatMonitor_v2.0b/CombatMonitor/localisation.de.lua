if (GetLocale() == "deDE") then
	CMON_ALL_OPPONENTS = "Alle Gegner";
	CMON_ENVIRONMENTAL = "Umgebend";
	CMON_ENABLEBUTTON = "CombatMonitor aktivieren";
	CMON_ENVIRONMENTBUTTON = "Umgebungsschaden beachten";
	CMON_DUMPCHANNEL = "Anzeige Fenster:";
	CMON_SHOWDPS = "Zeige eingehenden DPS"
	CMON_DPSBANNER = "Eingehender DPS";
	CMON_INSTANTANEOUS = "Aktueller:";
	CMON_AVERAGE = "Durchsch.:";

	CMON_NEWMOBS = "Zeichne alle neuen Gegner auf";
	CMON_NONELITE = "Track non-elite mobs";
	CMON_WORLDBOSS= "Track World Bosses only";
	CMON_SHOWPERCENT = "Prozente anzeigen"  -- "Zeige Prozente";
	CMON_PEAK = "Peak:";
	CMON_RESET = "CombatMonitor Reset";
	CMON_DEBUG_EVENT = "Event: source = ";
	CMON_COPY = "Copy";
	CMON_UPDATING = "CombatMonitor updating to version";

	CMON_VERSION = "CombatMonitor Version |cff00ff00";
	CMON_OPTIONS = "Einstellungen";
	CMON_DUMP = "Anzeigen";
	CMON_ENABLED = "CombatMonitor aktiviert";
	CMON_DISABLED = "CombatMonitor deaktiviert";
	CMON_NEWPLAYER = "CombatMonitor neuer Spieler: ";

	CMON_PERCENT = "%2.2f%%";
	CMON_ENABLINGPERIODIC = "CombatMonitor benötigt die Einstellung 'regelmäßiger Schaden' in den Interface Einstellungen um ordnungsgemäß arbeiten zu können. Diese wurden nun gesetzt.";
	CMON_MELEEHEADER = "Nahkampfschaden"
	CMON_SPELLHEADER = "Zauberschaden"
	CMON_RESET_CURRENT = "Remove Selected";
	
	CMON_ON = "on"
	CMON_OFF = "off"
	CMON_RESET = "reset";
	CMON_VER = "version";
	CMON_USAGE = "Verwendung: /combatmonitor on | off | reset | version";
	
	CMON_CLEARALLERR = "CombatMonitor: Konnte nicht die 'Alle Gegner' Kategorie aufräumen";
	CMON_VERSIONERROR1 = "CombatMonitor ";
	CMON_VERSIONERROR2 = " muss leider sämtliche alten Daten löschen. Tut mir leid...";
	CMON_UPDATING = "CombatMonitor updating to version";
	
	CMON_ENVIRONMENTTOOLTIP = "Record environmental damage taken.  This damage is never tracked in the All Opponents category";
	
	CMON_TOTALATTACKSLABEL = "Totale Angriffe:";
	CMON_MISSESLABEL = "Verfehlte:";
	CMON_DODGESLABEL = "Ausgewichene:";
	CMON_PARRIESLABEL = "Parierte:";
	CMON_BLOCKSLABEL = "Geblockte:";
	CMON_BLOCKMITIGATIONLABEL = "Block Mitigation:";
	CMON_HITSLABEL = "Treffer:";
	CMON_CRITICALHITSLABEL = "Kritische Treffer:";
	CMON_CRUSHINGBLOWSLABEL = "Crushing Blows:";
	CMON_PHYSICALDAMAGELABEL = "Körperlich:";
	CMON_AVERAGEHITLABEL = "Durchschn. Treffer:"; 
	CMON_DAMAGEAVOIDEDLABEL = "Vermiedener Schaden:";
	CMON_DOUBLECRITICALSLABEL = "Doppelt Kritische:";
	CMON_TRIPLECRITICALSLABEL = "Dreifach Kritische:";
	CMON_HOLYDAMAGELABEL = "Heilig:";
	CMON_FIREDAMAGELABEL = "Feuer:";
	CMON_NATUREDAMAGELABEL = "Natur:";
	CMON_FROSTDAMAGELABEL = "Eis:";
	CMON_SHADOWDAMAGELABEL = "Schatten:";
	CMON_ARCANEDAMAGELABEL = "Arkane:";
	CMON_SPELLRESISTSLABEL = "Komplett Widerstanden:";
	CMON_TOTALDAMAGELABEL = "Totaler Schaden:";
	CMON_TAKENEKEY = "Bekommen";
	CMON_RESISTEDKEY = "Widerstanden";
	CMON_HITSKEY = "Treffer";
	CMON_AVERAGEKEY = "Durchschnitt";
	CMON_MELEE = "|cff00ff00Nahkampf|r";
	CMON_SPELL = "|cff00ff00Zauber|r";

	-- Search Strings
	SEARCH_YOU_HIT = "Ihr trefft";
	SEARCH_CRUSHING = "(schmetternd)";
	SEARCH_CRITICAL = "trifft Euch kritisch";
	SEARCH_HIT = "(.+) trifft Euch f\195\188r (%d+) Schaden.";
	SEARCH_CRIT = "(.+) trifft Euch kritisch. Schaden: (%d+)";
	SEARCH_DAMAGESHIELD = "(.+) reflektiert (%d+) (.+)sschaden auf Euch.";
	SEARCH_BLOCK = "((%d+) geblockt)";
	SEARCH_RESISTED = "((%d+) widerstanden)";
	SEARCH_ABSORB = "((%d+) absorbiert)";
	SEARCH_DEFLECT = "(.+) greift an. Ihr wehrt ab.";
	SEARCH_DODGE = "(.+) greift an. Ihr weicht aus.";
	SEARCH_IMMUNE = "(.+) greift an, aber Ihr seid immun.";
	SEARCH_PARRY = "(.+) greift an. Ihr pariert.";
	SEARCH_FULL_BLOCK = "(.+) greift an. Ihr blockt.";
	SEARCH_FULL_ABSORB = "(.+) greift an. Ihr absorbiert allen Schaden.";
	SEARCH_MISS = "(.+) verfehlt Euch.";
	
	SEARCH_SPELL = "(.+)s (.+) trifft Euch f\195\188r (%d+) (.+) Schaden.";
	SEARCH_SPELL_FULL_ABSORB = "Ihr absorbiert (.+)s (.+)";
	SEARCH_CRIT_SPELL = "(.+) trifft Euch kritisch (mit (.+)). Schaden: (%d+).";
	SEARCH_TYPE_DAMAGE = "Ihr erleidet (%d+) (.+)schaden von (.+) (durch (.+)).";
	SEARCH_SPELL_MISS = "(.+) greift an (mit (.+)) und verfehlt Euch.";
	SEARCH_SPELL_DRAIN = "(.+) entzieht Euch (%d+) (.+).";
	SEARCH_SPELL_DRAIN_BUFF = "(.+) entzieht Euch (%d+) (.+) und erh\195\164lt (.+).";
	SEARCH_SPELL_REFLECT = "(.+)s (.+) wird von Euch abgewehrt.";
	SEARCH_SPELL_RESIST = "(.+) versucht es mit (.+) ... widerstanden.";
	SEARCH_SPELL_DEFLECT = "(.+)versuchte es mit (.+) ... abgewehrt.";
	SEARCH_SPELL_DODGE = "(.+)s (.+) wurde ausgewichen.";
	SEARCH_SPELL_PARRY = "(.+) von (.+) wurde pariert.";
	SEARCH_SPELL_FULL_BLOCK = "(.+)s (.+) wurde geblockt.";
	SEARCH_SPELL_MISS = "(.+) greift an (mit (.+)) und verfehlt Euch.";
	SEARCH_SPELL_AFFLICTED = "Ihr seid von (.+) betroffen.";
	SEARCH_SPELL_PERFORM = "(.+) f\195\188hrt (.+) auf Euch aus.";
	SEARCH_SELF_TYPE_DAMAGE = "Ihr erleidet (%d+) Punkte (.+)schaden (durch (.+)).";
	SEARCH_SELF_SPELL = "Euer Tier (.+) trifft Euch: Schaden (%d+).";
	SEARCH_SELF_CRIT_SPELL = "Euer Tier (.+) trifft Euch kritisch. Schaden: (%d+).";
	SEARCH_SELF_SPELL_ABSORB = "Euer Tier (.+) trifft Euch. Schaden: (%d+) ((%d+) absorbiert).";
	SEARCH_PERIODIC_ABSORB = "Ihr erleidet (%d+) (.+)schaden durch (.+)s von (.+) ((%d+) absorbiert).";
	SEARCH_PERIODIC = "Ihr erleidet (%d+) (.+)schaden von (.+) (durch (.+)).";
	SEARCH_SELF_PERIODIC_ABSORB = "Ihr erleidet (%d+) Punkte (.+)schaden (durch (.+), (%d+) absorbiert).";
	
	SEARCH_TYPE_ARCANE = "Arkan Schaden";
	SEARCH_TYPE_FIRE = "Feuer Schaden";
	SEARCH_TYPE_FROST = "Frost Schaden";
	SEARCH_TYPE_HOLY = "Heilig Schaden";
	SEARCH_TYPE_NATURE = "Natur Schaden";
	SEARCH_TYPE_SHADOW = "Schatten Schaden";
	
	SEARCH_TYPE_SHORT_ARCANE = "arkan";
	SEARCH_TYPE_SHORT_FIRE = "feuer";
	SEARCH_TYPE_SHORT_FROST = "frost";
	SEARCH_TYPE_SHORT_HOLY = "heilig";
	SEARCH_TYPE_SHORT_NATURE = "natur";
	SEARCH_TYPE_SHORT_SHADOW = "schatten";

	ENVIRONMENTAL_DROWNING = "Ihr geht unter und verliert (%d+) Gesundheit.";
	ENVIRONMENTAL_FALLING = "Ihr fallt und verliert (%d+) Gesundheit.";
	ENVIRONMENTAL_FATIGUE = "Ihr seid ersch\195\182pft und verliert (%d+) Gesundheit.";
	ENVIRONMENTAL_FIRE = "Ihr verliert (%d+) Punkte aufgrund von Feuerschaden.";
	ENVIRONMENTAL_LAVA = "Ihr verliert (%d+) Gesundheit durch Ber\195\188hrung mit Lava.";
	ENVIRONMENTAL_SLIME  = "Ihr verliert (%d+) Gesundheit wegen Schwimmens in Schleim.";
end