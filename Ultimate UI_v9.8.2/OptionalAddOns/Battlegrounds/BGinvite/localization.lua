-- German translation by MeKyle

function BGinvite_localize(locale)

	if locale == "enUS" then

		BGlocal_BLANK_DECLINES_YOUR_INVITATION 		= 	"%w+ declines your group invitation."
		BGlocal_BLANK_DECLINES_YOUR_INVITATION_FIND	=	"^(%w+) declines your group invitation."
		BGlocal_BLANK_IS_IGNORING_YOU 			= 	"%w+ is ignoring you."
		BGlocal_BLANK_IS_IGNORING_YOU_FIND		= 	"^(%w+) is ignoring you."
		BGlocal_BLANK_HAS_JOINED_THE_RAID 		= 	"%w+ has joined the raid group"
		BGlocal_BLANK_HAS_JOINED_THE_RAID_FIND		=	"^(%w+) has joined the raid group"
		BGlocal_BLANK_HAS_JOINED_THE_PARTY		=	"%w+ joins the party."
		BGlocal_BLANK_HAS_JOINED_THE_PARTY_FIND		=	"^(%w+) joins the party."
		BGlocal_BLANK_IS_ALREADY_IN_GROUP		=	"%W+ is already in a group."
		BGlocal_BLANK_IS_ALREADY_IN_GROUP_FIND		=	"^(%w+) is already in a group."
		BGlocal_YOU_JOINED_RAID_GROUP			=	"You have joined a raid group"
		BGlocal_YOU_HAVE_INVITED			=	"You have invited %w+ to join your group."
		BGlocal_YOU_HAVE_INVITED_FIND			=	"You have invited (%w+) to join your group."
		BGlocal_SOMEONE_JOINED_BG				=	"has joined the battle"
		BGlocal_SOMEONE_LEFT_BG					=	"%w+ has left the battle"
		BGlocal_SOMEONE_LEFT_BG_FIND			=	"^(%w+) has left the battle"
		BGlocal_BG_WARSONG				=	"Warsong Gulch"
		BGlocal_BG_ALTERAC				=	"Alterac Valley"
		BGlocal_BG_ARATHI				=	"Arathi Basin"

	
		BGlocal_MOD_LOADED				=	"[Gibybo] BGInvite Loaded - /bginvite help - Purging: "..BGvar_save.purge.." Auto-invites: "..BGvar_save.auto
		BGlocal_NOW_PURGING				=	"Now purging the group whenever you check the scores! Note: Due to issues with lag, it may be necesary to refresh the scores twice for a purge to take effect."
		BGlocal_NOT_PURGING				=	"No longer purging the group"
		BGlocal_AUTO_INVITING				=	"Automatically inviting newcomers"
		BGlocal_NOT_AUTO_INVITING			=	"Not auto-inviting newcomers"
		BGlocal_BLACKLISTED_PLAYERS			=	"Blacklisted players:"
		BGlocal_VERSION_STR				=	"[BGinvite] Version: "..BGvar_version
		BGlocal_SAY_INVITING				=	"[BGinvite] Leave your groups if you would like invites (assuming the raid hasn't already been created)."
		BGlocal_CONVERTING_TO_RAID			=	"Converting to raid"
		BGlocal_PURGING_PLAYERS				=	"Purging old players"
		BGlocal_ERROR_SCANNING				=	"Error scanning players, please refresh scoreboard"
		BGlocal_YOU_APPEAR_GONE				=	"[BGinvite] You no longer appear to be in the BG instance and have been removed to make room for others. You will automatically be reinvited if you return."
		BGlocal_HELP_ERR				=	"Type '/bginvite help' for a listing of [BGinvite] commands"
		BGlocal_HELP_1					=	" - /bginvite : Sends an invite to everyone in your battlefield instance"	
		BGlocal_HELP_2					=	" - /bginvite auto on|off : Turns auto-inviting of new players on or off"
		BGlocal_HELP_3					=	" - /bginvite purge on|off : Turns purging (removes members from the raid if they are no longer in the BG) on or off"
		BGlocal_HELP_4					=	" - /bginvite promote all : Promotes everyone in the raid group to assistant"
		BGlocal_HELP_5					=	" - /bginvite demote all : Demotes all assistants in the raid"
		BGlocal_HELP_6					=	" - /bginvite blacklist : Displays the current blacklist. Blacklisted players will not be invited by [BGinvite]"
		BGlocal_HELP_7					=	" - /bginvite blacklist add <name> : Adds a player to the blacklist"
		BGlocal_HELP_8					=	" - /bginvite blacklist remove <name> : Removes a player from the blacklist"
		BGlocal_HELP_9					=	" - /bginvite magicword <word/phrase> : Sets a word or phrase to the magic word. If someone sends you a tell with the magicword it will automatically invite them. (it attempts to determine if they want an invite or if they are just talking about the magic word)"
		BGlocal_HELP_10					=	" - /bginvite version : Displays your [BGinvite] Version"
		BGlocal_HAS_BEEN_REMOVED			=	" has been removed from the blacklist"
		BGlocal_WASNT_ON_BLACKLIST			=	" wasn't on the blacklist!"
		BGlocal_IS_ALREADY_BLACKLISTED			=	" is already on the blacklist!"
		BGlocal_HAS_BEEN_ADDED_BLACKLIST		=	" has been added to the blacklist"
		BINDING_NAME_BG_PROMOTE_ALL			=	"Promote all"
		BINDING_NAME_BG_DEMOTE_ALL			=	"Demote all"
		BINDING_HEADER_BGINVITE				=	"BGInvite"
		BINDING_NAME_BG_SEND_INVITE			=	"Send Invites"
		

		BGInviteBlacklistAdd:SetText("Add")
		BGInviteBlacklistRemove:SetText("Remove")
		BGInviteMagicwordChange:SetText("Change")
		BGInviteMagicwordDefault:SetText("Default")
		BGInvitePromoteAll:SetText("Promote All")
		BGInviteDemoteAll:SetText("Demote All")
		BGInviteAutoPurgeEnableText:SetText("- - - Purging")
		BGInviteAutoInviteEnableText:SetText("- - - Auto-Inviting")
		BGInvitesendinvite:SetText("Send Invites")
		BGInviteHelpButton:SetText("Help: Commands")
		BGInviteBlacklistStr:SetText("Blacklist:")
		BGInviteMagicwordStr:SetText("Magicword:")
	
	elseif locale == "deDE" then

		BGlocal_BLANK_DECLINES_YOUR_INVITATION		=   "%w+ lehnt Eure Einladung in die Gruppe ab."
		BGlocal_BLANK_DECLINES_YOUR_INVITATION_FIND	=   "^(%w+) lehnt Eure Einladung in die Gruppe ab."
		BGlocal_BLANK_IS_IGNORING_YOU			=   "%w+ ignoriert Euch."
		BGlocal_BLANK_IS_IGNORING_YOU_FIND		=   "^(%w+) ignoriert Euch."
		BGlocal_BLANK_HAS_JOINED_THE_RAID		=   "%w+ hat sich der Schlachtgruppe angeschlossen."
		BGlocal_BLANK_HAS_JOINED_THE_RAID_FIND		=   "^(%w+) hat sich der Schlachtgruppe angeschlossen."
		BGlocal_BLANK_HAS_JOINED_THE_PARTY		=   "%w+ schließt sich der Gruppe an."
		BGlocal_BLANK_HAS_JOINED_THE_PARTY_FIND		=   "^(%w+) schließt sich der Gruppe an."
		BGlocal_BLANK_IS_ALREADY_IN_GROUP		=   "%W+ gehört bereits zu einer Gruppe."
		BGlocal_BLANK_IS_ALREADY_IN_GROUP_FIND		=   "^(%w+) gehört bereits zu einer Gruppe."
		BGlocal_YOU_JOINED_RAID_GROUP			=   "Ihr habt Euch einer Schlachtgruppe angeschlossen."
		BGlocal_YOU_HAVE_INVITED 			=   "Ihr habt %w+ eingeladen, sich Eurer Gruppe anzuschließen."
		BGlocal_YOU_HAVE_INVITED_FIND			=   "Ihr habt (%w+) eingeladen, sich Eurer Gruppe anzuschließen."
		BGlocal_SOMEONE_JOINED_BG				=	"???"
		BGlocal_SOMEONE_LEFT_BG					=	"%w+ ???"
		BGlocal_SOMEONE_LEFT_BG_FIND			=	"^(%w+) ???"
		BGlocal_BG_WARSONG				=   "Warsongschlucht"
		BGlocal_BG_ALTERAC				=   "Alteractal"
		BGlocal_BG_ARATHI				=   "Arathibecken"


		BGlocal_MOD_LOADED				=   "[Gibybo] BGInvite Loaded - /bginvite help - Purging: "..BGvar_save.purge.." Auto-invites: "..BGvar_save.auto
		BGlocal_NOW_PURGING				=   "Gruppe wird nun bereinigt sobald du die Punktetafel \195\182ffnest! Hinfeis: Bei lag's, k\195\182nnte es notwendig sein die Punktetafel zwei mal zu aktualisieren, damit die bereinigung wirkt."
		BGlocal_NOT_PURGING				=   "Gruppe wird nicht mehr bereinigt"
		BGlocal_AUTO_INVITING				=   "Automatisches Einladen von Neuank\195\182mmlingen"
		BGlocal_NOT_AUTO_INVITING			=   "Kein automatisches Einladen von Neuank\195\182mmlingen"
		BGlocal_BLACKLISTED_PLAYERS			=   "Blacklisted Spieler:"
		BGlocal_VERSION_STR				=   "[BGinvite] Version: "..BGvar_version
		BGlocal_SAY_INVITING				=   "[BGinvite] Verlasst eure Gruppen wenn ihr eingeladen werden wollt (Sofern der Raid nicht bereits erstellt wurde)."
		BGlocal_CONVERTING_TO_RAID			=   "Konvertiere zu Raid"
		BGlocal_PURGING_PLAYERS				=   "Bereinige alte Spieler"
		BGlocal_ERROR_SCANNING				=   "Fehler beim Spieler scan, Bitte Anzeigetafel aktualisieren"
		BGlocal_YOU_APPEAR_GONE				=   "[BGinvite] Du scheinst dich nicht l\195\164nger in der Schlachtfeld-Instanz zu befinden und wurdest entfernt um platz für andere Spieler zu schaffen. Du wirst automatisch erneut eingeladen sobald du zur\195\188ckkehrst."
		BGlocal_HELP_ERR				=   "Tippe '/bginvite help' f\195\188r eine Auflistung von [BGinvite] commands"
		BGlocal_HELP_1					=   " - /bginvite : Sendet eine Einladung an jeden auf diesem Schlachtfeld"
		BGlocal_HELP_2					=   " - /bginvite auto on|off : Stellt das automatische Einladen neuer Spieler ein|aus"
		BGlocal_HELP_3					=   " - /bginvite purge on|off : Stellt Bereinigung (entfernt Spieler vom Raid sollten sie sich nicht mehr auf dem Schlachtfeld befinden) ein|aus"
		BGlocal_HELP_4					=   " - /bginvite promote all : Bef\195\182rdert jeden in der Raid Gruppe zu Gehilfen"
		BGlocal_HELP_5					=   " - /bginvite demote all : Degradiert alle Gehilfen im Raid"
		BGlocal_HELP_6					=   " - /bginvite blacklist : Zeigt die momentane blacklist. Blacklisted Spieler werden nicht von [BGinvite] eingeladen"
		BGlocal_HELP_7					=   " - /bginvite blacklist add <name> : f\195\188gt einen Spieler der blacklist hinzu"
		BGlocal_HELP_8					=   " - /bginvite blacklist remove <name> : Entfernt einen Spieler aus der blacklist"
		BGlocal_HELP_9					=   " - /bginvite magicword <word/phrase> : Macht ein Wort oder Satz zum Zauberwort. Sollte dir jemand etwas mit dem Zauberwort sagen, wird er automatisch eingeladen. (Es wird versucht festzustellen, ob eine Einladung gew\195\188nscht ist, oder ob nur \195\188ber das Zauberwort geredet wird.)"
		BGlocal_HELP_10					=   " - /bginvite version : Zeigt deine [BGinvite] Version"
		BGlocal_HAS_BEEN_REMOVED			=   " wurde von der blacklist entfernt"
		BGlocal_WASNT_ON_BLACKLIST			=   " war nicht auf der blacklist!"
		BGlocal_IS_ALREADY_BLACKLISTED			=   " ist bereits auf der blacklist!"
		BGlocal_HAS_BEEN_ADDED_BLACKLIST		=   " wurde zur blacklist hinzugef\195\188gt"
		BINDING_NAME_BG_PROMOTE_ALL			=	"Promote all"
		BINDING_NAME_BG_DEMOTE_ALL			=	"Demote all"
		BINDING_HEADER_BGINVITE				=	"BGInvite"
		BINDING_NAME_BG_SEND_INVITE			=	"Send Invites"

		BGInviteBlacklistAdd:SetText("Hinzuf\195\188gen")
		BGInviteBlacklistRemove:SetText("Entfernen")
		BGInviteMagicwordChange:SetText("\195\132ndern")
		BGInviteMagicwordDefault:SetText("Standart")
		BGInvitePromoteAll:SetText("Bef\195\182rdert Alle")
		BGInviteDemoteAll:SetText("Degradiert Alle")
		BGInviteAutoPurgeEnableText:SetText("- - - Bereinigen")
		BGInviteAutoInviteEnableText:SetText("- - - Auto-Einladung")
		BGInvitesendinvite:SetText("Einladungen senden")
		BGInviteHelpButton:SetText("Hilfe: Befehle")
		BGInviteBlacklistStr:SetText("Blacklist:")
		BGInviteMagicwordStr:SetText("Zauberwort:")

	end
end

function BGinvite_localizevarvar(locale)
	if locale == "enUS" then
		BGlocal_LEAVE_GROUP_WHISPER         =   "[BGinvite] Leave your group if you would like an invite - respond with '"..BGvar_save.magicword.."' when you're ready."
		BGlocal_MAGICWORD_CHANGE            =   "The magic word has been set to: "..BGvar_save.magicword
	elseif locale == "frFR" then
		-- french localization here
	elseif locale == "deDE" then
		BGlocal_LEAVE_GROUP_WHISPER         =   "[BGinvite] Verlasse deine Gruppe wenn du eine Einladung m\195\182chtest - Wenn du fertig bist mit '"..BGvar_save.magicword.."' ansprechen."
		BGlocal_MAGICWORD_CHANGE            =   "Das Zauberwort ist nun: "..BGvar_save.magicword
	end
end

