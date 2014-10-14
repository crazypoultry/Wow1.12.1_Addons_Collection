if (GetLocale() == "deDE") then

--
-- Deutsch
--

DDhelp = {	"Einstellungen:   /dd", -- 1
		"Syntax:   /dd <befehl>", -- 2
		"Befehle:   ", -- 3
		"Weitere Informationen zu den Befehlen sind in der HTML-Anleitung zu finden, die dem Addon beiliegt.", -- 4
}

DOCDRUID = {	"Heilende Ber\195\188hrung", -- Spell -- 1
		"Heilende Ber\195\188hrung (ohne Rang-Erh\195\182hung)", -- 2
		"Nachwachsen", -- Spell -- 3
		"Nachwachsen (ohne Rang-Erh\195\182hung)", -- 4
		"Verj\195\188ngung", -- Spell -- 5
		"Mal der Wildnis", -- Spell -- 6
		"Dornen", -- Spell -- 7
		"Entgiften", -- 8
		"Anregen", -- Spell -- 9
		"Mondfeuer", -- Spell -- 10
		"Anregen: Kein Hinweis", -- 11
		"Anregen: Gefl\195\188sterter Hinweis", -- 12
		"Anregen: Gruppenhinweis", -- 13
		"Anregen: Schlachtgruppenhinweis", -- 14
		"Form: Druidengestalt", -- 15
		"Form: B\195\164rengestalt", -- 16
		"Form: Wassergestalt", -- 17
		"Form: Katzengestalt", -- 18
		"Form: Reisegestalt", -- 19
		"Form: Moonkin", -- 20
		"Totem-Mondfeuer", -- 21
		"Katze: Schleichen (nicht abschaltbar)", -- 22
		"Katze: Angriff von vorn", -- 23
		"Katze: Angriff von hinten", -- 24
		"Verbessertes Mondfeuer", -- Talent -- 25
		"Mondschein", -- Talent -- 26
		"Mondfuror", -- Talent -- 27
		"Verbesserte Heilende Ber\195\188hrung", -- Talent -- 28
		"Geschenk der Natur", -- Talent -- 29
		"Verbesserte Verj\195\188ngung", -- Talent -- 30
		"Gelassener Geist", -- Talent -- 31
		"Vergiftung heilen", -- Spell -- 32
		"Vergiftung aufheben", -- Spell -- 33
		"Einzelne Entgiftung", -- 34
		"Multiple Entgiftung", -- 35
		"Maximale Heilung \195\188ber Zeit: 1x", -- 36
		"Maximale Heilung \195\188ber Zeit: INAKTIV", -- 37
		"Schleichen", -- Spell / Catform -- 38
		"otem", -- Totem-Attribute UnitName() -- 39
		"Totem", -- Totem-Attribute UnitCreatureType() -- 40
		"WARRIOR", -- Totem-Attribute UnitClass() -- 41
		"Rang", -- Part of spell name, used for strings like 'Healing Touch(Rank 9)' / 'Heilende Berührung(Rang 9)' -- 42
		": Du besitzt diesen Zauber nicht.", -- 43
		": Bitte ein freundliches Ziel ausw\195\164hlen.", -- 44
		"Ein ", " verwendet kein Mana.", -- these belong together -- 45, 46
		"Ziel nicht in Reichweite.", -- 47
		"Besitzt noch mehr als 75% Mana.", -- 48
		"Buff", -- 49
		"[Anregen] f\195\188r Euch.", -- 50
		"[Anregen] f\195\188r ", -- 51
		"Nicht genug Mana. ", " nicht m\195\182glich.", -- these belong together -- 52, 53
		"Nichts zu entgiften.", -- 54
		" => ", -- 55
		" (Mangels Mana reduziert um ", " / maximal Rang ", " bei diesem Ziel", ")", -- these belong together -- 56, 57, 58, 59
		", Rang ", " von ", -- these belong together -- 60, 61
		" (Max. Heilung)", -- 62
		" (", " Schaden)", " Schaden, gesch\195\164tzt)", -- these belong together -- 63, 64, 65
		" nicht notwendig", -- 66
		"Umschalter: Maximale HOTs", -- 67
		" (Erh\195\182ht um ", ")", -- these belong together -- 68, 69
		" (Freizauberzustand: Maximaler Rang)", -- 70
		" (Kampf => Maximale Verj\195\188ngung)", -- 71
		"Entgiften: ", -- 72
		"Anspringen", -- Spell / Catform -- 73
		"Verheeren", -- Spell / Catform -- 74
		"Zerfetzen", -- Spell / Catform -- 75
		"Wilder Biss", -- Spell / Catform -- 76
		"Krallenhieb", -- Spell / Catform -- 77
		"Klaue", -- Spell / Catform -- 78
		"Schreddern", -- Spell / Catform -- 79
		"Ducken", -- Spell / Catform -- 80
		"Tigerfuror", -- Spell / Catform -- 81
		"Maximale Heilung \195\188ber Zeit: 2x", -- 82
		"Maximale Heilung \195\188ber Zeit: PERMANENT", -- 83
		" (Max. HoT: 1x)", -- 84
		" (Max. HoT: 0x)", -- 85
		": Noch nicht bereit.", -- 86
		" (Ohne vorzeitige Finisher)", -- 87
		"Feenfeuer (Tiergestalt)", -- 88
		"[Anregen] Abklingzeit: ", -- 89
		"Sekunden", -- 90
		"Minuten", -- 91
		"Form: Wasser- oder Reisegestalt", -- 92
		"Form: Druidengestalt + Schnelligkeit der Natur", -- 93
		"Schnelligkeit der Natur", -- 94
		"Er\195\182ffnung", -- 95
		"Automatisch", -- 96
		" vor Er\195\182ffnungsangriff", -- 97
		"Immer ducken", -- 98
		"Ducken, falls Aggro", -- 99
		"Katzenform", -- 100
		"B\195\164renform", -- 101
		"Fluch aufheben", -- 102
		"Entgiften/Entfluchen: ", -- 103
		"Es wurden keine Zauber zum Entfernen von Giften oder Fl\195\188chen gefunden.", -- 104
		"Du besitzt keinen Zauber zum Entfernen von Gift.", -- 105
		"Du besitzt keinen Zauber zum Entfernen von Fl\195\188chen.", -- 106
		"Kein Gift oder Fluch gefunden.", -- 107
		"Gift oder Fluch entfernen", -- 108
		"H\195\182here Priorit\195\164t", -- 109
		"Gift", -- 110
		"Fluch", -- 111
		"Standard", -- 112
		"Schlie\195\159en", -- 113
		"Knurren", -- 114
		"Zermalmen", -- 115
		"Prankenhieb", -- 116
		"Demoralisierendes Gebr\195\188ll", -- 117
		"Hieb", -- 118
		"Wilde Attacke", -- 119
		"Wutanfall", -- 120
		"Herausforderndes Gebr\195\188ll", -- 121
		"Taste 3: ", " erlauben", -- these belong together -- 122, 123
		"Taste 1+2+3: Immer knurren, falls sonst nichts ausgef\195\188hrt wird", -- 124
		"Taste 1+2+4: Knurren, wenn Aggro verloren", -- 125
		"B\195\164r #1: Angriff auf einzelnes Ziel", -- 126
		"B\195\164r #2: Angriff auf mehrere Ziele", -- 127
		"B\195\164r #3: Spezialf\195\164higkeit(en)", -- 128
		"Rasende Regeneration", -- 129
		" (Ab 70 Wut und unter 70% Leben)", -- 130
		"Nicht im PvP", -- 131
		" vor Finishern", -- 132
		"Stunden", -- 133
		"Tage", -- 134
		" heilt...\nBen\195\182tigte Zeit: ", -- 135
		"Statistiken", -- 136
		"Setup", -- 137
		"Heiler-Attribute", -- 138
		"+Heilung", -- 139
		"Mana", -- 140
		"Mana-Reg / 5s", -- 141
		"Berechnen", -- 142
		"Char-Werte", -- 143
		"G\195\182tze der Wildheit", -- 144
		"G\195\182tze der Gesundheit", -- 145
		"G\195\182tze der Langlebigkeit", -- 146
		"G\195\182tze der Unmenschlichkeit", -- 147
		"G\195\182tze der Verj\195\188ngung", -- 148
		"G\195\182tze der Mondes", -- 149
		"Allgemeine Einstellungen", -- 150
		"Tier-Funktionen (Feral) und dynamische Wucherwurzeln aktivieren", -- 151
		"Top 9 der Heilzauber bei diesen Attributen:", -- 152
		"Textausgabe in welchem Fenster? (1-15; 0 = Keine Textausgabe)", -- 153
		"Speichern", -- 154
		"Einstellungen", -- 155
		"Norm. Angriffe", -- 156
		"Finisher", -- 157
		"Beide", -- 158
		"Humanoide aufsp\195\188ren", -- 159
		"Erneutes Dr\195\188cken der Katzenform-Taste = Humanoide aufsp\195\188ren", -- 160
		"Katze: Schleichen (abschaltbar)", -- 161
		"Katze&Nachtelf: Schleichen abschalten", -- 162
		"[Wiedergeburt ", -- 163
		"[Wiedergeburt] Abklingzeit: ", -- 164
		"Wiedergeburt", -- 165
		"Ahornsamenkorn", -- 166
		"Schlingendornsamenkorn", -- 167
		"Eschenholzsamenkorn", -- 168
		"Hainbuchensamenkorn", -- 169
		"Eisenholzsamenkorn", -- 170
		"Ung\195\188ltiges Ziel", -- 171
		"[Wiedergeburt] Keine Reagenz gefunden.", -- 172
		"] f\195\188r ", -- 173
		"] Nun bitte ein Ziel w\195\164hlen.", -- 174
		"Wiedergeburt: Kein Hinweis bei Abklingzeit", -- 175
		"Gleichzeitig", -- 176
		"Einstellungen der Schleichen-Taste", -- 177
		"Einstellungen der Angriffs-Tasten", -- 178
		"+Tigerfuror", -- 179
		"Erneutes Dr\195\188cken der Katzenform-Taste = Schleichen", -- 180
		"Elementar", -- 181
		"Wucherwurzeln", -- 182
		" (", " Wurzeln pro Minute)", -- 183,184 -- these belong together
		"Dynamische Wucherwurzeln", -- 185
		": Bitte ein Ziel ausw\195\164hlen.", -- 186
		"Allgemein", -- 187
		"Heilung", -- 188
		"Katzenform", -- 189
		"B\195\164renform", -- 190
		"Balance", -- 191
		"Zur\195\188ck", -- 192
		"Wucherwurzel-Rang gegen Spieler (PvP), 0 = dynamisch", -- 193
		"Wucherwurzel-Rang gegen Mobs (PvE), 0 = dynamisch", -- 194
		"Wirklich Standardeinstellungen wiederherstellen?", -- 195
		"Ja", -- 196
		"Nein", -- 197
		"Standardeinstellungen wiederhergestellt.", -- 198
		"Feenfeuer", -- 199
		"Wiedergeburt: Gruppenhinweis bei Abklingzeit", -- 200
		"Wiedergeburt: Schlachtgruppenhinweis bei Abklingzeit", -- 201
		"Feenfeuer in jeder Gestalt", -- 202
		" im Kampf (PvE)", -- 203
		" im Kampf (PvP)", -- 204
		"Selbst anregen: Kein Hinweis", -- 205
		"Selbst anregen: Gruppenhinweis", -- 206
		"Selbst anregen: Schlachtgruppenhinweis", -- 207
		"Erneutes Dr\195\188cken der B\195\164renform-Taste = Wutanfall", -- 208
		"Erneutes Dr\195\188cken der B\195\164renform-Taste = Wilde Attacke", -- 209
		"Erneutes Dr\195\188cken der B\195\164renform-Taste = Hieb", -- 210
		"B\195\164rentasten 2 und 4 miteinander vertauschen", -- 211
		"B\195\164rentasten 2 und 4 sind nun VERTAUSCHT.", -- 212
		"B\195\164rentasten 2 und 4 sind nun NORMAL.", -- 213
		"Erneutes Dr\195\188cken der B\195\164renform-Taste = B\195\164rentaste 4", -- 214
		"B\195\164r #4: Maximale Aggro-Erzeugung", -- 215
		"B\195\164r #2 und #4 vertauschen", -- 216
		"\nImmer Krallenhieb versuchen, wenn zu wenig Energie f\195\188r Klaue\n(Nur wenn bei 'Norm. Angriffe' 'Beide' eingestellt ist)", -- 217
		"Sekunde", -- 218
		"Minute", -- 219
		"Stunde", -- 220
		"Tag", -- 221
		"B\195\164ren- und Katzendruiden werden nicht angeregt. (Siehe Einstellungen)", -- 222
		"Druiden in B\195\164rengestalt/Katzengestalt nicht anregen", -- 223
		"Es seidenn, das neue Ziel des Ziels ist ein Krieger", -- 224
		"Nicht spezifiziert", -- 225
		"Automatisch freundlichen Zielen helfen (Ziel des Ziels anw\195\164hlen)", -- 226
		" sofort", -- 227
		" \195\188ber Zeit", -- 228
}

