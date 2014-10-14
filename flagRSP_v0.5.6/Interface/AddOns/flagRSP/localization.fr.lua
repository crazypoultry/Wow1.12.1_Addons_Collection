if ( GetLocale() == "frFR" ) then
-- This is how "Level" is called in tooltip, (MUST BE EXACT!)
-- flagRSP needs to detect which line contains the level.
-- Think it's niveau or similar in French.
FlagRSP_Locale_Level = "Niveau";
-- This determines how the common language is called. (MUST BE EXACT!)
-- This is the alliance language speakable by all four races.
FlagRSP_Locale_CLanguage = "Commun";

-- This determines how pets are named in the tooltip. (MUST BE EXACT!)
-- It's needed to get their owners name.
-- Should be something like: "Minion of <player Name>"
-- (.+) stands for the player's name.
-- IMPORTANT: replace player's name  by (.+), the rest MUST be exact!
-- All occurrances must be included.
FlagRSP_Locale_MinionLine = {};
FlagRSP_Locale_MinionLine[0] = "Familier de (.+)";
FlagRSP_Locale_MinionLine[1] = "Familier d'(.+)";
FlagRSP_Locale_MinionLine[2] = "Serviteur de (.+)";
FlagRSP_Locale_MinionLine[3] = "Serviteur d'(.+)";

-- keywords which determine the owner line in the tooltip of a pet. (MUST BE EXACT!)
-- If flagRSP finds these words it knows that the line is a owner line.
-- All occurrances must be included.
FlagRSP_Locale_MinionText = {};
FlagRSP_Locale_MinionText[0] = "Familier";
FlagRSP_Locale_MinionText[1] = "Serviteur";

-- messages from client after getting AFK. (MUST BE EXACT!)
FlagRSP_Locale_AFK = "Vous \195\170tes maintenant ABS :";
FlagRSP_Locale_NOTAFK = "Vous n'\195\170tes plus ABS.";

-- This is how civilians are called in tooltip. (MUST BE EXACT!)
FlagRSP_Locale_CivilianText = "Civil";
-- This is how "Skinnable" is called in tooltip. (MUST BE EXACT!)
FlagRSP_Locale_SkinnableText = "D\195\169pe\195\167able";
-- This is how the resurrectable line is called in tooltip. (MUST BE EXACT!)
FlagRSP_Locale_ResurrectableText = "Peut \195\170tre ressucit\195\169";
-- This is how your skinning skill is called. (MUST BE EXACT!)
FlagRSP_Locale_Skinning = "D\195\169pe\195\167age";

--------------------------------------------------------------------------------------------------
-- Having translated until here flagRSP should run on your client. It will be in English however.
--------------------------------------------------------------------------------------------------

-- This is how the civilian line should appear in tooltip. Should be the same as above.
FlagRSP_Locale_CivilianLine = "Civil";
-- This is how the "Skinnable" line should appear in tooltip. Should be the same as above.
FlagRSP_Locale_SkinnableLine = "d\195\169pe\195\167able";

-- This is how unknown players should be named.
FlagRSP_Locale_Unknown = "<Inconnu>";
FlagRSP_Locale_UnknownPet = "<Entit\195\169e inconnue>";
-- %flagRSPPetOwnerLine is a dynamical variable. flagRSP will care about such variables. 
-- These MUST NOT be translated.
--FlagRSP_Locale_UnknownPetKnownPlayer = "<%flagRSPPetOwnerLine>";

-- Tooltip texts for alternative level display. Do not change this
-- %-variables. You can use them as a substitution for the alternative 
-- level descriptions which follow later. flagRSP will decide which
-- description will be chosen.
FlagRSP_Locale_AltLevelLine = "Experience: ";
-- Tooltip texts for traditional level display. Should be the same as your client
-- uses to display level/class/race information in tooltip.
FlagRSP_Locale_TradLevelLine = "Niveau ";

-- Tooltip texts for name display of known players.
--FlagRSP_Locale_KnownNameLine = "%UnitName %flagRSPSurname";
---FlagRSP_Locale_KnownPetNameLine = "%UnitName";
-- Line for unknown pets which owner we know (comment out or leave empty for the standard line).
-- A "--" means comment. Unless you don't want to change default behaviour you can ignore this.
--FlagRSP_Locale_KnownPetOwnerLine = "%flagRSPPetOwner's companion";

-- Tooltip texts for PvP rank display.
FlagRSP_Locale_PVPRankLine = "Rang: ";

-- Tooltip texts for character status display.
FlagRSP_Locale_CharStatusLine = "Character status: ";

-- Tooltip texts for PvP rank display.
FlagRSP_Locale_TitleLine = "%UnitTitle";

-- Tooltip texts for guild display.
--FlagRSP_Locale_GuildLine = "<%UnitGuild>";

-- Prefix before alternative level display.
-- Commented out because not needed anymore.
--FlagRSP_Locale_AltLevelPrefix = "Experience: ";
-- Prefix before traditional level display.
--FlagRSP_Locale_TradLevelPrefix = "Niveau ";

-- Prefix for PvP rank display.
--FlagRSP_Locale_PVPRankPrefix = "Rang: ";

-- Descriptions for alternative level display.
-- Objects that are 7 or more levels weaker than you.
FlagRSP_Locale_Epuny = "extr\195\170mement vuln\195\169rable";
-- Objects 5 or 6 levels weaker than you.
FlagRSP_Locale_Puny = "vuln\195\169rable";
-- Objects 2 to 4 levels weaker.
FlagRSP_Locale_Weak = "faible";
-- Objects 1 level weaker to 1 level stronger.
FlagRSP_Locale_Equal = "\195\169gal";
-- Objects 2 to 3 levels stronger.
FlagRSP_Locale_Strong = "fort";
-- Objects 4 to 6 levels stronger.
FlagRSP_Locale_Vstrong = "tr\195\168s fort";
-- Objects 7 to 9 levels stronger.
FlagRSP_Locale_Estrong = "extr\195\170mement puissant";
-- Objects 10 or more levels stronger.
FlagRSP_Locale_Impossible = "imbattable";

