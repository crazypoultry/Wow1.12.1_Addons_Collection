-- -------------------------------------------- --
-- La Vendetta Boss Mods - french localization  --
-- -------------------------------------------- --

if (GetLocale() == "frFR") then	
	--classes
	LVBM_MAGE = "Mage";
	LVBM_PRIEST = "Pr\195\170tre";
	LVBM_PALADIN = "Paladin";
	LVBM_DRUID = "Druide";
	LVBM_WARLOCK = "D\195\169moniste";
	LVBM_ROGUE = "Voleur";
	LVBM_HUNTER = "Chasseur";
	LVBM_WARRIOR = "Guerrier";
	LVBM_SHAMAN = "Chaman";
	
	--zone
	LVBM_NAXX	= "Naxxramas";
	LVBM_AQ40	= "Ahn'Qiraj";
	LVBM_BWL	= "Repaire de l'Aile noire";
	LVBM_MC		= "C\221\181r du Magma";
	LVBM_AQ20	= "Ruines d'Ahn'Qiraj";
	LVBM_ZG 	= "Zul'Gurub";
	LVBM_ONYXIAS_LAIR	= "Repaire d'Onyxia";
	LVBM_DUSKWOOD		= "Bois de la p\195\169nombre";
	LVBM_ASHENVALE		= "Ashenvale";
	LVBM_FERALAS		= "Feralas";
	LVBM_HINTERLANDS	= "Les Hinterlands";
	LVBM_BLASTED_LANDS	= "Terres foudroy\195\169es";
	LVBM_AZSHARA		= "Azshara";
	
	--spells/buffs
	LVBM_CHARGE = "Charge";
	LVBM_FERALCHARGE = "Charge farouche";
	LVBM_BLOODRAGE = "Rage sanguinaire";
	LVBM_REDEMPTION = "Esprit de r\195\169demption";
	LVBM_FEIGNDEATH	= "Feindre la mort";
	LVBM_MINDCONTROL	= "Contr\195\180le mental";
	
	--create status bar timer localization table
LVBM_SBT = {};

--key bindings
BINDING_HEADER_LVBM 		= "La Vendetta Boss Mods";
BINDING_NAME_TOGGLE 		= "Toggle GUI";

--OnLoad messages
LVBM_LOADED			= "La Vendetta Boss Mods v%s par Destiny|Tandanu @ EU-Aegwynn et La Vendetta|Nitram @ EU-Azshara charg\195\169.";
LVBM_MODS_LOADED		= "%s %s boss mods charg\195\169."

--Slash command messages
LVBM_MOD_ENABLED		= "Boss mod activ\195\169.";
LVBM_MOD_DISABLED		= "Boss mod d\195\169sactiv\195\169.";
LVBM_ANNOUNCE_ENABLED		= "Annonce activ\195\169e.";
LVBM_ANNOUNCE_DISABLED		= "Annonce d\195\169sactiv\195\169e.";
LVBM_MOD_STOPPED		= "Tous les timers ont \195\169t\195\169 stopp\195\169s.";
LVBM_MOD_INFO			= "Boss mod v%s par %s";
LVBM_SLASH_HELP1		= " on/off";
LVBM_SLASH_HELP2		= " Annonce on/off";
LVBM_SLASH_HELP3		= " Stop";
LVBM_SLASH_HELP4		= "Vous pouvez utiliser %s \195\170 la place de /%s.";
LVBM_RANGE_CHECK		= "Joueurs \195\160 plus de 30m: ";
LVBM_FOUND_CLIENTS		= "%s joueurs utilisant Vendetta Boss Mods trouv\195\169s";

--Sync options
LVBM_SOMEONE_SET_SYNC_CHANNEL	= "%s a chang\195\169 le sync channel en: %s";
LVBM_SET_SYNC_CHANNEL		= "Sync channel chang\195\169 en: %s";
LVBM_CHANNEL_NOT_SET		= "Aucun channel, impossible de cr\195\169er un broadcast.";
LVBM_NEED_LEADER		= "Vous devez \195\170tre promu ou chef du raid pour broadcast le channel!";
LVBM_NEED_LEADER_STOP_ALL	= "Vous devez \195\170tre promu ou chef du raid pour utiliser cette fonction!";
LVBM_ALL_STOPPED		= "Tous les timers ont \195\169t\195\169 stopp\195\169s.";
LVBM_REC_STOP_ALL		= "Commande d'arr\195\170t g\195\169n\195\169ral re\195\135ue de %s.";

