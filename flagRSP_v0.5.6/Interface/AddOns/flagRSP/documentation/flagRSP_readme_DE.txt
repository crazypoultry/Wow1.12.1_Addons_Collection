flagRSP is an addon for roleplayers to enhance their roleplaying 
experience. You can set different flags and information other 
players will see. An enhanced Friendlist is also included.

Please report bugs (even spelling or language mistakes) or send suggestions
for flagRSP/Friendlist to the following addresses AFTER READING THE 
TROUBLESHOOTING SECTION:

flokru-flagrsp@flokru.gnuu.de

You can find flagRSP discussion forums here:

http://www.fabledrealm.com/flagrsp


1. DEUTSCHE ANLEITUNG

flagRSP & Friendlist basieren auf xTooltip von Per 'Doxxan' Lönn Wege und 
flagRSP & Friendlist von Zmrzlina (der die meisten Features entwickelt 
hat). Ich (flokru) werde versuchen, dieses Addon weiter zu pflegen und 
entwickeln.

Mein Dank geht daher an Zmrzlina, der dieses Addon in der jetzigen Form 
überhaupt erst möglich gemacht hat und die WoW-Welt leider verlassen hat!


Features
--------

Hier eine Übersicht über die Features von flagRSP und Friendlist (alles 
optional):

- Einen von vier verschiedene Rollenspieler-Flags setzen, um das
  eigene Rollenspielverhalten anderen Spielern anzuzeigen (s.u.).
- Einen Nachnamen für den Charakter wählen, der anderen Spielern mit 
  flagRSP dann auch angezeigt wird.
- Einen Titel für den Charakter wählen.
- Eine Beschreibung der Äußerlichkeiten des eigenen Charakters eingeben,
  die auch anderen flagRSP-Nutzern angezeigt wird.
- Spieler beider Fraktionen auf die Friendlist setzen (inkl. Nachnamen).
- Gilden als Freunde oder Feinde markieren.
- NPCs/Mobs als Freunde oder Feinde markieren.
- Notizen zu Spielern/Gilden/NPCs in die Friendlist eintragen. 
- Exakte Levelangaben durch relative Levelangaben ("keine Herausforderung"
  bis "hoffnungslos überlegen") ersetzen.
- Namen unbekannter Spieler verstecken.
- RP-Flags, Nachname und Titel über ein GUI konfigurieren (erweitertes GUI
  folgt später).
- Feinde werden bei einem MouseOver akustisch signalisiert.
- Eigene Flags und Tags durch spezielle Option anzeigen, die ein Tooltip 
  für den eigenen Spieler erstellt.
- Vollständig abwärtskompatibel zu xTooltip2.
- Ersetzen der Levelangaben im Targetframe.


In eigener Sache
----------------

Leider musste ich feststellen, dass in diversen Internetforen Leute
über Bugs von flagRSP berichten. Unfairerweise geht diese Kritik auch
schonmal so weit, dass flagRSP als "crap" beschimpft wird oder Nutzer
sich über Fehlfunktionen aufregen. Dummerweise lese ich dort von Bugs,
von denen ich noch nie gehört habe.

1. Ich entwickle flagRSP freiwillig und OHNE Bezahlung.
2. Ich bin kein professioneller Programmierer.
3. Aus 1./2. folgt, dass ich sicherlich Fehler mache, die zu Bugs führen.
4. Ich habe nie irgendwelche Garantien gegeben, dass irgendwas funktioniert.
5. flagRSP ist inzwischen so komplex, dass ich nicht alle Möglichkeiten 
   testen kann. Somit gibt es sicher Bugs, die ich NIE finden werde.
6. Ich bin bemüht, ein möglichst fehlerfreies Addon abzuliefern.
7. Um 6. unter 5. zu erreichen, BRAUCHE ICH BUGREPORTS.
8. Bugfixes kommen bei mir immer an erster Stelle. Aber ich kann Bugs nur
   fixen, wenn ich davon weiß.