-- Targetframe texts for alternative level display.
-- Objects that are 7 or more levels weaker than you.
FlagRSP_Locale_TF_Epuny = "<<";
-- Objects 5 or 6 levels weaker than you.
FlagRSP_Locale_TF_Puny = "<<";
-- Objects 2 to 4 levels weaker.
FlagRSP_Locale_TF_Weak = "<";
-- Objects 1 level weaker to 1 level stronger.
FlagRSP_Locale_TF_Equal = "=";
-- Objects 2 to 3 levels stronger.
FlagRSP_Locale_TF_Strong = ">";
-- Objects 4 to 6 levels stronger.
FlagRSP_Locale_TF_Vstrong = ">>";
-- Objects 7 to 9 levels stronger.
FlagRSP_Locale_TF_Estrong = "!";
-- Objects 10 or more levels stronger.
FlagRSP_Locale_TF_Impossible = "!!";

-- Elite Objects.
-- will be added behind alternative description (therefore the ",").
FlagRSP_Locale_Elite = ", elite";
-- Boss Objects.
FlagRSP_Locale_Boss = ", boss";

-- This is how roleplayers should be called.
FlagRSP_Locale_RP = "<Roleplayer>";
FlagRSP_Locale_RP2 = "<Casual roleplayer>"; 
FlagRSP_Locale_RP3 = "<Fulltime roleplayer>";
FlagRSP_Locale_RP4 = "<Roleplaying beginner>"; 

-- This is how character status should be called.
FlagRSP_Locale_OOC = "<out of character>";
FlagRSP_Locale_IC = "<in character>"; 
FlagRSP_Locale_FFAIC = "<in character, looking for contact>";
FlagRSP_Locale_ST = "<Storyteller>";

-- Notification that player is on ignore list.
FlagRSP_Locale_Ignored = "Ignor\195\169!";

-- Command line options for "/rsp" command.
-- For example "/rsp names".
-- Option to (de)activate hiding of names.
FlagRSP_Locale_HideNames_Cmd = "names";
-- Option to (de)activate alternative level display.
FlagRSP_Locale_LevelDisp_Cmd = "level";
-- Option to (de)activate PvP rank display.
FlagRSP_Locale_RankDisp_Cmd = "ranks";
-- Option to (de)activate guild display.
FlagRSP_Locale_GuildDisp_Cmd = "guilds";
-- Option to set your surname.
FlagRSP_Locale_Surname_Cmd = "surname";
-- Option to set title.
FlagRSP_Locale_Title_Cmd = "title";
-- Option to set player afk.
FlagRSP_Locale_AFK_Cmd = "afk";
-- Option to plot status.
FlagRSP_Locale_Status_Cmd = "status";

-- Option to show own tooltip.
FlagRSP_Locale_OwnTooltip_Cmd = "owntooltip";

-- Option to set beginner-flag.
FlagRSP_Locale_Beginner_Cmd = "beginner";
-- Option for casual flag.
FlagRSP_Locale_Casual_Cmd = "casual";
-- Option for normal flag.
FlagRSP_Locale_Normal_Cmd = "normal";
-- Option for fulltime flag.
FlagRSP_Locale_Fulltime_Cmd = "fulltime";
-- Option to deactivate rp flag.
FlagRSP_Locale_NoRP_Cmd = "off";

-- Option to set ooc flag.
FlagRSP_Locale_OOC_Cmd = "ooc";
-- Option for ic flag.
FlagRSP_Locale_IC_Cmd = "ic";
-- Option for ic-ffa flag.
FlagRSP_Locale_ICFFA_Cmd = "ffa-ic";
-- Option to deactivate character status flag.
FlagRSP_Locale_NoCStatus_Cmd = "stopcharstat";
-- Option for st flag.
FlagRSP_Locale_ST_Cmd = "st";

-- OnLoad-Message (%flagRSPVersion for flagRSP version).
FlagRSP_Locale_OnLoad = {};
FlagRSP_Locale_OnLoad[0] = "d\195\169marrage de flagRSP flagRSP %flagRSPVersion...";
FlagRSP_Locale_OnLoad[1] = "Vous pouvez jouer d\195\168s maintenant, flagRSP sera pr\195\170t dans un moment.";
FlagRSP_Locale_OnLoad[2] = "/rsp ? pour avoir un apper\195\167u des fonctions de flagRSP."

-- Messages after several commands.
-- Message if Hiding of Names was activated.
FlagRSP_Locale_HideNames = "Les noms inconnus sont maintenant cach\195\169s.";
FlagRSP_Locale_UnhideNames = "Les noms inconnus sont maintenant affich\195\169s.";

-- Hiding of exact levels.
FlagRSP_Locale_HideLevels = "Affichage relatif des niveaux activ\195\169.";
FlagRSP_Locale_UnhideLevels = "Affichage relatif des niveaux d\195\169sactiv\195\169s.";

-- PvP rank display options.
FlagRSP_Locale_ShowRanks = "Affichage du rang PvP activ\195\169.";
FlagRSP_Locale_HideRanks = "Affichage du rang PvP d\195\169sactiv\195\169.";

-- Guild display options.
FlagRSP_Locale_ShowAllGuild = "Affichage de tous les noms de guilde.";
FlagRSP_Locale_ShowKnownGuild = "Affichage des noms des guildes connues.";
FlagRSP_Locale_HideGuild = "Affichage des noms de guilde d\195\169sactiv\195\169.";

-- Message if beginner flag set.
FlagRSP_Locale_BeginnerFlagSet = "Marqueur Roleplaying beginner \195\169tabli. Amusez-vous bien \195\160 dacouvrir cette nouvelle passion!";
-- Casual roleplayer.
FlagRSP_Locale_CasualFlagSet = "Marqueur Casual roleplayer \195\169tabli.";
-- Normal roleplayer.
FlagRSP_Locale_NormalRPFlagSet = "Marqueur Normal roleplayer \195\169tabli.";
-- Fulltime roleplayer.
FlagRSP_Locale_FulltimeFlagSet = "Marqueur roleplayer \195\169tabli.";
-- No roleplayer.
FlagRSP_Locale_NoRPFlagSet = "Marqueur Roleplayer d\195\169sactiv\195\169!";

-- 
-- not needed anymore. 
--FlagRSP_Locale_UnicornOfficial = "<Unicorn>"; 
--FlagRSP_Locale_UnicornNonOfficial = "<Unicorn, NOT OFFICIALLY CONFIRMED>"; 

