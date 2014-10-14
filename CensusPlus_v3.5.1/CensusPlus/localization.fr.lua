--[[
	CensusPlus for World of Warcraft(tm).
	
	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]


-- Version : French (by Juki)
-- Last Update : 02/17/2005

if ( GetLocale() == "frFR" ) then

    -- Cosmos Configuration
    CENSUSPlus_BUTTON_TEXT      = "Census+";
    CENSUSPlus_BUTTON_SUBTEXT   = "Stats serveur";
    CENSUSPlus_BUTTON_TIP       = "Cliquez ici pour montrer ou masquer Census+.";
    CENSUSPlus_HELP             = " Utilisez /censusplus pour ouvrir et fermer Census+.";
    
    -- Chat Configuration
    CENSUSPlus_MSG1             = " Chargée - Tapez /censusplus ou /census+ pour ouvrir la fenêtre principale";
    CENSUSPlus_MSG2             = "Utilisez /censusdate pour configurer la date du jour dans le format MM-DD-YYYY, ie.12-25-2004";

    -- Chat Configuration
    CENSUSPlus_UPLOAD           = "";
    CENSUSPlus_SETTINGDATE      = "Mise à jour de la date => ";
    CENSUSPlus_PAUSE            = "Pause";
    CENSUSPlus_UNPAUSE          = "Reprendre";
    CENSUSPlus_STOP             = "Stop";
    
    CENSUSPlus_TAKECENSUS       = "Faire un recensement des joueurs \nactuellement en ligne sur ce serveur \net dans cette faction";
    CENSUSPlus_PURGEDATABASE    = "Supprime la base de donnée concernant \nle serveur et la faction en cours.";
    CENSUSPlus_PAUSECENSUS      = "Mettre en pause le recensement en cours";
    CENSUSPlus_STOPCENSUS       = "Arrêter le recensement en cours"
    
    CENSUSPlus_PURGEMSG         = "Base de donnée supprimée.";
    CENSUSPlus_ISINPROGRESS     = "Un recensement est en cours, veuillez patienter";
    CENSUSPlus_TAKINGONLINE     = "Recensement des joueurs en cours ...";
    CENSUSPlus_PLZUPDATEDATE    = "SVP utilisez /censusdate pour configurer la date du jour pour des données plus précises. Format /censusdate MM-DD-YYYY, exemple, /censusdate 12-25-2004";
    CENSUSPlus_NOCENSUS         = "Aucun recensement en cours";
    CENSUSPlus_FINISHED         = "Recensement terminé. %s nouveaux personnages et %s mis à jour.";
    CENSUSPlus_TOOMANY          = "ERREUR: Trop de joueurs correspondants à : %s";
    CENSUSPlus_WAITING          = "En attente de lancement de requête /who ...";
    CENSUSPlus_SENDING          = "Envoi de requête /who %s";
    CENSUSPlus_PROCESSING       = "Analyse de %s personnages.";
    
    CENSUSPlus_REALMNAME        = "Serveur : %s";
    CENSUSPlus_REALMUNKNOWN     = "Serveur : Inconnu";
    CENSUSPlus_FACTION          = "Faction : %s";
    CENSUSPlus_FACTIONUNKNOWN   = "Faction : Inconnu";
    CENSUSPlus_TOTALCHAR        = "Nombre de personnages : %d";
    CENSUSPlus_TOTALCHAR_0      = "Nombre de personnages : 0";
    CENSUSPlus_TOTALCHARXP      = "Nombre d'xp total : %d";
    CENSUSPlus_TOTALCHARXP_0    = "Nombre d'xp total : 0";
    CENSUSPlus_AUTOCLOSEWHO     = "Fermeture auto du /Who";
    CENSUSPlus_SHOWMINI         = "Montrer Mini au démarrage";
    CENSUSPlus_UNGUILDED        = "(Sans Guilde)";
    CENSUSPlus_TAKE             = "Recenser";
    CENSUSPlus_TOPGUILD         = "Meilleures guildes par XP";
    CENSUSPlus_RACE             = "Races";
    CENSUSPlus_CLASS            = "Classes";
    CENSUSPlus_LEVEL            = "Niveaux";
    CENSUSPlus_PURGE            = "Mettre à Zero"; 
    
    CENSUSPlus_MAXIMIZE         = "Agrandir la fenêtre CensusPlus";
    CENSUSPlus_MINIMIZE         = "Réduire la fenêtre CensusPlus";
    CENSUSPlus_BUTTON_MINIMIZE  = "Réduire";
        
    CENSUSPlus_HORDE            = "Horde";
    CENSUSPlus_ALLIANCE         = "Alliance";

    CENSUSPlus_DRUID            = "Druide";
    CENSUSPlus_HUNTER           = "Chasseur";
    CENSUSPlus_MAGE             = "Mage";
    CENSUSPlus_PRIEST           = "Prêtre";
    CENSUSPlus_ROGUE            = "Voleur";
    CENSUSPlus_WARLOCK          = "Démoniste";
    CENSUSPlus_WARRIOR          = "Guerrier";
    CENSUSPlus_SHAMAN           = "Chaman";
    CENSUSPlus_PALADIN          = "Paladin";
 
    CENSUSPlus_DWARF            = "Nain";
    CENSUSPlus_GNOME            = "Gnome";
    CENSUSPlus_HUMAN            = "Humain";
    CENSUSPlus_NIGHTELF         = "Elfe de la nuit";
    CENSUSPlus_ORC              = "Orc";
    CENSUSPlus_TAUREN           = "Tauren";
    CENSUSPlus_TROLL            = "Troll";
    CENSUSPlus_UNDEAD           = "Mort-vivant";

	CENSUSPLUS_US_LOCALE		= "Choisissez si vous jouez sur un serveur US";
	CENSUSPLUS_EU_LOCALE		= "Choisissez si vous jouez sur un serveur EURO";
    CENSUSPLUS_LOCALE_SELECT    = "Choisissez la localité de votre serveur";
    
end