DDcmd = {	"mdw", -- 1
		"dornen", -- 2
		"hb", -- 3
		"hb+", -- 4
		"nachwachsen", -- 5
		"nachwachsen+", -- 6
		"verjuengung", -- 7
		"maxheal", -- 8
		"entgiften", -- 9
		"anregen", -- 10
		"anregen1", -- 11
		"anregen2", -- 12
		"anregen3", -- 13
		"caster", -- 14
		"caster+", -- 15
		"baer", -- 16
		"katze", -- 17
		"moonkin", -- 18
		"reisewasser", -- 19
		"reisegestalt", -- 20
		"wassergestalt", -- 21
		"totem", -- 22
		"katzemulti", -- 23
		"katzevorn+", -- 24
		"katzehinten+", -- 25
		"katzevorn", -- 26
		"katzehinten", -- 27
		"giftfluch", -- 28
		"baer1", -- 29
		"baer2", -- 30
		"baer3", -- 31
		"katzemulti2", -- 32
		"stopstealth", -- 33
		"wiedergeburt", -- 34
		"wurzeln", -- 35
		"wiedergeburt1", -- 36
		"wiedergeburt2", -- 37
		"feenfeuer", -- 38
		"selbstanregen", -- 39
		"selbstanregen2", -- 40
		"selbstanregen3", -- 41
		"baer4", -- 42
		"baertausch", -- 43
}