-- Message if ooc flag set.
FlagRSP_Locale_OOCFlag = "Vous jouez maintenant out of character.";
-- Message if ic flag set.
FlagRSP_Locale_ICFlag = "Vous jouez maintenant in character. Vivez votre r\195\180le!";
-- Message if free for all ic flag set.
FlagRSP_Locale_FFAICFlag = "Vous jouez maintenant in character free-for-all. Les autres joueurs sont invit\195\169s à vous contacter.";
-- Message if no character status flag set.
FlagRSP_Locale_NoCFlag = "Pas de statut de joueur d\195\169fini..";
-- Message if st flag set.
FlagRSP_Locale_STFlag = "Vous jouez maintenant un storyteller. Que l\'aventure commence!";

-- Message that no surname is set.
FlagRSP_Locale_NoSurname = "Pas de surnom d\195\169fini.";
-- Message with new surname (%s is new name).
FlagRSP_Locale_NewSurname = "Votre nom est %s.";

-- Message that no title is set.
FlagRSP_Locale_NoTitle = "Pas de titre d\195\169fini.";
-- Message with new title (%s is new title).
FlagRSP_Locale_NewTitle = "Votre titre est: %s.";

-- Message for updated description.
FlagRSP_Locale_DescUpdate = "Description mise \195\160 jour."

-- Message for flagRSP-AFK activated.
FlagRSP_Locale_AFK_Activated = "flagRSP: ABS activ\195\169 - envoi de marqueurs d\195\169sactiv\195\169.";
-- Message for flagRSP-AFK deactivated.
FlagRSP_Locale_AFK_Deactivated = "flagRSP: ABS d\195\169sactiv\195\169 - envoi de marqueurs activ\195\169.";

-- Message for sending rp-help request.
FlagRSP_Locale_RPTicket = "Envoi d\'une requ\195\170te d\'aide RP:";

-- The help lines.
FlagRSP_Locale_Help = {};
FlagRSP_Locale_Help[0] = "flagRSP: Help --------------------------------------------------------------";
FlagRSP_Locale_Help[1] = "/rsp toggle --> (D\195\169s)active le marqueur roleplay.";
FlagRSP_Locale_Help[2] = "/rsp " .. FlagRSP_Locale_HideNames_Cmd .. " --> (D\195\169s)active l\'affichage des noms inconnus.";
FlagRSP_Locale_Help[3] = "/rsp " .. FlagRSP_Locale_LevelDisp_Cmd .. " --> (D\195\169s)active l\'affichage relatif des niveaux.";
FlagRSP_Locale_Help[4] = "/rsp " .. FlagRSP_Locale_RankDisp_Cmd .. " --> (D\195\169s)active l\'affichage des rangs PvP.";
FlagRSP_Locale_Help[5] = "/rsp " .. FlagRSP_Locale_GuildDisp_Cmd .. " --> (D\195\169s)active l\'affichage des noms de guildes.";
FlagRSP_Locale_Help[6] = "/rsp " .. FlagRSP_Locale_Surname_Cmd .. " <TEXT> --> Votre nom de famille est <TEXTE>.";
FlagRSP_Locale_Help[7] = "/rsp " .. FlagRSP_Locale_Title_Cmd .. " <TEXT> --> Votre titre est <TEXTE>.";
FlagRSP_Locale_Help[8] = "/rsp [" .. FlagRSP_Locale_Beginner_Cmd .. "/" .. FlagRSP_Locale_Casual_Cmd .. "/" .. FlagRSP_Locale_Normal_Cmd .. "/" .. FlagRSP_Locale_Fulltime_Cmd .. "/" .. FlagRSP_Locale_NoRP_Cmd .. "] --> D\195\169finit votre style de roleplay pr\195\169f\195\169r\195\169:";
FlagRSP_Locale_Help[9] = "   " .. FlagRSP_Locale_Beginner_Cmd .. ": D\195\169butant roleplayer, i.e. un nouveau joueur dispos\195\169 au roleplay. On  lui pardonnera ses erreurs.";
FlagRSP_Locale_Help[10] = "   " .. FlagRSP_Locale_Casual_Cmd .. ": Casual roleplayer, i.e. quelqu\'un qui a besoin ou qui au moins accepte les  discussions hors-rp.";
FlagRSP_Locale_Help[11] = "   " .. FlagRSP_Locale_Normal_Cmd .. ": Normal roleplayer, i.e. quelqu\'un qui ne veut pas de hors-rp en  g\195\169n\195\169ral, mais qui l\'accepte si besoin est.";
FlagRSP_Locale_Help[12] = "   " .. FlagRSP_Locale_Fulltime_Cmd .. ": Fulltime roleplayer, i.e. quelqu\'un qui rejette strictement le hors-rp et qui  joue son r\195\180le en permanence.";
FlagRSP_Locale_Help[13] = "   " .. FlagRSP_Locale_NoRP_Cmd .. ": Supprime tout marqueur roleplay.";
FlagRSP_Locale_Help[14] = "/rsp [" .. FlagRSP_Locale_OOC_Cmd .. "/" .. FlagRSP_Locale_IC_Cmd .. "/" .. FlagRSP_Locale_ICFFA_Cmd .. "/" .. FlagRSP_Locale_ST_Cmd .. "/" .. FlagRSP_Locale_NoCStatus_Cmd .. "] --> D\195\169finit le statut du personnage:";
FlagRSP_Locale_Help[15] = "   " .. FlagRSP_Locale_OOC_Cmd .. ": Out of character, le joueur ne joue pas son r\195\180le.";
FlagRSP_Locale_Help[16] = "   " .. FlagRSP_Locale_IC_Cmd .. ": In character, le joueur joue son r\195\180le!";
FlagRSP_Locale_Help[17] = "   " .. FlagRSP_Locale_ICFFA_Cmd .. ": In character free-for-all, comme ".. FlagRSP_Locale_IC_Cmd .. " mais le joueur  souhaite interagir avec d\'autres joueurs.";
FlagRSP_Locale_Help[18] = "   " .. FlagRSP_Locale_ST_Cmd .. ": Storyteller. Joueur qui guide le roleplay.";
FlagRSP_Locale_Help[19] = "   " .. FlagRSP_Locale_NoCStatus_Cmd .. ": Supprime le marqueur de statut de presonnage.";
FlagRSP_Locale_Help[20] = "/rsp " .. FlagRSP_Locale_AFK_Cmd .. " --> Vous met en mode ABS et stoppe l\'envoi de marqueurs.";
FlagRSP_Locale_Help[21] = "/rsp " .. FlagRSP_Locale_Status_Cmd .. " --> Vous montre les options pour ce personnage.";
FlagRSP_Locale_Help[22] = "/rsp " ..FlagRSP_Locale_OwnTooltip_Cmd .. " --> Affiche ou non le tooltip de votre personnage.";
FlagRSP_Locale_Help[23] = "/rspon --> Active le marqueur normal roleplayer et l\'affichage relatif des noms et des niveaux.";
FlagRSP_Locale_Help[24] = "/rspoff --> D\195\169sactive le marqueur roleplayer, l\'affichage relatif des noms et des niveaux, et supprime votre nom  et votre titre.";

