flagRSP est un addon destiné à enrichir l'expérience roleplay des joueurs. Il vous permet de paramétrer différents marqueurs et informations que les autres joueurs pourront voir. Une liste d'amis améliorée est également incluse.

Vous pouvez signaler les bugs (même les fautes/erreurs de traduction) ou envoyer des suggestions pour flagRSP&Friendlist à l'adresse suivante APRES AVOIR LU LA PARTIE DEPANNAGE:

flokru-flagrsp@flokru.gnuu.de

Le forum de discussion dédié à flagRSP se trouve à l'adresse suivante: 

http://www.fabledrealm.com/flagrsp

1. Documentation française

flagRSP&Friendlist sont basés sur xTooltip par Per 'Doxxan' Lönn Wege et flagRSP&Friendlist par Zmrzlina (qui a implémenté la plupart des fonctionnalités). Je (flokru) vais essayer de supporter cet addon et de continuer son développement.

Je tiens à remercier Zmrzlina  qui a rendu possible la création de cet addon! Il a malheureusement quitté le monde de WoW.

Notes pour la traduction française
----------------------------------
Pour des raisons de commodité, certains termes n'ont pas été traduits dans le jeu. En voici la liste, ainsi qu leur signification:

roleplay/roleplaying	jeu de rôle
roleplayer		joueur qui joue selon les modalités du jeu de rôle

rp			roleplay
hrp			hors-roleplay, qui ne se conforme pas aux pratiques du roleplay
ooc = out of charactère	fait de jouer sans endosser de rôle, de se comporter hrp
ic=in character		fait de jouer/se comporter rp



Fonctionnalités
---------------

Voici un apperçu des fonctionnalités de flagRSP&Friendlist:

-Définir un (parmi quatre) marqueur roleplaying pour montrer aux autres votre façon de jouer roleplay préférée.
-Donner un nom de famille à votre personnage, que les autres joueurs utilisant flagRSP pourront voir.
-Donner un titre à votre personnage.
-Entrer une description de l'apparence extérieure de votre personnage, que les autres joueurs pourront égalament voir.
-Mettre des joueurs de la faction opoosée dans votre liste d'amis (avec leur nom de famille).
-Marquer les guildes commes amies/ennemies.
-Marquer les PNJs/mobs comme amis/ennemis.
-Ecrire des notes correspondant aux autres joueurs/guildes/PNJs dans Friendlist.
-Remplacer les informations de niveau exact par des informations relatives (de "extremement vulnérable" à "imbattable").
-Cacher le noms des joueurs que vous ne connaissez pas.
-Configurer les marqueurs rp, vote nom et titre via une interface (qui sera encore développée).
-Un signal sonore vous indique un ennemi lorsque vous passez le curseur dessus.
-Voir vos propres marqueurs via une option spéciale qui montre un tooltip (boîte d'informations) dédié à votre personnage.
-Entièrement rétrocompatible avecxTooltip2.
-Remplacer les informations de niveau dans la targetframe.


Sur mon propre compte
---------------------

Malheureusement, j'ai découvert que certaines personnes parlent des bugs de flagRSP sur plusieurs forums internet. Parfois même, ces critiques considèrent flagRSP comme de la merde (ce que je trouve un peu exagéré). J'ai lu des choses sur des bugs dont je n'avais encore jamais entendu parler.

1. Je développe flagRSP de façon absolument bénévole, sans en retirer aucun profit financier.
2. Je ne suis pas un programmeur professionnel.
3. A cause de 1. et de 2., je peux faire des erreurs qui induisent des bugs.
4. Je n'ai jamais garanti quoi que ce soit.
5. flagRSP est devenu si complexe que je ne peux pas tester toutes ses possibilités.
6. J'essaie de développer un addon qui soit aussi exempt de bugs que possible.
7. Pour réussir 6., et à cause de 5., J'AI BESOIN QUE L'ON ME SIGNALE LES BUGS
8. La résolution de bugs est toujours ma priorité. Je ne peux résoudre que les bugs que je connais.


VERSIONS EXPERIMENTALES
-----------------------

Certaines versions de flagRSP sont des versions d'essai (preview releases). Veuillez noter les points suivants:

- Si vous voulez utiliser flagRSP sans rencontrer de problèmes, n'utilisez pas ces versions d'essai. Utilisez plutôt les versions définitives, plus stables.

- Les versions d'essai peuvent être EXTREMEMENT EXPERIMENTALES. Il y a à coup sûr des bugs dans ces versions. Peut-être en serez-vous affectés, peut-être pas. Je mets en ligne les versions d'essai pour que les utilisateurs qui le souhaitent testent les toutes nouvelles fonctionnalités.

- Certaines fonctionnalités ne fonctionneront sûrement (ou peut-être) pas -des boutons qui ne contrôlent rien, etc. Si vous pensez avoir découvert un bug, veuillez vérifier d'abord dans le journal de changements (changelog). Peutêtre que la fonctionnalité n'a pas encore été implémentés, et ne peut par conséquent pas marcher.

- Si vous utilisez une version d'essai et que vous découvrez un bug, veuillez le signaler! Ces versions sont mises en ligne pour que l'on repère les bugs. Certains bugs n'apparaissent jamais chez moi. Ce n'est qu'en recevant des informations sur les bugs découverts que je pourrais développer une vresion plus stable.


Installation
------------

L'installation est simple, extrayez juste le ficher zip dans votre répertoire World of Warcraft (soyez sûr d'extraire les structures de dossiers, et pas seulement les fichiers eux-mêmes) ou sélectionnez votre répertoire World of Warcraft si vous utilisez l'installateur. Une fois cela fait, les addons devraient fonctionner.

