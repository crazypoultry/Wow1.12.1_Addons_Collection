--French localization
--Initial french translation by ??
--French translation by Sasmira ( Cosmos Team )
--Update 07/22/2005
--Update 02/22/2006 by Arnaud

if (GetLocale() == "frFR") then

ServitudeProp = {};
ServitudeProp.Version = 060519.0;
ServitudeProp.Author = "Graguk";
ServitudeProp.AppName = "Servitude";
ServitudeProp.Label = ServitudeProp.AppName .. " (v" .. ServitudeProp.Version .. ")";
ServitudeProp.LongLabel = ServitudeProp.Label .. " par " .. ServitudeProp.Author;
ServitudeProp.CleanLabel = ServitudeProp.AppName .. " par " .. ServitudeProp.Author;
ServitudeProp.Description = "Un Addon permettant la gestion et le lancement automatique des comp\195\169tences des familiers de D\195\169moniste";

ServitudeConfigMenuTitle = ServitudeProp.Label;

VoidwalkerOptions = "Options du Marcheur du Vide";
ImpOptions = "Options du Diablotin";
SuccubusOptions = "Options de la Succube";
FelhunterOptions = "Options du Chasseur corrompu";
GeneralOptions = "Options G\195\169n\195\169rales";

InCombatDivider = "=== In/Out Combat Line ===";-- Don't translate in french !!
SpellLockDivider = "=== Spell Lock ===";-- Don't translate in french !!
ClassDivider = "=== Class Priority ===";-- Don't translate in french !!
BuffDatabaseTitle = "Debuff Priority";-- Don't translate in french !!
SpellDatabaseTitle = "Spell Lock";-- Don't translate in french !!
ClassDatabaseTitle = "Class Priority";-- Don't translate in french !!
FireShieldClassDatabaseTitle = "FS Class List";-- Don't translate in french !!

BINDING_HEADER_SERVITUDE = "Servitude";
BINDING_NAME_DOSERVITUDEOPEN = "Ouvrir le panneau de configuration de Servitude";
BINDING_NAME_DOPRIMARY = "Lancement des sorts Primaires";
BINDING_NAME_DOSECONDARY = "Lancement des sorts Secondaires";

ConfigObjectText =
{
	VWAutoShadow = "Alerte Consumer les ombres";
	VWAutoShadowRatio = "Pourcentage";
	VWAutoSacrif = "Alerte Sacrifice";
	VWAutoSacrifCombat = "En Combat Seulement";
	VWAutoSacrifPetRatio = "Pourcentage pour Familier";
	VWAutoSacrifPlayerRatio = "Pourcentage pour Joueur";
	VWSacrificeAlert = "Alerte Vocale Sacrifice";

	ImpSmartFireshield = "Bouclier Optimis\195\169 - Grp/Raid";
	ImpSmartFireshieldNeutral = "OFF en villes Neutres";
	ImpSmartFireshieldSolo = "Bouclier Optimis\195\169 - Solo";
	ImpSmartFireshieldAlways = "Bouclier Opt. permanent";
	ImpFireShieldAlert = "Alerte : Bouclier de Feu";
	
	ScbAutoInvisib = "Alerte Invisibilit\195\169";
	ScbAutoInvisibManaRatio = "Min Mana pour Invi.";
	ScbInvisDelay = "D\195\169lai Invi. apr\195\168s Combat";
--	ScbSeduceFollow = "Follow on Seduce break";
	ScbSeduceCOS = "MdT sur S\195\169duction";
	ScbSeduceCOE = "MdE sur S\195\169duction";
--	ScbAlwaysSeduce = "Re-Seduce on break";
	ScbSeduceAlert = " Alerte S\195\169duction";
	ScbSeduceAnnounce = "Rapport de S\195\169duction en Groupe";	
	ScbSeduceAnnounceRaid = "Rapport de S\195\169duction en Raid";	

	FHNonCombatDevour = "Alerte Festin Magique apr\195\168s le Combat";
	FHHungerDevour = "Chasseur corrompu affam\195\169";
	FHHungerDevourRatio = "Pourcentage";
	FHPartyDevour = "Festin sur Groupe";
	FHDevourSelf = "Chasseur en 1er";
	FHDevourPets = "Raid/Grp Pets";
	FHDevourIgnoreSelf = "Ignorer Chasseur";
	FHRaidDevour = "Festin sur Raid";
	FHDevourMindVision = "D\195\169vorer Vision T\195\169l\195\169pathique";
	FHSpellLockPVP = "Verrou Magic JcJ";
	FHSpellLockPVE = "Verrou Magic JcE";
	FHDisableNotification = "D\195\169sactiver la notification des Sorts/Debuff";
	FHClassAsPriority = "D\195\169vorer / Classe";
	FHPriorityUnitOnly = "D\195\169vorer que sur les unit\195\169s pioritaires";
	FHDevourAlert = "Alerte Festin Magic";
	FHSpellLockAlert = "Alerte Verrou Magique";
	
	OneButton = "Mode un Bouton";
	HealthWarning = "Alerte Vie du Pet";
	HealthWarningRatio = "Vie du Pet en Pourcentage";
	HealthWarningVocal = "Alerte Vocale Soins";
}

