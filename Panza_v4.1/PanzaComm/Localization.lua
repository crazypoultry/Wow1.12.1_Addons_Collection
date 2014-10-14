--[[

PanzaComm Localization
Version 3.0

--]]

PANZACOMM_MODE_SEND_RECEIVE			= 1;
PANZACOMM_MODE_RECEIVE_ONLY			= 2;

-- Channel Types
PANZACOMM_TYPE_GUILD				= 1;
PANZACOMM_TYPE_RAID					= 2;
PANZACOMM_TYPE_PARTY				= 3;
PANZACOMM_TYPE_BG					= 4;

-- Destinations
PANZACOMM_DEST_GUILD				= "Guild";
PANZACOMM_DEST_RAID					= "Raid";
PANZACOMM_DEST_PARTY				= "Party";
PANZACOMM_DEST_BG					= "BG";

PANZACOMM_MSG_HELP_TOGGLE			= "Toggle PanzaComm On/Off. See enable and disable commands.";
PANZACOMM_MSG_HELP_ENABLE			= "Enable PanzaComm.";
PANZACOMM_MSG_HELP_DISABLE			= "Disable PanzaComm.";
PANZACOMM_MSG_HELP_STATUS			= "Status of registered addons,and clients.";
PANZACOMM_MSG_HELP_RESET			= "Reset and clear client/app/channel data.";
PANZACOMM_MSG_HELP_DEBUG			= "Toggle debug messages to diagnose problems.";
PANZACOMM_MSG_HELP_DEFAULTS			= "Restore all settings to default values.";

PANZACOMM_MSG_RESET					= "(PanzaComm) Resetting communication data.";
PANZACOMM_MSG_ENABLE				= "(PanzaComm) Enabling transmission.";
PANZACOMM_MSG_DISABLE				= "(PanzaComm) Disabling transmission.";
PANZACOMM_MSG_XMIT_DISABLED			= "(PanzaComm) Message Transmit Disabled!";
PANZACOMM_MSG_XMIT_DISABLE_SHORT	= " because message transmit is disabled.";
PANZACOMM_MSG_XMIT_ENABLED			= "(PanzaComm) Message Transmit Enabled.";
PANZACOMM_MSG_XMIT_SKIP				= "(PanzaComm) Message: %s to %s not sent %s.";
PANZACOMM_MSG_XMIT_REJECT			= "(PanzaComm) Message %s rejected from %s: (Unregistered App)";
PANZACOMM_MSG_RCVD_REJECT_1			= "(PanzaComm) %s is not in our party or raid; Rejected.";
PANZACOMM_MSG_RCVD_REJECT_2			= "(PanzaComm) %s sent %s intended for %s";
PANZACOMM_MSG_DEBUG_DISABLED		= "(PanzaComm) Debug Mode Disabled.";
PANZACOMM_MSG_DEBUG_ENABLED			= "(PanzaComm) Debug Mode Enabled.";

PANZACOMM_MSG_STATUS_NOCHAN			= "(PanzaComm) Channel not in use. Broadcasting messages disabled.";
PANZACOMM_MSG_STATUS_CHANREQ		= "(PanzaComm) Must be in a raid, party, or be a member of a guild to auto-join a channel.";
PANZACOMM_MSG_STATUS_DISABLED		= "PanzaComm is Disabled. Use /pcom toggle or /pcom enable to start using PanzaComm."
PANZACOMM_MSG_NOCHAN_APP			= "(PanzaComm) No channel to use for app: %s message=%s";
PANZACOMM_MSG_INT_REGISTER_FAIL		= "(PanzaComm) Failure Occured when Registering Internal Receiver!";
PANZACOMM_MSG_INT_REGISTER			= "(PanzaComm) Registered Internal Receiver.";
PANZACOMM_MSG_SEND_FAIL_CHECK		= "(PanzaComm) Send Message Error. Check destination."
PANZACOMM_MSG_INVALIDRECIVER		= "(PanzaComm) Invalid receiver function from %s";
PANZACOMM_MSG_RECEIVER				= "(PanzaComm) %s Registered. %s on %s";
PANZACOMM_MSG_UNKNOWN				= "(PanzaComm) Unknown command: %s";

PANZACOMM_INVALIDCALL_REGISTER		= "(PanzaComm) Invalid call to PanzaComm_Register(id,receiver.mode,destination).";
PANZACOMM_INVALIDCALL_MESSAGE		= "(PanzaComm) Invalid call to PanzaComm_Message(id, message).";
PANZACOMM_INVALIDCALL_CHANNELOK		= "(PanzaComm) Invalid call to PanzaComm_ChannelOK(id).";
PANZACOMM_MSG_INVALIDRECEIVER		= "(PanzaComm) Invalid reciever given on registration.";

PANZACOMM_CHECK_UNREGISTERED		= "(PanzaComm) %s is Unregistered.";
PANZACOMM_CHECK_NODESTDEFINED		= "(PanzaComm) %s does not have a destination defined. Check Registration.";

PANZACOMM_CLEARINGAFK				= "(PanzaComm) Clearing AFK - %s";

PANZACOMM_MSG_SWITCH				= "(PanzaComm) Switching %s from %s to %s";