Un message dans votre fenête de discussion devrait vous informer que flagRSP est en train de s'initialiser. Après environ une minute, un message doit vous informer que flagRSP a été initialisé. De plus, il devrait y avoir un nouveau bouton pour Friendlist au bord de la minicarte.

IMPORTANT: normalement, les étapes suivantes ne sont pas nécessaires. Malheureusement, pour des raisons inconnues,il y a parfois des dysfonctionnements.

Après l'installation, vous devez vérifier que flagRSP peut joindre correctement le canal de messages "xTensionTooltip2". Normalement, il le fait automatquement APRES UNE OU DEUX MINUTES (après que flagRSP a signalé qu'il était initialisé). Cependant, dans certaines circonstances mal définies (en général en conjonction avec Cosmos) cela peut échouer.

En conséquence, déplacez votre curseur sur votre fenêtre principale de messagerie pour faire apparaître l'onglet "général". Cliquez dessus, la liste de tous les canaux actifs est accessible via "canaux".

Dans cette liste, vous devriez voir "xTensionTooltip2". SI CE N'EST PAS LE CAS, VOUS DEVREZ REJOINDRE CE CANAL MANUELLEMENT. Pour ce faire, entrez la commande: 

/join xTensionTooltip2

Aprsè cela, le canal devrait apparraître dans la liste, même après un redémarrage du jeu. Si cen'est pas le cas, informez-m'en par email.

Ce canal est la fonction centrale de flagRSP. Le seul rôle de ce canal est d'envoyer vos marqueurs/informations aux autres utilisateurs de flagRSP. Leur addon écoute ce canal pour savoir quoi afficher dans le tooltip. C'est le seul mode de communication entre différents clients.

Cacher ce canal est évidemment une bonne idée pour que votre jeu ne soit pas constamment affecté par les messages de ce canal. Cacher les messages d'un canal n'est pas quitter un canal. Si vous quittez le canal, l'addon ne pourra fonctionner correctement car il ne pourra plus communiquer avec les auters clients. 

Mais cela ne signifie pas que vous devez afficher les informations dans votre fenête de discussion. Wow vous permet de créer plusieurs fenêtres de messageries et de les allouer à certains canaux, qui ne seront plus affichés que dans celle-ci. De la même façon, vous pouvez cacher tous les canaux de toutes les fenêtres (même si vous n'en avez qu'une) Techniquement, en faisant cela, vous ne quittez pas le canal, vous cessez juste d'afficher ses informations.


SECURITE
--------

Cette partie est très importante. flagRSP n'est pas capable d'écrire ses propres informations dans un fichier séparé. Ainsi, flagRSP NE PEUT faire de sauvegardes d'aucun des paramètres que vous avez défini, ni de vos informations de Friendlist ou de votre description!

flagRSP peut signaler à WoW quelles données doivent être sauvagardées pour flagRSP. Cependant, WoW peut supprimer ces données à tout moment si quelque chose se passe mal. Cette "garbage collection" est en général très utile pour ne pas encombrer inutilement la mémoire disponible après avoir désinstallé des addons nécessitant beaucoup de mémoire vive. WoW supprime simplement les informations das anciens addons pour ne pas que vous ayez à vous en occuper.

Cependant, il peut être très gênant de perdre touts vos informations de Friendlist ou vos descriptions à cause d'un problème de WoW.  Il faudrait donc sauvegarder ces informations le plus souvent possible!

Voici comment sauvegarder vos paramètres: vous trouverez dans votre répertoire World of Warcraft un dossier nommé WTF. Dans WTF\Account\<votre nom de compte>\Savedvariables\, il y a plusieurs fichiers .lua et .lua.bak. Pour flagRSP, nous avons besoin de flagRSP.lua et Friendlist.lua. Copiez ces deux fichiers dans un dossier où ils seront en sécurité.