-- Text for notes in info box.
FlagRSP_Locale_InfoBoxNotes = "Notes:";
-- Text for description in info box.
FlagRSP_Locale_InfoBoxDesc = "Description:";

-- Text for title in description tag warning.
FlagRSP_Locale_DescWarnTitle = "ATTENTION!";
-- Text for description tag warning.
-- This is important to show the user a warning box when entering a description.
-- Ugly readable, isn't it? 
-- Some explanations: "\n" means new line (same as if you hit enter).
--                    |CFFFF0000...|r means everything inbewtween will be colored red ("..." here).
--                    \" is a "-character.
FlagRSP_Locale_DescWarnText = "Vous venez d\'appeler une option pour entrer une description de votre personnage. |CFFFF0000VEUILLEZ LIRE AVEC ATTENTION  LES INFORMATIONS SUIVANTES AVANT D\'ECRIRE UNE DESCRIPTION!|r\n\nLe seul objectif de cette bo\195\174te de description et de donner un apper\195\167u  des caract\195\168res ext\195\169rieures de votre personnage. Cette description ne devra donc comporter que des \195\169l\195\169ments que les autres  joueurs sont capables de \"voir\". Cela n\'inclut pas des informations sur le caract\195\168re ou l\'histoire de votre personnage, ou autre  renseignement dont on ne peut avoir connaissance qu\'en discutant avec le personnage. \n\nVous pouvez par exemple d\195\169crire son apparence, ou  mentionner des mouvements r\195\169curents.\n\nExemples de description: \"Une longue cicatrice qui brille dans le noir barre le cou d\'Exemplus\",  \"Exemplus bo\195\174te\"...\n\nExemples de |CFFFF0000mauvaises|r descriptions: \"La cicatrice d\'Exemplus lui vient d\'un combat contre un terrible  d\195\169mon\", \"Exemplus a une jambe cass\195\169e\".\n\nJ\'esp\195\168re que cette fonctionnalit\195\169 vous sera utile et permettra d\'enrichir le  roleplay dans WoW.";

-- Text for title in welcome box.
FlagRSP_Locale_WelcomeTitle = "Welcome!";
-- Text for welcome box.
FlagRSP_Locale_WelcomeHeader = "Bienvenue dans |CFFFFFF7FflagRSP version %flagRSPVersion|r!\n\n";
FlagRSP_Locale_WelcomeText = "Apparemment, vous utilisez flagRSP pour la premi\195\168re fois (au moins sur cette installation de WoW). Si vous pouvez lire ce message, vous avez correctement install\195\169 flagRSP&Friendlist. J\'esp\195\168re que vous trouverez dans cet addon toutes les fonctionnalit\195\169s que vous en attendez. Vous pouvez configurer flagRSP et Friendlist via le bouton repr\195\169sentant un parchemin au bord de la minicarte. Plus d\\\'options sont disponibles via les commandes /rsp et /fl.\n\n|CFFFF0000REMARQUE:|r Si vous ne l\'avez pas encore fait, il est fortement conseill\195\169 de lire le fichier readme (flagRSP_readme_FR, qui se trouve dans votre r\195\169pertoire WoW) qui contient des informations importantes, en particulier la partie |CFFFFFF7FSECURITE|r, si vous ne voulez pas perdre toutes les informations que vous avez entr\195\169es apr\195\168s un plantage, par exemple.\n\n";
FlagRSP_Locale_WelcomeHomepage = "Pour obtenir les derni\195\168res informations sur flagRSP, visitez la page d\'accueil situ\195\169e  sur:\n\nhttp://flokru.org/flagrsp/\n\nJ\'esp\195\168re que vous appr\195\169ciez flagRSP! Pour tout probl\195\168me, suggestion ou critique,  contactez-moi.\n\n\n|CFFD4D4D4Changements majeurs dans cette version (voir le fichier changelog pour plus de d\195\169tails):\n\n";
FlagRSP_Locale_WelcomeChanges = "- Fixed the problem that caused Auctioneer to be unable to load itself upon opening the auction frame.\n- Fixed a bug that caused flagRSP to display descriptions of players for hunters's pets with the same name.\n- Added \"/rsp purge\" to make flagRSP delete all saved flags.\n- Fixed minor bugs concerning the light tooltip mode.";

-- Text for title in new version notification.
FlagRSP_Locale_NewVersionTitle = "Nouvelle version!";
-- Text for new version notification.
-- |CFFFFFF7F%r.%m.%n|r is a color code again. %r.%m.%n will be the version number.
FlagRSP_Locale_NewVersionText = "Une nouvelle version de flagRSP est disponible, si vous souhaitez mettre l'addon à jour.\n\nVersion de flagRSP disponible:|CFFFFFF7F%r.%m.%n|r";
-- Text for checkbutton.
FlagRSP_Locale_NewVersionCheckButton = "Ne plus afficher ce message";

-- Message after enabling ui names.
FlagRSP_Locale_UINamesEnabled = "Affichage des noms dans l\'interface utilisateur activ\195\169.";
-- Message after disabling ui names.
FlagRSP_Locale_UINamesDisabled = "Affichage des noms dans l\'interface utilisateur d\195\169sactiv\195\169.";

-- Messages for toggling the always show InfoBox option.
FlagRSP_Locale_AlwaysShowInfoBox = "L\'infobox sera automatiquement r\195\169ouverte apr\195\168s un changement de cible."; 
FlagRSP_Locale_InfoBoxTradBehaviour = "L\'infobox ne sera r\195\169ouverte que si du nouveau ontenu est disponible ou si vous l\'activez."; 