-- German Translation

if (GetLocale() == "deDE") then

	PANZACOMM_MSG_HELP_TOGGLE			= "Umschalten von PanzaComm. Siehe Befehle f\195\188r aktivieren und deaktivieren.";
	PANZACOMM_MSG_HELP_ENABLE			= "PanzaComm aktivieren und Channel beitreten.";
	PANZACOMM_MSG_HELP_DISABLE			= "PanzaComm deaktivieren und alle eingestellten Channel verlassen.";
	PANZACOMM_MSG_HELP_STATUS			= "Status aller registrierten Addons und Clients.";
	PANZACOMM_MSG_HELP_RESET			= "Zur\195\188cksetzen und Nachrichtendaten l\195\182schen.";
	PANZACOMM_MSG_HELP_DEBUG			= "Umschalten der Debug-Meldungen.";
	PANZACOMM_MSG_HELP_DEFAULTS			= "Einstellungen auf Standardwerte zur\195\188cksetzen.";	

	PANZACOMM_MSG_RESET					= "(PanzaComm) Kommunikationsdaten zur\195\188ckgesetzt.";
	PANZACOMM_MSG_ENABLE				= "(PanzaComm) Nachrichten senden und Channelzugriff aktiviert.";
	PANZACOMM_MSG_DISABLE				= "(PanzaComm) Nachrichten senden und Channelzugriff deaktiviert.";
	PANZACOMM_MSG_XMIT_DISABLED			= "(PanzaComm) Nachrichten senden deaktiviert!";
	PANZACOMM_MSG_XMIT_DISABLE_SHORT	= " weil Nachrichten senden deaktiviert ist.";
	PANZACOMM_MSG_XMIT_ENABLED			= "(PanzaComm) Nachrichten senden aktiviert.";
	PANZACOMM_MSG_XMIT_SKIP				= "(PanzaComm) Nachricht: %s an %s nicht gesendet %s.";
	PANZACOMM_MSG_XMIT_REJECT			= "(PanzaComm) Nachricht %s von %s abgewiesen: (Nicht angemeldet)";
	PANZACOMM_MSG_RCVD_REJECT_1			= "(PanzaComm) %s ist nicht in unsere(r/m) Gruppe oder Schlachtzug; Abgewiesen.";
	PANZACOMM_MSG_RCVD_REJECT_2			= "(PanzaComm) Nicht angemeldete PanzaComm Nachricht gesendet von %s: %s";
	PANZACOMM_MSG_DEBUG_DISABLED		= "(PanzaComm) Debug-Meldungen deaktiviert.";
	PANZACOMM_MSG_DEBUG_ENABLED			= "(PanzaComm) Debug-Meldungen aktiviert.";

	PANZACOMM_MSG_STATUS_NOCHAN			= "(PanzaComm) Channel nicht in Benutzung. Nachrichten\195\188bertragung deaktiviert.";
	PANZACOMM_MSG_STATUS_CHANREQ		= "(PanzaComm) Automatische Channelauswahl nur m\195\182glich als Mitglied einer Gruppe, Gilde oder eines Schlachtzugs.";
	PANZACOMM_MSG_STATUS_DISABLED		= "PanzaComm ist deaktiviert. /pcom toggle oder /pcom enable benutzen zum Starten von PanzaComm."
	PANZACOMM_MSG_NOCHAN_APP			= "(PanzaComm) Kein Channel verf\195\188gbar: %s Nachricht=%s";
	PANZACOMM_MSG_INT_REGISTER_FAIL		= "(PanzaComm) Fehler beim Anmelden des internen Empf\195\164ngers!";
	PANZACOMM_MSG_INT_REGISTER			= "(PanzaComm) Interner Empf\195\164nger angemeldet.";
	PANZACOMM_MSG_SEND_FAIL_CHECK		= "(PanzaComm) Fehler beim Senden. Channel pr\195\188fen."
	PANZACOMM_MSG_INVALIDRECIVER		= "(PanzaComm) Ung\195\188ltige Empf\195\164ngerreaktion von %s";
	PANZACOMM_MSG_RECEIVER				= "(PanzaComm) %s angemeldet. %s on %s";
	PANZACOMM_MSG_UNKNOWN				= "(PanzaComm) Unbekannter Befehl: %s";

	PANZACOMM_INVALIDCALL_REGISTER		= "(PanzaComm) Ung\195\188ltiger Aufruf von PanzaComm_Register(id,receiver.mode,destination).";
	PANZACOMM_INVALIDCALL_MESSAGE		= "(PanzaComm) Ung\195\188ltiger Aufruf von PanzaComm_Message(id, message).";
	PANZACOMM_INVALIDCALL_CHANNELOK		= "(PanzaComm) Ung\195\188ltiger Aufruf von PanzaComm_ChannelOK(id).";

	PANZACOMM_CHECK_UNREGISTERED		= "(PanzaComm) %s ist nicht angemeldet.";
	PANZACOMM_CHECK_NODESTDEFINED		= "(PanzaComm) %s hat keine definierten Channel. Anmeldung pr\195\188fen.";
	
	PANZACOMM_CLEARINGAFK				= "(PanzaComm) Clearing AFK - %s";			

end