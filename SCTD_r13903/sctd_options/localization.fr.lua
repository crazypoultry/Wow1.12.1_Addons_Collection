--Traduction par Culhag

if GetLocale() ~= "frFR" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "D\195\169g\195\162ts de m\195\170l\195\169e", tooltipText = "Active ou d\195\169sactive l\'affichage de vos d\195\169g\195\162ts de m\195\170l\195\169e"};
SCT.LOCALS.OPTION_EVENT102 = {name = "D\195\169g\195\162ts p\195\169riodiques", tooltipText = "Active ou d\195\169sactive l\'affichage de vos d\195\169g\195\162ts p\195\169riodiques"};
SCT.LOCALS.OPTION_EVENT103 = {name = "D\195\169g\195\162ts des sorts", tooltipText = "Active ou d\195\169sactive l\'affichage des d\195\169g\195\162ts de vos sorts"};
SCT.LOCALS.OPTION_EVENT104 = {name = "D\195\169g\195\162ts du familier", tooltipText = "Active ou d\195\169sactive l\'affichage des d\195\169g\195\162ts de votre familier"};
SCT.LOCALS.OPTION_EVENT105 = {name = "Colorer les critiques", tooltipText = "Active ou d\195\169sactive l\'affichage des critiques de la couleur s\195\169lectionn\195\169e"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "Activer SCT - Damage", tooltipText = "Active ou d\195\169sactive SCT - Damage"};
SCT.LOCALS.OPTION_CHECK102 = { name = "Marquer les dommages", tooltipText = "Active ou d\195\169sactive un marqueur * autour de tous les dommages"};
SCT.LOCALS.OPTION_CHECK103 = { name = "Type de sorts", tooltipText = "Active ou d\195\169sactive l\'affichage du type de dommages des sorts"};
SCT.LOCALS.OPTION_CHECK104 = { name = "Nom des sorts", tooltipText = "Active ou d\195\169sactive l\'affichage du nom des sorts"};
SCT.LOCALS.OPTION_CHECK105 = { name = "R\195\169siste", tooltipText = "Active ou d\195\169sactive l\'affichage de vos dommages r\195\169sist\195\169s"};
SCT.LOCALS.OPTION_CHECK106 = { name = "Nom de la cible", tooltipText = "Active ou d\195\169sactive l\'affichage du nom de la cible"};
SCT.LOCALS.OPTION_CHECK107 = { name = "D\195\169sactiver les dommages de WoW", tooltipText = "Active ou d\195\169sactive l\'affichage des d\195\169g\195\162ts par WoW.\n\nNOTE : C\'est la m\195\170me chose que les contr\195\180les dans les options d\'interface avanc\195\169es. Vous avez plus de contr\195\180le l\195\160-bas."};
SCT.LOCALS.OPTION_CHECK108 = { name = "Cible uniquement", tooltipText = "Active ou d\195\169sactive l\'affichage des d\195\169g\195\162ts sur votre cible uniquement. Les dommages d\'AoE ne sont pas montr\195\169s, \195\160 moins que plusieurs cibles aient le m\195\170me nom."};
--SCT.LOCALS.OPTION_CHECK109 = { name = "D\195\169sactiver en PVP", tooltipText = "D\195\169sactive SCTD en mode PVP et remet l\'affichage de base. Probablement inutile sur serveur PVP."};
SCT.LOCALS.OPTION_CHECK110 = { name = "Utiliser l\'animation de SCT", tooltipText = "Utilise SCT pour l\'animation des d\195\169g\195\162ts. Quand activ\195\169, TOUT LE CONTROLE SUR LE TEXTE EST FAIT PAR SCT. Utilisez SCT pour configurer le texte comme vous le souhaitez."};
SCT.LOCALS.OPTION_CHECK111 = { name = "Critiques persistants", tooltipText = "Permet un affichage plus long des critiques. D\195\169sactiv\195\169, les critiques s\'affichent avec +1236+, etc.. "};
SCT.LOCALS.OPTION_CHECK112 = { name = "Couleur des sorts", tooltipText = "Active ou d\195\169sactive l\'affichage des d\195\169g\195\162ts magiques en couleur selon l\'\195\169cole du sort. (couleurs non configurables)"};
SCT.LOCALS.OPTION_CHECK113 = { name = "Affichage vers le bas", tooltipText = "Le texte partira vers le bas."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="Position en X du centre", minText="-600", maxText="600", tooltipText = "Contr\195\180le le placement du centre des textes"};
SCT.LOCALS.OPTION_SLIDER102 = { name="Position en Y du centre", minText="-400", maxText="400", tooltipText = "Contr\195\180le le placement du centre des textes"};
SCT.LOCALS.OPTION_SLIDER103 = { name="Vitesse de fondu", minText="rapide", maxText="lent", tooltipText = "Contr\195\180le la vitesse \195\160 laquelle les messages disparaissent"};
SCT.LOCALS.OPTION_SLIDER104 = { name="Taille du texte", minText="petit", maxText="grand", tooltipText = "Contr\195\180le la taille du texte"};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD Options "..SCTD.Version};
SCT.LOCALS.OPTION_MISC102 = {name="Fin", tooltipText = "Sauve tous les changements et ferme les options"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "Ouvre le menu d\'options"};
SCT.LOCALS.OPTION_MISC104 = {name="Ev\195\170nements", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="Affichage", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="Animation", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="Police des d\195\169g\195\162ts", tooltipText = "Quelle police employer pour les messages", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name,[5] = SCT.LOCALS.FONTS[5].name}};
SCT.LOCALS.OPTION_SELECTION102 = { name="Contour du texte", tooltipText = "Quel contour de police employer pour les messages", table = {[1] = "Aucun",[2] = "L\195\169ger",[3] = "Fort"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="Animation des d\195\169g\195\162ts", tooltipText = "Quel type d\'animation utiliser. Il est HAUTEMENT recommandé d\'utiliser un style diff\195\169rent de SCT.", table = {[1] = "Vertical (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down",[5] = "Angled Up",[6] = "Sprinkler"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="C\195\180t\195\169 des d\195\169g\195\162ts", tooltipText = "De quel c\195\180t\195\169 le texte doit s\'afficher", table = {[1] = "Alterne",[2] = "D\195\169g\195\162ts \195\160 gauche",[3] = "D\195\169g\195\162ts \195\160 droite", [4] = "Tout \195\160 gauche", [5] = "Tout \195\160 droite"}};                                                                                                                                                                                                                                                                                                                                             