if ( GetLocale() == "frFR" ) then

-- ---------- GLOBALS ----------------------------------------------------------------
CHHT_LABEL_CLOSE       = "Fermer";
CHHT_LABEL_DEFAULT     = "D\195\169faut";
CHHT_LABEL_DEFAULTS    = "D\195\169fauts";
CHHT_LABEL_CONFIGURE   = "Configure";

CHHT_LABEL_NONE        = 'Aucun';

CHHT_LABEL_MOUSE_1_3   = "Souris 1/3";
CHHT_LABEL_MOUSE_2_3   = "Souris 2/3";
CHHT_LABEL_MOUSE_3_3   = "Souris 3/3";

CHHT_LABEL_PLAYER      = 'Joueur';
CHHT_LABEL_PET         = 'Familier';
CHHT_LABEL_PARTY       = 'Groupe';
CHHT_LABEL_PARTYPET    = 'Familier Groupe';
CHHT_LABEL_RAID        = 'Raid';
CHHT_LABEL_RAIDPET     = 'Familier Raid';
CHHT_LABEL_TARGET      = 'Cible';
CHHT_LABEL_PARTY1      = 'Groupe 1';
CHHT_LABEL_PARTY2      = 'Groupe 2';
CHHT_LABEL_PARTY3      = 'Groupe 3';
CHHT_LABEL_PARTY4      = 'Groupe 4';
CHHT_LABEL_PARTYPET1   = 'Familier Groupe 1';
CHHT_LABEL_PARTYPET2   = 'Familier Groupe 2';
CHHT_LABEL_PARTYPET3   = 'Familier Groupe 3';
CHHT_LABEL_PARTYPET4   = 'Familier Groupe 4';

CHHT_LABEL_PLAYER_LC   = 'Joueur';
CHHT_LABEL_PET_LC      = 'Familier';
CHHT_LABEL_PARTY_LC    = 'Groupe';
CHHT_LABEL_PARTYPET_LC = 'Familier Groupe';
CHHT_LABEL_RAID_LC     = 'Raid';
CHHT_LABEL_RAIDPET_LC  = 'Familier Raid';
CHHT_LABEL_TARGET_LC   = 'Cible';
CHHT_LABEL_PARTY1_LC   = 'Groupe 1';
CHHT_LABEL_PARTY2_LC   = 'Groupe 2';
CHHT_LABEL_PARTY3_LC   = 'Groupe 3';
CHHT_LABEL_PARTY4_LC   = 'Groupe 4';
CHHT_LABEL_PARTYPET1_LC= 'Familier Groupe 1';
CHHT_LABEL_PARTYPET2_LC= 'Familier Groupe 2';
CHHT_LABEL_PARTYPET3_LC= 'Familier Groupe 3';
CHHT_LABEL_PARTYPET4_LC= 'Familier Groupe 4';

CHHT_LABEL_RAID_GROUP_FORMAT = 'Groupe %d';

CHHT_LABEL_MAX         = "max";
CHHT_LABEL_MIN         = "min";
CHHT_LABEL_ALWAYS      = "toujours";
CHHT_LABEL_NEVER       = "jamais";
CHHT_LABEL_CONTINOUSLY = "sans interruption";

CHHT_LABEL_UP          = "+";
CHHT_LABEL_DOWN        = "-";
CHHT_LABEL_DN          = "-";

CHHT_LABEL_LEFT        = 'Gauche';
CHHT_LABEL_RIGHT       = 'Droite';
CHHT_LABEL_TOP         = 'Haut';
CHHT_LABEL_BOTTOM      = 'Bas';
CHHT_LABEL_TOPLEFT     = 'Haut Gauche';
CHHT_LABEL_TOPRIGHT    = 'Haut Droite';
CHHT_LABEL_BOTTOMLEFT  = 'Bas Gauche';
CHHT_LABEL_BOTTOMRIGHT = 'Bas Droite';

CHHT_LABEL_HIGHEST     = '+ haut';
CHHT_LABEL_MEMBERS     = 'membres';

CHHT_NUMBER_ONE        = 'un';
CHHT_NUMBER_TWO        = 'deux';
CHHT_NUMBER_THREE      = 'trois';
CHHT_NUMBER_FOUR       = 'quatre';
CHHT_NUMBER_FIVE       = 'cinq';

CHHT_LABEL_UPDATE      = 'Mise \195\160 jour';

-- ---------- TABs -------------------------------------------------------------------
CHHT_TAB_HELP      = "Aide";
CHHT_TAB_CONFIG    = "Config";
CHHT_TAB_GUI       = "GUI";
CHHT_TAB_EXTENDED  = "Avanc\195\169";
CHHT_TAB_FRIEND    = "Ami";
CHHT_TAB_ENEMY     = "Enemi";
CHHT_TAB_PANIC     = "Panique";
CHHT_TAB_EXTRA     = "Extra";
CHHT_TAB_CHAINS    = "Enchain.";
CHHT_TAB_BUFFS     = "Am\195\169lio.";
CHHT_TAB_TOTEMS    = "Totems";

-- ---------- HELP / FAQ -------------------------------------------------------------
CHHT_HELP_TRACKING_BUFF = "(Am\195\169liorations manquantes comme recherche d\'Herbes, Minerais, Pistage, ..)";
CHHT_HELP_TITLE         = 'Aide / FAQ';
CHHT_HELP_MSG           = "ClickHeal Aide";
CHHT_HELP_PAGE1         = "Aide";
CHHT_HELP_PAGE2         = "Abr\195\169vations";
CHHT_HELP_PAGE3         = "FAQs";
CHHT_HELP_PAGE4         = "Cr\195\169dits";

CHHT_HELP_HELP =
  '|c00FFFF00Introduction|r\n'