-- Unvollständige Instanz-Namen genügen hier ... um Umlaute und Sonderzeichen zu umgehen.
instanceZone = {
	{ lvlmin = 15, lvlmax = 18, diff =  1, name = "ragefireabgrund" },
	{ lvlmin = 15, lvlmax = 22, diff =  1, name = "todesminen" },
	{ lvlmin = 15, lvlmax = 22, diff =  1, name = "wehklagens" },
	{ lvlmin = 18, lvlmax = 26, diff =  2, name = "shadowfang" },
	{ lvlmin = 20, lvlmax = 27, diff =  2, name = "blackfathom" },
	{ lvlmin = 23, lvlmax = 30, diff =  2, name = "palisaden" },
	{ lvlmin = 25, lvlmax = 31, diff =  3, name = "kral von razorfen" },
	{ lvlmin = 30, lvlmax = 37, diff =  3, name = "gnomeregan" },
	{ lvlmin = 35, lvlmax = 40, diff =  3, name = "gel von razorfen" },
	{ lvlmin = 35, lvlmax = 42, diff =  4, name = "scharlachrote kloster" },
	{ lvlmin = 40, lvlmax = 50, diff =  4, name = "uldaman" },
	{ lvlmin = 43, lvlmax = 47, diff =  4, name = "farrak" },
	{ lvlmin = 45, lvlmax = 52, diff =  5, name = "maraudon" },
	{ lvlmin = 49, lvlmax = 55, diff =  5, name = "versunkene tempel" },
	{ lvlmin = 55, lvlmax = 60, diff =  6, name = "blackrocktiefen" },
	{ lvlmin = 55, lvlmax = 60, diff =  6, name = "stratholme" },
	{ lvlmin = 57, lvlmax = 62, diff =  6, name = "scholomance" },
	{ lvlmin = 55, lvlmax = 65, diff =  7, name = "sterbruch" },
	{ lvlmin = 55, lvlmax = 65, diff =  7, name = "blackrockspitze" },
	{ lvlmin = 60, lvlmax = 70, diff =  8, name = "geschmolzene kern" },
	{ lvlmin = 60, lvlmax = 70, diff =  9, name = "pechschwingenhort" },
	{ lvlmin = 60, lvlmax = 70, diff = 10, name = "onyxias hort" },
	{ lvlmin = 60, lvlmax = 70, diff = 10, name = "gurub" },
	{ lvlmin = 60, lvlmax = 70, diff = 11, name = "qiraj" },
	{ lvlmin = 60, lvlmax = 70, diff = 12, name = "naxxramas" },
	{ lvlmin = 60, lvlmax = 70, diff = 13, name = "hellfire zitadelle" },		--?
}

classlist = {
	druide="DRUID", magier="MAGE", paladin="PALADIN", priester="PRIEST", schurke="ROGUE", schamane="SHAMAN",
	krieger="WARRIOR", hexer="WARLOCK", hexenmeister="WARLOCK", jaeger="HUNTER", jaegermeister="DRUNK",
}

end
