-- File containing localized strings
-- Version : English - Kiki
-- Translation by : frFR - Kiki
-- Translation by : deDE - Edur


if ( GetLocale() == "frFR" ) then
  -- French localized variables
  -- �(ç) �(à) �(á) �(â) �(ã) �(ä) �(æ) �(ç) �(è) �(é) �(ê) �(ë) �(î) �(ï) �(ò) �(ó) �(ô) �(õ) �(ö) �(ù) �(ú) �(û) �(ü) '(’)
  -- => Displayed strings
  AK_CHAT_MISC_LOADED = "Chargé ! (/ak pour l’aide)";
  AK_CHAT_HELP_TARGETED = "Quand vous ciblez quelqu'un, affiche un message dans la zone d'erreur (ef), la Tooltip (tt), les deux ou aucun";
  AK_CHAT_HELP_MOUSEOVER = "Quand vous passez la souris sur une cible, affiche un message dans la zone d'erreur (ef), la Tooltip (tt), les deux ou aucun";
  AK_CHAT_HELP_SHOW = "Affiche ou non, le compteur de Points d'Honneur Estimé";
  AK_CHAT_HELP_LOCK = "Verrouille ou non, le compteur de Points d'Honneur Estimé";
  AK_CHAT_HELP_TELL = "Affiche ou non, les points d'Honneur quand une cible meurt";
  AK_CHAT_HELP_FRAME = "Affiche ou non, le compteur de morts de votre cible";
  AK_CHAT_HELP_SCT = "Affiche ou non, les points d'honneur dans Sct";
  AK_CHAT_HELP_RESET = "Remet à zéro le compteur de Points d'Honneur Estimé";
  AK_CHAT_HELP_RESETKILLS = "Remet à zéro tous vos kills";
  AK_CHAT_HELP_ADDHP = "Ajoute manuellement des points au compteur de Points d'Honneur Estimé";
  AK_CHAT_CMD_PARAM_ERROR = "Erreur dans la commande ";
  AK_CHAT_CMD_UNKNOWN = "Commande /ak inconnue, essayez /ak help";
  AK_CHAT_RESET_KILLS = "Le compte de vos victimes a été réinitialisé. A la chargeeeeeee !!";
  AK_CHAT_ADDHP_ADDED = "A ajouté manuellement des points au compteur de PHE : ";
  AK_CHAT_BG_BONUS = " points gagnés dans le champ de bataille.";
  AK_CHAT_BG_BONUS2 = " points bonus gagnés dans le champ de bataille.";
  AK_CHAT_SCT_HONOR = " honneur";
  AK_CHAT_MAINTENANCE = "Première connexion depuis une maintenance hebdomadaire !";
  -- => Other strings
  AK_BG_WARSONG = "Goulet des Warsong";
  AK_BG_ALTERAC = "Vallée d'Alterac";
  AK_BG_ARATHI = "Bassin d'Arathi";
  AK_HONOR_GAIN_MESSAGE = "Vous avez reçu (%d+) points d'honneur%.";
  AK_EHP = "PHE";
