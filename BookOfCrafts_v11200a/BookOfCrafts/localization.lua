--[[
	BookOfCrafts Localization File

	Add-On developped by Ben a.k.a Blackdove (KirinTor Europe server), from Pandaren Empire Guild
--]]

	--[[
	é: \195\169
	ê: \195\170
	à: \195\160
	î: \195\174
	è: \195\168
	ë: \195\171
	ô: \195\180
	û: \195\187
	â: \195\162
	ç: \185\167
	ù: \195\185
	ä = \195\164
	Ä = \195\132
	ü = \195\188
	Ü = \195\156
	ö = \195\182
	Ö = \195\150
	ß = \195\159 
	pour une apostrophe : \226\128\153

	]]--



-- Addon version and data version
BC_VERSION                  = "1.12a"
BC_VERSION_DATA             = "0.80"

-- Generic texts
BC_ADDON_ICON               = "Interface\\Icons\\INV_Misc_Book_02"
BC_ADDON_NAME               = "BookOfCrafts"
BC_DELETECHAR               = "Delete Info"
BC_CONFIRMDELETE            = "Confirm"


--BC_ERR_LEARN_RECIPE = string.gsub( ERR_LEARN_RECIPE_S, "(.+) : .+", "%1" )
BC_ERR_LEARN_RECIPE = string.gsub( ERR_LEARN_RECIPE_S, "%%s", "%(.+%)" )

--BC_ERR_SKILL_UP = string.gsub( ERR_SKILL_UP_SI, "(.+)%%s(.+)%%d(.*)", "%1%(.+%)%2%(%%d+%)%3" )
BC_ERR_SKILL_UP = string.gsub( ERR_SKILL_UP_SI, "%%s", "(.+)" )
BC_ERR_SKILL_UP = string.gsub( BC_ERR_SKILL_UP, "%%d", "(%%d+)" )