ConfigObjectTooltip =
{
	VWAutoShadow = "Alerte le joueur apr\195\168s le combat si les points de vie du Marcheur du Vide sont en dessous du pourcentage sp\195\169cifi\195\169 afin de lancer Consumer les ombres.";
	VWAutoSacrif = "Alerte le joueur du Sacrifice du Marcheur du Vide pendant le combat si ses points de vie perdus ou celle du joueur sont en dessous du pourcentage sp\195\169cifi\195\169. (Note: Ne se d\195\169clenchera pas si une quantit\195\169e massive de dommages est prise sur une courte dur\195\169e)";
	VWAutoSacrifCombat = "L\'Alerte Sacrifice se d\195\169clenchera seulement en combat.";
	VWSacrificeAlert = "Une Alerte Vocale sera jou\195\169e lorsque la vie du joueur ou du Marcheur du Vide est en dessous du pourcentage sp\195\169cifi\195\169.";
	
	ImpSmartFireshield = "En Raid/Groupe, le Diablotin devra lancer Bouclier de Feu sur les classes de m\195\169l\195\169es.";
	ImpSmartFireshieldNeutral = "Le Diablotion ne lancera pas Bouclier de Feu dans les villes neutres. Il annulera le Bouclier de Feu sur les joueurs ce trouvant au m\195\170me endroit.";
	ImpSmartFireshieldSolo = "Le Diablotin lancera Bouclier de Feu sur le D\195\169moniste si celui-ci n\'est pas en Raid/Groupe.";
	ImpSmartFireshieldAlways = "Le Diablotin lancera Bouclier de Feu sur tous les membres du groupe s\'ils sont \195\160 port\195\169e du sort, sans se soucier de la classe.";
	ImpFireShieldAlert = "En fonction de la configuration, une alerte vocale sera jou\195\169e lorsque le Diablotin d\195\169tectera une unit\195\169 n\195\169cessitant un Bouclier de Feu.";
		
	ScbAutoInvisib = "Alerte le joueur lorsque la Succube peut lancer Invisibilit\195\169 Mineure apr\195\168s le combat et si elle n\'est pas D\195\169buff. Le slider au minimum de mana de la Succube pour les utilisateurs du Pacte Noir.";
	ScbInvisDelay = "Si coch\195\169, la succube attendra 10 secondes apr\195\168s la fin du combat avant d\'alerter le joueur que l\'invisibilit\195\169 est disponible - ceci tient compte du temps de Pacte Noir.";
--	ScbSeduceFollow = "Succubus will follow the player after the target of seduction has been damaged, instead of attacking it.";
--	ScbAlwaysSeduce = "Succubus will re-seduce even when the target is damaged. This option will override the Follow on Seduce Break option.";
	ScbSeduceAlert = "Une alerte vocale sera jou\195\169e lorsque la Succube d\195\169tecte que S\195\169duction est termin\195\169e ou qu\'elle a \195\169t\195\169 cass\195\169e par un ennemi.";
	ScbSeduceCOS = "Activ\195\169, le joueur lancera Mal\195\169diction des T\195\169n\195\168bres sur la cible pendant que la Succube s\195\169duit pour la premi\195\168re fois.";
	ScbSeduceCOE = "Activ\195\169, le joueur lancera Mal\195\169diction des El\195\169ments sur la cible pendant que la Succube s\195\169duit pour la premi\195\168re fois. MdT sur S\195\169duction sera prioritaire si elle est activ\195\169e.";
	ScbSeduceAnnounce = "Activ\195\169, le joueur annoncera la cible initiale de S\195\169duction dans le canal Groupe.";
	ScbSeduceAnnounceRaid = "Activ\195\169, le joueur annoncera la cible initiale de S\195\169duction dans le canal Raid.";

	FHNonCombatDevour = "Le Chasseur corrompu cherchera et d\195\169vorera les d\195\169buffs sur lui-m\195\170me ou sur un joueur apr\195\168s le combat.";
	FHHungerDevour = "Le Chasseur corrompu cherchera et d\195\169vorera les d\195\169buffs sur lui-m\195\170me ou sur un joueur pendant le combat si ses points de vie passe en dessous du pourcentage sp\195\169cifi\195\169.";
	FHPartyDevour = "Le Chasseur corrompu lancera Festin Magique sur les membres du Groupe.";
	FHDevourSelf = "Le Chasseur corrompu commencera par lui-m\195\170me le lancement de Festin Magique";
	FHDevourIgnoreSelf = "Ne jamais lancer Festin magique sur le Chasseur corrompu. Cette option \195\169crasera l\'option du lancement sur lui m\195\170me.";
	FHRaidDevour = "Le Chasseur corrompu lancera Festin Magique sur les membres du Raid.";
	FHDevourPets = "Activ\195\169, ceci scannera le Raid/Groupe/Familier si l\'option correspondante de scan de Raid/Groupe est permise.";
	FHDevourMindVision = "Vision T\195\169l\195\169pathique est souvent utilis\195\169e par des joueurs alli\195\169s, mais peut apparaitre comme un D\195\169buff. Selectionner cette option si vous voulez qu\'elle soit d\195\169vor\195\169e tout le temps.";
	FHSpellLockPVP = "Verrou Magique sur la cible en mode JcJ.";
	FHSpellLockPVE = "Verrou Magique sur la cible en mode JcE.";
	FHDisableNotification = "Cette option d\195\169sactive dans Servitude, la notification d\'\195\169tude d\'un nouveau sort ou d\195\169buff.";
	FHClassAsPriority = "Si coch\195\169, les Classes Prioritaires dans la database seront utilis\195\169es, par ordre de pr\195\169f\195\169rence, lors du Festion Magique.";
	FHPriorityUnitOnly = "Le Festin Magique automatique scannera seulement les d\195\169buffs sur les unit\195\169s prioritaires. Il ignorera tous autres membres du Raid/Groupe, y compris le joueur et le Chasseur corrompu.";
	FHDevourAlert = "En fonction de la configuration, une alerte vocale sera jou\195\169e lorsque le Chasseur corrompu d\195\169tectera une unit\195\169 n\195\169cessitant un Festin Magique.";
	FHSpellLockAlert = "Une alerte vocale sera jou\195\169e lorsque le Chasseur corrompu d\195\169tecte que votre cible commence \195\160 lancer un sort, vous lui direz \195\160 ce moment de lancer un Verrou Magique.";
	OneButton = "Activ\195\169, la gestion du familier peut \195\170tre ex\195\169cut\195\169e uniquement avec le bouton Primaire . Le bouton Secondaire sera utilis\195\169 pour S\195\169duction/Re-S\195\169duction ainsi que Festin Magique sur votre cible.";
	HealthWarning = "Activ\195\169, Servitude vous alertera lorsque la vie du familier sera en dessous du pourcentage sp\195\169cifi\195\169.";
	HealthWarningVocal = "Une alerte vocale sera jou\195\169e lorsque la vie du familier sera en dessous du pourcentage sp\195\169cifi\195\169.";
}

