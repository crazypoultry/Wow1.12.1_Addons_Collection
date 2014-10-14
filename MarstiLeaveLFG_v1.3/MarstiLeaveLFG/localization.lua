LEAVELFG_CITIES = { 
[0] = "Stormwind", 
[1] = "Ironforge",
[2] = "Darnassus",
[3] = "Orgrimmar",
[4] = "Thunder Bluff",
[5] = "Undercity" }

LEAVELFG_DUNGEON_LEAVE = "Entering dungeon. Leaving LFG channel.";
LEAVELFG_WORLD_JOIN = "Entering normal world. Joining LFG channel.";
LEAVELFG_CITY_JOIN = "Entering city. Joining LFG channel.";
LEAVELFG_BUTTON_JOIN = "Joining LFG channel";
LEAVELFG_BUTTON_LEAVE = "Leaving LFG channel";
LEAVELFG_BUTTON_NORMAL = ". Automatic join/leave deactivated for this session.";
LEAVELFG_BUTTON_CTRL = ". Automatic join/leave permanently deactivated.";
LEAVELFG_BUTTON_SHIFT = ". Automatic join/leave is still ";

LEAVELFG_BUTTON_TOOLTIP1 = "Left click without modify key: Join/leave LFG channel; deactivate automatism for this session";
LEAVELFG_BUTTON_TOOLTIP2 = "Left click+CTRL key: Join/leave LFG channel; deactivate automatism permanently";
LEAVELFG_BUTTON_TOOLTIP3 = "Left click+SHIFT key: Join/leave LFG channel; leave automatism untouched";
LEAVELFG_BUTTON_TOOLTIP4 = "Left click+ALT key or middle click: Toggle automatic join/leave (is equivalent to /lfg automatic)";
LEAVELFG_BUTTON_TOOLTIP5 = "Right click without modify key: Show current settings (is equivalent to /lfg status)";
LEAVELFG_BUTTON_TOOLTIP6 = "Right click+SHIFT key: Toggle mover (appears topleft of button)";

LEAVELFG_MOVER_TOOLTIP1 = "Left click (keep pressed): Move button";
LEAVELFG_MOVER_TOOLTIP2 = "Right click+SHIFT key: Lock button on current position";
LEAVELFG_MOVER_TOOLTIP3 = "Right click+CTRL key: Reset and lock button on original position";
	
LEAVELFG_LFGCHANNEL = "LookingForGroup";

LEAVELFG_SLASHCMD_CITIES_ON = "Will now join automatically LFG channel in cities.";
LEAVELFG_SLASHCMD_CITIES_OFF = "Will no longer join automatically LFG channel in cities.";
LEAVELFG_SLASHCMD_WORLD_JOIN_ON = "Will now join automatically LFG channel in normal world.";
LEAVELFG_SLASHCMD_WORLD_JOIN_OFF = "Will no longer join automatically LFG channel in normal world.";
LEAVELFG_SLASHCMD_WORLD_LEAVE_ON = "Will now leave automatically LFG channel in normal world.";
LEAVELFG_SLASHCMD_WORLD_LEAVE_OFF = "Will no longer leave automatically LFG channel in normal world.";
LEAVELFG_SLASHCMD_DUNGEON_ON = "Will now leave automatically LFG channel in dungeons.";
LEAVELFG_SLASHCMD_DUNGEON_OFF = "Will no longer leave automatically LFG channel in dungeons.";
LEAVELFG_SLASHCMD_AUTOMATIC_ON = "The join/leave automatism is now activated.";
LEAVELFG_SLASHCMD_AUTOMATIC_OFF = "The join/leave automatism is now deactivated. Will now only join/leave when commanded to do that.";

LEAVELFG_SLASHCMD_JOIN_ALREADY = "You are already in LFG channel";
LEAVELFG_SLASHCMD_LEAVE_ALREADY = "You are already left LFG channel";

LeaveLFG_STATUS_OFF = "|cffff0000 OFF";
LeaveLFG_STATUS_ON = "|cff00ff00 ON";