if( GetLocale()=="frFR" ) then

	--[[ French translation ]]--

	BC_ADDON_DESC                = "Aide \195\160 la gestion des comp\195\169tences d'artisanats de tous vos personnages."
	BC_ADDON_SHORT_DESC          = "Livre d'artisanats"

	BC_SKILL_MANUAL              = "Manuel : "
	BC_SKILL_FORMULA             = "Formule : "
	BC_SKILL_PATTERN             = "Patron : "
	BC_SKILL_PLANS               = "Plans : "
	BC_SKILL_RECIPE              = "Recette : "
	BC_SKILL_SCHEMATIC           = "Sch\195\169ma : "

	BC_SKILL_SPECIALS            = "| travail du cuir tribal | travail du cuir d'\195\169cailles de dragon | travail du cuir \195\169l\195\169mentaire | fabricant d'armes | fabriquant d'armures | ma\195\174tre fabriquant de haches | ma\195\174tre fabriquant d'\195\169p\195\169es | ma\195\174tre fabriquant de marteaux | ing\195\169nieur gnome | ing\195\169nieur gobelin |"

	BC_SKILL_REQUISITE           = "(.+) %((%d+)%) requis"
	BC_SKILL_REQUIRE_SPECIAL     = "Requiert"

	BC_SKILL_KNOWN               = "A d\195\169j\195\160 appris: "
	BC_SKILL_MAYLEARN            = "Peut apprendre : "
	BC_SKILL_WILLLEARN           = "Rang insuffisant : "
	BC_SKILL_UNKNOWN_UNLEARNABLE = "Recette inutile"

	BC_CONFIG_INFO               = "Info"
	BC_CONFIG_TITLE              = "Livre d'artisanats"
	BC_CONFIG_TOOLTIPS           = "Tooltips"

	BC_TAB_OPTIONS               = "Options"
	BC_TAB_DATA                  = "Data"

	BC_MSG_USAGE                 = BC_ADDON_NAME.."usage:\n   /boc config - Ouvre l'\195\169cran de configuration:\n   /boc delete NOM - Efface les donn\195\169es du personnage NOM"
	BC_MSG_INITIALIZED           = BC_ADDON_NAME.." v"..BC_VERSION.." charg\195\169 (/boc pour les options)."

	-- WoW Key Bindings menu

	BINDING_HEADER_BCHEADER      = BC_ADDON_NAME.." v"..BC_VERSION
	BINDING_NAME_BCCONFIGDIALOG  = "Ouvre la fen\195\170tre de configuration"

	-- Check button labels

	BCUI_DropDownCharacters_Help                    = "Selectionner le personnage dont vous voudriez effacer les donn\195\169es"
	BCUI_CheckButton_SameFaction_Label              = "Afficher seulement les personnages de la m\195\170me faction"
	BCUI_CheckButton_SameFaction_Help               = "La recherche de personnages, pouvant apprendre ou \nconnaissant d\195\169j\195\160 une recette, est limit\195\169e \195\160 la m\195\170me \nfaction"
	BCUI_CheckButton_ShowSkillRank_Label            = "Montrer le niveau de comp\195\169tence"
	BCUI_CheckButton_ShowSkillRank_Help             = "Si l'option est activ\195\169e, le rang du personnagesera \nmontr\195\169 s'il peut apprendre la comp\195\169tence\n(le rang n'est pas montr\195\169 si d\195\169j\195\160 connu)"
	BCUI_Color_Tooltips_Label                       = "Couleur de fond"
	BCUI_Color_Tooltips_ColorSwatch_Help            = "D\195\169finit la couleur de fond du tooltip"
	BCUI_Color_TooltipsKnownBy_Label                = "Recette connue"
	BCUI_Color_TooltipsKnownBy_ColorSwatch_Help     = "D\195\169finit la couleur du texte pour les noms de ceux qui connaissent d\195\169j\195\160 la recette"
	BCUI_Color_TooltipsMayLearn_Label               = "Recette \195\160 apprendre"
	BCUI_Color_TooltipsMayLearn_ColorSwatch_Help    = "D\195\169finit la couleur du texte pour les noms de \nceux qui peuvent apprendre la recette"
	BCUI_Color_TooltipsRankTooHigh_Label            = "Recette Inaccessible"
	BCUI_Color_TooltipsRankTooHigh_ColorSwatch_Help = "D\195\169finit la couleur du texte pour les noms de \nceux pour qui la recette est encore inaccessible"
	BCUI_CheckButton_ShowChatMsg_Label              = "Verbose"
	BCUI_CheckButton_ShowChatMsg_Help               = "Affichage de messages informatifs dans la fen\195\170tre \nde t'chat"
	BCUI_CheckButton_ShowCurPlayer_Label            = "Lister aussi ce personnage"
	BCUI_CheckButton_ShowCurPlayer_Help             = "Affichage du nom du personnage courant dans les listes \ns'il peut apprendre une recette"
	BCUI_CheckButton_UseSideTooltip_Label           = "Utiliser tooltip ind\195\169pendant"
	BCUI_CheckButton_UseSideTooltip_Help            = "Les r\195\169sultats sont affich\195\169s dans un tooltip ind\195\169pendant \n au lieu de s'afficher dans le descriptif de la recette"

	BookOfCrafts_Exceptions = -- Craft recipe name = fixed name (header + skill name)
	{
		["elixir d'agilit\195\169 inf\195\169rieure"] = "elixir d'agilit\195\169 inf\195\169rieur",
		["elixir de d\195\169tection de l'invisibilit\195\169 inf\195\169rieure"] = "elixir de d\195\169tection d'invisibilit\195\169 inf\195\169rieure",
		["carburant de fus\195\169e gobelin"] = "carburant de fus\195\169e des gobelins",
		["transmutation : fer en or"] = "transmutation du fer en or",
		["transmutation : mithril en vrai-argent"] = "transmutation du mithril en vrai-argent",
		["cadeau d'arthas"] = "don d'arthas",
		["elixir de d\195\169fense excellent"] = "elixir de d\195\169fense excellente",
		["potion de sommeil sans r\195\170ve sup\195\169rieure"] = "sommeil sans r\195\170ve sup\195\169rieur",
		["transmutation : feu \195\169l\195\169mentaire"] = "transmutation du feu \195\169l\195\169mentaire",
		["biscuit au pain d'\195\169pices"] = "biscuit de pain d'\195\169pice",
		["chilli de souffle de dragon"] = "chili de souffle de dragon",
		["chilli de crabe \195\169pic\195\169"] = "chili de crabe \195\169pic\195\169",
		["ench. de plastron (mana mineur)"] = "enchantement de plastron (mana mineur)",
		["ench. de bracelets (esprit mineur)"] = "enchantement de bracelets (esprit mineur)",
		["ench. de plastron (mana inf\195\169rieur)"] = "enchantement de plastron (mana inf\195\169rieur)",
		["ench. de bracelets (force mineure)"] = "enchantement de bracelets (force mineure)",
		["ench. d'arme (tueur de b\195\170te mineur)"] = "enchantement d'arme (tueur de b\195\170te mineur)",
		["ench. d'arme 2m (intelligence inf\195\169rieure)"] = "enchantement d'arme 2m (intelligence inf\195\169rieure)",
		["ench. d'arme 2m (esprit inf\195\169rieur)"] = "enchantement d'arme 2m (esprit inf\195\169rieur)",
		["ench. de cape (agilit\195\169 mineure)"] = "enchantement de cape (agilit\195\169 mineure)",
		["ench. de bouclier (protection inf\195\169rieure)"] = "enchantement de bouclier (protection inf\195\169rieure)",
		["ench. de bracelets (esprit inf\195\169rieur)"] = "enchantement de bracelet (esprit inf\195\169rieur)",
		["ench. de bottes (agilit\195\169 mineure)"] = "bottes enchant\195\169es (agilit\195\169 mineure)",
		["ench. de cape (r\195\169sistance \195\160 l'ombre inf.)"] = "enchantement de cape (r\195\169sistance aux t\195\169n\195\168bres inf\195\169rieure)",
		["ench. de bracelets (force inf\195\169rieure)"] = "enchantement de bracelets (force inf\195\169rieure)",
		["ench. de gants (minage)"] = "enchantement de gants (minage)",
		["ench. de gants (herboristerie)"] = "enchantement de gants (herboristerie)",
		["ench. de gants (p\195\170che)"] = "enchantement de gants (p\195\170che)",
		["ench. de bracelets (d\195\169viation inf\195\169rieure)"] = "enchantement de bracelets (d\195\169viation inf\195\169rieure)",
		["ench. d'arme (tueur de b\195\170te inf\195\169rieur)"] = "enchantement d'arme (tueur de b\195\170te inf\195\169rieur)",
		["ench. d'arme (tueur d'\195\169l\195\169mentaire inf\195\169rieur)"] = "enchantement d'arme (tueur d'\195\169l\195\169mentaire inf\195\169rieur)",
		["ench. de bottes (esprit inf\195\169rieur)"] = "enchantement de bottes (esprit inf\195\169rieur)",
		["ench. d'arme (puissance de l'hiver)"] = "enchantement d'arme (puissance de l'hiver)",
		["ench. de bouclier (blocage inf\195\169rieur)"] = "enchantement de bouclier (blocage inf\195\169rieur)",
		["ench. de gants (d\195\169peçage)"] = "enchantement de gants (d\195\169peçage)",
		["ench. de bouclier (endurance)"] = "enchantement de bouclier (endurance)",
		["ench. de gants (minage avanc\195\169)"] = "enchantement de gants (minage avanc\195\169)",
		["ench. de bracelets (esprit sup\195\169rieur)"] = "enchantement de bracelets (esprit sup\195\169rieur)",
		["ench. de gants (herboristerie avanc\195\169e)"] = "enchantement de gants (herboristerie avanc\195\169e)",
		["ench. de cape (agilit\195\169 inf\195\169rieure)"] = "enchantement de cape (agilit\195\169 inf\195\169rieure)",
		["ench. d'arme (tueur de d\195\169mons)"] = "enchantement d'arme (tueur de d\195\169mon)",
		["ench. de bracelets (d\195\169viation)"] = "enchantement de bracelets (d\195\169viation)",
		["ench. de bouclier (r\195\169sistance au givre)"] = "enchantement de bouclier (r\195\169sistance au givre)",
		["ench. de bracelets (endurance sup\195\169rieure)"] = "enchantement de bracelets (endurance sup\195\169rieure)",
		["ench. de gants (equitation)"] = "enchantement de gants (equitation)",
		["ench. de bracelets (intelligence sup\195\169rieure)"] = "enchantement de bracelets (intelligence sup\195\169rieure)",
		["ench. de bottes (endurance sup\195\169rieure)"] = "enchantement de bottes (endurance sup\195\169rieure)",
		["ench. d'arme (arme flamboyante)"] = "enchantement d'arme (arme flamboyante)",
		["ench. de cape (r\195\169sistance sup\195\169rieure)"] = "enchantement de cape (r\195\169sistance sup\195\169rieure)",
		["ench. de bouclier (endurance sup\195\169rieure)"] = "enchantement de bouclier (endurance sup\195\169rieure)",
		["ench. de bracelets (esprit excellent)"] = "enchantement de bracelets (esprit excellent)",
		["ench. de gants (agilit\195\169 sup\195\169rieure)"] = "enchantement de gants (agilit\195\169 sup\195\169rieure)",
		["ench. de bottes (esprit)"] = "enchantement de bottes (esprit)",
		["ench. de plastron (vie majeure)"] = "enchantement de plastron (sant\195\169 majeure)",
		["ench. de bouclier (esprit excellent)"] = "enchantement de bouclier (esprit excellent)",
		["ench. d'arme (frisson glacial)"] = "enchantement d'arme (frisson glacial)",
		["ench. de cape (d\195\169fense excellente)"] = "enchantement de cape (d\195\169fense excellent)",
		["ench. de plastron (mana majeur)"] = "enchantement de plastron (mana majeur)",
		["ench. d'arme (force)"] = "enchantement d'arme (force)",
		["ench. d'arme (agilit\195\169)"] = "enchantement d'arme (agilit\195\169)",
		["ench. de bracelets (r\195\169g\195\169n\195\169ration de mana)"] = "enchantement de bracelets (r\195\169g\195\169n\195\169ration de mana)",
		["ench. de gants (force sup\195\169rieure)"] = "enchantement de gants (force sup\195\169rieure)",
		["ench. de bottes (agilit\195\169 sup\195\169rieure)"] = "enchantement de bottes (agilit\195\169 sup\195\169rieure)",
		["ench. de bracelets (force excellente)"] = "enchantement de bracelet (force excellente)",
		["ench. d'arme 2m (impact excellent)"] = "enchantement d'arme 2m - impact excellent",
		["ench. d'arme (arme impie)"] = "enchantement d'arme (impie)",
		["ench. d'arme 2m (intelligence majeure)"] = "enchantement d'arme 2m (intelligence majeure)",
		["ench. d'arme (frappe excellente)"] = "enchantement d'arme (frappe excellente)",
		["ench. de bracelets (endurance excellente)"] = "enchantement de bracelets (endurance excellente)",
		["ench. d'arme (crois\195\169)"] = "enchantement d'arme (crois\195\169)",
		["ench. de plastron (caract. sup\195\169rieures)"] = "enchantement de plastron (caract\195\169ristiques sup\195\169rieures)",
		["ench. d'arme (vol de vie)"] = "enchantement d'arme (vol de vie)",
		["ench. d'arme 2m (esprit majeur)"] = "enchantement d'arme 2m (esprit majeur)",
		["ench. d'arme (puissance de sort)"] = "enchantement d'arme (puissance de sort)",
		["ench. d'arme (pouvoir de gu\195\169rison)"] = "enchantement d'arme (pouvoir de gu\195\169rison)",
		["ench. de bracelets (pouvoir de gu\195\169rison)"] = "enchantement de bracelets (soin)",
		["ench. d'arme (esprit renforc\195\169)"] = "enchantement d'arme (esprit renforc\195\169)",
		["ench. d'arme (intelligence renforc\195\169e)"] = "enchantement d'arme (intelligence renforc\195\169e)",
		["ench. de cape (r\195\169sistance au feu sup\195\169rieure)"] = "enchantement de cape (r\195\169sistance au feu sup\195\169rieure)",
		["ench. de cape (r\195\169sistance \195\160 la nature sup\195\169rieure)"] = "enchantement de cape (r\195\169sistance \195\160 la nature sup\195\169rieure)",
		["petite charge de seaforium"] = "petite charge d'hydroglyc\195\169rine",
		["dynamite ez-thro"] = "dynamite ev-lan",
		["mortier en bronze portable"] = "mortier portable en bronze",
		["monocle d'artisan"] = "monocle de l'artisan",
		["maître-neige 9000"] = "maîtreneige 9000",
		["grande charge de seaforium"] = "grande charge d'hydroglyc\195\169rine",
		["dynamite ez-thro ii"] = "dynamite ev-lan ii",
		--["feu d'artifice "explosion de serpent""] = "feu d'artifice "explosion serpentine"",
		["rouage en thorium"] = "rouages en thorium",
		["puissante charge de seaforium"] = "puissante charge d'hydroglyc\195\169rine",
		["bombe dark iron"] = "bombe en sombrefer",
		["petit dragon d'arcanite"] = "petit dragon en arcanite",
		["carabine d'arcanite sans d\195\169faut"] = "carabine en arcanite sans d\195\169faut",
		["robot d'alarme"] = "robot d'alarme gnome",
		["tunique blanche en cuir"] = "pourpoint blanc en cuir",
		["veste de moonglow"] = "gilet lueur-de-lune",
		["plastron en \195\169cailles de murloc"] = "cuirasse en \195\169cailles de murloc",
		["veste d'homme des collines en cuir"] = "gilet d'homme des collines en cuir",
		["cape en cuir de dragonnet noir"] = "cape de dragonnet noir",
		["tunique en cuir de dragonnet noir"] = "tunique de dragonnet noir",
		["gants barbares"] = "gants barbare",
		["ceinture de gardien"] = "ceinture du gardien",
		["armure de murloc \195\169paisse"] = "armure \195\169paisse de murloc",
		["armure en cuir de dragonnet vert"] = "armure de dragonnet vert",
		["ceinture en cuir clout\195\169 de gemmes"] = "ceinture en cuir clout\195\169e de gemmes",
		["cape de gardien"] = "cape du gardien",
		["bracelets en \195\169cailles de murloc"] = "brassards en \195\169cailles de murloc",
		["bracelets en cuir de dragonnet vert"] = "brassards de dragonnet vert",
		["bracelets de gardien en cuir"] = "brassards de gardien en cuir",
		["bottes mates"] = "bottes mattes",
		["robe vaudou"] = "robe du grand vaudou",
		["plastron arm\195\169 du scorpide"] = "cuirasse arm\195\169e du scorpide",
		["masque vaudou"] = "masque du grand vaudou",
		["bracelets arm\195\169s du scorpide"] = "brassards arm\195\169s du scorpide",
		["veste en cuir sauvage"] = "gilet en cuir sauvage",
		["pantalon vaudou"] = "pantalon du grand vaudou",
		["grande cape vaudou"] = "cape du grand vaudou",
		["bracelets en \195\169cailles de scorpide \195\169paisses"] = "brassards en \195\169cailles de scorpide \195\169paisses",
		["veste en \195\169cailles de scorpide \195\169paisses"] = "broigne en \195\169cailles de scorpide \195\169paisses",
		["bracelets corrompus en cuir"] = "brassards corrompus en cuir",
		["gantelets runique en cuir"] = "gantelets runiques en cuir",
		["bracelets runiques en cuir"] = "brassards runiques en cuir",
		["bracelets de vol rapide"] = "brassards de vol rapide",
		["gants grumegueules"] = "batailleurs grumegueules",
		["plastron du tigre-sang"] = "cuirasse du tigre-sang",
		["tunique en peau de chauve-souris primordiale"] = "pourpoint en peau de chauve-souris primordiale",
		["plastron de crache-feu"] = "cuirasse de crache-feu",
		["plastron de traqueuse des sables"] = "cuirasse de traqueuse des sables",
		["plastron de r\195\170v\195\169caille"] = "cuirasse de r\195\170v\195\169caille",
		["plastron en \195\169cailles de dragon vert"] = "cuirasse en \195\169cailles de dragon vert",
		["plastron en \195\169cailles de dragon bleu"] = "cuirasse en \195\169cailles de dragon bleu",
		["plastron en \195\169cailles de dragon noir"] = "cuirasse en \195\169cailles de dragon noir",
		["plastron en \195\169cailles de dragon rouge"] = "cuirasse en \195\169cailles de dragon rouge",
		["plastron volcanique"] = "cuirasse volcanique",
		["plastron vivant"] = "cuirasse vivante",
		["harnais des grands ours"] = "harnais de l'ours de guerre",
		["jambi\195\168res des grands ours"] = "jambi\195\168res de l'ours de guerre",
		["veste chim\195\169rique"] = "gilet chim\195\169rique",
		["plastron en plumacier"] = "cuirasse en plumacier",
		["veste bleue en lin"] = "gilet bleu en lin",
		["veste rouge en lin"] = "gilet rouge en lin",
		["combinaison bleue"] = "salopette bleue",
		["robe d'adepte sup\195\169rieure"] = "robe d'adepte sup\195\169rieur",
		["chausses en soie d'araign\195\169e"] = "mules en soie d'araign\195\169e",
		["gants de foi"] = "gants de vraie foi",
		["veste rouge en tissu de mage"] = "gilet rouge en tisse-mage",
		["pantalon rouge en tissu de mage"] = "pantalon rouge en tisse-mage",
		["gants rouges en tissu de mage"] = "gants rouges en tisse-mage",
		["chemise lavande en tissu de mage"] = "chemise lavande en tisse-mage",
		["epauli\195\168res rouges en tissu de mage"] = "epauli\195\168res rouges en tisse-mage",
		["chemise rose en tissu de mage"] = "chemise rose en tisse-mage",
		["bandeau rouge en tissu de mage"] = "bandeau rouge en tisse-mage",
		["masque en tissu-t\195\169n\195\168bres"] = "masque en tisse-ombre",
		["robe de f\195\170te rouge"] = "robe de f\195\170te",
		["habit de f\195\170te rouge"] = "habit de f\195\170te",
		["tunique de tisse-glace"] = "tunique tisse-givre",
		["robe de tisse-glace"] = "robe tisse-givre",
		["veste en \195\169toffe cendr\195\169e"] = "gilet en \195\169toffe cendr\195\169e",
		["ceinture en \195\169toffe fantôme"] = "ceinture en tisse-fantôme",
		["gants de tisse-glace"] = "gants tisse-givre",
		["gants en \195\169toffe fantôme"] = "gants en tisse-fantôme",
		["veste en \195\169toffe fantôme"] = "gilet en tisse-fantôme",
		["jambi\195\168res en tissu de sorcier"] = "jambi\195\168res en tisse-sorcier",
		["pantalon de tisse-glace"] = "pantalon tisse-givre",
		["pantalon en \195\169toffe fantôme"] = "pantalon en tisse-fantôme",
		["robe en tissu de sorcier"] = "robe en tisse-sorcier",
		["veste en \195\169toffe lunaire"] = "gilet en \195\169toffe lunaire",
		["turban en tissu de sorcier"] = "turban en tisse-sorcier",
		["robe de foi"] = "habit de vraie foi",
		["bracelets coeur-de-braise"] = "couvre-bras coeur-de-braise",
		["jambi\195\168res en vignesang"] = "jambi\195\168res  en vignesang",
		["veste en vignesang"] = "gilet en vignesang",
		["bandage en tissu de mage"] = "bandage en tisse-mage",
		["cottes de mailles de cuivre"] = "lorica en cuivre",
		["gantelets orn\195\169s en cuivre"] = "gantelets ornement\195\169s en cuivre",
		["plastron runique en cuivre"] = "cuirasse runique en cuivre",
		["plastron d'ironforge"] = "cuirasse d'ironforge",
		["plastron en bronze argent\195\169"] = "cuirasse en bronze argent\195\169",
		["marteau iris\195\169"] = "marteau iridescent",
		["bottes en fer sylvestre"] = "bottes en fer \195\169meraude",
		["gantelets en fer sylvestre"] = "gantelets en fer \195\169meraude",
		["epauli\195\168res en fer sylvestre"] = "epauli\195\168res en fer \195\169meraude",
		["plastron barbare en fer"] = "cuirasse barbare en fer",
		["contrepoids de fer"] = "contrepoids en fer",
		["cylindre en alliage de mithril"] = "cylindre damasquin\195\169 en mithril",
		["jambi\195\168res en mithril lourd"] = "jambi\195\168res lourdes en mithril",
		["bracelets en \195\169cailles de mithril"] = "brassards en \195\169cailles de mithril",
		["jambi\195\168res en mithril orn\195\169"] = "jambi\195\168res orn\195\169es en mithril",
		["gants en mithril orn\195\169"] = "gants orn\195\169s en mithril",
		["epauli\195\168res en mithril orn\195\169"] = "epauli\195\168res orn\195\169es en mithril",
		["rapi\195\168re en mithril \195\169blouissante"] = "rapi\195\168re \195\169blouissante en mithril",
		["heaume en mithril lourd"] = "heaume lourd en mithril",
		["bracelets en thorium"] = "brassards en thorium",
		["plastron radieux"] = "cuirasse radieuse",
		["hachette en thorium orn\195\169e"] = "hachette orn\195\169e en thorium",
		["plastron imp\195\169rial en plaques"] = "pansi\195\168re imp\195\169riale",
		["plastron runique"] = "cuirasse runique",
		["plastron d'âmesang"] = "cuirasse d'âmesang",
		["plastron de t\195\169n\195\169brâme"] = "cuirasse de t\195\169n\195\169brâme",
		["plastron de sombrerune"] = "cuirasse de sombrerune",
		["pulv\195\169riseur dark iron"] = "pulv\195\169riseur en sombrefer",
		["d\195\169coupeuse dark iron"] = "d\195\169coupeuse en sombrefer",
		["cotte de mailles ronce-sauvage"] = "cotte de mailles de ronce-sauvage",
		["plate d'armure dark iron"] = "harnois en sombrefer",
		["plastron d\195\169moniaque"] = "cuirasse d\195\169moniaque",
		["bracelets dark iron"] = "brassards dark iron",
		["heaume cœur-de-lion"] = "heaume coeur-de-lion",
		["plastron en thorium enchant\195\169"] = "cuirasse en thorium enchant\195\169",
		["championne d'arcanite"] = "championne en arcanite",
		["d\195\169chireuse d'arcanite"] = "d\195\169chireuse en arcanite",
	}


