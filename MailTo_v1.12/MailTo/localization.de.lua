-- German text strings

-- Thanks to Brainsen, Ghandi, Rhphoenix and Smilyman for the translations.

if(GetLocale()=="deDE") then

BINDING_NAME_MAILTOLOG = "Protokoll anzeigen";
BINDING_NAME_MAILTOEX = "Verfallsliste anzeigen";
BINDING_NAME_MAILTOMAIL = "Nachrichteneingang ein/aus";

MAILTO_OPTION = { alert= {flag='noalert', name="Zustellbenachrichtigung"},
				  auction={flag='noauction', name="Auktionen-Klick"},
				  chat=  {flag='nochat', name="Chat-Klick"},
				  coin=  {flag='nocoin', name="M\195\188nzen-Initial"},
				  ding=  {flag='noding', name="Ding Sound"},
				  click= {flag='noclick', name="Inventar-Klick"},
				  login= {flag='nologin', name="Login Nachricht"},
				  shift= {flag='noshift', name="Shift-Klick"},
				  trade= {flag='notrade', name="Handeln-Klick"},
				}

MAILTO_ON = "%s ist jetzt eingeschaltet."
MAILTO_OFF = "%s ist jetzt ausgeschaltet."
MAILTO_TIME = "Die Zeit bis zu '%s' Verfallen wurde auf %s gesetzt."
MAILTO_TOOLTIP = "Klicken um Empf\195\164nger auszuw\195\164hlen."
MAILTO_CLEARED = "Die MailTo Liste wurde gel\195\182scht!"
MAILTO_LISTEMPTY = "Leere Liste."
MAILTO_LISTFULL = "Warnung: Liste ist voll!"
MAILTO_ADDED = " zur MailTo Liste hinzugef\195\188gt."
MAILTO_REMOVED = " von MailTo Liste gel\195\182scht."
MAILTO_F_ADD = "(%s hinzuf\195\188gen)"
MAILTO_F_REMOVE = "(%s l\195\182schen)"
MAILTO_YOU = UnitName('player')
MAILTO_DELIVERED = "ausgeliefert."
MAILTO_DUE = "f\195\164llig in %d Minuten."
MAILTO_SENT = "%s gesendet an %s von %s ist %s"
MAILTO_NEW = "%s%s von %s ist ausgeliefert an %s"
MAILTO_NONEW = "Keine neuen Nachrichten gefunden."
MAILTO_NEWMAIL = "(possible new mail)"
MAILTO_LOGEMPTY = "Das Protokoll ist leer."
MAILTO_NODATA = "Keine Nachrichteneing\195\164nge."
MAILTO_NOITEMS = "Keine Gegenst\195\164nde im Nachrichteneingang."
MAILTO_NOTFOUND = "Keine Gegenst\195\164nde gefunden."
MAILTO_INBOX = "#%d: %s von %s"
MAILTO_EXPIRES = " verf\195\164llt in "
MAILTO_EXPIRED = " ist verfallen!"
MAILTO_UNDEFINED = "Unbekanntes Kommando, "
MAILTO_RECEIVED = "Erhalten: %s von %s, %s";
MAILTO_SOLD = "%s hat %s f\195\188r %s (net=%s) gekauft."
MAILTO_NONAME = "Name nicht angegeben."
MAILTO_NODESC = "Fehlende Beschreibung."
MAILTO_MAILOPEN = "Briefkasten ist offen."
MAILTO_MAILCHECK = "Briefkasten nicht gepr\195\188ft."
MAILTO_TITLE = "MailTo Nachrichteneingang"
MAILTO_SELECT = "W\195\164hle:"
MAILTO_SERVER = "Server"
MAILTO_SERVERTIP = "Markieren um Charakter von anderen Servern auszuw\195\164hlen."
MAILTO_FROM = "Von: "
MAILTO_EXPIRES2 = "Verf\195\164llt in "
MAILTO_EXPIRED2 = "Ist Verfallen!"
MAILTO_LOCATE = "Finde Gegenstände mit '%s':"
MAILTO_REMOVE2 = "Entferne %s von %s."
MAILTO_BACKPACK = "Kein leerer Taschenplatz zum Teilen frei."
MAILTO_EMPTYNEW = "Du hast neue Nachrichten..."
MAILTO_MAIL = "Nachricht"
MAILTO_INV = "Inventar"
MAILTO_BANK = "Bank"
MAILTO_SOLD = "Auktion erfolgreich"
MAILTO_OUTBID = "\195\156berboten"
MAILTO_CANCEL = "Auktion abgebrochen"
MAILTO_CASH = "Empfangenes Gold: Gesamt=%s, Verkauft=%s, Erstattet=%s, Anderes=%s"

end