ServitudeChatMsg = 
{
	SoothingKissToggleError = "Baiser Apaisant est actuellement control\195\169 par Servitude. Le lancement automatique des sorts par d\195\169faut va \195\170tre remplac\195\169 pendant le combat.";
	LOPToggleError = "Fouet de Douleur est actuellement control\195\169 par Servitude. Le lancement automatique des sorts par d\195\169faut va \195\170tre remplac\195\169.";
	AutoTauntToggleError = "Provocation est actuellement control\195\169 par Servitude. Le lancement automatique des sorts par d\195\169faut va \195\170tre remplac\195\169 pendant le combat.";
	ImpSmartFireshieldToggleError = "Fire Shield est actuellement control\195\169 par Servitude. Le lancement automatique des sorts par d\195\169faut va \195\170tre remplac\195\169 au prochain scan du joueur.";
	ImpSmartFireboltToggleError = "Eclair de Feu est actuellement control\195\169 par Servitude. Le lancement automatique des sorts par d\195\169faut va \195\170tre remplac\195\169.";
	FHSpellLockToggleError = "Verrou Magique est actuellement control\195\169 par Servitude. Le lancement automatique des sorts par d\195\169faut va \195\170tre remplac\195\169 en combat.";
	LoadDefault = "Configuration par d\195\169faut lanc\195\169e.";
	ObjectLoadFail = "Erreur! Lancement de l\'objet \195\169chou\195\169 :";
	ObjectSaveFail = "Erreur! Sauvegarde de l\'objet \195\169chou\195\169e :";
	WelcomeMsg = ServitudeProp.CleanLabel .. " Membre du corps des D\195\169monistes (Lignes de commande : /servitude help ou /serv help)";
	NewDebuffObserved = "Un nouveau D\195\169buff magique a \195\169t\195\169 observ\195\169 :";
	NewSpellObserved = "Un nouveau Sort a \195\169t\195\169 observ\195\169 :";
	DebuffDatabaseCorrupted = "La Database des D\195\169buffs est corrompue ou vide. La Database par d\195\169faut est lanc\195\169e.";
	SpellDatabaseCorrupted = "La Database des Verrous Magiques est corrompue ou vide. Database nettoy\195\169e.";
	ClassDatabaseCorrupted = "La Database des Classes est corrompue ou vide. La Database par d\195\169faut est lanc\195\169e.";
	FireShieldClassDatabaseCorrupted = "La Database de Bouclier de Feu par Classe est corrompue ou vide. La Database par d\195\169faut est lanc\195\169e.";
	DebuffDatabaseVerified = "Nombre de D\195\169buffs entr\195\169s dans la database :";
	SpellDatabaseVerified = "Nombre de Verrous Magiques entr\195\169s dans la database :";
	SeductionMessage = " is being Seduced! Avoid the Hearts <3 <3";
}