elseif( GetLocale()=="deDE" ) then

	--[[ German translation ]]--

	BC_ERR_LEARN_RECIPE          = string.gsub( ERR_LEARN_RECIPE_S, "%%s", "%(.+%)" )
	BC_ERR_SKILL_UP              = string.gsub( ERR_SKILL_UP_SI, "%%1%$s", "(.+)" )
	BC_ERR_SKILL_UP              = string.gsub( BC_ERR_SKILL_UP, "%%2%$d", "(%%d+)" )

	BC_ADDON_DESC                = "Unterst\195\188tzt Sie bei der Verwaltung der Fertigkeiten aller Charaktere."
	BC_ADDON_SHORT_DESC          = "Buch der Fertigkeiten"


	BC_SKILL_MANUAL              = "Handbuch: "
	BC_SKILL_FORMULA             = "Formel: "
	BC_SKILL_PATTERN             = "Muster: "
	BC_SKILL_PLANS               = "Pl\195\164ne: "
	BC_SKILL_RECIPE              = "Rezept: "
	BC_SKILL_SCHEMATIC           = "Bauplan: "

	BC_SKILL_SPECIALS            = "| R\195\188stungsschmied | Waffenschmied | Schwertschmiedemeister | Axtschmiedemeister | Hammerschmiedemeister | Goblin-Ingenieur | Gnomen-Ingenieur | Stammeslederverarbeitung | Elementarlederverarbeitung | Drachenschuppenlederverarbeitung |"

	BC_SKILL_REQUISITE           = "Ben\195\182tigt (.+) %((%d+)%)"
	BC_SKILL_REQUIRE_SPECIAL     = "Ben\195\182tigt"

	BC_SKILL_KNOWN               = "Bereits bekannt: "
	BC_SKILL_MAYLEARN            = "Gleich erlernbar: "
	BC_SKILL_WILLLEARN           = "Sp\195\164ter erlernbar: "
	BC_SKILL_UNKNOWN_UNLEARNABLE = "Nicht erlernbar / Fertigkeit noch nicht erlernt"

	BC_CONFIG_INFO               = "Information"
	BC_CONFIG_TITLE              = "Buch der Fertigkeiten"
	BC_CONFIG_TOOLTIPS           = "Tooltips"

	BC_TAB_OPTIONS               = "Einstellungen"
	BC_TAB_DATA                  = "Daten"

	BC_MSG_USAGE                 = BC_ADDON_NAME.." Aufruf:\n   /boc config - \195\150ffnet das Konfigurationsfenster von BoC\n   /boc delete NAME - L\195\182scht die gesammelten Daten des Charakters: NAME";
	BC_MSG_INITIALIZED           = BC_ADDON_NAME.." v"..BC_VERSION.." wurde geladen (/boc um das Konfigurationsfenster zu \195\182ffnen)."

	-- WoW Key Bindings menu

	BINDING_HEADER_BCHEADER      = BC_ADDON_NAME.." v"..BC_VERSION
	BINDING_NAME_BCCONFIGDIALOG  = "Konfigurationsfenster \195\182ffnen"

	-- Check button labels

	BCUI_DropDownCharacters_Help                    = "W\195\164hlen Sie die Charakter Daten aus, die sie l\195\182schen m\195\182chten"
	BCUI_CheckButton_SameFaction_Label              = "Nur Charakter der eigenen Fraktion\nanzeigen"
	BCUI_CheckButton_SameFaction_Help               = "Die Suche nach alternativen Charaktern, die eine\nFertigkeit kennen oder erlernen k\195\182nnen, ist auf\ndie eigene Fraktion beschr\195\164nkt."
	BCUI_CheckButton_ShowSkillRank_Label            = "Fertigkeitsr\195\164nge anzeigen"
	BCUI_CheckButton_ShowSkillRank_Help             = "Den Rang wann eine Fertigkeit erlernt werden kann\nneben dem Namen anzeigen (nicht f\195\188r Fertigkeiten\ndie bereits bekannt sind)."
	BCUI_Color_Tooltips_Label                       = "Tooltip Farbe"
	BCUI_Color_Tooltips_ColorSwatch_Help            = "Farbe f\195\188r den Tooltip-Text ausw\195\164hlen."
	BCUI_CheckButton_ShowChatMsg_Label              = "Chat Nachrichten detailierter\nanzeigen"
	BCUI_CheckButton_ShowChatMsg_Help               = "Informative Nachrichten als Chat\nNachrichten anzeigen"
	BCUI_CheckButton_ShowCurPlayer_Label            = "Auch diesen Charakter bei der\nAuswertung miteinbeziehen"
	BCUI_CheckButton_ShowCurPlayer_Help             = "Auch diesen Charakter zum Tooltip\nhinzuf\195\188gen"
	BCUI_Color_TooltipsKnownBy_Label                = "Bereits bekannt"
	BCUI_Color_TooltipsKnownBy_ColorSwatch_Help     = "Definiert die Farbe mit der die Charaktere der \nEinstufung \"Bereits bekannt\" angezeigt werden"
	BCUI_Color_TooltipsMayLearn_Label               = "Gleich erlernbar"
	BCUI_Color_TooltipsMayLearn_ColorSwatch_Help    = "Definiert die Farbe mit der die Charaktere der \nEinstufung \"Gleich erlernbar\" angezeigt werden"
	BCUI_Color_TooltipsRankTooHigh_Label            = "Sp\195\164ter erlernbar"
	BCUI_Color_TooltipsRankTooHigh_ColorSwatch_Help = "Definiert die Farbe mit der die Charaktere der \nEinstufung \"Sp\195\164ter erlernbar\" angezeigt werden"
	BCUI_CheckButton_UseSideTooltip_Label           = "Seitlichen Tooltip benutzen"
	BCUI_CheckButton_UseSideTooltip_Help            = "Ergebnisse werden in einem seperaten seitlichen \nTooltip angezeigt"

	BookOfCrafts_Exceptions = -- Craft recipe name, signature
	{
		["elixier der entd. geringer unsichtbarkeit"] = "elixier der entdeckung geringer unsichtbarkeit",
		["magiewiderstandtrank"] = "magiewiderstandstrank",
		["transmutieren: eisen in gold"] = "eisen in gold transmutieren",
		["transmutieren: mithril in echtsilber"] = "mithril in echtsilber transmutieren",
		["transmutieren: arkanit"] = "arkanit transmutieren",
		["transmutieren: luft zu feuer"] = "luft zu feuer transmutieren",
		["transmutieren: erde zu wasser"] = "erde zu wasser transmutieren",
		["transmutieren: erde zu leben"] = "erde in leben transmutieren",
		["transmutieren: feuer zu erde"] = "feuer zu erde transmutieren",
		["transmutieren: untod zu wasser"] = "untod zu wasser transmutieren",
		["transmutieren: wasser zu luft"] = "wasser zu luft transmutieren",
		["transmutieren: wasser zu untod"] = "wasser zu untod transmutieren",
		["transmutieren: leben zu erde"] = "leben in erde transmutieren",
		["redridge-gulasch"] = "rotkammgulasch",
		["dirges abgefahrene chimearokkoteletts"] = "dirges abgefahrene chimaerokkoteletts",
		["armschiene - schwacher willen"] = "armschiene - schwache willenskraft",
		["zweihandwaffe - geringer willen"] = "zweihandwaffe - geringe willenskraft",
		["schild - schwacher schutz"] = "schild - geringer schutz",
		["armschiene - geringer willen"] = "armschiene - geringe willenskraft",
		["stiefel - geringer willen"] = "stiefel - geringe willenskraft",
		["armschiene - \195\188berragender willen"] = "armschiene - \195\188berragende willenskraft",
		["handschuhe verzaubern - gro\195\159e beweglichkeit"] = "handschuhe - gro\195\159e beweglichkeit",
		["stiefel - willen"] = "stiefel - willenskraft",
		["schild - erheblicher willen"] = "schild - erhebliche willenskraft",
		["waffe verzaubern - stärke"] = "waffe - stärke",
		["waffe verzaubern - beweglichkeit"] = "waffe - beweglichkeit",
		["armschiene verzaubern - manaregeneration"] = "armschiene - manaregeneration",
		["waffe - unheilige waffe"] = "waffe - unheilig",
		["zweihandwaffen - erhebliche intelligenz"] = "zweihandwaffe - erhebliche intelligenz",
		["zweihandwaffe - erheblicher willen"] = "zweihandwaffe - erhebliche willenskraft",
		["waffe verzaubern -  zauberkraft"] = "waffe - zauberkraft",
		["waffe verzaubern -  heilkraft"] = "waffe - heilkraft",
		["armschiene verzaubern - heilkraft"] = "armschiene - heilung",
		["waffe verzaubern - mächtige willenskraft"] = "waffe - mächtige willenskraft",
		["waffe verzaubern - mächtige intelligenz"] = "waffe - mächtige intelligenz",
		["formel: handschuhe verzaubern - bedrohung"] = "handschuhe - bedrohung",
		["formel: handschuhe verzaubern - schattenmacht"] = "handschuhe - schattenmacht",
		["formel: handschuhe verzaubern - frostmacht"] = "handschuhe - frostmacht",
		["formel: handschuhe verzaubern - feuermacht"] = "handschuhe - feuermacht",
		["handschuhe verzaubern - heilkraft"] = "handschuhe - heilkraft",
		["handschuhe verzaubern - \195\188berragende beweglichkeit"] = "handschuhe - \195\188berragende beweglichkeit",
		["formel: umhang verzaubern - gro\195\159er feuerwiderstand"] = "umhang - gro\195\159er feuerwiderstand",
		["formel: umhang verzaubern - gro\195\159er naturwiderstand"] = "umhang - gro\195\159er naturwiderstand",
		["formel: umhang verzaubern - verstohlenheit"] = "umhang - verstohlenheit",
		["formel: umhang verzaubern - feingef\195\188hl"] = "umhang - feingef\195\188hl",
		["formel: umhang verzaubern - ausweichen"] = "umhang - ausweichen",
		["mechanischer gro\195\159drachling"] = "mechanischer drachling",
		["ez-thro dynamit ii"] = "ez-thro-dynamit ii",
		["tierbombling"] = "winzige wandelnde bombe",
		["fallschirmumhang"] = "fallschirm-umhang",
		["tieftauchhelm"] = "tiefentaucherhelm",
		["mechanischer mithrilgro\195\159drachling"] = "mechanischer mithrildrachling",
		["echtsilber-umwandler"] = "echtsilberumwandler",
		["gyrofrosteisdeflektor"] = "gyrofrosteisreflektor",
		["arkanitgro\195\159drachling"] = "arkanitdrachling",
		["kern-scharfsch\195\188tzengewehr"] = "kernscharfsch\195\188tzengewehr",
		["alarm-o-bot"] = "gnomischer alarm-o-bot",
		["murlocschuppen-g\195\188rtel"] = "murlocschuppeng\195\188rtel",
		["murlocschuppen-brustplatte"] = "murlocschuppenbrustplatte",
		["hillman-lederweste"] = "lederweste des h\195\188gelwächters",
		["hillman-g\195\188rtel"] = "g\195\188rtel des h\195\188gelwächters",
		["murlocschuppen-armschienen"] = "murlocschuppenarmschienen",
		["gr\195\188nwelpenarmschienen"] = "gr\195\188nwelpen-armschienen",
		["gro\195\159e voodoo-robe"] = "gro\195\159e voodoorobe",
		["gro\195\159e voodoo-maske"] = "gro\195\159e voodoomaske",
		["gro\195\159e voodoo-hose"] = "gro\195\159e voodoohose",
		["gro\195\159er voodoo-umhang"] = "gro\195\159er voodooumhang",
		["kern-r\195\188stungsset"] = "kernr\195\188stungsset",
		["urzeitliche fledermaushautwams"] = "urzeitliches fledermaushautwams",
		["spinnenseiden-slipper"] = "spinnenseidenslipper",
		["gr\195\188nes festtagsshemd"] = "gr\195\188nes festtagshemd",
		["rotes festtagskleid"] = "festtagskleid",
		["festlicher roter hosenanzug"] = "festtagsanzug",
		["ironforge-brustplatte"] = "ironforgebrustplatte",
		["verschnörkelte mithrilschultern"] = "verschnörkelte mithrilschulter",
		["sulfuron-hammer"] = "sulfuronhammer",
		["dunkeleisenhandschuhe"] = "dunkeleisenstulpen",
	}