--Update dialog
LVBM_UPDATE_DIALOG		= "Votre version de <La Vendetta Boss Mods> est p\195\169rim\195\169e!\n%s et %s ont la version %s.\nMerci de visiter www.curse-gaming.com afin d'obtenir la derni\195\168re version.";
LVBM_REQ_PATCHNOTES		= "Requ\195\170te des notes de mise-\195\170-jour en cours %s...Chargement, attendez s'il vous plaît.";
LVBM_SHOW_PATCHNOTES		= "Afficher les notes de mise-\195\170-jour";
LVBM_PATCHNOTES			= "Notes de mise-\195\170-jour";
LVBM_COPY_PASTE_URL		= "Copier & coller l'URL";
LVBM_COPY_PASTE_NOW		= "Appuyez sur CTRL-C afin de copier l'URL dans le presse-papier";

--Status Bar Timers
LVBM_SBT_TIMELEFT				= "Temps restant:";
LVBM_SBT_TIMEELAPSED			= "Temps \195\169coul\195\169:";
LVBM_SBT_TOTALTIME				= "Temps total:";
LVBM_SBT_REPETITIONS			= "R\195\169p\195\169titions:";
LVBM_SBT_INFINITE				= "infinie";
LVBM_SBT_BOSSMOD				= "Boss mod:";
LVBM_SBT_STARTEDBY				= "D\195\169marr\195\169 par:";
LVBM_SBT_RIGHTCLICK				= "Click droit sur la barre pour la masquer.";
LVBM_SBT_LEFTCLICK				= "Shift + Click gauche sur la barre pour l'annoncer";
LVBM_TIMER_IS_ABOUT_TO_EXPIRE	= "<ATTENTION !> Le timer de \"%s\" va bientôt terminer!";
LVBM_BAR_STYLE_DEFAULT			= "Default";
LVBM_BAR_STYLE_MODERN			= "Modern";
LVBM_BAR_STYLE_CLOUDS			= "Clouds";
LVBM_BAR_STYLE_PERL				= "Perl";


--Combat messages
LVBM_BOSS_ENGAGED			= "%s engag\195\169. Bonne chance et HF! :)";
LVBM_BOSS_SYNCED_BY			= "(Commande de synchro reçue de %s)";
LVBM_BOSS_DOWN				= "%s down apr\195\168s %s!";
LVBM_COMBAT_ENDED			= "Combat termin\195\169 apr\195\168s %s.";
LVBM_DEFAULT_BUSY_MSG		= "%P est occup\195\169. (En combat contre %B - %HP - %ALIVE/%RAID personnes en vie) Vous serrez inform\195\169 apr\195\168s le combat!";
LVBM_RAID_STATUS_WHISPER	= "%B - %HP - %ALIVE/%RAID personnes en vie.";
LVBM_SEND_STATUS_INFO		= "Whispez \"status\" pour recevoir le status du raid.";
LVBM_AUTO_RESPOND_SHORT		= "R\195\169ponse automatique envoy\195\169e.";
LVBM_AUTO_RESPOND_LONG		= "R\195\169ponse automatique envoy\195\169e \195\170 %s";
LVBM_MISSED_WHISPERS		= "Whisps manqu\195\169s durant le combat:";
LVBM_SHOW_MISSED_WHISPER	= "|Hplayer:%1\$s|h[%1\$s]|h: %2\$s";
LVBM_BALCONY_PHASE			= "<ATTENTION !>Passage en phase #%s";

--Misc stuff
LVBM_YOU					= "Vous";
LVBM_ARE					= "\195\170tes";
LVBM_IS						= "est";
LVBM_OR						= "ou";
LVBM_AND					= "et";
LVBM_UNKNOWN			 		= "inconnu";
LVBM_LOCAL					= "local";
LVBM_DEFAULT_DESCRIPTION			= "Description non disponible.";
LVBM_SEC					= "sec";
LVBM_MIN					= "min";
LVBM_SECOND					= "second";
LVBM_SECONDS					= "seconds";
LVBM_MINUTES					= "minutes";
LVBM_MINUTE					= "minute";
LVBM_HIT					= "coup";
LVBM_HITS					= "coups";
LVBM_CRIT					= "crit";
LVBM_CRITS					= "crits";
LVBM_MISS					= "manqu\195\169";
LVBM_DODGE					= "esquiv\195\169";
LVBM_PARRY					= "parr\195\169";
LVBM_FROST					= "Givre";
LVBM_ARCANE					= "Arcane";
LVBM_FIRE					= "Feu";
LVBM_HOLY					= "Sacr\195\169";
LVBM_NATURE					= "Nature";
LVBM_SHADOW					= "Ombre";
LVBM_CLOSE					= "Fermer";
LVBM_AGGRO_FROM					= "Prise d'aggro de ";
LVBM_SET_ICON					= "Mettre icone";
LVBM_SEND_WHISPER				= "Whisper";
LVBM_DEAD					= "Mort";
LVBM_OFFLINE					= "Hors-ligne";
LVBM_PHASE					= "Phase %s";
LVBM_WAVE					= "Vague %s";

end