ServitudeNotificationMsg =
{
	InvisNotification = "Invisibilit\195\169 Mineure";
	SpellLockPVP = "Verrou Magique !";
	SpellLockPVE = "Verrou Magique !";
	SeductionNotification = "Re-S\195\169duire MAINTENANT !";
	Sacrifice = "Sacrifice MAINTENANT !";
	ConsumeShadows = "Consumer les ombres";
	DebuffsDetected = "Festin Magique MAINTENANT !";
	FireShieldRequired = "Bouclier de Feu !";
	ServitudeAlertTest = "!!! TEST !!!. D\195\169placez cette fen\195\170tre dans la zone la plus lisible.";
	HealthLow = "Votre Familier est entrain de mourir";
	Primary = " (Primaire)";
	Secondary = " (Secondaire)";
}

	ServitudeLocalization = 
	{
		Class = "D\195\169moniste";
		Class2 = "Guerrier";
		Class3 = "Chaman";
		Class4 = "Paladin";
		Pet1 = "Diablotin";
		Pet2 = "Marcheur du Vide";
		Pet3 = "Succube";
		Pet4 = "Chasseur corrompu";
		Pet5 = "Garde funeste";
		Magic1 = "Invisibilit\195\169 mineure";
		Magic2 = "Baiser apaisant";
		Magic3 = "Consumer les ombres";
		Magic4 = "Sacrifice";
		Magic5 = "Festin magique";
		Magic6 = "Tourment";
		Magic7 = "Bouclier de feu";
		Magic8 = "S\195\169duction";
		Magic9 = "Verrou magique";
		Magic10 = "Dissiper Magie";
		Magic11 = "Fouet de la douleur";
		Magic12 = "Bannir";
		Magic13 = "Eclair de feu";
		Magic14 = "Souffrance";
		Magic15 = "Malédiction des Ténèbres";
		Magic16 = "Malédiction des Eléments";
		Buff1 = "SacrificialShield";
		Buff2 = "Nature_Swiftness";
		Buff3 = "LesserInvisi";
		Buff4 = "Vision t\195\169l\195\169pathique";
		Buff5 = "Sommeil sans r\195\170ves";
		Buff6 = "Bouclier de feu";
		Buff7 = "Epines";
		Buff8 = "Lien spirituel";
		Buff9 = "Pacte de sang";
		Buff10 = "Aura de R\195\169tribution";
		Buff11 = "Parano\195\175a";
		Buff12 = "Contrôle Mental";
		Bufftype = "Magie";
		NoDesc = "Texte non trouv\195\169";
		CastString = "(.+) commence \195\160 lancer (.+).";
		SedString = "(.+) commence \195\160 lancer S\195\169duction";
		FadeString = "S\195\169duction sur (.+) vient de se dissiper";
		DarkPactString = "Vous drainez %d+ Mana à";
	}	