-- Message that flagRSP had to (re)join channel.
FlagRSP_Locale_ReJoinedChannel = "Connexion au canal de donn\195\169es (n\195\169cessaire \195\160 la communication de flagRSP).";

-- Message that flagRSP is fully initialized.
FlagRSP_Locale_Initialized = "flagRSP est initialis\195\169. Passez un bon moment!";

-- Message that tooltip manipulation is (de)activated.
FlagRSP_Locale_ModifyTooltip = "Modifie le tooltip.";
FlagRSP_Locale_LightModifyTooltip = "Modifie partiellement le tooltip.";
FlagRSP_Locale_NoModifyTooltip = "Ne modifie plus le tooltip.";

-- Message that flagRSP has been (un)set from/to standby.
FlagRSP_Locale_StandBy = "Pause activ\195\169e. flagRSP a quitt\195\169 le canal d\'informations.";
FlagRSP_Locale_StandBy2 = "|CFFFF0000NOTE:|r l\'envoi et la r\195\169ception de marqueurs ne fonctionne|CFFFF0000plus|r!";
FlagRSP_Locale_NoStandBy = "Pause d\195\169sactiv\195\169e.";

-- Message for purged entries.
FlagRSP_Locale_EntriesPurged = "Les marqueurs vieux de |CFFFFFF7F%s|r ont \195\169t\195\169 supprim\195\169s.";

-- Message for changed purge interval.
FlagRSP_Locale_PurgeInterval = "Les messages en cache seront maintenant supprim\195\169s tous les |CFFFFFF7F%s|r jours.";

-- Buttons for DYK window.
FlagRSP_Locale_NextTipButton = "Conseil suivant";
FlagRSP_Locale_CloseButton = "Fermer"; 
FlagRSP_Locale_DYKTitle = "Le saviez-vous?";
FlagRSP_Locale_DYKCheckText = "Ne plus afficher les conseils.";

FlagRSP_Locale_TipText = {};
FlagRSP_Locale_TipText[1] = "Le saviez-vous?\n\nSur les royaumes non-PvP, flagRSP peut afficher les marqueurs et la description des membres de l\'autre faction. Pour ce faire, entrez dans le jeu avec un personnage de l\'autre faction. Plus vous resterez longtemps en jeu, plus vous enregistrerez de marqueurs.\nTapez \"/rspcollect\"pour que flagRSP ne d\195\169tecte plus le mode ABS. flagRSP enregistrera toujours les descriptions. Utilisez cette commande pour que flagRSP enregistre les marqueurs et descriptions de l\'autre faction sans avoir \195\160 interrompre sans cesse l\'ABS  manuellement.";
FlagRSP_Locale_TipText[2] = "Le saviez-vous?\n\nflagRSP enregistre les marqueurs et descriptions continuellement. Cela inclut aussi les marqueurs de  l\'autre faction. Vous pouvez d\195\169finir le temps pendant lequel ces marqueurs sont conserv\195\169s via la commande \"/rsp purgeinterval x\",  \"x\" \195\169tant le nombre de jours apr\195\168s lesquels les informations seront effac\195\169es.";
FlagRSP_Locale_TipText[3] = "Le saviez-vous?\n\nPour \195\169viter la perte de vos descrptions et de votre contenu de Friendlist, vous devriez  sauvegarder r\195\169guli\195\168rement les param\195\168tres de flagRSP. Voyez dans le readme comment sauvegarder ces informations.";
FlagRSP_Locale_TipText[4] = "Le saviez-vous?\n\nLe bouton de flagRSP affich\195\169 au bord de la minicarte peut \195\170te d\195\169plac\195\169 via  la commande /fl buttonpos x\", \"x\" \195\169tant compris entre 0 et 360.";
FlagRSP_Locale_TipText[5] = "Le saviez-vous?\n\nVous pouvez d\195\169placer l\'Infobox (la fen\195\170tre \195\160 gauche de l\'\195\169cran dans  lquelle sont affich\195\169es les descriptions et d\'autres informations) et le bouton de l\'Infobox sous le targetframe (le cadre montrant les barres  de vie/mana de votre cible). Faites simplement un clic droit dessus pur les d\195\169placer.";
FlagRSP_Locale_TipText[6] = "Le saviez-vous?\n\nVous pouvez \195\169diter les informationd de Friendlist en double-cliquant dessus.";
FlagRSP_Locale_TipText[7] = "Le saviez-vous?\n\nflagRSP ouvre la liste d\'amis de WoW pendant quelques secondes apr\195\168s avoir lanc\195\169 le jeu.  Ce n\'est pas un bug.\nCette fen\195\170te doit \195\170te ouverte pour que Friendlist fonctionne correctement. Si je trouve une meilleure solution, je  modifierai l\'addon pour que cette fen\195\170te ne s\'ouvre plus au d\195\169marrage.";
FlagRSP_Locale_TipText[8] = "Le saviez-vous?\n\nSi vous s\195\169lectionnez un joueur, vous pouvez ouvrir un menu contextuel es faisant un clic droit  sur son portrait. Ce menu vous permet entre autres d\'ajouter ce joueur \195\160 votre Friendlist sans avoir \195\160 ouvrir la fen\195\170tre de  l\'addon.";
FlagRSP_Locale_TipText[9] = "Le saviez-vous?\n\nVous pouvez importer le contenu de la liste d\'amis de WoW dans Friendlist et vice versa via la  commande \"/fl import\" ou \"/fl export\".";
FlagRSP_Locale_TipText[10] = "Le saviez-vous?\n\nflagRSP supporte le fonction de load on demand. Il comprend donc un petit addon nomm\195\169 flagRSPLoader qui charge flagRSp automatiquement au lancement du jeu. Vous pouvez configurer flagRSPLoader pour (d\195\169s)activer le lancement de flagRSP au d\195\169marrage, pour le royaune et le personnage actuel. Pour acc\195\169der aux options de flagRSPLoader, tapez \"/rspload \196\177\".";
FlagRSP_Locale_TipText[11] = "Le saviez-vous?\n\nflagRSP peut g\195\169rer le tooltip de trois fa\195\167ons diff\195\169rentes.\nLa premi\195\168re ne  le change pas. Ce mode est utile pour les joueurs utilisant des addons qui modifient d\195\169j\195\160 le tooltip, et qui ne sont pas compatibles avec  flagRSP.\nLe second mode (partiel) n\'ajoute que les marqueurs (nom de famille, titre, marqueur rp et statut du personnage) au tooltip sans modifier la  couleur des lignes et sans cacher d\'informations. Ce mode doit \195\170tre compatible avec tous les addons modifiant le tooltip. Il est  \195\169galement significativement plus rapide que le troisi\195\168me.\nSi vous rencontrez des probl\195\168mes avec d\'autres addons modifiant le  tooltip ou que vous voulez les meilleures performances (pour le PvP/les raids), essayez ce mode.\nLe troisi\195\168me mode est le mode par  d\195\169faut de flagRSP. Il modifie la plupart du contenu du tooltip et supporte toutes les fonctionnalit\195\169s de flagRSP (affichage des  marqueurs, couleurs, noms et niveaux cach\195\169s, etc.). Cependant ce mode peut entrer en conflit avec d\'autres addons modifiant le tooltip, et  n\'est pas aussi rapide que le mode partiel, mais la plupart des utilisateurs ne remarqueront aucune diff\195\169rence (la g\195\169n\195\169ration de  tooltip prend entre 1 et 10 ms). Vous pouvez modifier le mode d\'affichage du tooltip en entrant /rsp toggletooltip\".";

