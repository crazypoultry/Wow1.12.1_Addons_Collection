if ( GetLocale() == "frFR" ) then

GUILDADS_TITLE				= "GuildAds";

-- Minimap button
GUILDADS_BUTTON_TIP			= "Les Annonces de la guilde";

-- Config
GUILDADS_CHAT_OPTIONS		= "Options du canal GuildAds";
GUILDADS_CHAT_USETHIS		= "Utiliser ce canal :";
GUILDADS_CHAT_CHANNEL		= "Nom";
GUILDADS_CHAT_PASSWORD		= "Mot de passe";
GUILDADS_CHAT_COMMAND		= 'Commande "/"';
GUILDADS_CHAT_ALIAS 		= "Alias";
GUILDADS_CHAT_SHOW_NEWEVENT	= "Afficher les nouveaux evenements"
GUILDADS_CHAT_SHOW_NEWASK	= "Afficher les nouvelles demandes";
GUILDADS_CHAT_SHOW_NEWHAVE	= "Afficher les nouvelles propositions";
GUILDADS_ADS_OPTIONS		= "Options des annonces";
GUILDADS_PUBLISH			= "Publier mes annonces";
GUILDADS_VIEWMYADS			= "Voir mes annonces";
GUILDADS_ICON_OPTIONS		= "Options de l\'ic\195\180ne de la Minimap";
GUILDADS_ICON 				= "Ic\195\180ne de la Minimap";
GUILDADS_ADJUST_ANGLE 		= "Adjuster l\'Angle";
GUILDADS_ADJUST_RADIUS 		= "Adjuster le Rayon";

GUILDADS_AUTOCHANNELCONFIG  = "Configuration de canal automatique";
GUILDADS_MANUALCHANNELCONFIG= "Configuration du canal manuelle";

GUILDADS_ERROR_TOOMANYCHANNELS		= "Vous avez d\195\169j\195\160 rejoint le nombre maximum de canaux (10)"; 
GUILDADS_ERROR_JOINCHANNELFAILED 	= "N'a pas joint le canal pour une raison inconnue";
GUILDADS_ERROR_WRONGPASSWORD 		= "Le mot de passe est incorrect";

-- Main frame
GUILDADS_MYADS				= "Mes Annonces";
GUILDADS_BUTTON_INVITE		= "Invite Groupe";
GUILDADS_BUTTON_ADDREQUEST	= "Demander";
GUILDADS_BUTTON_ADDAVAILABLE= "Proposer";
GUILDADS_BUTTON_ADDEVENT	= "Participer";
GUILDADS_QUANTITY			= "Quantité";
GUILDADS_SINCE				= "Depuis %s";
GUILDADS_SIMPLE_SINCE		= "Depuis";
GUILDADS_ACCOUNT_NA			= "Information non disponible";
GUILDADS_GROUPBYACCOUNT		= "Regrouper par compte";

GUILDADS_TRADE_PROVIDER = "Par";
GUILDADS_TRADE_NUMBER="Nb";
GUILDADS_TRADE_OBJECT="Objet";
GUILDADS_TRADE_ACTIVE="Active";
GUILDADS_TRADE_TYPE="Type";
-- Column headers
GUILDADS_HEADER_REQUEST        = "Demande";
GUILDADS_HEADER_AVAILABLE      = "Propose";
-- GUILDADS_HEADER_INVENTORY : done by WOW
-- GUILDADS_HEADER_SKILL : done by WOW
-- GUILDADS_HEADER_ANNONCE : done by WOW
GUILDADS_HEADER_EVENT		= "Evénements";

-- Equipment
GUILDADS_EQUIPMENT             = "Equipement";

-- Tooltip requests
GUILDADS_ASKTOOLTIP		= "%s demande(s)";
				
-- Race
GUILDADS_RACES			= {
					[1] = "Humain",
					[2] = "Nain",
					[3] = "Elfe de la nuit",
					[4] = "Gnome",
					[5] = "Orc",
					[6] = "Mort-vivant",
					[7] = "Tauren",
					[8] = "Troll"
				};
				
GUILDADS_CLASSES		= {
					[1] = "Guerrier",
					[2] = "Chaman",
					[3] = "Paladin",
					[4] = "Druide",
					[5] = "Voleur",
					[6] = "Chasseur",
					[7] = "Démoniste",
					[8] = "Mage",
					[9] = "Prêtre"
				};
				
-- Item
-- arme, armure, conteneur, artisanat, projectile, carquois, recette, composant, divers
GUILDADS_ITEMS			= {
					everything	= "Tout",
					everythingelse	= "Tout le reste",
					monster		= "Obtenu sur des monstres",
					classReagent	= "Utilisé par une classe",
					tradeReagent	= "Utilisé pour les professions",
					vendor		= "Vendeur",
					trade		= "Produit par les professions",
					gather		= "Recolte",
				};
				
GUILDADS_ITEMS_SIMPLE		= {
					everything	= "Tout"
				};
				
-- Skill
GUILDADS_SKILLS			= {
					[1]  = "Herboristerie",
					[2]  = "Minage",
					[3]  = "Dépeçage",
					[4]  = "Alchimie",
					[5]  = "Forge",
					[6]  = "Ingénierie",
					[7]  = "Travail du cuir",
					[8]  = "Couture",
					[9]  = "Enchantement",
					[10] = "Pêche",
					[11] = "Secourisme",
					[12] = "Cuisine",
					[13] = "Crochetage",
				-- [14] = "Poisons",
				
					[20] = "Armes de pugilat",
					[21] = "Dagues",
					[22] = "Epées",
					[23] = "Epées à deux mains",
					[24] = "Masse",
					[25] = "Masses à deux mains",
					[26] = "Haches",
					[27] = "Haches à deux mains",
					[28] = "Armes d'hast",
					[29] = "Bâtons",
					[30] = "Armes de jet",
					[31] = "Armes à feu",
					[32] = "Arcs",
					[33] = "Arbalètes",
					[34] = "Baguettes"
				};
				
-- Tradeskills
GUILDADS_TS_ASKITEMS		= "Demander les composants pour %i %s";
GUILDADS_TS_ASKITEMS_TT		= "Modifiez le nombre d'objets à créer pour préciser les quantités.";

-- Bindings
-- BINDING_HEADER_GUILDADS
BINDING_NAME_SHOW		= "Afficher GuildAds";
BINDING_NAME_SHOW_CONFIG	= "Afficher les préférences";
end