else
	--[[ Generic translation ]]--

	BC_ADDON_DESC                = "Helps managing trade skills for all your characters."
	BC_ADDON_SHORT_DESC          = "Book of crafts"

	BC_SKILL_MANUAL              = "Manual: "
	BC_SKILL_FORMULA             = "Formula: "
	BC_SKILL_PATTERN             = "Pattern: "
	BC_SKILL_PLANS               = "Plans: "
	BC_SKILL_RECIPE              = "Recipe: "
	BC_SKILL_SCHEMATIC           = "Schematic: "

	BC_SKILL_SPECIALS            = "| tribal leatherworking | dragonscale leatherworking | elemental leatherworking | weaponsmith | armorsmith | master axesmith | master swordsmith | master hammersmith | gnomish engineer | goblin engineer |"

	BC_SKILL_REQUISITE           = "Requires (.+) %((%d+)%)"
	BC_SKILL_REQUIRE_SPECIAL     = "Requires"

	BC_SKILL_KNOWN               = "Already known : "
	BC_SKILL_MAYLEARN            = "May learn : "
	BC_SKILL_WILLLEARN           = "Rank too high : "
	BC_SKILL_UNKNOWN_UNLEARNABLE = "Unuseful recipe"

	--BC_SKILL_NOTKNOWN             = "Known by no other character"
	--BC_SKILL_MAYBELEARNTBY        = "May learn : "
	--BC_SKILL_MAYBENOTBELEARNT     = "May not be learnt by an other character"

	BC_CONFIG_INFO               = "Info"
	BC_CONFIG_TITLE              = "Book of Crafts"
	BC_CONFIG_TOOLTIPS           = "Tooltips"

	BC_TAB_OPTIONS               = "Options"
	BC_TAB_DATA                  = "Donn\195\169es"

	BC_MSG_USAGE                 = BC_ADDON_NAME.."usage:\n   /boc config - Opens configuration screen\n   /boc delete NAME - Delete character NAME data"
	BC_MSG_INITIALIZED           = BC_ADDON_NAME.." v"..BC_VERSION.." is loaded (/boc)"

	-- WoW Key Bindings menu

	BINDING_HEADER_BCHEADER     = BC_ADDON_NAME.." v"..BC_VERSION
	BINDING_NAME_BCCONFIGDIALOG = "Open Configuration dialog"


	-- Check button labels
	BCUI_DropDownCharacters_Help                    = "Select character data to delete"
	BCUI_CheckButton_SameFaction_Label              = "Only display characters \nfrom same faction"
	BCUI_CheckButton_SameFaction_Help               = "Search for alternative characters, who know or who\nmay learn a selected recipe, is limited to same\nfaction"
	BCUI_CheckButton_ShowSkillRank_Label            = "Show skill rank"
	BCUI_CheckButton_ShowSkillRank_Help             = "If option is checked, a character skill rank will \nbe shown next to his name if he may learn skill\n(not for Already known lists)"
	BCUI_Color_Tooltips_Label                       = "Tooltip color"
	BCUI_Color_Tooltips_ColorSwatch_Help            = "Define color for tooltip text"
	BCUI_CheckButton_ShowChatMsg_Label              = "Verbose"
	BCUI_CheckButton_ShowChatMsg_Help               = "Show misc. information as chat messages"
	BCUI_CheckButton_ShowCurPlayer_Label            = "Display current character \nin results"
	BCUI_CheckButton_ShowCurPlayer_Help             = "Add also this player name to tooltip lists"
	BCUI_Color_TooltipsKnownBy_Label                = "Known recipe"
	BCUI_Color_TooltipsKnownBy_ColorSwatch_Help     = "Defines color used to display characters who know selected \nrecipe"
	BCUI_Color_TooltipsMayLearn_Label               = "Learnable recipe"
	BCUI_Color_TooltipsMayLearn_ColorSwatch_Help    = "Defines color used to display character who may lears \nselected recipe"
	BCUI_Color_TooltipsRankTooHigh_Label            = "Rank too high"
	BCUI_Color_TooltipsRankTooHigh_ColorSwatch_Help = "Defines color used to display character for whom recipe \nrank is too high"
	BCUI_CheckButton_UseSideTooltip_Label           = "Use side tooltip"
	BCUI_CheckButton_UseSideTooltip_Help            = "Results are displayed in a side tooltip instead of inside \nthe recipe description"

	BookOfCrafts_Exceptions = -- Craft recipe name, signature
	{
		["philosophers' stone"] = "philosopher's stone",
		["transmute: iron to gold"] = "transmute iron to gold",
		["transmute: mithril to truesilver"] = "transmute mithril to truesilver",
		["transmute: arcanite"] = "transmute arcanite",
		["transmute: air to fire"] = "transmute air to fire",
		["transmute: earth to water"] = "transmute earth to water",
		["transmute: earth to life"] = "transmute earth to life",
		["transmute: fire to earth"] = "transmute fire to earth",
		["transmute: undeath to water"] = "transmute undeath to water",
		["transmute: water to air"] = "transmute water to air",
		["transmute: water to undeath"] = "transmute water to undeath",
		["transmute: life to earth"] = "transmute life to earth",
		["greater dreamless sleep potion"] = "greater dreamless sleep",
		["transmute: elemental fire"] = "transmute elemental fire",
		["mithril headed trout"] = "mithril head trout",
		["enchant cloak - minor protection"] = "imbue cloak - protection",
		["enchant weapon - unholy weapon"] = "enchant weapon - unholy",
		["enchant  weapon - spell power"] = "enchant weapon - spell power",
		["enchant  weapon - healing power"] = "enchant weapon - healing power",
		["enchant bracer - healing power"] = "enchant bracer - healing",
		["firework cluster launcher"] = "cluster launcher",
		["alarm-o-bot"] = "gnomish alarm-o-bot",
		["festive red dress"] = "festival dress",
		["festive red pant suit"] = "festival suit",
		["ornate mithril shoulders"] = "ornate mithril shoulder",
	}

end