-- Message for collecting flags.
FlagRSP_Locale_Collecting = "AFK detection deactivated to be able to collect flags and descriptions.";
FlagRSP_Locale_NoCollecting = "AFK detection activated.";

-- Texts for UnitPopupMenu.
FlagRSP_Locale_AddEntry = "Ajouter %UnitName dans Friendlist";
FlagRSP_Locale_EditEntry = "Editer %UnitName dans Friendlist";
FlagRSP_Locale_ToggleBox = "(D\195\169s)activer l\'infobox";

-- Button to add friend/foe.
FRIENDLIST_LOCALE_ADDFRIENDBUTTON = "Aj. ami";
-- Button to add Guild to Friendlist.
FRIENDLIST_LOCALE_ADDGUILDBUTTON = "Aj. guilde";
-- Button to edit entry in Friendlist.
FRIENDLIST_LOCALE_EDITENTRYBUTTON = "Modifier";
-- Button to remove friend/foe.
FRIENDLIST_LOCALE_REMOVEFRIENDBUTTON = "Supprimer un ami";
-- Button to edit own title and surname.
FRIENDLIST_LOCALE_EDITTITLEBUTTON = "Titre";

-- Button for filtering options in Friendlist.
FRIENDLIST_LOCALE_FilterButton = "Filtre";

-- Button for undo in Friendlist's char page.
FRIENDLIST_LOCALE_CharResetButton = "Annuler";
-- Button for turning over Friendlist frames.
FRIENDLIST_LOCALE_TurnPageButton = "Tourner";

-- General ok button.
FRIENDLIST_LOCALE_OK_BUTTON = "OK";
-- General abort button.
FRIENDLIST_LOCALE_ABORT_BUTTON = "Annuler";
-- General add button.
FRIENDLIST_LOCALE_ADD_BUTTON = "Ajouter";

-- Title of add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_TITLE = "Ajouter un ami";
-- Text before name field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NAME_FIELD = "Nom";
-- Text before surname field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_SURNAME_FIELD = "Nom de famille";
-- Text before title field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_TITLE_FIELD = "Titre:";
-- Text before friendstate field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FRIENDSTATE_FIELD = "Etat:";
-- Text before notes field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NOTES_FIELD = "Notes";
-- Checkbutton for foe option in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FOE_BUTTON = "Ennemi";
-- Button to add friend/foe in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ADD_BUTTON = FRIENDLIST_LOCALE_ADD_BUTTON;
-- Button to abort in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ABORT_BUTTON = FRIENDLIST_LOCALE_ABORT_BUTTON;

-- Title of add guild frame.
FRIENDLIST_LOCALE_ADD_GUILD_FRAME_TITLE = "Ajouter une guilde";
-- Text before name field in add guild frame.
FRIENDLIST_LOCALE_ADD_GUILD_FRAME_NAME_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NAME_FIELD;
-- Checkbutton for foe option in add guild frame.
FRIENDLIST_LOCALE_ADD_GUILD_FRAME_FOE_BUTTON = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FOE_BUTTON;

-- Title of edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_TITLE = "Editer";
-- Text before name field in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_NAME_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NAME_FIELD;
-- Text before surname field in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_SURNAME_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_SURNAME_FIELD;
-- Text before notes field in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_NOTES_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NOTES_FIELD;
-- Checkbutton for foe option in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_FOE_BUTTON = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FOE_BUTTON;
-- Button to accept friend/foe in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_OK_BUTTON = FRIENDLIST_LOCALE_OK_BUTTON;
-- Button to abort in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_ABORT_BUTTON = FRIENDLIST_LOCALE_ABORT_BUTTON;

-- Help.
FRIENDLIST_LOCALE_HELP = {};
FRIENDLIST_LOCALE_HELP[0] = "Friendlist: Help --------------------------------------------------------------";
FRIENDLIST_LOCALE_HELP[1] = "/fl --> Affiche cette aide.";
FRIENDLIST_LOCALE_HELP[2] = "/fl help --> Affiche cette aide.";
FRIENDLIST_LOCALE_HELP[3] = "/fl show --> Ouvre la fen\195\170tre de Friendlist.";
FRIENDLIST_LOCALE_HELP[4] = "/fl hide --> Ferme la fen\195\170tre de Friendlist.";
FRIENDLIST_LOCALE_HELP[5] = "/fl mm <an/aus> --> Affiche (an) ou non (aus) le bouton au bord de la minicarte)";
FRIENDLIST_LOCALE_HELP[6] = "/fl buttonpos <ANGLE> --> Change la position du bouton au bord de la minicarte \195\160 un angle entre 0 et 360.";
FRIENDLIST_LOCALE_HELP[7] = "/fl add <NAME> <SURNAME> --> Ajoute le joueur <NOM> et son nom  <NOM DE FAMILLE> dans Friendlist.";
FRIENDLIST_LOCALE_HELP[8] = "/fl addguild <NAME> --> Ajoute la guilde <NOM> dans Friendlist.";
FRIENDLIST_LOCALE_HELP[9] = "/fl del <NAME> --> Enl\195\168ve le joueur/la guilde <NOM> de Friendlist.";
FRIENDLIST_LOCALE_HELP[10] = "/fl reset --> Efface toute votre Friendlist SANS AUCUN AUTRE AVERTISSEMENT.";
FRIENDLIST_LOCALE_HELP[11] = "/fl import --> Importe la liste d\'amis de WoW dans Friendlist.";
FRIENDLIST_LOCALE_HELP[12] = "/fl export --> Exporte Friendlist dans la liste d\'amis de WoW.";
FRIENDLIST_LOCALE_HELP[13] = "/add <NAME> <SURNAME> <NOTE> --> Ajoute le joueur <NOM> avec son <NOM DE FAMILLE> ainsi que ses <NOTE> dans  Friendlist.";