Si quelque chose tourne mal (si WoW supprime vos paramètres), vous n'aurez qu'à copier ces fichiers sauvagardés dans WTF\Account\<votre nom de compte>\Savedvariables\.


Utilisation
-----------

Pour accéder aux lignes de commande de flagRSP, tapez "/rsp [options]" dans votre fenête de message. Voici un apperçu des commandes disponibles:

/rsp ?						Affiche l'aide
/rsp toggle					(Dés)active le marqueur roleplayer
/rsp names					(Dés)active l'affichage des noms inconnus
/rsp level					(Dés)active l'affichage alternatif des niveaux
/rsp ranks					(Dés)active l'affichage des rangs PvP
/rsp guilds					(Dés)active l'affichage des noms de guilde
/rsp susrname <TEXTE>				Définit votre surnom
/rsp title						Définit votre titre
/rsp [beginner/casual/normal/fulltime/off]		Définit votre style de jeu roleplay préféré:
	beginner				Roleplayer débutant, par ex. en nouveau joueur s'essayant au rp. On
						lui pardonnera ses erreurs.
	casual					Casual roleplayer, par ex. un joueur qui a besoin, ou qui au moins
						accepte le dialogue ooc.
	normal					Normal roleplayer, par ex. un joueur qui ne veut pas de dialogue ooc
						en général, mais qui l'accepte si besoin est.
	fulltime					Fulltime roleplayer, par ex. un joueur qui rejette strictement 
						le dialogue ooc et qui joue son rôle en permanence.
	off					Désactive tout marqueur roleplayer.
/rsp [ooc/ic/ffa-ic/stopcharstat]			Définit le statut du personnage:
	ooc					Out of character, le joueur ne joue pas son rôle.
	ic					In character, le joueur joue son rôle!
	ffa-ic					In character free-for-all, comme ic mais le joueur souhaite interagir
						avec d'autres joueurs.
	st					Stooryteller. Un joueur qui guide le rp.
	stopcharstat				Désactive le marqueur de statut du personnage.
/rsp afk						Vous met en mode ABS et arrête l'envoi de vos marqueurs (qui
						interrompraient l'ABS normal)
/rsp edit						Ouvre une fenête pour entrer votre description
/rsp status					Donne un apperçu des options pour le personnage actuel
/rsp owntooltip					(Dés)active  le tooltip affichant les infos de votre personnage
/rsp stat					Affiche des statiqtiques d'usage
/rsp toggletooltip				(Dés)active  les modifications de tooltip de flagRSP. Vous pouvez
						ainsi cesser de modifier le tooltip par défaut.
/rsp purgeinterval				Définit la période durant laquelle flagRSP sauvegarde en cache les 
						marqueurs (en jours, 14 jours par défaut)
/rsp standby					Force flagRSP à quitter le canal d'informations (pour des questions
						de performances). Voir le changelog pour plus de détails.
/rspon						Active le marqueur normal roleplayer et l'affichage alternatif des noms
						et des niveaux.
/rspoff						Désactive le marqueur roleplayer, l'affichage alternatif des noms
						et des niveaux et supprime le nom de famille et le titre.


Vous pouvez accéder aux options de Friendlist via la commande "/fl" et "/friendlist" Voici un apperçu des options disponibles.

/fl						Affiche l'aide
/fl help					Affiche l'aide
/fl show					Ouvre la fenêtre de Friendlist
/fl hide					Ferme la fenêtre de Friendlist
/fl mm <an/aus>				Affiche (an) ou non (aus) le bouton au bord de la minicarte
/fl ass <NOM> <NOM DE FAMILLE>	Ajoute le joueur <NOM> et son nom  <NOM DE FAMILLE> dans Friendlist
/fl addguild <Nom>			Ajoute la guilde <NOM> dans Friendlist
/fl del <NOM>				Enlève le joueur/la guilde <NOM> de Friendlist
/fl reset					 
/fl import					Importe la liste d'amis de WoW dans votre Friendlist
/fl export					Exporte votre Friendlist dans la liste d'amis de WoW
/add <NOM> <NOM DE FAMILLE> <NOTE>	Ajoute le joueur <NOM> avec son <NOM DE FAMILLE> ainsi que ses <NOTE> à Friendlist


Options avancées
----------------

A propos de l'Infobox et d'autres nouvelles fonctionnalités apparues avec la version 0.4.0: certaines options ne peuvent être configurées via la fenête GUI ou les lignes de commande.

Ces options doivent être configurées à la main (si vous voulez modifier la configuration par défaut) tant que le GUI n'est pas terminé.

Voyez à la fin du fichier Interface\Addons\flagRSP\settings.lua connaître le fonctionneement de ces options supplémentaires.