..'ClickHeal vous permet de lancer un sort sur un PNJ/Joueur en un clic de souris, sans avoir \195\160 cibler \195\160 l\' avance l\'unit\195\169 et ensuite lancer le sort. '
..'A l\'origine, ClickHeal \195\169tait orient\195\169 vers les gu\195\169risseurs. Bienqu\' il sagisse de la fonction la plus importante de ClickHeal, il est aussi extr\195\170mement utile pour les autres '
..'lanceurs de sorts.\n\n'
..'|c00FFFF00Assignement des sorts|r\n'
..'La puissance de ClickHeal r\195\169side dans la facilit\195\169 d\'assigner des sorts \195\160 vos boutons de souris. Vous pouvez assigner tous vos boutons (gauche,centre,droit) jusqu\' \195\160 cinq boutons. '
..'De plus vous pouvez attribuer des touches de modification, comme MAJ +  bouton gauche de la souris.\n'
..'Les sorts et les boutons de la souris seront assign\195\169s \195\160 des groupes, comme ennemis, amis et les *Extra*. Selon l\'unit\195\169 ou la case sur laquelle vous cliquez, '
..'le sort attribu\195\169 sera lanc\195\169. Par exemble, si vous cliquez via le bouton gauche de la souris sur une unit\195\169 amie, vous allez lancer un sort de soins mais lorsque vous cliquez via le bouton gauche de la souris sur une unit\195\169 ennemie, '
..'un sort offensif sera lanc\195\169.\n'
..'Les sorts peuvent \195\170tre assign\195\169s gr\195\162ce \195\160 l\'\195\169cran de configuration. S\195\169lectionnez le groupe appropri\195\169, auquel vous d\195\169sirez attribuer des sorts, via les onglets en bas de celui-ci. Dans la nouvelle section '
..'vous pouvez d\195\169finir les options globales et attribuer les sorts aux boutons de la souris.\n\n'
..'|c00FFFF00Plus encore sur ClickHeal|r\n'
..'ClickHeal non seulement vous permez d\' attribuer des sorts, mais aussi des actions, comme attaquer, ordonner \195\160 votre familier, boire des potions, et plus encore. '
..'ClickHeal permet entre autre, de r\195\169aliser des encha\195\174nements de sorts et de veiller au sur-soin.\n\n'
..'|c00FFFF00Le bloc de fen\195\170tres ClickHeal|r\n'
..'Par d\195\169faut il se situe sur la partie gauche de l\'\195\169cran, mais peut \195\170tre d\195\169plac\195\169 avec la fine barre bleu au dessus du bloc de fen\195\170tres ClickHeal. '
..'Les quatre boutons au-dessus du bloc sont les boutons *Extra*, auxquels vous pouvez attribuer des sorts globaux ou des actions.\n'
..'Juste en dessous d\'eux, le gros bouton bleu, est le bouton de panique. A l\'int\195\169rieur duquel votre mana est affich\195\169e, ainsi que les alertes ou les am\195\169liorations manquantes ou les affaiblissements actifs. '
..'Lorsque vous cliquez sur ce bouton sp\195\169cial de PANIQUE, ClickHeal d\195\169cidera quelle est la chose la plus importante \195\160  r\195\169aliser dans votre situation, des soins, '
..'des cures ou des am\195\169liorations seront alors lanc\195\169s sur votre groupe ou votre raid.\n'
..'Directement en dessous du bouton de PANIQUE se situe celui de votre Avatar, suivi par le ou les boutons des membres de votre groupe. Tout en bas se placent les boutons '
..'pour votre familier ainsi que ceux de votre groupe. A c\195\180t\195\169 de ces boutons se trouve l\'affichage de leurs cibles respectives. Une m\195\170me couleur pour le nom des cibles '
..'indique que les membres du groupe poss\195\168dent la m\195\170me cible.\n\n'
..'|c00FFFF00Aide d\195\169taill\195\169e|r\n'
..'Une aide d\195\169taill\195\169e d\195\169crivant ClickHeal peut \195\170tre trouv\195\169e sur '
..'|c0000CCFFhttp://www.xs4all.nl/~rmetzger/ClickHeal|r';

CHHT_HELP_TEXT_DEBUFFS =
  '|c00FFFF00Affaiblissements (rouge):\n'
..'|c00FF0000M|c00FFFFFF (magie)\n'
..'|c00FF0000C|c00FFFFFF (mal\195\169diction)\n'
..'|c00FF0000D|c00FFFFFF (maladie)\n'
..'|c00FF0000P|c00FFFFFF (poison)\n'
..'|c00FF8800B|c00FFFFFF (Un bandage a \195\169t\195\169 appliqu\195\169 r\195\169cemment)\n'
..'|c00FF8800P|c00FFFFFF (phase shifted imp)\n\n';

CHHT_HELP_TEXT_HOT =
  '|c00FFFF00Soins sur la dur\195\169e (HOT) (vert)\n'
..'|c0000FF00J|c00FFFFFF (R\195\169cup\195\169ration)\n'
..'|c0000FF00G|c00FFFFFF (R\195\169tablissement)\n'
..'|c0000FF00N|c00FFFFFF (R\195\169novation)\n\n';

CHHT_HELP_TEXT_SHIELD =
  '|c00FFFF00Bouclier\n'
..'|c0000FF00S|c00FFFFFF (Mot de pouvoir : Bouclier)\n'
..'|c00FF8800s|c00FFFFFF (Ame affaiblie)\n\n';

CHHT_HELP_TEXT_BUFFS =
  '|c00FFFF00Am\195\169liorations manquantes (jaune):\n'
..'|c00FFFF00B|r (les buff, Bouton PANIQUE uniquement)\n';

CHHT_HELP_TEXT_FINETUNE =
  '|c00FFFF00Encha\195\174nement des sorts:|c00FFFFFF\n'
..'|c0000CCFFMot de pouvoir : Bouclier|c00FFFFFF -> R\195\169novation -> Soins rapides\n'
..'|c0000CCFFR\195\169novation|c00FFFFFF -> Soins rapides\n'
..'|c0000CCFFR\195\169cup\195\169ration|c00FFFFFF -> R\195\169tablissement -> Toucher Gu\195\169risseur\n'
..'|c0000CCFFR\195\169tablissement|c00FFFFFF -> R\195\169cup\195\169ration -> R\195\169tablissement\n\n'
;

CHHT_HELP_TEXT_UPPER_LOWER =
  '|c00FFFF00Les effets des am\195\169liorations, et soins sur la dur\195\169e (HOT), en minuscules sont sur le point d\'expirer.|r\n';

CHHT_HELP_FAQ =
  '|c00FFFF00Ou puis je trouver une aide d\195\169taill\195\169e?|r\n'
..'Veuillez consulter |c0000CCFFhttp://www.xs4all.nl/~rmetzger/ClickHeal|r pour une documentation compl\195\168te.\n\n'
..'|c00FFFF00J\'ai lu l\'aide mais j\'ai toujours des questions. Que faire?|r\n'
..'Je consulte fr\195\169quemment les pages de |c0000CCFFui.worldofwar.net|r et de |c0000CCFFwww.curse-gaming.com|r. Recherchez ClickHeal et '
..'les messages s\'y rapportant. Beaucoup de questions trouvent d\195\169j\195\160 r\195\169ponse \195\160 cet endroit. Mais si vous n\'\195\170tes toujours pas satisf\195\169, n\'h\195\169sitez pas \195\160 y d\195\169poser vos questions.\n\n'
..'|c00FFFF00J\'ai trouv\195\169 un bug, d\195\169sire l\' impl\195\169mentation d\'une fonctionnalit\195\169 ou donner un retour. O\uffff puis je faire ca?|r\n'
..'Veuillez vous rendre sur |c0000CCFFui.worldofwar.net|r and |c0000CCFFwww.curse-gaming.com|r, dans la section ClickHeal. Je suis extr\195\170mement interess\195\169 '
..'par vos retours et impressions.';

CHHT_HELP_CREDITS =
  '|c00FFFF00A propos|r\n'
..'ClickHeal est d\195\169velop\195\169 par rmet0815. Il est sous liscense GPL (Gnu Public Licence), ce qui g\195\169n\195\169ralement implique qu\'il est utilisable par tout le monde '
..'sans restriction. GPL est fixe, ce qui signifie que si vous apportez des modifications \195\160 l\'AddOn ou utilisez des parties de celui-ci dans vos propres '
..'applications, vous devrez le repasser sous liscence GPL.\n\n'
..'|c00FFFF00Credits|r\n'
..'Traduction Fran\195\167aise: Genre, Mainsacr\195\169\n'
..'Traduction Cor\195\169enne: Damjau\n'
..'Traduction Allemande: Rastibor, Teodred@Rat von Dalaran, Farook\n'
..'Traduction Chinoise: Space Dragon\n'
..'Traduction Chinoise Classique: Bell\n\n'
..'Et merci \195\160 vous tous qui utilisez ClickHeal, apportez des commentaires et remontez des anomalies. Sans vous, '
..'ClickHeal ne serait pas ce qu\'il est aujourd\'hui!';