end

FR_Magical_Debuff_List = {
	["Corruption"] = "54 points de dégâts d'ombre toutes les 3 secondes.",
	["Marque du chasseur"] = "Tous les attaquants gagnent 110 points de puissance d'attaque à distance contre cette cible.",
	["Nova de givre"] = "Immobilisé.",
	["Marteau de la justice"] = "Etourdi.",
	["Explosion sonore"] = "Ne peut pas lancer de sorts.",
	["Eclair de givre"] = "Mouvement réduit à 60 %.",
	["Drain de mana"] = "Le lanceur de sort draine 138 points de mana par seconde.",
	["Flammes sacrées"] = "Points de dégâts de Feu toutes les 2 sec.",
	["Torpeur"] = "Endormi.",
	["Métamorphose"] = "Ne peut pas attaquer ou lancer de sorts. Vitesse de récupération des points de vie augmentée.",
	["Frappe fantôme"] = "Réduit l’armure de 100, Camouflage ou Invisibilité impossibles.",
	["Immolation"] = "73 dégâts de Feu toutes les 3 secondes.",
	["Rugissement glacial"] = "Assommée.",
	["Hurlement de terreur"] = "Fuit terrorisé.",
	["Acide corrosif"] = "Armure réduite de 736.",
	["Champignon de Mirefin"] = "Vitesse de déplacement réduite à 50% de la normale.",
	["Fragilité"] = "Toutes les caractéristiques sont réduites de 10,",
	["Faiblesse"] = "Vitesse de déplacement réduite à 50% de la normale. La vitesse d'attaque est réduite de 50%. La Force est réduite de 50%.",
	["Peur"] = "Apeuré.",
	["Bannir le Démon"] = "Etourdi.",
	["Sommeil cristallin"] = "Assommée.",
	["Effet Piège explosif"] = "33 points de dégâts de Feu toutes les 2 secondes.",
	["Détection de la magie"] = "Détection de la Magie.",
	["Pétrifier"] = "Assommé. Armure augmentée de 30%.",
	["Hex"] = "Sous l'effet de l'Hex.",
	["Rafale de flammes"] = "Les points de dégâts de Feu subis sont augmentés de 30,",
	["Gelé"] = "Vitesse d'attaque réduite de 20%. Vitesse de déplacement réduite à 70% de la normale.",
	["Bannir"] = "Invulnérable, mais incapable d'agir.",
	["Intimidation"] = "Fuit effrayé.",
	["Fouet malveillant"] = "Les points de dégâts physiques subis sont augmentés de 43 à 57.",
	["Trait de choc"] = "Vitesse de déplacement réduite à 50% de la normale.",
	["Aveuglement"] = "Aveuglé.",
	["Transi"] = "Mouvement réduit à 70 % et attaques réduites de 20 %.",
	["Hurlement terrifiant"] = "Fuit effrayé.",
	["Horion de givre"] = "Mouvement réduit à 50 % de la vitesse normale.",
	["Vulnérabilité au feu"] = "Augmente les dégâts de Feu subis de 4.",
	["Siphon de vie"] = "Draine 45 points de vie au lanceur de sorts toutes les 3 secs.",
	["Coup fané"] = "Vitesse d'attaque réduite de 33%.",
	["Silence"] = "Ne peut pas lancer de sorts.",
	["Bombe fumigène"] = "Assommée.",
	["Coupure d'ailes améliorée"] = "Immobilisé.",
	["Vision télépathique"] = "Vue par les yeux de la cible.",
	["Linceul de vents"] = "Assommée.",
	["Horion de flammes"] = "Dégâts de Feu toutes les 3 sec.",
	["Lenteur"] = "Vitesse d'attaque réduite de 35%. Vitesse de déplacement réduite à 40% de la normale.",
	["Jugement de justice"] = "Ne peut pas fuir.",
	["Effet Piège givrant"] = "Gelé.",
	["Sarments"] = "Enraciné. Inflige 25 points de dégâts toutes les 3 secondes.",
	["Coup de bouclier - silencieux"] = "Réduit au silence.",
	["Jugement d'autorité"] = "38 dégâts Sacrés subis lorsque étourdi.",
	["Geler sur place"] = "Assommé. 108 à 122 points de dégâts de givre infligés toutes les 3 sec.",
	["Effet Piège gelant"] = "Gelé.",
	["Drain de vie"] = "Le lanceur de sort draine 71 points de vie par seconde.",
	["Effet de Corruption sanguine"] = "Puissance d'attaque réduite de 120,",
	["Effrayer une bête"] = "Effrayé.",
	["Mot de l'ombre : Douleur"] = "Points de dégâts d'ombre infligés toutes les 3 sec.",
	["Fracas de vagues"] = "Assommée.",
	["Trait de glace"] = "Immobilisation.",
	["Lien à la terre"] = "Vitesse de déplacement réduite à 50% de la normale.",
	["Jugement de sagesse"] = "Les attaques et les sorts à votre encontre ont une chance de rendre 46 mana à l'attaquant.",
	["Rendre fou"] = "Charmé. Vitesse d'attaque augmentée de 50%. Vitesse de déplacement augmentée de 80%.",
	["Effet Piège immolation"] = "138 points de dégâts de Feu toutes les 3 secondes.",
	["Flèche de givre"] = "Vitesse de déplacement réduite à 40% de la normale.",
	["Cône de froid"] = "Mouvement réduit à 50 %.",
	["Conséquences"] = "Vitesse de déplacement réduite de 50%.",
	["Amplifier flammes"] = "Les points de dégâts de Feu subis sont augmentés de 100.",
	["Drainer la vie"] = "Le lanceur de sort draine 55 points de vie par seconde.",
	["Vulnérabilité à l'ombre"] = "Les points de dégâts d'ombre sont augmentés de 20%.",
	["Griffe de glace"] = "Vitesse d'attaque réduite de 50%.",
	["Jugement de lumière"] = "Les attaques de mêlée contre vous ont une chance de soigner l'attaquant pour 34,",
	["Jugement du Croisé"] = "Augmente les dégâts Sacrés subis de 110,",
	["Effet Piège de givre"] = "Vitesse de déplacement réduite à 40% de la normale.",
	["Coup de tonnerre"] = "Vitesse d'attaque réduite de 30%. Vitesse de déplacement réduite à 27% de la normale.",
	["Gel instantané"] = "Assommée.",
	["Drainer mana"] = "Le lanceur de sort draine 102 points de mana par seconde.",
	["Mot de l'ombre : Douleur"] = "Points de dégâts d'ombre infligés toutes les 3 sec.",
	["Séduction"] = "Séduit.",
	["Toucher débilitant"] = "Force réduite de 40, Endurance réduite de 40,",
	["Eclair de cristal"] = "Assommée.",
	["Inquisition"] = "Les points de dégâts du Sacré subis sont augmentés.",
	["Lucioles"] = "Réduit l’armure de 505, Camouflage ou Invisibilité impossibles.",
	["Geyser"] = "Vitesse de déplacement réduite à 50% de la normale.",
	["Terrifier"] = "Fuit effrayé.",
	["Eclat lunaire"] = "Points de dégâts des Arcanes infligés toutes les 3 sec.",
}