Installation
------------

Die Installation ist simpel. Einfach die ZIP-Datei in das
World-of-Warcraft-Verzechnis entpacken (dabei darauf achten, dass die
Verzeichnisstruktur mit entpackt wird und nicht nur die Dateien) oder
im Installer das World-of-Warcraft-Verzeichnis auswählen. Danach
sollten die Addons auch schon funktionieren.

dsIm Spiel sollte dann im Chatfenster eine Meldung erscheinen, dass
flagRSP initialisiert wird. Nach ungefähr einer Minute sollte eine 
Meldung erscheinen, dass flagRSP initialisiert ist. Weiterhin sollte 
an der Minimap ein Button für die Friendlist erscheinen.

WICHTIG: Eigentlich sollte der folgende Schritt unnötig sein. Leider
passiert es jedoch aus bisher ungeklärten Gründen selten, dass dabei
etwas schief läuft.

Es muss unbedingt nach der Installation im Spiel überprüft werden, ob
flagRSP ordnungsgemäß dem Chatkanal "xTensionXTooltip2" beitreten
konnte. Normalerweise sollte dies automatisch NACH EIN BIS ZWEI
MINUTEN (nachdem flagRSP gemeldet hat, dass es initialisiert ist) 
durch das Addon passieren, was aber leider (vor allem im Zusammenhang 
mit Cosmos) hin und wieder nicht klappt.

Dazu muss die Maus auf das Hauptchatfenster bewegt werden, bis der
Reiter "Allgemein" oder "General" sichtbar wird. Danach kann man durch
einen Rechtsklick das entsprechende Menü öffnen. Bei dem Punkt
"Channels" sollte dann ein weiteres Menü aufgehen, in dem alle aktiven
Chatkanäle aufgelistet sind.

In dieser Liste sollte auch "xTensionXTooltip2" zu finden sein
(evtl. kleingeschrieben). IST DAS NICHT DER FALL, MUSS DEM KANAL
MANUELL BEIGETRETEN WERDEN. Dazu gibt man folgenden Befehl ein:

/join xTensionXTooltip2

Danach sollte auch nach Spielneustart der Channel nach dem Einloggen
in der Liste erscheinen. Sollte er danach immer noch nicht da sein,
bitte ich um einen Bugreport per Mail.

Der Channel ist DIE zentrale Funktion von flagRSP. Die einzige
Funktion des Channels ist, anderen Nutzern von flagRSP seine Flags zu
senden. Deren Addon horcht in diesem Channel und wertet die
Steuerbefehle aus, um zu wissen, bei welchem Spieler was in den
Tooltip geschrieben werden muss. Es gibt keine andere Möglichkeit, per
Addon Daten zwischen verschiedenen Clients hin und her zu
schicken. 

Allerdings ist es anzuraten, den Channel stumm zu stellen, damit das
Spiel nicht durch die Steuernachrichten aus dem Kanal beeinträchtigt
wird:

Es gibt einen Unterschied dazwischen, ob man einem Channel beigetreten
und dieser "an" ist oder ob man die Nachrichten des Channels in seinem
Chatfenster auch anzeigen lässt.

Ist ersteres nicht der Fall, kann das Addon nicht richtig
funktionieren, weil es -wie bereits gesagt- keine Möglichkeit hat, mit
anderen Clients zu kommunizieren.

Das heißt aber nicht, dass man sich diese Daten auch anzeigen lassen
muss. Man kann sich in WoW mehrere Chatfenster erstellen und in
einzelne Fenster einzelne Kanäle legen (die dann nur dort angezeigt
werden). Genauso kann man aber auch in jedem Chatfenster (auch wenn
man nur eins hat) jeden Kanal auf stumm schalten. Damit wird dann
technisch gesehen der Channel nicht verlassen, sondern nur die Anzeige
dessen für dieses Fenster deaktiviert.