-- ---------- COMMON / CH_HELP -------------------------------------------------------
CHHT_PET_ATTACK_NONE         = 'Aucun';
CHHT_PET_ATTACK_HUNTERS_MARK = CH_SPELL_HUNTERS_MARK;

CHHT_UNITBUFF_AUTOMATIC      = 'Automatique';
CHHT_UNITBUFF_POPUP          = 'Popup';

CHHT_GROUPBUFF_REFRESH_TIME  = 'Dur\195\169e de reg\195\169ner.';
CHHT_GROUPBUFF_WARN_TIME     = 'Dur\195\169e d\'alerte';

-- ---------- MISC -------------------------------------------------------------------
CHHT_MISC_OPTIONS                       = 'Options Diverses';
CHHT_MISC_ADDONS			= 'Addons';
CHHT_MISC_CTRA                          = "Int\195\169gration CT Raid Assist";
CHHT_MISC_DUF                           = "Discord Unit Frames (DUF)";
CHHT_MISC_BONUSSCANNER                  = "BonusScanner";
CHHT_MISC_PCUF                          = "Perl Classic Unit Frames (PCUF)";
CHHT_MISC_ORA                           = "oRA";
CHHT_MISC_WOWGUI                        = "Interface Standard WoW";
CHHT_MISC_DECURSIVE                     = "Int\195\169gration Decursive";
CHHT_MISC_NEEDYLIST                     = "Int\195\169gration Ralek's Needy List";
CHHT_CAST_SPELL_BY_NAME_ON_SELF         = "Utiliser le self-cast de World of Warcraft";
CHHT_MISC_DEBUG_LEVEL                   = "Debug Messages";
CHHT_MISC_RESETALL_Q                    = "Cocher cette option et cliquer sur le bouton reinitialisera COMPLETEMENT la configuration de ClickHeal";
CHHT_MISC_RESETALL                      = "Tout R\195\169init";
CHHT_MISC_PLUGINS                       = 'Add-ons';
CHHT_CONFIG_PLUGIN_INFO_MSG             = 'Les Add-ons peuvent \195\170tre d\195\169sactiv\195\169 dans l\'\195\169cran de login du personnage, bouton "Add-ons" en bas \195\160 droite';
CHHT_MISC_COMBAT                        = "Combat";
CHHT_MISC_COMBAT_SAFE_TAUNT             = "Provocation efficasse";
CHHT_MISC_COMBAT_SD                     = 'Self d\195\169fense';
CHHT_MISC_COMBAT_SD_ATTACK              = "Si attaqu\195\169 mais pas en combat, attaque votre cible";
CHHT_MISC_COMBAT_SD_PET                 = "Si attaqu\195\169 et familier pas en combat, familier attaque votre cible";
CHHT_MISC_COMBAT_SD_HIT                 = "Se considerer attaqu\195\169 seulement si reellement frapper";
CHHT_MISC_COMBAT_SD_MES                 = "Ne jamais auto-attaquer les unit\195\169s sous emprises (entrav\195\169es, mouton\195\169es, ...)";
CHHT_MISC_COMBAT_SD_SWITCH              = 'D\195\169sactiver autod\195\169fence lorsque en groupe';
CHHT_MISC_CDW                           = 'Affichage dur\195\169e de recharge';
CHHT_MISC_CDW_EXTRA1                    = 'Bouton Extra1';
CHHT_MISC_CDW_EXTRA2                    = 'Bouton Extra2';
CHHT_MISC_CDW_EXTRA3                    = 'Bouton Extra3';
CHHT_MISC_CDW_EXTRA4                    = 'Bouton Extra4';
CHHT_MISC_CDW_SPELLS                    = 'Sorts';
CHHT_MISC_CDW_BAG                       = "Afficher temps de r\195\169utilisation des objets dans les sacs";
CHHT_MISC_OVERHEAL                      = 'Efficacit\195\169 des soins';
CHHT_MISC_OVERHEAL_COMBAT               = "En combat, lancer le sort si vie du joueur est inf. ou \195\169gale \195\160";
CHHT_MISC_OVERHEAL_NOCOMBAT             = "Utiliser le sort le plus \195\169fficasse si joueur n'est pas en combat";
CHHT_MISC_OVERHEAL_DOWNSCALE            = "Reduire le rang du sort en combat afin d\'\195\169viter les sur-soins";
CHHT_MISC_OVERHEAL_LOM_DOWNSCALE        = "Nombre de rangs de mana a réduire en combat";
CHHT_MISC_OVERHEAL_BASE                 = "Pourcentage des soins \195\160 prendre en compte dans les calculs";
CHHT_MISC_OVERHEAL_HOT                  = "Pourcentage des soins sur la dur\195\169e (HOT) \195\160 prendre en compte dans les calculs";
CHHT_MISC_OVERHEAL_QUICK                = 'RAPIDE';
CHHT_MISC_OVERHEAL_SLOW                 = 'LENT';
CHHT_MISC_OVERHEAL_DPSCHECK             = 'Dur\195\169e au del\195\160s de laquelle les dommages sont inclus dans les calculs';
CHHT_MISC_OVERHEAL_CLICK_ABORT_PERC     = 'Pourcentage de vie de la cible arr\195\170tant un nouveau sort de soin alors qu\'il y en a un en cours';
CHHT_MISC_OVERHEAL_MODIFY_TOTAL_PERC    = 'Pourcentage \195\160 appliquer sur le calcul des soins';
CHHT_MISC_OVERHEAL_OVERHEAL_ALLOWANCE   = 'Combien sursoin par sort est autoris\195\169';
CHHT_MISC_OVERHEAL_LOM_NONE             = 'Aucun';
CHHT_MISC_OVERHEAL_LOM_MAX              = 'Maximum';
CHHT_MISC_OVERHEAL_LOM_TITLE_FORMAT     = '%d rangs du sort';
CHHT_MISC_OVERHEAL_GEAR                 = 'Inclure les bonus d\'\195\169quipement dans les calculs (actuellement +%s en soin)';
CHHT_MISC_OVERHEAL_FORMULA_QUICK        = "Pour Rapide:";
CHHT_MISC_OVERHEAL_FORMULA_SLOW         = "Pour Lent:";
CHHT_MISC_NOTIFY_HIT                    = 'L\'avatar est frapp\195\169';
CHHT_MISC_NOTIFY_HIT_SOUND              = "Jouer un Son";
CHHT_MISC_NOTIFY_HIT_SOUND_REPEAT       = "Ne pas rejouer le son avant";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PARTY     = "Annoncer au groupe";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PLAY_EMOTE= "Jouer un emote";
CHHT_MISC_NOTIFY_HIT_HITPOINTS          = "Annoncer si points de vie inf. ou \195\169gaux \195\160";
CHHT_MISC_NOTIFY_HIT_HITPOINT_SLIDER_TITLE = "Points de vie (%d%%)";
CHHT_MISC_NOTIFY_HIT_HITPOINTS_FADE     = "Avec oubli actif, annoncer si points de vie inf. ou \195\169gaux \195\160 (Pr\195\170tre seulement)";
CHHT_MISC_NOTIFY_HIT_REPEAT             = "Ne pas r\195\169-annoncer avant";
CHHT_MISC_NOTIFY_HIT_MSG                = "Message \195\160 afficher";
CHHT_MISC_NOTIFY_OOM                    = 'Plus de Mana';
CHHT_MISC_NOTIFY_OOM_PARTY              = "Annoncer au groupe";
CHHT_MISC_NOTIFY_OOM_RAID               = "Annoncer au raid";
CHHT_MISC_NOTIFY_OOM_CUSTOM_CHANNEL     = "Annoncer dans un canal priv\195\169";
CHHT_MISC_NOTIFY_OOM_PLAY_EMOTE         = "Jouer un emote";
CHHT_MISC_NOTIFY_OOM_MANA               = "Annoncer si mana inf. ou \195\169gale \195\160";
CHHT_MISC_NOTIFY_OOM_SLIDER_TITLE       = 'mana (%d%%)';
CHHT_MISC_NOTIFY_OOM_REPEAT             = "Ne pas r\195\169annoncer avant";
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL         = "Canal priv\195\169"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_NAME    = "Nom"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_PASSWORD= "Mot de passe"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_CHAT_BOX= "Fen\195\170tre de discussion";
CHHT_MISC_NOTIFY_DEFAULT_CHAT_WINDOW_LABEL="Fen\195\170tre par d\195\169faut";
CHHT_MISC_NOTIFY_CHAT_WINDOW_LABEL_FORMAT="Fen\195\170tre de discussion %d";
CHHT_MISC_NOTIFY_SPELLCAST              = 'Annoncer l\'incantation';
CHHT_MISC_NOTIFY_SPELLCAST_SAY          = "Annoncer avec /dire";
CHHT_MISC_NOTIFY_SPELLCAST_TELL         = "Chuchoter \195\160 la cible";
CHHT_MISC_NOTIFY_SPELLCAST_PARTY        = "Annoncer avec /gr";
CHHT_MISC_NOTIFY_SPELLCAST_RAID         = "Annoncer avec /raid";
CHHT_MISC_NOTIFY_SPELLCAST_CUSTOM_CHANNEL="Canal priv\195\169";
CHHT_MISC_PAGE1                         = "Divers";
CHHT_MISC_PAGE2                         = "Add-ons";
CHHT_MISC_PAGE3                         = "Combat";
CHHT_MISC_PAGE4                         = "Cooldown";
CHHT_MISC_PAGE5                         = "Soins";
CHHT_MISC_PAGE6                         = "Notif.";
CHHT_MISC_PAGE7                         = "Notif. 2";
CHHT_MISC_HEALTH_PERCENT_TITLE_FORMAT   = "Pourcentage Vie (%s%%)";
CHHT_MISC_HEAL_POTENTIAL_TITLE_FORMAT   = "Potentiel de soin (%s%%)";
CHHT_MISC_HOT_PERCENTAGE_TITLE_FORMAT   = "Pourcentage HOT(%s%%)";
CHHT_MISC_HIT_AGO_TITLE_FORMAT          = "Coup recu il y a %s secondes";
CHHT_MISC_CLICK_ABORT_PERC_TITLE_FORMAT = "Pourcentage Vie (%s%%)";
CHHT_MISC_OVERHEAL_ALLOWANCE_TITLE_FORMAT="Sursoin (%s%%)";
CHHT_MISC_SECONDS_TITLE_FORMAT          = "secondes (%s)";
CHHT_MISC_MODIFY_TOTAL_PERC_FORMAT      = "Modifier total (%s%%)";