FR_Devour_Order = {
	[1] = "Hex",
	[2] = "Acide corrosif",
	[3] = "Explosion sonore",
	[4] = "Séduction",
	[5] = "Fracas de vagues",
	[6] = "Sommeil cristallin",
	[7] = "Métamorphose",
	[8] = "Silence",
	[9] = "Torpeur",
	[10] = "Hurlement de terreur",
	[11] = "Vulnérabilité à l'ombre",
	[12] = "Transi",
	[13] = "Rugissement glacial",
	[14] = "Eclair de cristal",
	[15] = "Lenteur",
	[16] = "Peur",
	[17] = "Corruption",
	[18] = "Immolation",
	[19] = "=== In/Out Combat Line ===",
	[20] = "Marque du chasseur",
	[21] = "Trait de choc",
	[22] = "Effet de Corruption sanguine",
	[23] = "Effet Piège explosif",
	[24] = "Flammes sacrées",
	[25] = "Mot de l'ombre : Douleur",
	[26] = "Drainer mana",
	[27] = "Marteau de la justice",
	[28] = "Jugement de lumière",
	[29] = "Drainer la vie",
	[30] = "Eclair de givre",
	[31] = "Inquisition",
	[32] = "Cône de froid",
	[33] = "Effet Piège de givre",
	[34] = "Nova de givre",
	[35] = "Effet Piège gelant",
	[36] = "Jugement du Croisé",
	[37] = "Vulnérabilité au feu",
	[38] = "Bannir",
	[39] = "Effet Piège immolation",
	[40] = "Eclat lunaire",
	[41] = "Lucioles",
	[42] = "Sarments",
	[43] = "Jugement de justice",
	[44] = "Geyser",
	[45] = "Trait de glace",
	[46] = "Horion de givre",
	[47] = "Conséquences",
	[48] = "Rafale de flammes",
	[49] = "Intimidation",
	[50] = "Coup de tonnerre",
	[51] = "Champignon de Mirefin",
	[52] = "Jugement d'autorité",
	[53] = "Effrayer une bête",
	[54] = "Griffe de glace",
	[55] = "Horion de flammes",
	[56] = "Coup de bouclier - silencieux",
	[57] = "Bombe fumigène",
	[58] = "Siphon de vie",
	[59] = "Coupure d'ailes améliorée",
	[60] = "Détection de la magie",
	[61] = "Amplifier flammes",
	[62] = "Linceul de vents",
	[63] = "Jugement de sagesse",
	[64] = "Pétrifier",
	[65] = "Fouet malveillant",
	[66] = "Flèche de givre",
	[67] = "Faiblesse",
	[68] = "Mot de l'ombre : Douleur",
	[69] = "Geler sur place",
	[70] = "Vision télépathique",
	[71] = "Drain de vie",
	[72] = "Hurlement terrifiant",
	[73] = "Terrifier",
	[74] = "Frappe fantôme",
	[75] = "Drain de mana",
	[76] = "Bannir le Démon",
	[77] = "Effet Piège givrant",
	[78] = "Aveuglement",
	[79] = "Fragilité",
	[80] = "Gel instantané",
	[81] = "Rendre fou",
	[82] = "Coup fané",
	[83] = "Lien à la terre",
	[84] = "Toucher débilitant",
	[85] = "Gelé",
}

FR_Spell_Lock_List = {
}

FR_Spell_Lock_Order = {
				[1] = "=== Spell Lock ===",
}

FR_Class_Order = {
				[1] = "Druide",
				[2] = "Chasseur",
				[3] = "Mage",
				[4] = "Paladin",
				[5] = "Prêtre",
				[6] = "Voleur",
				[7] = "Chaman",
				[8] = "D\195\169moniste",
				[9] = "Guerrier",
				[10] = "=== Class Priority ===",--Don't translate in french !!
}

