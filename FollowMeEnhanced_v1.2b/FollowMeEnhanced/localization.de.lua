-- German translation
-- by Lyriane

if ( GetLocale() == "deDE" ) then

	--Commands
	FM_GROUP_ON = "an";
	FM_GROUP_OFF = "aus";
	FM_WHISPERCOMMAND_FOLLOW = "!folgen";
	FM_WHISPERCOMMAND_STATUS = "!status";
	FM_COMMAND_STATUS = "status";
	FM_COMMAND_ANNOUNCE = "party";
	FM_COMMAND_RAID = "raid";
	FM_COMMAND_TARGET = "whisper";
	FM_COMMAND_ENABLE = "aktivieren";
	FM_COMMAND_DISABLE = "deaktivieren";
	FM_COMMAND_TELLGROUP = "gruppenmeldung";
	FM_COMMAND_TELLRAID = "raidmeldung";
	FM_COMMAND_FOLLOWGUILD = "gilde";
	FM_COMMAND_FOLLOWFRIENDS = "freunde";
	
	--Usage
	FM_USE_TITLE	 = "  Benutzung:";
	FM_USE_STATUS	 = "              status - Zeigt den FollowMe-Status an";
	FM_USE_ENABLE	 = "          aktivieren - Aktiviert FollowMe";
	FM_USE_DISABLE	 = "        deaktivieren - Deaktiviert FollowMe";
	FM_USE_GUILD	 = "        gilde an/aus - Schaltet, ob Gildenmitglieder dich auf Folgen setzten koennen";
	FM_USE_FRIENDS	 = "      freunde an/aus - Schaltet, ob Freunde dich auf Folgen setzten koennen";
	FM_USE_TELL3	 = "  raidmeldung an/aus - Schaltet automatische Raidmeldungen";
	FM_USE_TELL4	 = "                       ein/aus";
	FM_USE_ANNOUNCE1 = "               party - Teilt der Gruppe mit, wie das";
	FM_USE_ANNOUNCE2 = "                       FollowMe-AddOn funktioniert";
	FM_USE_RAID1	 = "                raid - Teilt dem Raid mit, wie das";
	FM_USE_RAID2	 = "                       FollowMe-AddOn funktioniert";
	FM_USE_WHISPER1	 = "             whisper - Teilt dem aktuellen Ziel per Whisper mit, wie das";
	FM_USE_WHISPER2	 = "                       FollowMe-AddOn funktioniert";
	FM_USE_TELL1	 = "gruppenmeldung an/aus- Schaltet automatische Gruppenmeldungen";
	FM_USE_TELL2	 = "                       ein/aus";
	FM_USE_TELL3	 = "  raidmeldung an/aus- Schaltet automatische Raidmeldungen";
	FM_USE_TELL4	 = "                       ein/aus";
	
	--Status
	FM_STATUS_LOADED = "geladen";
	FM_STATUS_ENABLED = "Aktiviert";
	FM_STATUS_DISABLED = "Deaktiviert";
	FM_STATUS_GROUP = "   Gruppenmeldungen sind ";
	FM_STATUS_RAID = "   Raidmeldungen sind ";
	FM_STATUS_GUILD = "   Folgen auf Gildenmitglieder ist ";
	FM_STATUS_FRIENDS = "   Folgen auf Freunde ist ";
	
	--Tellgroup
	FM_TELLGROUP = "FollowMeEnhanced: Gruppenmeldungen sind ";
	FM_TELLRAID = "FollowMeEnhanced: Raidmeldungen sind ";
	FM_FOLLOWGUILD = "FollowMeEnhanced: Folgen auf Gildenmitglieder ist ";
	FM_FOLLOWFRIENDS = "FollowMeEnhanced: Folgen auf Freunde ist ";
	
	--Event messages
	FM_ERR_AUTOFOLLOW_TOO_FAR = "Ich kann dir nicht folgen.  Vielleicht bist du nicht nahe genug?";
	FM_ERR_INVALID_FOLLOW_TARGET = "Ich kann dir nicht folgen.  Vielleicht bist du nicht nahe genug?";
	FM_ERR_GENERIC = "Ich kann dir nicht folgen.  Vielleicht bist du nicht nahe genug?";
	FM_ERR_NOGROUP = "Ich kann dir nicht folgen -- wir sind nicht in der gleichen Gruppe bzw. Raid";
	FM_WHISPER_AUTOFOLLOW_BEGIN = "Ich folge dir...weise den Weg :)";
	FM_PARTY_AUTOFOLLOW_BEGIN = "Ich folge ";
	FM_WHISPER_AUTOFOLLOW_END = "Ich folge dir nicht mehr.";
	FM_PARTY_AUTOFOLLOW_END = "Ich folge nicht mehr ";
	FM_WHISPER_DISABLED = "Ich kann dir nicht folgen -- Das FollowMe-Addon ist deaktiviert";
	FM_WHISPER_STATUS_FOLLOW = "  Ich folge gerade ";

	--Announce
	FM_ANNOUNCE = [[Ich verwende das "FollowMeEnhanced"-AddOn.  Wenn ich dir folgen soll, /w mich mit "]]..FM_WHISPERCOMMAND_FOLLOW..[[" an.]]..[[ Um meinen aktuellen Status abzufragen verwende "]]..FM_WHISPERCOMMAND_STATUS..[["."]];

end
