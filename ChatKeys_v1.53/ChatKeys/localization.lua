if (GetLocale() == "frFR") then
	BIND_NAME_CHATUI = "Panneau d\'interface";

	BIND_NAME_SAY = "Dire";
	BIND_NAME_YELL = "Crier";
	BIND_NAME_PARTY = "Groupe";
	BIND_NAME_RAID = "Raid / D\195\169fenseLocale";
	BIND_NAME_RWRAID = "Avertissement Raid";
	BIND_NAME_GUILD = "Guilde";
	BIND_NAME_GUILDOFFICER = "Officiers de guilde";
	BIND_NAME_WHISPER = "Chuchoter \195\160 la cible";
	BIND_NAME_CUSTOM = "Chuchoter \195\160 votre ami";
	BIND_NAME_CHANNEL = "Canal personnel";
	BIND_NAME_EMOTE = "Emote";
	BIND_NAME_WHO = "Ex\195\169cuter une requ\195\170te \"/who\" sur le dernier chuchotement";
	BIND_NAME_WHOCHAN = "Afficher les joueurs connect\195\169s au canal personel";
	GENERALCHANNELNAME = "G\195\169n\195\169ral";
	TRADECHANNELNAME = "Commerce";
	DEFENSECHANNELNAME = "D\195\169fenseLocale";
	GROUPCHANNELNAME = "RechercheGroupe";
	MSGFROM = "De";
	MSGTO = "A";
	ERRORNAME = "ERREUR";
	ERRORWHISPER = "Aucun chuchotement envoy\195\169 ou recu !";
	ERRORPARTY = "Vous ne faites pas partie d\'un groupe !";
	ERRORRAID = "Vous ne faites pas partie d\'un raid !";
	ERRORGUILD = "Vous ne faites pas partie d\'une guilde !";
	ERRORGUILDOFFICER = "Vous ne faites pas partie des officiers !";
	ERRORBUDDY = "Votre ami n\'est pas d\195\169fini ! Ouvrez le panneau des options en tapant /chatui.";
	ERRORCHANNEL = "Votre canal n\'est pas d\195\169fini ! Ouvrez le panneau des options en tapant /chatui.";
	ERRORTARGET = "Impossible de chuchoter \195\160 la cible.";
	NOCHANNEL = "Impossible de trouver le canal : ";

	UI_TITLEFRIEND = "D\195\169finition d\'un contact privil\195\169gi\195\169\nLa touche d\195\169finie permet de murmurer \195\160 cette personne";
	UI_BUDDYNAME = "Nom de votre ami(e) :";
	UI_TITLECHAN = "D\195\169finition d\'un canal personnel\nLa touche d\195\169finie permet de commencer un message dans ce canal";
	UI_CHANNAME = "Nom du canal :";
	UI_CHECKSOUND = "Notification sonore \195\160 r\195\169ception d\'un chuchotement";
	UI_BTNSAVE = "Enregistrer";
	UI_BTNCANCEL = "Fermer";
	
elseif (GetLocale() == "deDE") then
	BIND_NAME_CHATUI = "Interface panel";
	
	BIND_NAME_SAY = "Sagen";
	BIND_NAME_YELL = "Schreien";
	BIND_NAME_PARTY = "Gruppe";
	BIND_NAME_RAID = "Schlachtzug / LokaleVerteidigung";
	BIND_NAME_RWRAID = "Raid warning";
	BIND_NAME_GUILD = "Gilde";
	BIND_NAME_GUILDOFFICER = "Guild officers";
	BIND_NAME_WHISPER = "Whisper to target";
	BIND_NAME_CUSTOM = "Whisper to your friend";
	BIND_NAME_CHANNEL = "Custom channel";
	BIND_NAME_EMOTE = "Emote";
	BIND_NAME_WHOCHAN = "Show players connected to the custom channel";
	BIND_NAME_WHO = "\"who\"-Abfrage f\195\188r Fl\195\188sterer";
	GENERALCHANNELNAME = "Allgemein";
	TRADECHANNELNAME = "Handel";
	DEFENSECHANNELNAME = "LokaleVerteidigung";
	GROUPCHANNELNAME = "SucheNachGruppe";
	MSGFROM = "Von";
	MSGTO = "An";
	ERRORNAME = "FEHLER";
	ERRORWHISPER = "Kein Fl\195\188stern gesendet oder empfangen!";
	ERRORPARTY = "Du bist in keiner Gruppe!";
	ERRORRAID = "Du bist in keinem Schlachtzug!";
	ERRORGUILD = "Du bist in keiner Gilde!";
	ERRORGUILDOFFICER = "You are not an officer!";
	ERRORBUDDY = "Your friend is not defined! Open the settings panel by typing /chatui.";
	ERRORCHANNEL = "Your channel is not defined! Open the settings panel by typing /chatui.";
	ERRORTARGET = "Unable to whisper to the target.";
	NOCHANNEL = "Kann Kanal nicht finden: ";

	UI_TITLEFRIEND = "Special friend definition\nThe defined key allows to whisper to this person";
	UI_BUDDYNAME = "Your (girl/boy)friend\'s name:";
	UI_TITLECHAN = "Custom channel definition\nThe defined key starts a message on this channel";
	UI_CHANNAME = "Custom channel\'s name:";
	UI_CHECKSOUND = "Play sound when receiving whisper";
	UI_BTNSAVE = "Save";
	UI_BTNCANCEL = "Close";

else -- US/English by default
	BIND_NAME_CHATUI = "Interface panel";
	
	BIND_NAME_SAY = "Say";
	BIND_NAME_YELL = "Yell";
	BIND_NAME_PARTY = "Party";
	BIND_NAME_RAID = "Raid / LocalDefense";
	BIND_NAME_RWRAID = "Raid warning";
	BIND_NAME_GUILD = "Guild";
	BIND_NAME_GUILDOFFICER = "Guild officers";
	BIND_NAME_WHISPER = "Whisper to target";
	BIND_NAME_CUSTOM = "Whisper to your friend";
	BIND_NAME_CHANNEL = "Custom channel";
	BIND_NAME_EMOTE = "Emote";
	BIND_NAME_WHOCHAN = "Show players connected to the custom channel";
	BIND_NAME_WHO = "Perform a \"who\" query on last whisper";
	GENERALCHANNELNAME = "General";
	TRADECHANNELNAME = "Trade";
	DEFENSECHANNELNAME = "LocalDefense";
	GROUPCHANNELNAME = "LookingForGroup";
	MSGFROM = "From";
	MSGTO = "To";
	ERRORNAME = "ERROR";
	ERRORWHISPER = "No whisper sent or received!";
	ERRORPARTY = "You are not in party!";
	ERRORRAID = "You are not in raid!";
	ERRORGUILD = "You are not member of a guild!";
	ERRORGUILDOFFICER = "You are not an officer!";
	ERRORBUDDY = "Your friend is not defined! Open the settings panel by typing /chatui.";
	ERRORCHANNEL = "Your channel is not defined! Open the settings panel by typing /chatui.";
	ERRORTARGET = "Unable to whisper to the target.";
	NOCHANNEL = "Unable to find channel: ";

	UI_TITLEFRIEND = "Special friend definition\nThe defined key allows to whisper to this person";
	UI_BUDDYNAME = "Your (girl/boy)friend\'s name:";
	UI_TITLECHAN = "Custom channel definition\nThe defined key starts a message on this channel";
	UI_CHANNAME = "Custom channel\'s name:";
	UI_CHECKSOUND = "Play sound when receiving whisper";
	UI_BTNSAVE = "Save";
	UI_BTNCANCEL = "Close";

end;