LEAVELFG_SLASHCMD_STATUS = {
	[1] = "|cffffffffLeaveLFG commands (you can use /leavefg too instead of /lfg):";
	[2] = "/lfg join|cffffffff - Join LFG channel (automatic join/leave will stay untouched)";
	[3] = "/lfg leave|cffffffff - Leave LFG channel (automatic join/leave will stay untouched)";
	[4] = "/lfg join2|cffffffff - Join LFG channel (automatic join/leave will be deactivated for this session)";
	[5] = "/lfg leave2|cffffffff - Leave LFG channel (automatic join/leave will be deactivated for this session)";
	[6] = "/lfg cities|cffffffff - Toggle automatic joining/leaving of LFG channel in cities",
	[7] = "/lfg worldjoin|cffffffff - Toggle automatic joining of LFG channel in normal world",
	[8] = "/lfg worldleave|cffffffff - Toggle automatic leaving of LFG channel in normal world",
	[9] = "/lfg dungeons|cffffffff - Toggle automatic leaving of LFG channel in dungeons",
	[10] = "/lfg automatic|cffffffff - Toggle automatic joining/leaving of LFG channel (in general)",
}

LEAVELFG_HINT_SESSION_AUTOMATIC_OFF = "Hint:|cffffffff The session lock of the join/leave automatism is resetted now.";
LEAVELFG_HINT_AUTOMATIC_OFF = "Hint:|cffffffff The join/leave automatism (changeable with command /lfg automatic) is currently "..LeaveLFG_STATUS_OFF;