In der Datei flagRSP_FAQ_DE.txt steht, wie das geht.


SICHERHEIT
----------

Dieser Punkt ist sehr wichtig! flagRSP hat keine Möglichkeit, seine Daten 
in bestimmte Dateien zu schreiben. Deswegen kann flagRSP auch KEINE Backups
von den vorgenommenen Einstellungen, den Friendlist-Einträgen und der 
eigenen Charakterbeschreibung anlegen.

flagRSP kann WoW lediglich sagen, welche Daten es speichern soll. 
Allerdings kann WoW diese Daten sofortig löschen, sobald etwas schief 
läuft. Diese "garbage collection" ist normalerweise gut und sinnvoll, damit
man nach der Deinstallation von RAM-hungrigen Addons keinen aufgeblähten 
Speicher zu befürchten hat. WoW löscht dessen Daten einfach, so dass man 
sich darum keine Sorgen machen braucht.

Seine Friendlist-Einträge oder die Beschreibung zu verlieren, nur weil in 
WoW/flagRSP etwas schiefgelaufen ist, kann jedoch eine sehr schmerzhafte 
Erfahrung sein. Deswegen sollte man seine Einstellungen so oft wie möglich
sichern!

Wie man Einstellungen sichert: Im WoW-Verzeichnis befindet sich ein 
Unterverzeichnis mit Namen "WTF". Wenn man dem Pfad 
"WTF\Account\<Accountname>\SavedVariables\" folgt, findet man in diesem 
Verzeichnis normalerweise mehrere .lua- und .lua.bak-Dateien. Für flagRSP
braucht man die Dateien flagRSP.lua und Friendlist.lua. Diese beiden 
Dateien sollte man in ein anderes Verzeichnis kopieren, wo sie sicher sind.

Falls irgendetwas schief läuft (weil z.B. WoW die Daten löscht), kann man 
einfach diese Backup-Dateien in dieses Verzeichnis zurückkopieren.


Nutzung
-------

Um auf die Optionen von flagRSP zuzugreifen kann das Kommando 
"/rsp [optionen]" im Chatprompt verwendet werden. Hier ist eine Übersicht
über die verfügbaren Optionen.

/rsp ?                           Zeigt die Hilfe an.
/rsp toggle                      (De)Aktiviert Rollenspieler-Flag.
/rsp namen                       (De)Aktiviert das Verstecken unbekannter
                                 Namen.
/rsp level                       (De)Aktiviert die alternative Levelanzeige.
/rsp ranks                       (De)Aktiviert die Anzeige der PvP-Ränge.
/rsp guilds                      (De)Aktiviert die Anzeige der Gildennamen.
/rsp nachname <TEXT>             Setzt Nachname auf <TEXT>.
/rsp titel <TEXT>                Setzt Titel auf <TEXT>.
/rsp [beginner/leicht/normal/
      dauer/aus]                 Setzt bevorzugte Rollenspielart:
     beginner                    Rollenspielanfänger, d.h. RP-Newbie, dem 
                                 evtl. Fehler verziehen werden sollten.
     leicht                      Gelegenheitsrollenspieler, d.h. jemand, 
                                 der OOC-Chat braucht oder zumindest  
                                 akzeptiert.
     normal                      Normaler Rollenspieler, d.h. jemand, der 
                                 generell kein OOC wünscht, sich aber ggf.
                                 anpasst.
     dauer                       Vollzeitrollenspieler, d.h. jemand, der 
                                 OOC strikt ablehnt und vollzeit in seiner
                                 Rolle ist.
     aus                         Rollenspiel-Flag komplett entfernen.
/rsp [ooc/ic/ffa-ic/
      stopcharstat]              Setzt Charakter-Status:
     ooc                         Out of character, Spieler spielt nicht 
                                 seine Rolle.
     ic                          In character, Spieler spielt seine Rolle!
     ffa-ic                      In character free-for-all, wie ic, Spieler
                                 wünscht IC-Kontakt zu anderen 
                                 Rollenspielern.
     st                          Spielleiter-Modus. Spieler leitet RP bzw.
                                 einen Plot.
     stopcharstat                Charakter-Status-Flag entfernen.
