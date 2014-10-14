if GetLocale() == "deDE" then
	--Razorgore
	LVBM_RG_NAME				= "Razorgore der Ungez\195\164hmte";
	LVBM_RG_DESCRIPTION			= "Stellt einen Timer f\195\188r den Anfang des Spawns zur Verf\195\188gung.";
	
	LVBM_RG_CONTROLLER			= "Grethok der Aufseher";
	
	
	--Vaelastrasz
	LVBM_VAEL_NAME				= "Vaelastrasz der Verdorbene";
	LVBM_VAEL_DESCRIPTION			= "Announces Burning Adrenaline.";
	LVBM_VAEL_SEND_WHISPER			= "Whisper verschicken";
	LVBM_VAEL_SET_ICON			= "Icon setzen";
	
	LVBM_VAEL_BA_WARNING			= "*** %s brennt ***";
	LVBM_VAEL_BA_WHISPER			= "Du brennst!";
	LVBM_VAEL_BA				= "Brennendes Adrenalin";
	
	LVBM_VAEL_BA_REGEXP			= "([^%s]+) (%w+) von Brennendes Adrenalin betroffen";
	LVBM_VAEL_BA_FADES_REGEXP		= "Brennendes Adrenalin schwindet von ([^%s]+)%.";
	
	
	--Firemaw/Ebonroc/Flamegor
	LVBM_FIREMAW_NAME			= "Feuerschwinge";
	LVBM_FIREMAW_DESCRIPTION		= "Stellt einen Timer f\195\188r Fl\195\188gelsto\195\159 zur Verf\195\188gung.";
	LVBM_EBONROC_NAME			= "Schattenschwinge";
	LVBM_EBONROC_DESCRIPTION		= "Stellt einen Timer f\195\188r Fl\195\188gelsto\195\159 zur Verf\195\188gung und sagt Schattenschwinges Schatten an.";
	LVBM_EBONROC_SET_ICON			= "Icon setzen"
	LVBM_FLAMEGOR_NAME			= "Flammenmaul";
	LVBM_FLAMEGOR_DESCRIPTION		= "Stellt einen Timer f\195\188r Fl\195\188gelsto\195\159 zur Verf\195\188gung und sagt Frenzy an.";
	LVBM_FLAMEGOR_ANNOUNCE_FRENZY		= "Frenzy ansagen";
	
	LVBM_FIREMAW_FIREMAW			= "Feuerschwinge";
	LVBM_EBONROC_EBONROC			= "Schattenschwinge";
	LVBM_EBONROC_FLAMEGOR			= "Flammenmaul";
	
	LVBM_FIREMAW_WING_BUFFET		= "Feuerschwinge beginnt Fl\195\188gelsto\195\159 zu wirken.";
	LVBM_EBONROC_WING_BUFFET		= "Schattenschwinge beginnt Fl\195\188gelsto\195\159 zu wirken.";
	LVBM_FLAMEGOR_WING_BUFFET		= "Flammenmaul beginnt Fl\195\188gelsto\195\159 zu wirken.";
	
	LVBM_FIREMAW_SHADOW_FLAME		= "Feuerschwinge beginnt Schattenflamme zu wirken.";
	LVBM_EBONROC_SHADOW_FLAME		= "Schattenschwinge beginnt Schattenflamme zu wirken.";
	LVBM_FLAMEGOR_SHADOW_FLAME		= "Flammenmaul beginnt Schattenflamme zu wirken.";
	
	LVBM_SHADOW_FLAME_WARNING		= "*** Schattenflamme in 2 Sek ***";
	LVBM_WING_BUFFET_WARNING		= "*** Fl\195\188gelsto\195\159 in %s Sek ***";
	LVBM_EBONROC_SHADOW_WARNING		= "*** %s hat Schattenschwinges Schatten ***";
	LVBM_FLAMEGOR_FRENZY			= "%s ger\195\164t in Raserei!";
	
	LVBM_EBONROC_SHADOW_REGEXP		= "([^%s]+) (%w+) von Schattenschwinges Schatten betroffen.";
	LVBM_EBONROC_SHADOW_REGEXP2		= "Schattenschwinges Schatten schwindet von ([^%s]+)%.";
	
	LVBM_SBT["Wing Buffet"]			= "Fl\195\188gelsto\195\159";
	LVBM_SBT["Wing Buffet Cast"]		= "Fl\195\188gelsto\195\159 Cast";
	LVBM_SBT["Shadow Flame Cast"]		= "Schattenflamme Cast";
	
	
	--Chromaggus
	LVBM_CHROMAGGUS_NAME			= "Chromaggus";
	LVBM_CHROMAGGUS_DESCRIPTION		= "Stellt einen Timer f\195\188r seinen Atem zur Verf\195\188gung und sagt die Verwundbarkeit an.";
	LVBM_CHROMAGGUS_ANNOUNCE_FRENZY		= "Frenzy ansagen";
	LVBM_CHROMAGGUS_ANNOUNCE_VULNERABILITY	= "Verwundbarkeit ansagen";
	
	LVBM_CHROMAGGUS_BREATH_1		= "Atem 1";
	LVBM_CHROMAGGUS_BREATH_2		= "Atem 2";
	
	LVBM_CHROMAGGUS_BREATH_CAST_WARNING	= "*** Chromaggus begins to cast %s ***"
	LVBM_CHROMAGGUS_BREATH_WARNING		= "*** %s in 10 Sek ***"
	
	LVBM_CHROMAGGUS_BREATH_REGEXP		= "Chromaggus begins to cast ([%w%s]+)"; --do not translate this!
	LVBM_CHROMAGGUS_VULNERABILITY_REGEXP	= "[^%s]+ [^%s]+ (%w+) Chromaggus for (%d+) ([^%s]+) damage";
	LVBM_CHROMAGGUS_CHROMAGGUS		= "Chromaggus";
	
	LVBM_SBT["Breath 1"]			= "Atem 1";
	LVBM_SBT["Breath 2"]			= "Atem 2";
	LVBM_SBT["Time Lapse"]			= "Zeitraffer";
	LVBM_SBT["Time Lapse cast"]		= "Zeitraffer Cast";
	LVBM_SBT["Ignite Flesh"]		= "Fleisch entz\195\188nden";
	LVBM_SBT["Ignite Flesh cast"]		= "Fleisch entz\195\188nden Cast";
	LVBM_SBT["Incinerate"]			= "Verbrennen";
	LVBM_SBT["Incinerate cast"]		= "Verbrennen Cast";
	LVBM_SBT["Frost Burn"]			= "Frostbeulen";
	LVBM_SBT["Frost Burn cast"]		= "Frostbeulen Cast";
	LVBM_SBT["Corrosive Acid"]		= "\195\132tzende S\195\164ure";
	LVBM_SBT["Corrosive Acid cast"]		= "\195\132tzende S\195\164ure Cast";
	
	--Nefarian
	LVBM_NEFARIAN_NAME			= "Nefarian";
	LVBM_NEFARIAN_DESCRIPTION		= "Stellt Timer f\195\188r Class Calls zur Verf\195\188gung.";
	LVBM_NEFARIAN_BLOCK_HEALS		= "Heilung w\195\164hrend Priester Calls blockieren";
	LVBM_NEFARIAN_UNEQUIP_BOW		= "Bogen/Gewehr vor Class Calls ausziehen";
	
	LVBM_NEFARIAN_SYNCKILLS_INFO		= "Syncronisiere kills in Phase1";

	LVBM_NEFARIAN_FEAR_WARNING		= "*** Fear in 1.5 Sek ***";
	LVBM_NEFARIAN_PHASE2_WARNING		= "*** Nefarian inc - 15 Sek ***";
	LVBM_NEFARIAN_CLASS_CALL_WARNING	= "*** Class Call bald ***";
	LVBM_NEFARIAN_SHAMAN_WARNING		= "*** Schamanen Call - Totems ***";
	LVBM_NEFARIAN_PALA_WARNING		= "*** Paladin Call - Segen des Schutzes ***";
	LVBM_NEFARIAN_DRUID_WARNING		= "*** Druiden Call - Katzengestalt ***";
	LVBM_NEFARIAN_PRIEST_WARNING		= "*** Priester Call - Nicht heilen! ***";
	LVBM_NEFARIAN_WARRIOR_WARNING		= "*** Krieger Call - Berserkerhaltung ***";
	LVBM_NEFARIAN_ROGUE_WARNING		= "*** Schurken Call - Teleportiert und festgewurzelt ***";
	LVBM_NEFARIAN_WARLOCK_WARNING		= "*** Hexenmeister Call - H\195\182llenbestien ***";
	LVBM_NEFARIAN_HUNTER_WARNING		= "*** J\195\164ger Call - B\195\182gen/Gewehre kaputt ***";
	LVBM_NEFARIAN_MAGE_WARNING		= "*** Magier Call - Polymorph ***";
	LVBM_NEFARIAN_HEAL_BLOCKED		= "Du darfst %s nicht w\195\164hrend einem Priester Call wirken!";
	LVBM_NEFARIAN_UNEQUIP_ERROR		= "Fehler bei dem Versuch die Waffe auszuziehen."
	LVBM_NEFARIAN_EQUIP_ERROR		= "Fehler bei dem Versuch die Waffe anzuziehen."

	LVBM_NEFARIAN_DRAKONID_DOWN = {};
	LVBM_NEFARIAN_DRAKONID_DOWN[1] = "Schwarzer Drakonid stirbt.";
	LVBM_NEFARIAN_DRAKONID_DOWN[2] = "Blauer Drakonid stirbt.";
	LVBM_NEFARIAN_DRAKONID_DOWN[3] = "Grüner Drakonid stirbt.";
	LVBM_NEFARIAN_DRAKONID_DOWN[4] = "Bronzener Drakonid stirbt.";
	LVBM_NEFARIAN_DRAKONID_DOWN[5] = "Roter Drakonid stirbt.";
	LVBM_NEFARIAN_DRAKONID_DOWN[6] = "Prismatischer Drakonid stirbt.";

	LVBM_NEFARIAN_KILLCOUNT			= "Aktuell getötet: %d";

	LVBM_NEFARIAN_BLOCKED_SPELLS	= {
		["Blitzheilung"]		= 1.5,
		["Große Heilung"]		= 2.5,
		["Gebet der Heilung"]		= 3,
		["Heilen"]			= 2.5,
		["Geringes Heilen"]		= 1.5,
	}
	
	LVBM_NEFARIAN_CAST_SHADOW_FLAME		= "Nefarian beginnt Schattenflamme zu wirken.";
	LVBM_NEFARIAN_CAST_FEAR			= "Nefarian beginnt Dr\195\182hnendes Gebr\195\188ll zu wirken.";
	LVBM_NEFARIAN_YELL_PHASE2		= "Sehr gut, meine Diener. Der Mut der Sterblichen scheint zu schwinden! Nun lasst uns sehen, wie sie sich gegen den wahren Herrscher des Blackrock behaupten werden!";
	LVBM_NEFARIAN_YELL_PHASE3		= "Impossible! Rise my minions!  Serve your master once more!";
	--thx 2 leidenschafft
	LVBM_NEFARIAN_YELL_SHAMANS		= "Schamanen";
	LVBM_NEFARIAN_YELL_PALAS		= "Paladine... ich habe geh\195\182rt, dass Ihr viele Leben habt. Zeigt es mir.";
	LVBM_NEFARIAN_YELL_DRUIDS		= "Druiden und ihre l\195\164cherliche Gestaltwandlung. Zeigt mal was Ihr k\195\182nnt!";
	LVBM_NEFARIAN_YELL_PRIESTS		= "Priester! Wenn Ihr weiterhin so heilt, k\195\182nnen wir es auch gerne etwas interessanter gestalten!";
	LVBM_NEFARIAN_YELL_WARRIORS		= "Krieger, Ich bin mir sicher, dass ihr kr\195\164ftiger als das zuschlagen k\195\182nnt!";
	LVBM_NEFARIAN_YELL_ROGUES		= "Schurken? Kommt aus den Schatten und zeigt Euch!";
	LVBM_NEFARIAN_YELL_WARLOCKS		= "Hexenmeister, Ihr solltet nicht mit Magie spielen, die Ihr nicht versteht. Seht Ihr was ich meine?";
	LVBM_NEFARIAN_YELL_HUNTERS		= "J\195\164ger und ihre l\195\164stigen Knallb\195\188chsen!";
	LVBM_NEFARIAN_YELL_MAGES		= "Auch Magier? Ihr solltet vorsichtiger sein, wenn Ihr mit Magie spielt...";
	
	LVBM_SBT["Class call CD"] 		= "Class Call CD";
	LVBM_SBT["Druid call"] 			= "Druiden Call";
	LVBM_SBT["Priest call"] 		= "Priester Call";
	LVBM_SBT["Warrior call"] 		= "Krieger Call";
	LVBM_SBT["Rogue call"] 			= "Schurken Call";
	LVBM_SBT["Mage call"] 			= "Magier Call";
end