-- GERMAN
if (GetLocale() == "deDE") then
	LEAVELFG_DUNGEON_LEAVE = "Betrete Instanz - verlasse SucheNachGruppe-Channel";
	LEAVELFG_WORLD_JOIN = "Betrete normale Welt - trete SucheNachGruppe-Channel bei";
	LEAVELFG_WORLD_LEAVE = "Betrete normale Welt - verlasse SucheNachGruppe-Channel";
	LEAVELFG_CITY_JOIN = "Betrete Stadt - trete SucheNachGruppe-Channel bei";
	LEAVELFG_BUTTON_JOIN = "Trete SucheNachGruppe-Channel bei";
	LEAVELFG_BUTTON_LEAVE = "Verlasse SucheNachGruppe-Channel";
	LEAVELFG_BUTTON_NORMAL = ". Automatisches Beitreten/Verlassen f\195\188r diese Sitzung deaktiviert.";
	LEAVELFG_BUTTON_CTRL = ". Automatisches Beitreten/Verlassen permanent deaktiviert.";
	LEAVELFG_BUTTON_SHIFT = ". Automatisches Beitreten/Verlassen bleibt weiterhin ";
	
	LEAVELFG_BUTTON_TOOLTIP1 = "Linksklick ohne Zusatztaste: LFG-Channel beitreten/verlassen; Automatik f\195\188r diese Sitzung deaktivieren";
	LEAVELFG_BUTTON_TOOLTIP2 = "Linksklick+Strg-Taste: LFG-Channel beitreten/verlassen; Automatik permanent deaktivieren";
	LEAVELFG_BUTTON_TOOLTIP3 = "Linksklick+Shift-Taste: LFG-Channel beitreten/verlassen; Automatik belassen wie sie ist";
	LEAVELFG_BUTTON_TOOLTIP4 = "Linksklick+Alt-Taste, oder Mittelklick: Automatisches Beitreten/Verlassen umschalten (entspricht /lfg automatic)";
	LEAVELFG_BUTTON_TOOLTIP5 = "Rechtsklick ohne Zusatztaste: Aktuelle Einstellungen anzeigen (entspricht /lfg status)";
	LEAVELFG_BUTTON_TOOLTIP6 = "Rechtsklick+Shift-Taste: Beweger an-/ausschalten (erscheints links oben vom Button)";
	
	LEAVELFG_MOVER_TOOLTIP1 = "Linksklick (gedr\195\188ckt halten): Bewegen";
	LEAVELFG_MOVER_TOOLTIP2 = "Rechtsklick+Shift-Taste: Button an der aktuellen Position festsetzen";
	LEAVELFG_MOVER_TOOLTIP3 = "Rechtsklick+Strg-Taste: Button an der originalen Position (rechts oben vom Hauptchatframe) festsetzen";
	
	LEAVELFG_LFGCHANNEL = "SucheNachGruppe";
	
	LEAVELFG_SLASHCMD_CITIES_ON = "Trete absofort automatisch SucheNachGruppe-Channel in St\195\164dten bei";
	LEAVELFG_SLASHCMD_CITIES_OFF = "Trete absofort nicht mehr automatisch SucheNachGruppe-Channel in St\195\164dten bei";
	LEAVELFG_SLASHCMD_WORLD_JOIN_ON = "Trete absofort automatisch SucheNachGruppe-Channel in der normalen Welt bei.";
	LEAVELFG_SLASHCMD_WORLD_JOIN_OFF = "Trete absofort nicht mehr automatisch SucheNachGruppe-Channel in der normalen Welt bei.";
	LEAVELFG_SLASHCMD_WORLD_LEAVE_ON = "Verlasse absofort automatisch SucheNachGruppe-Channel in der normalen Welt.";
	LEAVELFG_SLASHCMD_WORLD_LEAVE_OFF = "Verlasse absofort nicht mehr automatisch SucheNachGruppe-Channel in der normalen Welt.";
	LEAVELFG_SLASHCMD_DUNGEON_ON = "Verlasse absofort automatisch SucheNachGruppe-Channel in Instanzen.";
	LEAVELFG_SLASHCMD_DUNGEON_OFF = "Verlasse absofort nicht mehr automatisch SucheNachGruppe-Channel in Instanzen.";
	LEAVELFG_SLASHCMD_AUTOMATIC_ON = "SucheNachGruppe-Channel automatisch beitreten/verlassen aktiviert.";
	LEAVELFG_SLASHCMD_AUTOMATIC_OFF = "SucheNachGruppe-Channel wird absofort nur noch auf Befehl verlassen/beigetreten.";
	
	LEAVELFG_SLASHCMD_JOIN_ALREADY = "Du bist bereits im SucheNachGruppe-Channel";
	LEAVELFG_SLASHCMD_LEAVE_ALREADY = "Du hast den SucheNachGruppe-Channel bereits verlassen";

	LeaveLFG_STATUS_OFF = "|cffff0000 DEAKTIVIERT";
	LeaveLFG_STATUS_ON = "|cff00ff00 AKTIVIERT";
	
	LEAVELFG_SLASHCMD_STATUS = {
		[1] = "|cffffffffLeaveLFG-Befehle (statt /lfg kannst du auch /leavelfg schreiben):";
		[2] = "/lfg join|cffffffff - SucheNachGruppe-Channel beitreten (Sitzungs-Beitreten-/Verlassen-Automatik bleibt wie sie ist)";
		[3] = "/lfg leave|cffffffff - SucheNachGruppe-Channel verlassen (Sitzungs-Beitreten-/Verlassen-Automatik bleibt wie sie ist)";
		[4] = "/lfg join2|cffffffff - SucheNachGruppe-Channel beitreten (Beitreten-/Verlassen-Automatik wird f\195\188r diese Sitzung deaktiviert)";
		[5] = "/lfg leave2|cffffffff - SucheNachGruppe-Channel verlassen (Beitreten-/Verlassen-Automatik wird f\195\188r diese Sitzung deaktiviert)";
		[6] = "/lfg cities|cffffffff - In St\195\164dten automatisch SucheNachGruppe-Channel beitreten an-/ausschalten",
		[7] = "/lfg worldjoin|cffffffff - In normaler Welt automatisch SucheNachGruppe-Channel beitreten an-/ausschalten",
		[8] = "/lfg worldleave|cffffffff - In normaler Welt automatisch SucheNachGruppe-Channel verlassen an-/ausschalten",
		[9] = "/lfg dungeons|cffffffff - In Instanzen automatisch SucheNachGruppe-Channel verlassen an-/ausschalten",
		[10] = "/lfg automatic|cffffffff - Automatisches Beitreten/Verlassen des SucheNachGruppe-Channels an-/ausschalten",
	}
	
	LEAVELFG_HINT_SESSION_AUTOMATIC_OFF = "Hinweis:|cffffffff Die Sitzungs-Sperre f\195\188r automatisches Beitreten/Verlassen wurde aufgehoben.";
	LEAVELFG_HINT_AUTOMATIC_OFF = "Hinweis:|cffffffff Automatisches Beitreten/Verlassen (\195\164nderbar \195\188ber /lfg automatic) ist momentan "..LeaveLFG_STATUS_OFF;
-- FRENCH
elseif(GetLocale()=="frFR") then
	LEAVELFG_LFGCHANNEL = "RechercheGroupe";
end

--[[
 à : \195\160    è : \195\168    ì : \195\172    ò : \195\178    ù : \195\185
   á : \195\161    é : \195\169    í : \195\173    ó : \195\179    ú : \195\186
   â : \195\162    ê : \195\170    î : \195\174    ô : \195\180    û : \195\187
   ã : \195\163    ë : \195\171    ï : \195\175    õ : \195\181    ü : \195\188
   ä : \195\164                    ñ : \195\177    ö : \195\182
   æ : \195\166                                    ø : \195\184
   ç : \195\167
   
   Ä : \195\132
   Ö : \195\150
   Ü : \195\156
   ß : \195\159
]]