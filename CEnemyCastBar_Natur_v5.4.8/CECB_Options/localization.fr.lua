if ( GetLocale() == "frFR" ) then

-- Options Menue
CECB_status_txt = "Activer EnemyCastBar Mod";
CECB_pvp_txt = "Activer |cffffffaaPvP/Commun|r CastBars ";
 CECB_globalpvp_txt = "Afficher CastBars toutes les cibles";
 CECB_gains_txt = "Activer les types de sorts 'gagn\195\169\'";
  CECB_gainsonly_txt = "Seulment les 'gagn\195\169\s'";
 CECB_cdown_txt = "Activer quelque CoolDownBars";
  CECB_cdownshort_txt = "Afficher SEULEMENT les CDs courts";
  CECB_usecddb_txt = "Use a CoolDown Database";
 CECB_spellbreak_txt = "Pas de CastBreaks en Raid";
CECB_pve_txt = "Activer |cffffffaaPvE/Raid|r Castbars";
 CECB_pvew_txt = "Jouer un son";
CECB_afflict_txt = "Afficher |cffffffaaDebuffs";
 CECB_globalfrag_txt = "Afficher les Debuffs hors-cible";
 CECB_magecold_txt = "Effets de glace et vuln\195\169rabilit\195\169";
 CECB_solod_txt = "Afficher 'Solo Debuffs' (Stuns)";
  CECB_drtimer_txt = "Consid\195\169rer 'Effet Diminu\195\169'";
  CECB_classdr_txt = "Consid\195\169rer 'EDs' sp\195\169cifique de classe  ";
 CECB_sdots_txt = "Observer vos DoTs";
 CECB_affuni_txt = "SEULEMENT les Debuffs du Boss";
CECB_parsec_txt = "Analyser AddOn/Raid/PartyChat";
 CECB_broadcast_txt = "Broadcast CBs via le canal AddOn";
CECB_targetm_txt = "Clic-Gauche pour cibler";
CECB_timer_txt = "Afficher le temps de la CastBars";
CECB_tsize_txt = "R\195\169duire le texte dans les CastBars";
CECB_flipb_txt = "Inverser les CastBars";
CECB_flashit_txt = "'Clignotement' des CastBars \195\160 leur fin";
CECB_showicon_txt = "Afficher l\'icon du sort";
CECB_scale_txt = "Echelle: ";
CECB_alpha_txt = "Transparence: ";
CECB_numbars_txt = "Nombre Max. de CastBars: ";
CECB_space_txt = "Espace entre les CastBars: ";
CECB_blength_txt = "Largeur des CastBars ";
CECB_minimap_txt = "Position sur la MiniMap: ";
CECB_throttle_txt = "Rafraichissement Rapide: ";

CECB_status_tooltip = "Activer/ D\195\169activer l\'affichage des CastBars pendant le jeu.  Annule tous les \195\169v\195\169nements pour r\195\169duire le chargement de CPU.";
CECB_pvp_tooltip = "Active CastBars pour  tous les sorts communs des joueurs.";
 CECB_globalpvp_tooltip = "Affiche tout les PvPCastBars dans la gamme de votre journal de combat, au lieu de montrer seulement les CastBars de votre v\195\169ritable cible.\n\n|cffff0000Avertissement:|r Cela peut avoir pour r\195\169sultat beaucoup de CastBars a affich\195\169 rapidement!\n\n|cffff0000D\195\169tection ami/ennemi ne fonctionne pas avec ceci!";
 CECB_gains_tooltip = "Activer CastBars pour les types de sorts 'gagn\195\169\'.\nDes sorts comme 'Bloc de glace', 'Rage sanguinaire' et 'Heal over Time' (HoTs).";
  CECB_gainsonly_tooltip = "Seulment les 'gagn\195\169s' seront afficher. Leurs incantations seront ignor\195\169\s.";
 CECB_cdown_tooltip = "Activer les temps de CoolDown pour quelque(!) sorts, temps d'incantation ou les sorts 'gagn\195\169\'.";
  CECB_cdownshort_tooltip = "Afficher seulement les Cooldowns si leur dur\195\169e est de 60sec ou moins.";
  CECB_usecddb_tooltip = "Stores all recognized CoolDowns in Combatlog-Range into a Database and dynamically triggers the fitting CoolDowns for the selected target, in case the special CoolDowns were detected before.";
 CECB_spellbreak_tooltip = "Emp\195\170che la d\195\169tection des contre-sorts (PvP!) en Raid.\nCette option am\195\169liore l'ex\195\169cution et emp\195\170che une mauvaise d\195\169tection des contre-sorts en Raid.";
CECB_pve_tooltip = "Activer CastBars pour le PvE ou les Raids";
 CECB_pvew_tooltip = "Jouer un son quand une Raid CastBar fini.";