FRIENDLIST_LOCALE_FRIENDSTATE_TEXT = {};
-- Text for friendstate -10.
FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[-10] = "Ennemi";
-- Text for friendstate +10.
FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[10] = "Ami";
-- Text for friendstate 0.
FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[0] = "Connu";

FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT = {};
-- Text for friendstate -10.
FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[-10] = "Guilde ennemie";
-- Text for friendstate +10.
FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[10] = "Guilde alliée";
-- Text for friendstate 0.
FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[0] = "Guilde connue";

-- Bindings.
-- Texts for the bindings menu in WoW.
BINDING_HEADER_FRIENDLIST_LOCALE_HEADER = "flagRSP & Friendlist";
BINDING_NAME_FRIENDLIST_LOCALE_NAME = "Open Friendlist frame";
BINDING_NAME_FRIENDLIST_LOCALE_ADDFRIEND = "Ajouter un ami";
BINDING_NAME_FRIENDLIST_LOCALE_ADDGUILD = "Ajouter une guilde";
BINDING_NAME_FRIENDLIST_LOCALE_TOGGLEBOX = "(D\195\169s)activer l\'infobox";

-- Strings for the new GUI.
-- Online status for Friendlist.
-- does not need to be translated.
--FRIENDLIST_LOCALE_OnlineStatusLoc = "[%FriendlistOnline, %FriendlistLocation]";
--FRIENDLIST_LOCALE_OnlineStatusNoLoc = "[%FriendlistOnline]";

-- Title for char page.
-- %UnitName is the player's name.
FRIENDLIST_LOCALE_CharFrameTitle = "Page de %UnitName";
-- Title of certificate.
FRIENDLIST_LOCALE_CertTitle = "Certificat d\'identit\195\169";
-- Line 1 of certificate.
FRIENDLIST_LOCALE_CertText1 = "Ceci certifie que ";
-- Line 2 of certificate.
FRIENDLIST_LOCALE_CertText2 = "%UnitName, ";
-- Line 3 of certificate.
FRIENDLIST_LOCALE_CertText3 = "%UnitClass %UnitRace, porte le titre";
-- Line 4 of certificate.
FRIENDLIST_LOCALE_CertText4 = "Apparence ext\195\169rieure:";
-- Line 5 of certificate.
FRIENDLIST_LOCALE_CertText5 = "Bureau d'identification d\'Azeroth";

-- Line before rp type dropdown box.
FRIENDLIST_LOCALE_RpTypeText = "Style de roleplay p\195\169rf\195\169r\195\169:";
-- Line before explanation of rp type.
FRIENDLIST_LOCALE_RpExplanation = "Explication:";
-- Line before character status dropdown box.
FRIENDLIST_LOCALE_CSText = "Statut du personnage:";

-- Different rp type texts for drop down box.
FRIENDLIST_LOCALE_DropDownRP0 = "Pas de marqueur roleplayer"; 
FRIENDLIST_LOCALE_DropDownRP1 = "Normal roleplaying style"; 
FRIENDLIST_LOCALE_DropDownRP2 = "Casual roleplaying, OOC partiel"; 
FRIENDLIST_LOCALE_DropDownRP3 = "Fulltime roleplaying, aucun OOC"; 
FRIENDLIST_LOCALE_DropDownRP4 = "Roleplaying d\195\169butant"; 

-- Different character status texts for drop down box.
FRIENDLIST_LOCALE_DropDownCSNone = "Aucun statut d\195\169fini";
FRIENDLIST_LOCALE_DropDownCSOOC = "Jeu out of character";
FRIENDLIST_LOCALE_DropDownCSIC = "Jeu in character";
FRIENDLIST_LOCALE_DropDownCSFFAIC = "Jeu in character, \195\160 la recherche de contacts";
FRIENDLIST_LOCALE_DropDownCSST = "Jeu en tant que storyteller";

-- Different explanations for rp types.
-- again color codes and others.
FRIENDLIST_LOCALE_DropDownRP0Expl = "Choisissez ceci si vous ne voulez envoyer aucun marqueur roleplaying. Dans la mesure o\195\185 ce marqueur montre aux autres joueurs quel type de roleplaying vous p\195\169rf\195\169rez, r\195\169fl\195\169chissez avant de le d\195\169sactiver.\nRemarquez que ce marqueur ne montre en aucun cas la qualit\195\169 de roleplay de chacun. Son seul objectif est d\'indiquer aux autres joueurs la fa\195\167on dont vous jouez votre r\195\180le."; 
FRIENDLIST_LOCALE_DropDownRP1Expl = "Choisissez |cffE0E0E0Normal roleplaying|r si vous voulez envoyer le marqueur normal roleplayer.  Un roleplayer normal est quelqu\'un qui joue principalement son r\195\180le (il est in character). Cependant il communique parfois ooc (par ex. pour coordonner un groupe en /gr), ou accepte au moins parfois le dialogue ooc.\nNotez qu\'il s\'agit seulement de votre style de jeu pr\195\169f\195\169r\195\169: vous devriez toujours pouvoir adapter votre comportement \195\160 la fa\195\167on de jouer des autres joueurs."; 
FRIENDLIST_LOCALE_DropDownRP2Expl = "Choisissez |cffE0E0E0Casual roleplaying|r si vous voulez envoyer le marqueur casual roleplayer. Un roleplayer occasionnel veut jouer son r\195\180le, mais a besoin du dialogue ooc pour jouer (par ex. pour coordonner un groupe).\nNotez qu\'il s\'agit seulement de votre style de jeu pr\195\169f\195\169r\195\169: vous devriez toujours pouvoir adapter votre comportement \195\160 la fa\195\167on de jouer des autres joueurs. Veillez \195\160 ne pas utiliser l\'ooc \195\160 outrance, pour ne pas g\195\170ner les autres roleplayers.."; 
FRIENDLIST_LOCALE_DropDownRP3Expl = "Choisissez |cffE0E0E0Fulltime roleplaying|r si vous voulez envoyer le marqueur fulltime roleplayer. Un tel roleplayer veut jouer son r\195\180le la plupart du temps et ne veut pas pratiquer le dialogue ooc.\nNotez qu\'il s\'agit seulement de votre style de jeu pr\195\169f\195\169r\195\169: vous devriez toujours pouvoir adapter votre comportement \195\160 la fa\195\167on de jouer des autres joueurs. Gardez en t\195\170te que certains joueurs ont besoin de dialoguer ooc. Soyez compr\195\169hensif lorsque quelqu\'un le fait."; 
FRIENDLIST_LOCALE_DropDownRP4Expl = "Choisissez |cffE0E0E0Roleplaying beginner|r si vous d\195\169butez dans le roleplay et si vous craignez de ne pas savoir comment r\195\169agir \195\160 certaines situations ou de faire des erreurs. Les autres joueurs peuvent voir que vous \195\170tes un \"bleu\". Ils devraient vous encourager et vous aider. N\'ayez pas peur de demander de l\'aide! En r\195\168gle gn\195\169rale, les roleplayers sont tr\195\168s aimables lorsqu\'ils voient que quelqu\'un est int\195\169ress\195\169."; 

