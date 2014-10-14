Addon  : smilie2emote 
Typ	 	 : RPG - Chaterweiterung
Version: 1.4.1 beta

-------------------------------------------------------------------------------------------
Beschreibung: 
-------------------------------------------------------------------------------------------
Die Chaterweierung dient der Konvertierung von Smilies (z.B. :-), :-P ) und 
Akronymen ( cu, mom, wb) in WoW-Emotes. Smilies in ausgehenden Nachrichten werden anhand 
einer Liste definierter Smilies/Akronyme durchsucht und entsprechend umgewandelt. 
Eingehende Smilies werden ebenfalls erfasst und umgewandelt, zur Zeit jedoch nur in die 
korrespondierenden Token. 
Die Ausgabe der zugehörigen Texte wird wahrscheinlich in dernächsten Version erfolgen. 

-------------------------------------------------------------------------------------------
Features: 
-------------------------------------------------------------------------------------------
- Die Basisliste von Smilies/Akronymen kann vom Benutzer erweitert/verändert werden. 
- Konvertierung kann getrennt für eingehende und ausgehende Messages ein- und ausgeschaltet werden. 
- Die in WoW verfügbaren Token können gelistet werden. 

-------------------------------------------------------------------------------------------
Kommandos
-------------------------------------------------------------------------------------------
Basis-Kommandos 
/smilie, /sml		-> Smilieliste
/acronym, /acro -> Akronymliste
/s2e						-> AddOn Steuerung

smilie und Akronym Kommandos
---------------------------------
/smilie|/acronym show <smilie>|all
Zeigt die Zurodnung des Token zum jeweiligen smilie/akronym an 

/smilie|/acronym set <smilie> <token>
Setzt für den Smilie <smilie> das korrespondierende Token <token>. 
Existiert bereits eine Zuordnung, wird diese ersetzt. Ansonsten wird eine neue Zuordnung in die 
Liste eingefügt. 

/smilie|/acronym rem <smilie>
Entfernt die <smilie><token> Zuordnung aus der Liste. 

AddOn Steuerung
---------------------------------
/s2e
Zeigt den Konvertierungs-Status des AddOns an. 

/s2e token [<token>] 
Zeigt eine Liste der Verfügbaren WoW Emote Token an. 
Die Anzeige kann durch Teileingabe eingeschränkt werden. 

/s2e in <on|off>
Schaltet die Konvertierung eingehender Nachrichten aus oder ein. 

/s2e out <on|off>
schaltet die Konvertierung ausgehender Nachrichten aus oder ein. 

/s2e all <on|off>
Schaltet die Konvertierung ein- und ausgehender Nachrichten aus oder ein. 

-------------------------------------------------------------------------------------------
ToDo
-------------------------------------------------------------------------------------------
 - Ausgabe der Emote-Texte für eingehende Nachrichten
 - Inline Help zu den Kommandos
 - Frei definierbare Einstellung der Systeme (YELL,SAY,GUILD,PARTY,RAID) für die das AddOn greift. 