CECB_afflict_tooltip = "Afficher les Debuffs d\'immobilisations ex. '(M\195\169tamorphose)' ou 'Brise-genou'. Activ\195\169 simultanement beaucoup Debuffs de Boss qui peuvent \195\170tre lanc\195\169s sur les joueurs'.";
 CECB_globalfrag_tooltip = "Afficher les  CastBars , m\195\170me si le Mob affect\195\169e n\'est pas votre cible actuel.\n 'Entrave', 'Bannir', 'M\195\169tamorphose' etc.";
 CECB_magecold_tooltip = "Afficher les effets de glace suivant:\n'Nova de givre', 'Morsure de givre', 'Transi', 'Cône de froid' et 'Eclair de givre'.\nEn plus les vuln\195\169rabilit\195\169s (glace, feu, ombre) seront affich\195\169.";
 CECB_solod_tooltip = "Afficher les Stuns. Active aussi silence, peur, d\195\169sarmer et effets de menace!";
  CECB_drtimer_tooltip = "Consid\195\169rer 'Effet Diminu\195\169' pour la plupart des Stuns qui l\'utilise.\nIl en a  3 pour le guerrier, 3 pour le druide, 1  pour le Paladin et 1 pour le voleur.\n\nVous verrez qu\'une barre en bas affiche les 20sec, jusqu\'\195\160 ce que vous puissez effectuer le vrai Stun \195\160 nouveau.";
  CECB_classdr_tooltip = "Consid\195\169rer 'EDs' sp\195\169cifique de classe comme 'Assomer' et 'M\195\169tamorphose'.\n\n|cffff0000D\'habitude  ces minuteurs sont seulement actifs en JcJ|r et sont seulement affiché pour les classes correspondante.";
 CECB_sdots_tooltip = "Afficher la dur\195\169e de vos DoTs (ex. |cffffffff'Corruption' |r-|cffffffff 'Morsure de serpent'|r).\nles CastBars ne se renouveleront pas si le DoT est relanc\195\169 avant la fin! |cffff0000\n Conseil: renouveler le DoT \195\160 la fin de sa dur\195\169e ou le minuteur devient \'fou\'!|r\n\nLes DoTs qui affligent en plus des dommages imm\195\169diats renouvelleront la CastBar et n\'auront pas ce probl\195\168me (ex. |cffffffff'Immolation'|r)!";
 CECB_affuni_tooltip = "Annuler tout les Debuffs, sauf ceux du Boss, pour avoir un meilleur aper\195\167u g\195\169n\195\169ral.";
CECB_timer_tooltip = "Affiche en plus un Minuteur num\195\169rique en dessous des CastBars.";
CECB_targetm_tooltip = "S\195\169l\195\169ctionne le Mob avec un Clic-Gauche sur la CastBar par cette option.";
CECB_parsec_tooltip = "Tout les joueurs qui active cette option, recoive une CastBar sur leur \195\169cran, si une des commandes suivantes avec un temps apparait au d\195\169but, dans le canal Raid/Party/AddOn: '|cffffffff.countmin|r', '|cffffffff.countsec|r', '|cffffffff.repeat|r' ou '|cffffffff.stopcount|r' (s. Help).\n\nEx:\n|cffffffff.countsec 45 Until Spawn|r\n\nAu lieu de:\n|cffffffff/necb countsec 45 Until Spawn";
CECB_broadcast_tooltip = "Sorts et Debuffs du Raid seront diffus\195\169 grace au canal AddOn.\nCela fonctionne seulment si l\'annoceur et celui qui recois utilisent la m\195\170me langue!\n\n|cffff0000ATTENTION:|r Cette option doit \195\170tre seulement activ\195\169 par quelques uns des Joueurs choisis par le Raid!\nLes Sorts de JcJ ne seront pas transmis.";
CECB_tsize_tooltip = "R\195\169duit la taille du text pour permettre plus de lettres dans la castbars.";
CECB_flipb_tooltip = "Retourne la direction dans lesquelle apparaîssent les CastBars.\nNormalemant: De bas en haut.\nActivat\195\169: De haut en bas.";
CECB_flashit_tooltip = "CastBars avec un temps total d\'au moins 20sec , d\195\169but du \'clignotement\' apr\195\168s moins de 20% de la barre.\nMais au maximum les derni\195\168res 10sec sont \'clignot\195\169\'.";
CECB_showicon_tooltip = "Affiche l\'ic\195\180ne du sort a cot\195\169 de la Castbar.\n\nLa taille sera ajust\195\169 automatiquement grace \195\160 l\'option 'Espace entre les CastBars'.";
CECB_scale_tooltip = "Permet de changer la taille des CastBars de 30 jusqu\'\195\160 130 pourcent.";
CECB_alpha_tooltip = "Permet de changer la transparence des CastBars.";
CECB_numbars_tooltip = "R\195\168gle le maximum de CastBars affich\195\169 sur votre \195\169cran.";
CECB_space_tooltip = "R\195\168gle l\'espace entre CastBars. \n (par d\195\169faut est 20)";
CECB_blength_tooltip = "R\195\168gle la largeur suppl\195\169mentaire des CastBars.\n(d\195\169faut = 0)";
CECB_minimap_tooltip = "D\195\169place le Bouton de NECB autour de la MiniMap. \n\nD\195\169placer tout \195\160 gauche pour d\195\169activer le bouton!";
CECB_throttle_tooltip = "Rafraichissement par second pour les CastBars, le menu et la FPS Barre.\nCela exigera plus d'utilisation du CPU ! ";
CECB_fps_tooltip = "Cr\195\169e une barre de IPS qui peut \195\170tre d\195\169plac\195\169e librement.";


CECB_menue_txt = "Options";
CECB_menuesub1_txt = "Montrer quelle CastBars?";
CECB_menuesub2_txt = "Apparence des CastBars/Autre";
CECB_menue_reset = "R.A.Z";
CECB_menue_help = "Aides";
CECB_menue_colors = "Couleurs";
CECB_menue_mbar = "Barres Mobiles";
--CECB_menue_close = "Fermer";
CECB_menue_rwarning = "|cffff0000WARNING!|r\n\nToutes valeurs et les positions seront \nrestaur\195\169s 'configs de base'!\nVoulez-vous vraiment un retour \n\195\160 l\'\195\169tat initial \196\177 ";
CECB_menue_ryes = "Oui";
CECB_menue_rno = "Non!";
CECB_minimapoff_txt = "off";


end
