AdvancedOnlineMsg

Dieses Addon ersetzt die GildenMemberAlert Nachrichten 
durch eigene vollständig anpassbare Nachrichten.

Ausserdem lässt sich die Gildenliste durchsuchen mittels /gwho <text>


== Installation ==
Einfach ins Addonverzeichnis entpacken.

== Howto ==

** Suche:
Die eingebaute Suche durchsucht alle Felder (Name, Rang, Zone, Notiz, 
Offinote, Level, ...) der kompletten Gildenliste (incl. Offline Member) nach dem
suchstring, der mittels /gwho übergeben wurde. Das Ergebnis wird in den 
DefaultChatFrame ausgegeben (der "Allgemein" Reiter vom Chat) 

Beispiele:
/gwho schurke
-- sollte alle Schurken ausgeben, falls jmd Hansschurkenwurst heisst, wird
dieser ebenfalls mit ausgegeben

/gwho leder
-- sollte diverse Leute ausgeben, die Lederverarbeitung als Beruf haben,
vorrausgesetzt es ist in den Notizen vermerkt

/gwho 55
-- dürfte die Player ausgeben, die Level 55 sind.

Da die Suche alle(!) zur Verfügung stehenden Daten nutzt können immer ein paar
seltsame Ergebnisse erscheinen. Suchen nach Dingen, die auf alle zutrifft
funktionieren zwar, spammen das Chatfenster allerdings ordentlich voll.

Die Ausgabe der suche nutzt zum Formatieren die Einstellung, die für die Online 
bzw. Offline Nachricht eingestellt ist. Wenn diese also "<name> ist doof" lautet,
dann wird das ergebnis aus einer längeren liste doofer Leute bestehen :)

** Online / Offline Nachricht anpassen:

Um die angepassten Nachrichten an/auszuschalten einfach den Befehl
/aom showon			-- Für die Anzeige der neuen ...ist jetzt online Nachricht
bzw
/aom showoff		-- Für die Anzeige der neuen ...ist jetzt offline Nachricht
benutzen. Ist die Anzeige deaktiviert, so wird die in WoW eingebaute Ausgabe
genutzt.

Die Online und die Offline Nachricht lassen sich seperat an die eigenen 
Bedürfnisse anpassen. Dabei können sämtliche Felder, die auch in der Gildenliste
zu einem Spieler angegeben sind, verwendet werden.

Für beide Nachrichten ist ein Mustertext mit speziellen Tags angegeben, die
später vom Programm durch die eigentlichen Informationen ersetzt werden.

** Diese speziellen Tags sind die folgenden:
<name> Name des Spielers. 
!Ist der Spieler online, so wird der Name automatisch zu einem anklickbaren Link! 

<rank> Name des Gildenrangs, den der Spieler hat 
<rankIndex> Nummer, die dem Gildenrang entspricht 
<level> Level des Spielers als Zahl 
<class> Klasse des Spielers 
<zone> Zone in der sich der Spieler befindet (Winterspring, ...) 
<note> Die Spielernotiz 
<officernote> Die Officernotiz zu dem Spieler 
<online> ist 'online' oder 'offline', je nachdem, was derjenige nun ist 
<status> Status vom Spieler ('<AFK>', '<DND>' oder '') 

Damit das ganze nicht so langweilig aussieht lässt sich noch die Farbe ändern:
<colorRRGGBB> färbt alles, was danach kommt in der Farbe RRGGBB.
Beispielsweise <colorffffff> für Weiss oder <colorff0000> für Rot.
Wird keine Farbe angegeben (bzw. bis zu dem ersten auftreten einer Farbe) wird 
die Standardfarbe verwendet. Im Falle der On/Offline Benachrichtigungen ist das
Gelb und lässt sich im Channel Menü des Chats einstellen.

Um nun ein solches Muster festzulegen benutzt man einfach
/aom seton <muster>				-- für die Online Nachricht    
/aom setoff <muster>			-- für die Offline Nachricht

** Beispiele:
Um das gleiche Ergebnis zu erzielen, was WoW standardmäßig tut müsste man
/aom seton <name> ist jetzt online.
/aom setoff <name> ist jetzt offline.
verwenden.

Wem das zu langweilig ist (dafür ist das addon ja eigentlich gedacht^^), der kann
beispielsweise auch folgendes benutzen:
/aom seton <name> <color33ff00>(<level> <class> @<zone>) <officernote>    
/aom setoff <name> <colorff3300>(<level> <class> @<zone>) <officernote>    

Was dann beispielsweise ausgibt:
online (Nach dem Namen alles in Grün): 
[Noja] (60 Jäger @Winterspring) [M]Noja
offline (Nach dem Namen alles in Rot): 
Noja (60 Jäger @Winterspring) [M]Noja


== ACHTUNG ==
Dieses Addon ersetzt die Nachrichten, falls andere Addons auf die Nachrichten
zugreifen wollen, so kann das zu Problemen führen, weil die Nachrichten einen
vollkommen anderen Syntax aufweisen.