elseif ( GetLocale() == "deDE" ) then
  -- => Displayed strings
  AK_CHAT_MISC_LOADED = "Geladen ! (/ak für Hilfe)";
  AK_CHAT_HELP_TARGETED = "Wenn anvisiert, zeige Meldung im ErrorFrame (ef), Tooltip (tt), beidem oder keinem";
  AK_CHAT_HELP_MOUSEOVER = "Wenn 'MouseOver', zeige Meldung im ErrorFrame (ef), Tooltip (tt), beidem oder keinem";
  AK_CHAT_HELP_SHOW = "Zeige oder verstecke den gesch/195/164tzen Ehrenpunktenz/195/164hler";
  AK_CHAT_HELP_LOCK = "Sperre die Position des Ehrenpunktenz/195/164hlers, oder gebe sie frei";
  AK_CHAT_HELP_TELL = "Displays or not, a message indicating the gained honor when an enemy dies";
  AK_CHAT_HELP_FRAME = "Displays or not, target kills counter";
  AK_CHAT_HELP_SCT = "Displays or not, earned honor points in Sct";
  AK_CHAT_HELP_RESET = "Setzt den Ehrenpunktenz/195/164hler zur/195/188ck";
  AK_CHAT_HELP_RESETKILLS = "Resets all your kills";
  AK_CHAT_HELP_ADDHP = "F/195/188ge Punkte manuell dem Ehrenpunktenz/195/164hler hinzu";
  AK_CHAT_CMD_PARAM_ERROR = "Falscher oder fehlender Parameter f/195/188r Befehl ";
  AK_CHAT_CMD_UNKNOWN = "Unbekannter /ak Befehl, versuche /ak help";
  AK_CHAT_RESET_KILLS = "Alle deine Siege wurden zur/195/188ückgesetzt. Los Los, töte Sie alle";
  AK_CHAT_ADDHP_ADDED = "Manuell gesetzte Punkte wurden dem EP Z/195/164hler hinzugef/195/188gt: ";
  AK_CHAT_BG_BONUS = " Punkte im Schlachtfeld errungen.";
  AK_CHAT_BG_BONUS2 = " Bonus Punkte im Schlachtfeld errungen.";
  AK_CHAT_SCT_HONOR = " honor";
  AK_CHAT_MAINTENANCE = "Erste Verbindung seit den wöchentlichen Wartungsarbeiten !";
  -- => Other strings
  AK_EHP = "EP";
  AK_BG_WARSONG = "Warsongschlucht";
  AK_BG_ALTERAC = "Alteractal";
  AK_BG_ARATHI = "Arathibecken";
  AK_HONOR_GAIN_MESSAGE = "Ihr erhaltet (%d+) Ehrenpunkte%.";
else
  -- English localized variables (default)
  -- => Displayed strings
  AK_CHAT_MISC_LOADED = "Loaded ! (/ak for help)";
  AK_CHAT_HELP_TARGETED = "When targetting, displays message in ErrorFrame (ef), Tooltip (tt), both or none";
  AK_CHAT_HELP_MOUSEOVER = "When mousing over, displays message in ErrorFrame (ef), Tooltip (tt), both or none";
  AK_CHAT_HELP_SHOW = "Shows or not, the Estimated Honor Points counter";
  AK_CHAT_HELP_LOCK = "Locks or not, the position of the Estimated honor counter";
  AK_CHAT_HELP_FRAME = "Displays or not, target kills counter";
  AK_CHAT_HELP_TELL = "Displays or not, a message indicating the gained honor when an enemy dies";
  AK_CHAT_HELP_SCT = "Displays or not, earned honor points in Sct";
  AK_CHAT_HELP_RESET = "Resets the the Estimated honor counter";
  AK_CHAT_HELP_RESETKILLS = "Resets all your kills";
  AK_CHAT_HELP_ADDHP = "Manually adds points to the Estimated honor counter";
  AK_CHAT_CMD_PARAM_ERROR = "Wrong or missing parameter for command ";
  AK_CHAT_CMD_UNKNOWN = "Unknown /ak command, try /ak help";
  AK_CHAT_RESET_KILLS = "All your kills have been reset. Gogo kill'em all";
  AK_CHAT_ADDHP_ADDED = "Manually added points to the EHP counter : ";
  AK_CHAT_BG_BONUS = " points earned in the battleground.";
  AK_CHAT_BG_BONUS2 = " bonus points earned in the battleground.";
  AK_CHAT_SCT_HONOR = " honor";
  AK_CHAT_MAINTENANCE = "First connection since a weekly maintenance !";
  -- => Other strings
  AK_EHP = "EHP";
  AK_BG_WARSONG = "Warsong Gulch";
  AK_BG_ALTERAC = "Alterac Valley";
  AK_BG_ARATHI = "Arathi Basin";
  AK_HONOR_GAIN_MESSAGE = "You have been awarded (%d+) honor points%.";
end