-- ---------- GUI --------------------------------------------------------------------
CHHT_GUI_PARTY_SORT                   = 'Ordre Groupe';
CHHT_GUI_MISC                         = 'Divers';
CHHT_GUI_PARTY_MEMBER_LABEL           = "Titres des Membres du groupe/raid";
CHHT_GUI_SHOW_FRIEND_DEBUFFS          = "Montrer am\195\169liorations sur unit\195\169s amis";
CHHT_GUI_TARGET_BACKGROUND_COLOR      = "Couleur sant\195\169 de la cible";
CHHT_GUI_SHOW_TARGET_DEBUFFS          = "Afficher Mal\195\169dictions de la cible";
CHHT_GUI_FRAME_GROUP_MODE             = "Bloc de Groupe";
CHHT_GUI_SHOW_CLICKHEAL_FRAMES        = "Afficher bloc ClickHeal";
CHHT_GUI_SHOW_PARTY_FRAMES            = "Afficher blocs des membres";
CHHT_GUI_SHOW_PARTY_PETS_FRAMES       = "Afficher familiers du groupe";
CHHT_GUI_SHOW_WOW_PARTY_FRAMES        = "Afficher avatars WoW";
CHHT_GUI_SHOW_PLAYER_MANA             = "Afficher la mana dans le bloc du joueur";
CHHT_GUI_SHOW_PET_FOCUS               = "Afficher Focus familier";
CHHT_GUI_SHOW_PARTYPET_TARGET         = "Afficher les cibles des familiers du groupe";
CHHT_GUI_SHOW_MES                     = "Afficher dur\195\169e d\'emprise d\'un sort de contr\195\180le";
CHHT_GUI_SHOW_FIVE_SEC_RULE           = 'Afficher barre avec "R\195\168gle des 5sec" et Reg\195\169n. Mana';
CHHT_GUI_SHOW_HINTS                   = "Afficher conseils de config";
CHHT_GUI_UPDATE_SLIDER_TITLE          = 'intervalle de M.A.J des effets (%3.1f secondes)';
CHHT_GUI_RESET_FRAME_POS              = "R\195\169Init positions blocs";
CHHT_GUI_MAIN_FRAMES                  = 'Blocs Principaux';
CHHT_GUI_FRAME_ALIGNMENT              = "Alignement du bloc";
CHHT_GUI_FRAME_EXTRA_WIDTH            = 'Extra Frame Width (%d)';
CHHT_GUI_FRAME_PANIC_WIDTH            = 'Largeur bloc PANIQUE (%d)';
CHHT_GUI_FRAME_PLAYER_WIDTH           = 'Largeur bloc joueur (%d)';
CHHT_GUI_FRAME_PARTY_WIDTH            = 'Largeur bloc Groupe (%d)';
CHHT_GUI_FRAME_PET_WIDTH              = 'Largeur bloc Familier (%d)';
CHHT_GUI_FRAME_PARTYPET_WIDTH         = 'Largeur bloc Familier Groupe (%d)';
CHHT_GUI_FRAME_EXTRA_HEIGHT           = 'Extra Frame Height (%d)';
CHHT_GUI_FRAME_PANIC_HEIGHT           = 'Hauteur bloc PANIQUE (%d)';
CHHT_GUI_FRAME_PLAYER_HEIGHT          = 'Hauteur bloc Joueur (%d)';
CHHT_GUI_FRAME_PARTY_HEIGHT           = 'Hauteur bloc Groupe (%d)';
CHHT_GUI_FRAME_PET_HEIGHT             = 'Hauteur bloc FAMILIER (%d)';
CHHT_GUI_FRAME_PARTYPET_HEIGHT        = 'Hauteur bloc Familier groupe (%d)';
CHHT_GUI_FRAME_EXTRA_SCALE            = 'Echelle bloc Extra (%d%%)';
CHHT_GUI_FRAME_PANIC_SCALE            = 'Echelle bloc PANIQUE (%d%%)';
CHHT_GUI_FRAME_PLAYER_SCALE           = 'Echelle bloc Joueur (%d%%)';
CHHT_GUI_FRAME_PARTY_SCALE            = 'Echelle bloc Groupe (%d%%)';
CHHT_GUI_FRAME_PET_SCALE              = 'Echelle bloc Familier (%d%%)';
CHHT_GUI_FRAME_PARTYPET_SCALE         = 'Echelle bloc Familiers Groupe (%d%%)';
CHHT_GUI_TARGET_FRAMES                = 'bloc des cibles';
CHHT_GUI_SHOW_TARGETS                 = "Afficher les cibles";
CHHT_GUI_FRAME_PLAYER_TARGET_WIDTH    = 'Largeur bloc Cible du Joueur (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_WIDTH     = 'Largeur bloc Cible du Groupe (%d)';
CHHT_GUI_FRAME_PET_TARGET_WIDTH       = 'Largeur bloc Cible du Familier (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_WIDTH  = 'Largeur bloc Cible du Familier Groupe (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_HEIGHT   = 'Hauteur bloc Cible du Joueur (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_HEIGHT    = 'Hauteur bloc Cible du Groupe (%d)';
CHHT_GUI_FRAME_PET_TARGET_HEIGHT      = 'Hauteur bloc Cible du Familier (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_HEIGHT = 'Hauteur bloc Cible du Familier Groupe (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_SCALE    = 'Echelle bloc cible du joueur (%d%%)';
CHHT_GUI_FRAME_PARTY_TARGET_SCALE     = 'Echelle bloc cible du Groupe (%d%%)';
CHHT_GUI_FRAME_PET_TARGET_SCALE       = 'Echelle bloc cible du Familier (%d%%)';
CHHT_GUI_FRAME_PARTYPET_TARGET_SCALE  = 'Echelle bloc cible du Familier groupe (%d%%)';
CHHT_GUI_TOOLTIPS                     = 'Conseils';
CHHT_GUI_SHOW_GAME_TOOLTIPS           = "Afficher Fen\195\170tre infos au survol";
CHHT_GUI_SHOW_GAME_TOOLTIPS_LOCATION  = "Location of game tooltips";
CHHT_GUI_SHOW_ACTION_TOOLTIPS         = "Afficher infos avec racourcis Sorts/Actions";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK       = "Afficher rang du sort dans Fen\195\170tre d\'info";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK_MAX   = "Afficher indication que le + haut sort est utilis\195\169";
CHHT_GUI_PAGE1                        = "Divers";
CHHT_GUI_PAGE2                        = "Principal";
CHHT_GUI_PAGE3                        = "Blocs";
CHHT_GUI_PAGE4                        = "Conseils";
CHHT_GUI_PAGE5                        = "Ancres";
CHHT_GUI_FRAME_GROUP_MODE_ALL         = 'Tous les Groupes';
CHHT_GUI_FRAME_GROUP_MODE_GROUP       = 'Cr\195\169er Groupes';
CHHT_GUI_TARGET_COLOR_NEVER           = 'Jamais';
CHHT_GUI_TARGET_COLOR_PLAYER          = 'Joueur';
CHHT_GUI_TARGET_COLOR_ALWAYS          = 'Toujours';
CHHT_GUI_TARGET_DEBUFF_NONE           = 'Aucun';
CHHT_GUI_TARGET_DEBUFF_CASTABLE       = 'Incantable';
CHHT_GUI_TARGET_DEBUFF_ENEMY_CASTABLE = 'Enemi incantable';
CHHT_GUI_TARGET_DEBUFF_ENEMY_ALL      = 'Tout Enemi';
CHHT_GUI_TARGET_DEBUFF_ALL            = 'Tout';
CHHT_GUI_FRAME_ALIGN_LEFT             = 'Gauche';
CHHT_GUI_FRAME_ALIGN_CENTER           = 'Centr\195\169';
CHHT_GUI_FRAME_ALIGN_RIGHT            = 'Droite';
CHHT_GUI_DOCK_TARGET_NONE             = 'Aucun';
CHHT_GUI_DOCK_TARGET_RIGHT            = 'Droite';
CHHT_GUI_DOCK_TARGET_LEFT             = 'Gauche';
CHHT_GUI_UNIT_TOOLTIP_ALWAYS          = 'Toujours';
CHHT_GUI_UNIT_TOOLTIP_NEVER           = 'Jamais';
CHHT_GUI_UNIT_TOOLTIP_SHIFT           = 'Maj';
CHHT_GUI_UNIT_TOOLTIP_CTRL            = 'Control';
CHHT_GUI_UNIT_TOOLTIP_ALT             = 'Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRL       = 'Maj-Ctrl';
CHHT_GUI_UNIT_TOOLTIP_SHIFTALT        = 'Maj-Alt';
CHHT_GUI_UNIT_TOOLTIP_CTRLALT         = 'Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRLALT    = 'Maj-Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_MAIN   = 'ClickHeal Frames';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_WOW    = 'Standard WoW';
CHHT_GUI_ACTION_TOOLTIP_ALWAYS        = 'Toujours';
CHHT_GUI_ACTION_TOOLTIP_NEVER         = 'Jamais';
CHHT_GUI_TOOLTIP_UNIT_TOOLTIP_SCALE   = 'Echelle fen\195\170tre info unit\195\169s (%d%%)';
CHHT_GUI_TOOLTIP_ACTIONS_TOOLTIP_SCALE= 'Echelle fen\195\170tre des actions (%d%%)';
CHHT_GUI_TOOLTIP_HINT_TOOLTIP_SCALE   = 'Echelle fen\195\170tre des param\195\168tres (%d%%)';
CHHT_GUI_ANCHORS                      = 'Ancrages';
CHHT_GUI_ANCHORS_ANCHOR_NAME          = 'Ancrage';
CHHT_GUI_ANCHORS_RELATIVE_TO          = 'Ancr\195\169 \195\160';
CHHT_GUI_ANCHORS_RELATIVE_POINT       = 'Direction';
CHHT_GUI_ANCHORS_OFFSET_X             = 'X-Pos';
CHHT_GUI_ANCHORS_OFFSET_Y             = 'Y-Pos';
CHHT_GUI_ANCHORS_GROW                 = "Croissance";
CHHT_GUI_ANCHORS_SHOW_MENU            = "Menu";
CHHT_GUI_ANCHORS_VISIBILITY           = 'Affichage';
CHHT_GUI_ANCHORS_VISIBILITY_SHOW      = 'Afficher';
CHHT_GUI_ANCHORS_VISIBILITY_AUTOHIDE  = 'AutoMasquer';
CHHT_GUI_ANCHORS_VISIBILITY_COLLAPSE  = 'Collapse';
CHHT_GUI_ANCHORS_GROW_UP              = 'Plus';
CHHT_GUI_ANCHORS_GROW_DOWN            = 'Moins';
CHHT_GUI_ANCHOR_SHOW_DOCK_ANCHORS     = 'Afficher ancres';
CHHT_GUI_ANCHOR_SHOW_ANCHORS          = "Ancres d\195\169placable";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_TITLE  = "Ancrage Magnetique (%d pixels)";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_LOW    = "Aucun";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_HIGH   = "20 px";
CHHT_GUI_ANCHOR_MAGNETIC_TITLE_LOW    = "Libre";

-- ---------- EXTENDED ---------------------------------------------------------------
CHHT_EXTENDED_TOOLTIP_ORIENTATION_HIDE           = 'Ne pas Montrer';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_LEFT           = 'Gauche';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_TOP            = 'Haut';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_RIGHT          = 'Droite';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_BOTTOM         = 'Bas';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_MAIN           = 'Blocs principaux';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_WOW            = 'Standard WoW';
CHHT_EXTENDED_RAID_GROUPS                        = 'Groupes du Raid';
CHHT_EXTENDED_RAID_GROUP1                        = "Groupe 1";
CHHT_EXTENDED_RAID_GROUP2                        = "Groupe 2";
CHHT_EXTENDED_RAID_GROUP3                        = "Groupe 3";
CHHT_EXTENDED_RAID_GROUP4                        = "Groupe 4";
CHHT_EXTENDED_RAID_GROUP5                        = "Groupe 5";
CHHT_EXTENDED_RAID_GROUP6                        = "Groupe 6";
CHHT_EXTENDED_RAID_GROUP7                        = "Groupe 7";
CHHT_EXTENDED_RAID_GROUP8                        = "Groupe 8";
CHHT_EXTENDED_RAID_CLASSES                       = 'Classes du Raid';
CHHT_EXTENDED_RAID_PETS                          = "Familiers du Raid";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL            = "Chercher nouveau familier dans Raid toutes les %d secondes";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL_MAX        = "secondes (%s)";
CHHT_EXTENDED_RAID_GROUP_FRAME_WIDTH             = 'Largeur bloc Groupe/Raid (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_HEIGHT            = 'Hauteur bloc Groupe/Raid (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_WIDTH             = 'Largeur bloc classe Raid (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_HEIGHT            = 'Hauteur bloc classe Raid (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_SCALE             = 'Echelle bloc Groupe/Raid (%d%%)';
CHHT_EXTENDED_RAID_CLASS_FRAME_SCALE             = 'Echelle bloc classe Raid (%d%%)';
CHHT_EXTENDED_RAID_HIDE_PARTY_HIDE               = 'Masquer Groupe';
CHHT_EXTENDED_RAID_HIDE_PARTY_SHOW               = 'Afficher Groupe';
CHHT_EXTENDED_RAID_HIDE_PARTY_WOW                = 'Utiliser WoW config';
CHHT_EXTENDED_RAID_HIDE_PARTY_IN_RAID            = 'Masquer groupe dans Raid';
CHHT_EXTENDED_RAID_TOOLTIP_ORIENTATION           = "Orientation infos";
CHHT_EXTENDED_RAID                               = 'Raid';
CHHT_EXTENDED_MAINTANK                           = 'Tank/Assist';
CHHT_EXTENDED_MT1_LABEL                          = 'Tank #1';
CHHT_EXTENDED_MT2_LABEL                          = 'Tank #2';
CHHT_EXTENDED_MT3_LABEL                          = 'Tank #3';
CHHT_EXTENDED_MT4_LABEL                          = 'Tank #4';
CHHT_EXTENDED_MT5_LABEL                          = 'Tank #5';
CHHT_EXTENDED_MT6_LABEL                          = 'Tank #6';
CHHT_EXTENDED_MT7_LABEL                          = 'Tank #7';
CHHT_EXTENDED_MT8_LABEL                          = 'Tank #8';
CHHT_EXTENDED_MT9_LABEL                          = 'Tank #9';
CHHT_EXTENDED_MT10_LABEL                         = 'Tank #10';
CHHT_EXTENDED_MT_CTRA_MT                         = 'CTRA MT';
CHHT_EXTENDED_MT_CTRA_MT_FORMAT                  = 'CTRA MT #%d';
CHHT_EXTENDED_MT_CTRA_PT                         = 'CTRA PT';
CHHT_EXTENDED_MT_CTRA_PT_FORMAT                  = 'CTRA PT #%d';
CHHT_EXTENDED_MT_FRAME_WIDTH                     = 'Lageur bloc Tank principal (%d)';
CHHT_EXTENDED_MT_FRAME_HEIGHT                    = 'Hauteur bloc Tank principal (%d)';
CHHT_EXTENDED_MT_FRAME_SCALE                     = 'Echelle bloc Tank principal (%d%%)';
CHHT_EXTENDED_NEEDY_LIST_ENABLED                 = "Needy List activ\195\168";
CHHT_EXTENDED_NEEDY_LIST_HIDE_IN_BATTLEFIELD     = "Masquer dans les BG";
CHHT_EXTENDED_NEEDY_LIST_GROW_DIRECTION          = "Extension de la liste";
CHHT_EXTENDED_NEEDY_LIST_TOOLTIP_ORIENTATION     = "Orientation fen\195\170tre d\'info";
CHHT_EXTENDED_NEEDY_LIST_SCAN_INTERVAL           = "Examiner tous les %3.1f s";
CHHT_EXTENDED_NEEDY_LIST_SCAN_INTERVAL_CONT      = "Syst\195\168matiquement examiner";
CHHT_EXTENDED_NEEDY_LIST_MAX_UNITS               = "Nombre Maximum d\'unit\195\169s affich\195\169es (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_WIDTH             = "Lageur bloc (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_HEIGHT            = "Hauteur bloc (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_SCALE             = "Echelle bloc (%d%%)";
CHHT_EXTENDED_NEEDY_LIST_UNITS_LABEL             = "Unit\195\169s";
CHHT_EXTENDED_NEEDY_LIST_CLASSES_LABEL           = "Classes";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_ALWAYS          = "Toujours";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTY           = "Groupe";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_RAID            = "Raid";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTYRAID       = "Groupe & Raid";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_NEVER           = "Jamais";
CHHT_EXTENDED_NEEDY_LIST_SORT                    = 'Tri';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR                = 'Masquer OOR';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_NONE           = 'Ne pas masquer';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_POSSIBLE       = 'OOR possible';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_VERIFIED       = 'V\195\169rifier seulement';
CHHT_EXTENDED_NEEDY_LIST_HEAL                    = "Needy List Soin"
CHHT_EXTENDED_NEEDY_LIST_HEAL_HEALTH_PERCENTAGE  = "% de vie pour afficher une unit for unit\195\169 (%d%%)";
CHHT_EXTENDED_NEEDY_LIST_HEAL_LOCK_TANKS         = "Verouiller et afficher les Tanks";
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_UNSORTED      = 'Non tri\195\169';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_LOCKED        = 'Unit\195\169s V\195\169rouill\195\169es';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGENCY     = 'Emergency';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGLOCKED   = 'Emergency, locked';
CHHT_EXTENDED_NEEDY_LIST_CURE                    = "Needy List Gu\195\169rison"
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_CURSE         = "Afficher Mal\195\169diction";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_DISEASE       = "Afficher Maladie";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_POISON        = "Afficher Poison";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_MAGIC         = "Afficher Magie";
CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_UNSORTED      = 'Non tri\195\169';
CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_LOCKED        = 'Unit\195\169s V\195\169rouill\195\169es';
CHHT_EXTENDED_NEEDY_LIST_BUFF                    = "Needy List Buff"
CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_UNSORTED      = 'Non tri\195\169';
CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_LOCKED        = 'Unit\195\169s V\195\169rouill\195\169es';
CHHT_EXTENDED_NEEDY_LIST_DEAD                    = "Needy List Mort"
CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_UNSORTED      = 'Non tri\195\169';
CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_LOCKED        = 'Unit\195\169s V\195\169rouill\195\169es';
CHHT_EXTENDED_PAGE1                              = "Raid";
CHHT_EXTENDED_PAGE2                              = "Tank/Assist";
CHHT_EXTENDED_PAGE3                              = "NL Soin";
CHHT_EXTENDED_PAGE4                              = "NL Gu\195\169rison";
CHHT_EXTENDED_PAGE5                              = "NL Buff";
CHHT_EXTENDED_PAGE6                              = "NL Mort";

-- ---------- FRIEND -----------------------------------------------------------------
CHHT_FRIEND_OPTIONS                = 'Ami Options';
CHHT_FRIEND_HITPOINT_LABEL         = "D\195\169g\195\162ts des membres du groupe/raid en";
CHHT_FRIEND_FRAME_BACKGROUND       = "Arri\195\168re plan des blocs d\'avatars et des membres des groupes/raid";
CHHT_FRIEND_FRAME_BACKGROUND_ALPHA = 'Opacity (%3.2f)';
CHHT_FRIEND_PICK_COLOR             = 'Pick Color';
CHHT_FRIEND_RESURRECT              = "R\195\169ssuciter les joueurs morts";
CHHT_FRIEND_ADJUST_SPELLRANK       = "Ajuster rang du sort \195\160 la cible";
CHHT_FRIEND_SHOW_MANA              = "Afficher Mana";
CHHT_FRIEND_SHOW_RAGE              = "Afficher Rage";
CHHT_FRIEND_SHOW_ENERGY            = "Afficher Energie";
CHHT_FRIEND_SHOW_FOCUS             = "Afficher Focus Familier";
CHHT_FRIEND_SHADOWFORM             = "Basculer Forme d\'ombre/Loup Fantome/Stealth";
CHHT_FRIEND_CAST_ON_CHARMED        = "Lancer sorts affensifs sur des unit\195\169s amis sous contr\195\180les";
CHHT_FRIEND_MOUSE_TITLE            = 'Amis actions';
CHHT_FRIEND_PAGE1                  = "Options";
CHHT_FRIEND_PAGE2                  = "Souris 1/3";
CHHT_FRIEND_PAGE3                  = "Souris 2/3";
CHHT_FRIEND_PAGE4                  = "Souris 3/3";
CHHT_FRIEND_HP_LABEL_PERCENT       = 'pourcent';
CHHT_FRIEND_HP_LABEL_PERCENT_SIGN  = 'pourcent avec signe';
CHHT_FRIEND_HP_LABEL_CURRENT       = 'Points restants';
CHHT_FRIEND_HP_LABEL_MISSING       = 'Points perdus';
CHHT_FRIEND_HP_LABEL_NONE          = 'Rien';
CHHT_FRIEND_FRAME_BACKGROUND_HEALTH= 'Couleur Sant\195\169';
CHHT_FRIEND_FRAME_BACKGROUND_CLASS = 'Couleur des Classes';
CHHT_FRIEND_FRAME_BACKGROUND_CUSTOM= 'Custom';
CHHT_FRIEND_PARTY_LABEL_CLASS      = 'Classe';
CHHT_FRIEND_PARTY_LABEL_NAME       = 'Nom';
CHHT_FRIEND_PARTY_LABEL_BOTH       = 'Classe-Nom';
CHHT_FRIEND_PARTY_LABEL_COLOR      = 'Nom-Code Couleur';
CHHT_FRIEND_PARTY_LABEL_BOTHCOLOR  = 'Class-Name Color';
CHHT_FRIEND_FRIEND_DEBUFF_NONE     = 'Aucun';
CHHT_FRIEND_FRIEND_DEBUFF_CURABLE  = 'Curable';
CHHT_FRIEND_FRIEND_DEBUFF_ALL      = 'Tout';
CHHT_FRIEND_RESURRECT_AFTER_COMBAT = 'apr\195\169s combat';
CHHT_FRIEND_RESURRECT_ALWAYS       = 'toujours';
CHHT_FRIEND_RESURRECT_NEVER        = 'jamais';
CHHT_FRIEND_POWER_WORD_SHIELD      = 'Ne pas lancer Mot de pouvoir : Bouclier quand d\195\169j\195\160 actif';
CHHT_FRIEND_RENEW                  = 'Ne pas lancer R\195\169novation quand d\195\169j\195\160 actif';
CHHT_FRIEND_REGROWTH               = 'Ne pas lancer R\195\169tablissement quand d\195\169j\195\160 actif';
CHHT_FRIEND_REJUVENATION           = 'Ne pas lancer R\195\169cup\195\169ration quand d\195\169j\195\160 actif';
CHHT_FRIEND_SWIFTMEND              = 'Do not cast Swiftmend when already active';

CHHT_FRIEND_CHECK_HEAL_RANGE                              = 'V\195\169rif \195\169tendu des soins';
CHHT_FRIEND_CHECK_HEAL_RANGE_MODE                         = 'Mode';
CHHT_FRIEND_CHECK_HEAL_RANGE_NEVER                        = 'Ne pas V\195\169rif';
CHHT_FRIEND_CHECK_HEAL_RANGE_FOLLOW                       = 'Use follow range (Rapide)';
CHHT_FRIEND_CHECK_HEAL_RANGE_ONHWEVENT                    = 'V\195\169rif sur \195\169venement hardware';
CHHT_FRIEND_CHECK_HEAL_RANGE_BOUNDARY_FORMAT              = '%3.1f sec';
CHHT_FRIEND_CHECK_HEAL_RANGE_KEEP_DURATION                = 'Keep duration (%3.1f sec)';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_OOR            = 'Show OOR at hp';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_HP             = 'Color hitpoints';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_BACKGROUND     = 'Custom background';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_NONE           = 'Do not show';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_POSSIBLE       = 'Possible OOR';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_VERIFIED       = 'Verified OOR';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_POSSIBLE_COLOR = 'Color Possible';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_VERIFIED_COLOR = 'Color Verified';

-- ---------- TARGET/ENEMY -----------------------------------------------------------
CHHT_TARGET_TARGETING          = "Mode d\'acquisition de la cible";
CHHT_TARGET_PLAYER_TARGET      = "Cible Joueur";
CHHT_TARGET_PARTY1_TARGET      = "Cible Groupe 1";
CHHT_TARGET_PARTY2_TARGET      = "Cible Groupe 2";
CHHT_TARGET_PARTY3_TARGET      = "Cible Groupe 3";
CHHT_TARGET_PARTY4_TARGET      = "Cible Groupe 4";
CHHT_TARGET_PET_TARGET         = "Cible Familier";
CHHT_TARGET_PARTYPET1_TARGET   = "Cible Familier Gr1";
CHHT_TARGET_PARTYPET2_TARGET   = "Cible Familier Gr2";
CHHT_TARGET_PARTYPET3_TARGET   = "Cible Familier Gr3";
CHHT_TARGET_PARTYPET4_TARGET   = "Cible Familier Gr4";
CHHT_TARGET_OPTIONS            = 'Enemi Options';
CHHT_TARGET_SHOW_LEVEL_DIFF    = "Afficher Diff\195\169rence de niveau";
CHHT_TARGET_SHOW_MANA          = "Afficher Mana";
CHHT_TARGET_SHOW_RAGE          = "Afficher Rage";
CHHT_TARGET_SHOW_ENERGY        = "Afficher Energie";
CHHT_TARGET_SHOW_FOCUS         = "Afficher Focus (Familiers)";
CHHT_TARGET_CAST_ON_CHARMED    = "Lancer des sorts sur \195\168nemies sous contr\195\180le";
CHHT_TARGET_MOUSE_TITLE        = 'Enemi actions';
CHHT_TARGET_COLORS             = 'Couleurs';
CHHT_TARGET_PAGE1              = "Options";
CHHT_TARGET_PAGE2              = "Souris 1/3";
CHHT_TARGET_PAGE3              = "Souris 2/3";
CHHT_TARGET_PAGE4              = "Souris 3/3";
CHHT_TARGET_GROUP_LABEL_FORMAT = "Groupe %d";
CHHT_TARGET_TARGETING_KEEP     = 'Garder la cible en cours';
CHHT_TARGET_TARGETING_TARGET   = 'Cibler la cible';
CHHT_TARGET_TARGETING_INT      = 'Ciblage intelligent';
CHHT_COLOR_GROUP_LABEL_FORMAT  = 'Couleur Groupe %s';

-- ---------- PANIC ------------------------------------------------------------------
CHHT_PANIC_OPTIONS                     = 'Panique Options';
CHHT_PANIC_NO_BATTLEFIELD              = 'Hors champs de bataille';
CHHT_PANIC_IN_BATTLEFIELD              = 'Dans champs de bataille';
CHHT_PANIC_CURE_UNITS                  = "Traiter les unit\195\169s avec 'PANIQUE'";
CHHT_PANIC_UNMAPPED                    = "Utiliser mode 'PANIQUE' pour boutons non d\195\169finis";
CHHT_PANIC_CHECK_RANGE                 = "V\195\169rifie la plage de soins";
CHHT_PANIC_SPELL_DOWNGRADE             = "Minimiser les sursoins";
CHHT_PANIC_COMBAT_HEALING_IN_BATTLEFIELD="Toujours utilis\195\169 les sorts de combats";
CHHT_PANIC_MOUSE_TITLE                 = 'Panique actions';
CHHT_PANIC_BEHAVIOR                    = 'Panique comportement';
CHHT_PANIC_BEHAVIOR_LABEL              = "Modele de comportement mode Panique";
CHHT_PANIC_BEHAVIOR_SPELL_TITLE_FORMAT = "Spell %d";
CHHT_PANIC_BEHAVIOR_FORCE_CAST         = "force cast";
CHHT_PANIC_BEHAVIOR_CLASSES            = 'Classes';
CHHT_PANIC_BEHAVIOR_EMERGENCY_LEVELS   = 'Emergency Levels';
CHHT_PANIC_BEHAVIOR_SPELL_EDIT         = 'Configuration des Sorts';
CHHT_PANIC_PAGE1                       = "Options";
CHHT_PANIC_PAGE2                       = "Comportement";
CHHT_PANIC_PAGE3                       = "Souris 1/3";
CHHT_PANIC_PAGE4                       = "Souris 2/3";
CHHT_PANIC_PAGE5                       = "Souris 3/3";
CHHT_PANIC_TITLE_HEAL                  = 'PANIQUE: Soin';
CHHT_PANIC_TITLE_BUFF                  = 'PANIQUE: am\195\169liorations';
CHHT_PANIC_TITLE_FULL                  = 'Full spell range';
CHHT_PANIC_TITLE_TRASH                 = 'Trash healing';
CHHT_PANIC_TITLE_BATTLEFIELD           = 'Champs de bataille';
CHHT_PANIC_TITLE_CUSTOM1               = 'Personalis\195\169 1';
CHHT_PANIC_TITLE_CUSTOM2               = 'Personalis\195\169 2';
CHHT_PANIC_TITLE_CUSTOM3               = 'Personalis\195\169 3';

-- ---------- EXTRA ------------------------------------------------------------------
CHHT_EXTRA_LABEL         = "Titres";
CHHT_EXTRA_SHOW_COOLDOWN = "Montrer temps recharge de";
CHHT_EXTRA_OPTIONS       = 'Extra Options';
CHHT_EXTRA_HIDE_BUTTON   = "Cacher Bouton";
CHHT_EXTRA_PAGE1         = "Options";
CHHT_EXTRA_PAGE2         = "Souris 1/3";
CHHT_EXTRA_PAGE3         = "Souris 2/3";
CHHT_EXTRA_PAGE4         = "Souris 3/3";
CHHT_EXTRA_LABEL_FORMAT  = 'Extra %d';
CHHT_EXTRA_TITLE_FORMAT  = 'Boutons extra %d';

-- ---------- CHAINS -----------------------------------------------------------------
CHHT_CHAINS_BUTTON_ASSIGNMENT = 'D\195\169finition des boutons';
CHHT_CHAINS_CHAIN1            = "Enchain. 1";
CHHT_CHAINS_CHAIN2            = "Enchain. 2";
CHHT_CHAINS_CHAIN3            = "Enchain. 3";
CHHT_CHAINS_CHAIN4            = "Enchain. 4";
CHHT_CHAINS_NAME_FORMAT       = "Enchain %d";
CHHT_CHAINS_TITLE_FORMAT      = 'Param\195\169trage Enchain. %d ';

-- ---------- BUFFS ------------------------------------------------------------------
CHHT_BUFF_TITLE              = 'Am\195\169liorations Options';
CHHT_BUFF_EXPIRE_PLAY_SOUND  = "Jouer son quand l'am\195\169lioration a expir\195\169e";
CHHT_BUFF_EXPIRE_SHOW_MSG    = "Emettre un message quand l'am\195\169lioration a expir\195\169e";
CHHT_BUFF_WARN_PLAY_SOUND    = "Jouer son quand l'am\195\169lioration va expirer";
CHHT_BUFF_WARN_SHOW_MSG      = "Emettre un message quand l'am\195\169lioration va expirer";
CHHT_BUFF_SHOW_TRACKING_BUFF = "Afficher les recherches manquantes (Cueillette, Minage, Humanoides, ...)";
CHHT_BUFF_SHOW_RAID_EFFECTS  = "Afficher effets sur membres du raid (am\195\169lio. manquantes, Rem\195\168des actifs, ...)";
CHHT_BUFF_COMBINE_IN_PANIC   = "Indique les buffs manquant dans le bloc PANIQUE";
CHHT_BUFF_AVAILABLE_BUFFS    = 'Am\195\169liorations Disponibles';
CHHT_BUFF_ALLOWED_CLASSES    = 'Classes Autoris\195\169es';
CHHT_BUFF_ALLOWED_UNITS      = 'Unit\195\169es Autoris\195\169es';
CHHT_BUFF_BUFF_DATA          = 'Donn\195\169es d\'am\195\169lioration';
CHHT_BUFF_UPGRADE_Q          = "Lancer #PARTYSPELLNAME# si au moins (n) membres du #PARTYSPELLSPEC# ont en besoin";
CHHT_BUFF_UPGRADE_MSG        = "Upgrade unit spell";
CHHT_BUFF_IN_BATTLEFIELD     = "Cast in Battlefield";
CHHT_BUFF_PAGE1              = "Options";
CHHT_BUFF_PAGE2              = "Liste am\195\169lio.";
CHHT_BUFFS_NEVER_WARN        = "Jamais avertir";
CHHT_BUFFS_ALWAYS_WARN       = "Toujours avertir";
CHHT_BUFFS_WARN_EXPIRE_TITLE = "Avertir %s avant expiration";
CHHT_BUFFS_NEVER_REFRESH     = "Jamais reg\195\169n\195\169rer";
CHHT_BUFFS_ALWAYS_REFRESH    = "Toujours reg\195\169n\195\169rer";
CHHT_BUFFS_REFRESH_TITLE     = "Reg\195\169n\195\169rer %s avant expiration";

-- ---------- TOTEMSET ---------------------------------------------------------------
CHHT_TOTEMSET_LABEL_FORMAT            = "Totem Set %d";
CHHT_TOTEMSET_RESET_TIME_TITLE_FORMAT = "Reset time (%s)";
CHHT_TOTEMSET_SLIDER_TITLE_FORMAT     = "%d sec";

-- frFR
end
