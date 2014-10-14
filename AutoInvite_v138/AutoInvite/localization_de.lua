-- ä = \195\164 (z.B. Jäger = J\195\164ger)
-- Ä = \195\132 (z.B. Ärger = \195\132rger)
-- ö = \195\182 (z.B. schön = sch\195\182n)
-- Ö = \195\150 (z.B. Ödipus = \195\150dipus)
-- ü = \195\188 (z.B. Rüstung = R\195\188stung)
-- Ü = \195\156 (z.B. Übung = \195\156bung)
-- ß = \195\159 (z.B. Straße = Stra\195\159e) 

if ( GetLocale() == "deDE" ) then

AUTO_INVITE_COMPLETELIST="Komplette Liste (%d)";

AUTO_INVITE_CLASS = {
   DRUID	= "Druide",
   HUNTER	= "J\195\164ger",
   MAGE		= "Magier",
   PALADIN	= "Paladin",
   SHAMAN	= "Schamane",
   PRIEST	= "Priester",
   ROGUE	= "Schurke",
   WARRIOR	= "Krieger",
   WARLOCK	= "Hexenmeister"
};

AUTO_INVITE_DECLINES_YOUR_INVITATION="%a+ lehnt Eure Einladung in die Gruppe ab.";
AUTO_INVITE_DECLINES_YOUR_INVITATION_FIND="^(.+) lehnt Eure Einladung in die Gruppe ab.";
AUTO_INVITE_IGNORES_YOUR_INVITATION="%a+ ignoriert Euch.";
AUTO_INVITE_IGNORES_YOUR_INVITATION_FIND="^(.+) ignoriert Euch.";

AUTO_INVITE_IS_ALREADY_IN_GROUP="%w+ geh\195\182rt bereits zu einer Gruppe.";
AUTO_INVITE_IS_ALREADY_IN_GROUP_FIND="^(.+) geh\195\182rt bereits zu einer Gruppe.";
AUTO_INVITE_SEND_MESSAGE_ALREADY_IN_GROUP="Ich kann dich nicht einladen, da Du schon in einer Gruppe bist, verlasse die bitte";

AUTO_INVITE_GROUP_LEAVE="%w+ verl\195\164sst die Gruppe.";
AUTO_INVITE_GROUP_LEAVE_FIND="(.+) verl\195\164sst die Gruppe.";
AUTO_INVITE_RAID_LEAVE="%w+ hat die Schlachtgruppe verlassen.";
AUTO_INVITE_RAID_LEAVE_FIND="(.+) hat die Schlachtgruppe verlassen.";

AUTO_INVITE_INVITED="Ihr habt %w+ eingeladen, sich Eurer Gruppe anzuschlie\195\159en.";
AUTO_INVITE_INVITED_FIND="Ihr habt (.+) eingeladen, sich Eurer Gruppe anzuschlie\195\159en.";
AUTO_INVITE_GROUP_DISBANDED="Eure Gruppe wurde aufgel\195\182st.";
AUTO_INVITE_GROUP_DISBANDED2="Ihr verlasst die Gruppe.";
AUTO_INVITE_RAID_DISBANDED="Ihr habt die Schlachtgruppe verlassen.";

AUTO_INVITE_GONE_OFFLINE="%w+ has gone offline.";
AUTO_INVITE_IS_OFFLINE=".+ ist nicht auffindbar.";
AUTO_INVITE_IS_OFFLINE_FIND="'(.+)' ist nicht auffindbar.";
AUTO_INVITE_ADDMEMBER_LABEL="Spieler der in die Liste aufgenommen werden soll:";
AUTO_INVITE_SAVEDESCRPTION_LABEL="Beschreibung f\195\188r die aktuelle Gruppenzusammenstellung";

AUTO_INVITE_UNKNOWN_ENTITY="Unbekannte Entit\195\164t"
end