-- Different explanations for character status.
FRIENDLIST_LOCALE_DropDownCSNoneExpl = "Choisissez ceci si vous ne voulez envoyer aucune information \195\160 propos de votre statut de joueur. Aucun joueur ne peut savoir si vous jouez ic ou ooc, ni si vous cherchez des contacts.";
FRIENDLIST_LOCALE_DropDownCSOOCExpl = "Choisissez |cffE0E0E0out of character|r  si vous n\'\195\170tes PAS en train de jouer votre r\195\180le et que vous ne souhaitez aucun contact ic(par exemple lorsque vous farmez pour une qu\195\170te ou pour gagner un niveau). Cette information peut \195\170tre autant utile \195\160 vous qu\'aux autres joueurs.";
FRIENDLIST_LOCALE_DropDownCSICExpl = "Choisissez |cffE0E0E0in character|r  si vous \195\170tes en train de jouer votre r\195\180le. Souvenez-vous que vos paroles et actions pourront \195\170tre attribu\195\169es \195\160 votre personnage. D\'autres joueurs peuvent contacter votre personnage.";
FRIENDLIST_LOCALE_DropDownCSFFAICExpl = "Choisissez |cffE0E0E0in character, looking for contact|r  si vous \195\170tes en train de jouer votre r\195\180le et que vous cherchez \195\160 interagir avec d\'autes joueurs. Vos paroles et actions pourront \195\170tre attribu\195\169es \195\160 votre personnage.  Ce mode \"invitation\" montre aux autres joueurs que vous \195\170tes disponible et que vous voulez jouer votre r\195\180le.";
FRIENDLIST_LOCALE_DropDownCSSTExpl = "Choisissez |cffE0E0E0Storyteller|r  si vous jouez le r\195\180le d\'un storyteller. Les storytellers sont des joueurs avan\195\167\195\169s qui cr\195\169ent des intrigues pour d\'autres joueurs dans le contexte du jeu. Utilisez ce marqueur si vous \195\170tes en train de menez un sc\195\169nario ou si vous recherchez des joueurs (PJ ou PNJ) pour celui-ci.";

-- Drop down elements for Friendlist sorting.
FRIENDLIST_LOCALE_SortDropDown_AlphOnline = "Classement alphab\195\169tique (pr\195\169noms), joueurs en ligne d\'abord";
FRIENDLIST_LOCALE_SortDropDown_AlphOnlineSurname = "Classement alphab\195\169tique (noms de famille), joueurs en ligne d\'abord";
FRIENDLIST_LOCALE_SortDropDown_FStateOnline = "Classement par friend status, joueurs en ligne d\'abord";
FRIENDLIST_LOCALE_SortDropDown_TypeOnline = "Classement par type, joueurs en ligne d\'abord";
FRIENDLIST_LOCALE_SortDropDown_EDateOnline = "Classement par date d\'entr\195\169e, joueurs en ligne d\'abord";
FRIENDLIST_LOCALE_SortDropDown_Alph = "Classement alphab\195\169tique (pr\195\169noms)";
FRIENDLIST_LOCALE_SortDropDown_AlphSurname = "Classement alphab\195\169tique (noms de famille)";
FRIENDLIST_LOCALE_SortDropDown_FState = "Classement par friend status";
FRIENDLIST_LOCALE_SortDropDown_Type = "Classement par type";
FRIENDLIST_LOCALE_SortDropDown_EDate = "Classement par date d\'entr\195\169e";

-- Friendlist text for trad. Level display.
FRIENDLIST_LOCALE_LevelLine = "Niveau ";
-- Friendlist text for online players.
FRIENDLIST_LOCALE_OnlineLine = "en ligne";
-- Friendlist text for offline players.
FRIENDLIST_LOCALE_OfflineLine = "hors-lignee";
-- Friendlist text for guilds.
FRIENDLIST_LOCALE_GuildLine = "Guilde";

-- old and former unlocalized strings.
-- Entry added to Friendlist.
-- %n is the name of the entry.
FRIENDLIST_LOCALE_AddFriendMsg = "%n a \195\169t\195\169 ajout\195\169 \195\160 Friendlist.";
-- Entry deleted from Friendlist.
FRIENDLIST_LOCALE_DelFriendMsg = "%n a \195\169t\195\169 supprim\195\169 de Friendlist.";
-- Edit entry and select new name that already exists error / Add existing name error.
FRIENDLIST_LOCALE_NameExistsMsg = "%n est d\195\169j\195\160 dans Friendlist.";

-- Tab for normal view and group view.
FRIENDLIST_LOCALE_NormalView = "Vue normale";
FRIENDLIST_LOCALE_GroupView = "Vue par groupes";

-- Tooltip for the minimap button.
FRIENDLIST_LOCALE_MMBUTTON_TOOLTIP = "Ouvre l\'interface de flagRSP&Friendlist";
end