/rsp afk                         Setzt Spieler auf afk uns stoppt das Senden
                                 der eigenen Flags (was den Afk-Modus sonst
                                 unterbrechen würde).
/rsp edit                        Öffne eine Edit-Box für das Description-
                                 Tag.
/rsp status                      Zeigt eine Übersicht der Optionen für den
                                 aktuellen Spieler.
/rsp owntooltip                  (De)Aktiviert die Anzeige eines Tooltips 
                                 für sich selbst.
/rsp stat                        Benutzungsstatistik anzeigen.
/rsp toggletooltip               flagRSPs Tooltip-Modifikationen 
                                 umschalten.
                                 Mit dieser Option kann flagRSP daran 
                                 gehindert werden, den Tooltip zu ändern 
                                 bzw. der Light-Modus aktiviert werden.
/rsp purgeinterval               Stellt ein, wie lange flagRSP die zwischen-
                                 gespeicherten Flags und Descriptions 
                                 vorhält (in Tagen, Standard ist 14 Tage).
/rsp standby                     Veranlasst, dass flagRSP den Daten-
                                 Chatkanal verlässt (z.B. aus 
                                 Performancegründen). Siehe Changelog für
                                 Details.
/rsp collect                     Stoppt das automatische Erkennen des AFK-
                                 Modus, um Flags und Descriptions zu 
                                 sammeln.
/rspan                           Aktiviert normales Rollenspiel-Flag und 
                                 alternative Namens- und Levelanzeige.
/rspaus                          Deaktiviert Rollenspiel-Flag, alternative
                                 Namens- und Levelanzeige und löscht 
                                 Nachnamen und Titel.

Für die Optionen von Friendlist stehen die Kommandos "/fl" und "/friendlist"
zur Verfügung. Hier eine Übersicht über die Optionen.

/fl                              Hilfe anzeigen.
/fl help                         Hilfe anzeigen.
/fl show                         Friendlist-Fenster anzeigen.
/fl hide                         Friendlist-Fenster verstecken.
/fl mm <an/aus>                  Zeigt den Button an der Minimap an
                                 oder blendet ihn aus.
/fl buttonpos <ANGLE>            Setzt Position des Minimapbuttons 
                                 auf <ANGLE> mit 0<= <ANGLE> <=360.
/fl add <NAME> <NACHNAME>        Spieler/Objekt <NAME> mit Nachname 
                                 <NACHNAME> zur Friendlist hinzufügen.
/fl addguild <NAME>              Gilde <NAME> zur Friendlist hinzufügen.
/fl del <NAME>                   Spieler/Objekt/Gilde <NAME> aus Friendlist
                                 entfernen.
/fl reset                        Komplette Friendlist OHNE WEITERE WARNUNG
                                 löschen.
/fl import                       Importiere WoW-Freundesliste in die 
                                 Friendlist.
/fl export                       Exportiere die Friendlist in die WoW-
                                 Freundesliste.
/add <NAME> <NACHNAME> <NOTIZ>   Fügt Spieler <NAME> mit <NACHNAME> und 
                                 <NOTIZ> zur Friendlist hinzu.


Erweiterte Optionen
-------------------

Bezüglich der mit Version 0.4.0 erschienenen InfoBox und anderer Neuerungen
gibt es einige Optionen, die nicht per GUI oder Kommandozeile konfiguriert 
werden können.

Diese Optionen müssen momentan noch von Hand eingestellt werden (sofern 
man ein anderes Verhalten als die Standardeinstellungen wünscht), bis das 
GUI fertig ist.

Wie das geht, steht in der Datei Interface\Addons\flagRSP\settings.lua ganz
am Ende.