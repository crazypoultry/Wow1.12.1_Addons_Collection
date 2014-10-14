
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
---- Pour Version Fr -----------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
if (GetLocale() == "frFR") then 
	MINIMAPBUTTON_TOOLTIP 											= "Lancer EnchantingSell";
	
	ENCHANTINGSELL_MSG_LAUNCH										= "Lancement de EnchantingSell";
	ENCHANTINGSELL_MSG_RESETBD										= "Base de donn\195\169es effac\195\169e";
	ENCHANTINGSELL_MSG_LOADDEFAULTBD								= "Chargement de la base de composant par default";
	ENCHANTINGSELL_MSG_RESETALLDATAAREYOUSURE						= "Ete vous sur de vouloir r\195\169initialiser ce mod ?";
	ENCHANTINGSELL_MSG_LOADDEFAULTDATACOMPONANTAREYOUSURE			= "Charger la base de composant avec prix par d\195\169faut ecrasera celle en cours; Ete vous sur de vouloir continuer ?";
	ENCHANTINGSELL_MSG_LOADDEFAULTDATAENCHANTEAREYOUSURE			= "Charger la base d'enchantement par d\195\169faut ecrasera celle en cours; Ete vous sur de vouloir continuer ?";
	
	ENCHANTINGSELL_MSG_ERREUR_NOTLOADDEFAULTBD						= "Aucune base de composant par Default n'existe chargement impossible"
	ENCHANTINGSELL_MSG_ERREUR_NEWASKIMPOSSIBLE						= "Une Question est d\195\169j\195\162 pos\195\169e; repondez y avant de lancer une nouvelle action";
	ENCHANTINGSELL_MSG_ERREUR_PRICEMODIFCANCEL						= "Autre Action la modification de prix en cours a \195\169t\195\169 annul\195\169";
	ENCHANTINGSELL_ERRORMSG_INCOMPATIBLESORTENCHANTE				= "Ne peut lancer EnchantingSell !\n\rSortEnchante n'est pas compatible avec EnchantingSell par mesure de securit\165\169 Enchanting ne se lancera pas."
	
	ENCHANTINGSELL_TITLE 											= "Enchanting Sell "..ENCHANTINGSELL_VERSION;
	ENCHANTINGSELL_TAB_LIST_ENCHANTE								= "Enchantements";
	ENCHANTINGSELL_TAB_LIST_COMPONENT								= "Composants";
	ENCHANTINGSELL_TAB_OPTION										= "Option";
	
	ENCHANTINGSELL_CHANGEPRICEFRAME_PRICEWITHPOURCENTHEADER			= "Prix calcul\195\169 avec le % de B\195\169n\195\169f :";
	ENCHANTINGSELL_CHANGEPRICEFRAME_PRICEWITHPOURCENTCHECKBOX		= "Prendre le prix par calcul.";
	
	ENCHANTINGSELL_PRICE_UNITEGOLD									= "Po"; -- Pi�ce d'Or
	ENCHANTINGSELL_PRICE_UNITESILVER								= "Pa"; -- Pi�ce d'Argent
	ENCHANTINGSELL_PRICE_UNITECOPPER								= "Pc"; -- Pi�ce de Cuivre
	
	ENCHANTINGSELL_ENCHANTE_BUTTON_CREATEENCHANTE					= "Enchanter";
	ENCHANTINGSELL_ENCHANTE_CHECK_SORTBYCRAFT						= "Trie par faisabilit\195\169";
	
	ENCHANTINGSELL_ENCHANTE_HEADER_NAME								= "Nom enchantement";
	ENCHANTINGSELL_ENCHANTE_HEADER_ONTHIS							= "Sur";
	ENCHANTINGSELL_ENCHANTE_HEADER_BONUS							= "Bonus";
	ENCHANTINGSELL_ENCHANTE_HEADER_MONEY							= "Prix";
	
	ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_HEADER				= "N\195\169cessite :";
	ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_ADDNAMEFORINBANK		= "(en banque)";
	ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_ADDNOKNOW				= "(Apprendre cette enchante)";
	
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_HEADER							= "Ent\195\170te Enchantements\n\r\n\rClic: Trie cette colonne\n\rUn deuxi\195\168me clic: Inverse le trie Croissant\n\r  en D\195\169croissant ou inversement";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_LIST							= "Enchantement\n\r\n\rShift Clic: Copie les infos de cette enchantement dans le chat\n\r\n\rCouleur:\n\rVert Clair-> Tous les composants sont dans les sacs.(Faisable)\n\rVert Fonc\195\169-> Certains composants sont en banque.\n\rMarron-> Insuffisant dans sac/banque mais possible avec ceux des ReRolls.\n\rRouge-> Ingredients insuffisant\n\rGris-> Enchantement non connu par l'enchanteur s\195\169lectionn\195\169.";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_DETAIL_NAMEDESCRIPTION			= "D\195\169tail Enchantement\n\r\n\rShift Clic: Copie le (Nom complet et Description) dans le chat";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_REAGENTS						= "Composant n\195\169cessaires\n\r\n\rShift Clic: Copie, pour ce composant,\n\r  le (Nom et Quantit\195\169) n\195\169cessaire dans le chat\n\rDouble Clic: Affiche le d\195\169tail de\n\r  ce composant";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_REAGENTSHEADER					= "Ent\195\170te Composants\n\r\n\rShift Clic: Copie, pour tous les composants\n\r  le (Nom et Quantit\195\169) n\195\169cessaire dans le chat";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_SEPARATORFORPRICE				= " \195\160 "; -- " � "
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_TOTALPRICE						= "Prix de l'enchantement\n\r\n\rDouble Clic: Modifier le prix de cette enchantement,\n\ravec un prix perso.\n\r\n\rCouleur:\n\rBlanc-> Prix par calcul.\n\rVert-> Prix Perso."
	
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_NAME				= "Nom Composant";
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_NB					= "S/QN";
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_NBOTHER				= "B-RR";
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_PRICEUNITE			= "Prix U";
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_PRICETOTAL			= "Prix T";
	
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_PRICETOTALNOBENEF 	= "PT sans Benef";
	
	ENCHANTINGSELL_COMPONANT_HEADER_NAME							= "Nom Composant";
	ENCHANTINGSELL_COMPONANT_HEADER_NB								= "Nb";
	ENCHANTINGSELL_COMPONANT_HEADER_NBBANK							= "Bank";
	ENCHANTINGSELL_COMPONANT_HEADER_NBREROLL						= "ReRoll";
	ENCHANTINGSELL_COMPONANT_HEADER_PRICEUNITE						= "Prix U";
	--ENCHANTINGSELL_COMPONANT_HEADER_PRICETOTAL						= "Prix T";
	
	ENCHANTINGSELL_COMPONANT_DETAIL_HEADER_NAMEPLAYER				= "Nom du joueur";
	ENCHANTINGSELL_COMPONANT_DETAIL_HEADER_INBAG					= "Sacs";
	ENCHANTINGSELL_COMPONANT_DETAIL_HEADER_INBANK					= "Banque";
	
	ENCHANTINGSELL_OPTION_ENCHANTING_POURCENTBENEFICE				= "% de B\195\169n\195\169fice :";
	
	ENCHANTINGSELL_OPTION_ENCHANTING_ENCHANTORSELECTED				= "Enchanteur S\195\169l\195\169ctionn\195\169 :";
	ENCHANTINGSELL_OPTION_ENCHANTING_NOTHINGPLAYER					= "Aucun";
	ENCHANTINGSELL_OPTION_ENCHANTING_FORJOINTPLAYERANDSERVER_OF		= " sur ";
	ENCHANTINGSELL_OPTION_ENCHANTING_MSGYESORNOTCHANGESERVER		= "Cette enchanteur est sur un autre serveur, les quantit\165\169s Sac, Banque et ReRoll seront effac\165\169s.\n\rVoulez vous continuer ?"
	
	ENCHANTINGSELL_OPTION_BD_RESETBUTTON							= "Effacer toutes les donn\195\169es sauvegard\195\169es"
	ENCHANTINGSELL_OPTION_BD_DEFAULTCOMPONANTEBUTTON				= "Prendre la BD ingredients par defaut"
	ENCHANTINGSELL_OPTION_BD_DEFAULTENCHANTEBUTTON					= "Prendre la BD enchantements par defaut"

	ENCHANTINGSELL_OPTION_CHAT_SHOWPRICEFORCHATINFO					= "Envoyer le prix lors du transfert chat";
	ENCHANTINGSELL_OPTION_USE_AUCTIONEER						= "Employez La Base de donn�es D'Ench�re? ";
	ENCHANTINGSELL_OPTION_USE_MINIMAP_BUTTON					= "Use Minimap icon? ";
	ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE						= "Arrondi sur les prix calcul�s";
	ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE_TYPE1					= "Aucun (1Go 56Si 33Co)";
	ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE_TYPE2					= "Arrondi xx.xx (1Go57)";
	ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE_TYPE3					= "Arrondi xx (2Go)";

	
	ENCHANTINGSELL_OPTION_UI_MINIMAPPOSITION						= "Bouton MiniMap -> Position";
	
	ENCHANTINGSELL_TOOLTIPADD_TITLE									= "Ingredients d'enchantement";
	ENCHANTINGSELL_TOOLTIPADD_ONME									= "Sur Moi";
	ENCHANTINGSELL_TOOLTIPADD_INBANK								= "En banque";
	ENCHANTINGSELL_TOOLTIPADD_OTHERPLAYER							= "Les autres perso";
	ENCHANTINGSELL_TOOLTIPADD_PRICEUNITE							= "Prix Unitaire";

	NAME_SPELL_CRAFT_ENCHANTE										= "Enchantement";
	
	EnchantingSell_ToolsEnchanting = {
		{"B\195\162tonnet runique en cuivre"},
		{"B\195\162tonnet runique en argent"},
		{"B\195\162tonnet runique en or"},
		{"B\195\162tonnet runique en vrai-argent"},
		{"B\195\162tonnet runique en arcanite"},
	};
	
	EnchantingSell_ArmorCarac = {
		[1] = {"bottes", "Bottes"};		--boots
		[2] = {"bracelets", "Bracelets"};	--bracer
		[3] = {"plastron", "Plastron"};		--chest
		[4] = {"cape", "Cape"};			--cloak
		[5] = {"gants", "Gants"};		--gloves
		[6] = {"Huile", "Huile"};		--Oil
		[7] = {"B\195\162tonnet", "B\195\162tonnet"};	--Rod
		[8] = {"bouclier", "Bouclier"};		--shield
		[9] = {"Baguette", "Baguette"};		--wand
		[10] = {"arme 2M", "Arme 2M"};		--2h weapon
		[11] = {"arme", "Arme"};		--weapon
		[12] = {"Autres", "Autres"};		--Other
		Other = "Autres";
		All = "Tous";
	};
	
	EnchantingSell_Objet = {
		{"B\195\162tonnet runique en cuivre", "runiq cuivre", "B\195\162tonnet"},
		{"B\195\162tonnet runique en argent", "runiq argent", "B\195\162tonnet"},
		{"B\195\162tonnet runique en or", "runiq or", "B\195\162tonnet"},
		{"B\195\162tonnet runique en vrai-argent", "runiq v-argent", "B\195\162tonnet"},
		{"B\195\162tonnet runique en arcanite", "runiq arcanite", "B\195\162tonnet"},
		{"Baguette magique inf\195\169rieure", "(Arc)dps:05.7", "Baguette"},
		{"Baguette magique sup\195\169rieure", "(Arc)dps:11.9", "Baguette"},
		{"Baguette mystique inf\195\169rieure", "(Arc)dps:23.1", "Baguette"},
		{"Baguette mystique sup\195\169rieure", "(Arc)dps:27.2", "Baguette"},
		{"Huile de mana mineure", "Mana +4", "Huile"},
		{"Huile de mana inférieure", "Mana +8", "Huile"},
		{"Huile de mana brillante", "Mana +12", "Huile"},		--Brilliant Mana Oil 
		{"Huile de sorcier mineure", "Spl Dmg +8", "Huile"},
		{"Huile de sorcier inférieure", "Spl Dmg +16", "Huile"},
		{"Huile de sorcier", "Spl Dmg +24", "Huile"},
		{"Huile de sorcier brillante", "Spl Dmg +36", "Huile"},		--Brilliant Oil 
	};
	
	EnchantingSell_Quality = {
		["Quality_OneCarac"] = {
			[1] = {"mineur"; 1};
			[2] = {"inf\195\169rieur"; 3};
			[3] = {"None"; 5};
			[4] = {"sup\195\169rieur"; 7};
			[5] = {"excellent"; 9};
		};
		["Quality_Int_Weapon"] = {
			[1] = {"mineur"; 1};
			[2] = {"inf\195\169rieur"; 3};
			[3] = {"None"; 5};
			[5] = {"sup\195\169rieur"; 7};
			[6] = {"excellent"; 9};
			[7] = {"puissant"; 22};
		};
		["Quality_Spirit_Weapon"] = {
			[1] = {"mineur"; 1};
			[2] = {"inf\195\169rieur"; 3};
			[3] = {"None"; 5};
			[5] = {"sup\195\169rieur"; 7};
			[6] = {"excellent"; 9};
			[7] = {"puissant"; 20};
		};
		["Quality_Life"] = {
			[1] = {"mineur"; 5};
			[2] = {"inf\195\169rieur"; 15};
			[3] = {"None"; 25};
			[4] = {"sup\195\169rieur"; 35};
			[5] = {"excellent"; 50};
			[6] = {"majeur"; 100};
		};
		["Quality_Mana"] = {
			[1] = {"mineur"; 5};
			[2] = {"inf\195\169rieur"; 20};
			[3] = {"None"; 30};
			[4] = {"sup\195\169rieur"; 50};
			[5] = {"excellent"; 65};
		};
		["Quality_Caract"] = {
			[1] = {"mineur"; 1};
			[2] = {"inf\195\169rieur"; 2};
			[3] = {"None"; 3};
		};	
		["Quality_Armure"] = {
			[1] = {"mineur"; 10};
			[2] = {"inf\195\169rieur"; 20};
			[3] = {"None"; 30};
			[4] = {"sup\195\169rieur"; 50};
			[5] = {"excellent"; 70};
		};	
		["Quality_Defence"] = {
			[1] = {"mineur"; 1};
			[2] = {"inf\195\169rieur"; 2};
			[3] = {"None"; 3};
		};	
		["Quality_Degat1M"] = {
			[1] = {"mineur"; 1};
			[2] = {"inf\195\169rieur"; 2};
			[3] = {"None"; 3};
			[4] = {"sup\195\169rieur"; 4};
			[5] = {"excellent"; 5};
		};	
		["Quality_Degat2M"] = {
			[1] = {"mineur"; 2};
			[2] = {"inf\195\169rieur"; 3};
			[3] = {"None"; 5};
			[4] = {"sup\195\169rieur"; 7};
			[5] = {"excellent"; 9};
		};	
		["Quality_Tueur"] = {
			[1] = {"mineur"; 2};
			[2] = {"inf\195\169rieur"; 6};
--~ 			[3] = {"None"; 0};
		};	
		["Quality_Absorption"] = {
			[1] = {"mineur"; "2% Abs10pv"};
			[2] = {"inf\195\169rieur"; "5% Abs25pv"};
--~ 			[3] = {"None"; 0};
		};	
		["Quality_Metier"] = {
			[1] = {"None"; 2};
			[4] = {"avanc\195\169"; 5};
		};	
		["Quality_ResistFeu"] = {
			[1] = {"inf."; 5};
			[2] = {"None"; 7};
		};	
		["Quality_AllResist"] = {
			[1] = {"mineur"; 1};
			[3] = {"None"; 3};
			[4] = {"sup\195\169rieur"; 5};
		};	
		["Quality_ForNew"] = {
			[1] = {"mineur"; 0};
			[2] = {"inf\195\169rieur"; 0};
			[3] = {"None"; 0};
			[4] = {"sup\195\169rieur"; 0};
			[5] = {"excellent"; 0};
			[6] = {"majeur"; 0};
		};	
		["Quality_Agility_Gloves"] = {
			[1] = {"None"; 5};
			[2] = {"Greater"; 7};
			[3] = {"Superior"; 15};
		};	
	};

EnchantingSell_ForTakeNameCaracBonusModel = "^(.+)%(.+%)";
EnchantingSell_ForTakeQualityBonusModel = "^.+%((.+)%)";
	
	EnchantingSell_BonusCarac = {
		{"Protection";							"Armure";					{[1] = {"inf\195\169rieur"; 30}};					"Bouclier"};
		{"Agilit\195\169";						"Agi";						{[1] = {"None"; 15}};								"Arme"};
		{"Agilit\195\169";						"Agi";						{[1] = {"None"; 25}};								"Arme 2M"};
		{"Agilit\195\169";						"Agi";						EnchantingSell_Quality["Quality_OneCarac"];			nil};
		{"Agilit\195\169";						"Agi";						EnchantingSell_Quality["Quality_Agility_Gloves"];					"Gants"};
		{"Force";								"Force";					{[1] = {"None"; 15}};								"Arme"};
		{"Intelligence";						"Int";						EnchantingSell_Quality["Quality_Int_Weapon"];		"Arme"};
		{"Esprit";								"Esprit";					EnchantingSell_Quality["Quality_Spirit_Weapon"];	"Arme"};
		{"Intelligence";						"Int";						EnchantingSell_Quality["Quality_OneCarac"];			nil};
		{"Esprit";								"Esprit";					EnchantingSell_Quality["Quality_OneCarac"];			nil};
		{"Endurance";							"End";						EnchantingSell_Quality["Quality_OneCarac"];			nil};
		{"Force";								"Force";					EnchantingSell_Quality["Quality_OneCarac"];			nil};
		{"Vie";									"Vie";						EnchantingSell_Quality["Quality_Life"];				nil};
		{"Sant\195\169";						"Vie";						EnchantingSell_Quality["Quality_Life"];				nil};
		{"Mana";								"Mana";						EnchantingSell_Quality["Quality_Mana"];				nil};
		{"Caract\195\169ristiques";				"Carac";					EnchantingSell_Quality["Quality_Caract"];			nil};
		{"Caract.";								"Carac";					EnchantingSell_Quality["Quality_Caract"];			nil};
		{"D\195\169fense";						"Armure";					EnchantingSell_Quality["Quality_Armure"];			nil};
		{"Protection";							"Armure";					EnchantingSell_Quality["Quality_Armure"];			nil};
		{"D\195\169viation";					"D\195\169fence";			EnchantingSell_Quality["Quality_Defence"];			nil};
		{"R\195\169sistance \195\160 l'ombre";	"R\195\169si omb";			{[1] = {"inf."; 10}};								nil};
		{"R\195\169sistance au feu";			"R\195\169si  feu";			EnchantingSell_Quality["Quality_ResistFeu"];		nil};
		{"R\195\169sistance";					"R\195\169si";				EnchantingSell_Quality["Quality_AllResist"];		nil};
		{"Frappe";								"D\195\169gats";			EnchantingSell_Quality["Quality_Degat1M"];			nil};
		{"Impact";								"D\195\169gats";			EnchantingSell_Quality["Quality_Degat2M"];			nil};
		{"impact";								"D\195\169gats";			EnchantingSell_Quality["Quality_Degat2M"];			nil};
		{"Tueur de d\195\169mons";				"T Demons";					nil;												nil};
		{"Tueur de b\195\170te";				"T B\195\170te";			EnchantingSell_Quality["Quality_Tueur"];			nil};
		{"Tueur d'\195\169l\195\169mentaire";	"T El\195\169ment";			EnchantingSell_Quality["Quality_Tueur"];			nil};
		{"Blocage";								"Blocage";					{[1] = {"inf\195\169rieur"; "2%"}};					nil};
		{"D\195\169pe\195\167age";				"D\195\169pe\195\167age";	{[1] = {"None"; 5}};								nil};
		{"Absorption";							"";							EnchantingSell_Quality["Quality_Absorption"];		nil};
		{"Herboristerie";						"Herbo";					EnchantingSell_Quality["Quality_Metier"];			nil};
		{"Minage";								"Minage";					EnchantingSell_Quality["Quality_Metier"];			nil};
		{"P\195\170che";						"P\195\170che";				EnchantingSell_Quality["Quality_Metier"];			nil};
		{"H\195\162te";							"Vit d'atta";				{[1] = {"mineur"; "1%"}};							nil};
	};
	
	DescritionDefaultReagents = {
		[1] = {
			["Name"] = "Poussi\195\168re \195\169trange",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armures. Objet vert lvl 1-20 (valeur estim\195\169e \195\160 5 PA).",
		},
		[2] = {
			["Name"] = "Poussi\195\168re d'\195\162me",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armures. Objet vert lvl 21-30 (valeur estim\195\169e \195\160 10 PA).",
		},
		[3] = {
			["Name"] = "Poussi\195\168re de vision",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armures. Objet vert lvl 31-40 (valeur estim\195\169e \195\160 25 PA).",
		},
		[4] = {
			["Name"] = "Poussi\195\168re de r\195\170ve",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armures. Objet vert lvl 41-50 (valeur estim\195\169e \195\160 50 PA).",
		},
		[5] = {
			["Name"] = "Poudre d'illusion",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armures. Objet vert lvl 51-60 (valeur estim\195\169e \195\160 1.30 PO).",
		},
		[6] = {
			["Name"] = "Essence de magie inf\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 1-10 (valeur estim\195\169e \195\160 6 PA).",
		},
		[7] = {
			["Name"] = "Essence de magie sup\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 11-15 (valeur estim\195\169e \195\160 18 PA).",
		},
		[8] = {
			["Name"] = "Essence astrale inf\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 16-20 (valeur estim\195\169e \195\160 20 PA).",
		},
		[9] = {
			["Name"] = "Essence astrale sup\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 21-25 (valeur estim\195\169e \195\160 60 PA).",
		},
		[10] = {
			["Name"] = "Essence mystique inf\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 26-30 (valeur estim\195\169e \195\160 40 PA).",
		},
		[11] = {
			["Name"] = "Essence mystique sup\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 31-35 (valeur estim\195\169e \195\160 1.20 PO).",
		},
		[12] = {
			["Name"] = "Essence du n\195\169ant inf\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 36-40 (valeur estim\195\169e \195\160 80 PA).",
		},
		[13] = {
			["Name"] = "Essence du n\195\169ant sup\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 41-45 (valeur estim\195\169e \195\160 2.40 PO).",
		},
		[14] = {
			["Name"] = "Essence \195\169ternelle inf\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 46-50 (valeur estim\195\169e \195\160 1.20 PO).",
		},
		[15] = {
			["Name"] = "Essence \195\169ternelle sup\195\169rieure",
			["Description"] = "Se trouvent g\195\169n\195\169ralement sur les armes. Objet vert lvl 51-60 (valeur estim\195\169e \195\160 3.60 PO).",
		},
		[16] = {
			["Name"] = "Petit \195\169clat scintillant",
			["Description"] = "Se trouvent uniquement sur les objets bleus (et violets). Objet bleu lvl 1-20 (valeur estim\195\169e \195\160 35 PA).",
		},
		[17] = {
			["Name"] = "Gros \195\169clat scintillant",
			["Description"] = "Se trouvent uniquement sur les objets bleus (et violets). Objet bleu lvl 21-25 (valeur estim\195\169e \195\160 90 PA).",
		},
		[18] = {
			["Name"] = "Petit \195\169clat lumineux",
			["Description"] = "Se trouvent uniquement sur les objets bleus (et violets). Objet bleu lvl 26-30 (valeur estim\195\169e \195\160 1.50 PO).",
		},
		[19] = {
			["Name"] = "Gros \195\169clat lumineux",
			["Description"] = "Se trouvent uniquement sur les objets bleus (et violets). Objet bleu lvl 31-35 (valeur estim\195\169e \195\160 2.20 PO).",
		},
		[20] = {
			["Name"] = "Petit \195\169clat irradiant",
			["Description"] = "Se trouvent uniquement sur les objets bleus (et violets). Objet bleu lvl 36-40 (valeur estim\195\169e \195\160 2.70 PO).",
		},
		[21] = {
			["Name"] = "Gros \195\169clat irradiant",
			["Description"] = "Se trouvent uniquement sur les objets bleus (et violets). Objet bleu lvl 41-45 (valeur estim\195\169e \195\160 5 PO).",
		},
		[22] = {
			["Name"] = "Petit \195\169clat brillant",
			["Description"] = "Se trouvent uniquement sur les objets bleus (et violets). Objet bleu lvl 46-50 (valeur estim\195\169e \195\160 6 PO).",
		},
		[23] = {
			["Name"] = "Grand \195\169clat brillant",
			["Description"] = "Se trouvent uniquement sur les objets bleus (et violets). Objet bleu lvl 51-60 (valeur estim\195\169e \195\160 8.50 PO).",
		},
		[24] = {
			["Name"] = "B\195\162tonnet de cuivre",
			["Description"] = "Vendu par les PNJ vendeurs de Fourniture d'enchanteur \195\160 99PC.",
		},
		[25] = {
			["Name"] = "B\195\162tonnet d'argent",
			["Description"] = "Fabriqu\195\169 par les forgerons de lvl 100 mini.",
		},
		[26] = {
			["Name"] = "B\195\162tonnet en or",
			["Description"] = "Fabriqu\195\169 par les forgerons de lvl 150 mini.",
		},
		[27] = {
			["Name"] = "B\195\162tonnet en vrai-argent",
			["Description"] = "Fabriqu\195\169 par les forgerons de lvl 200 mini.",
		},
		[28] = {
			["Name"] = "B\195\162tonnet en arcanite",
			["Description"] = "Fabriqu\195\169 par les forgerons de lvl 275 mini.",
		},
		[29] = {
			["Name"] = "Bois simple",
			["Description"] = "Vendu par les PNJ vendeurs de Fourniture d'enchanteur \195\160 30PC.",
		},
		[30] = {
			["Name"] = "Bois d'\195\169toile",
			["Description"] = "Vendu par les PNJ vendeurs de Fourniture d'enchanteur \195\160 36PA.",
		},
	};
	
	-- Svg Parciel de BD pour chargement par defaut a l'inizalisation logiciel
	EnchantingSell_DefaultList = {
		Componantes = {
			[1] = {
				["PriceUnite"] = 2500,
				["Link"] = "|cff1eff00|Hitem:7909:0:0:0|h[Aquamarine]|h|r",
				["Name"] = "Aquamarine",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Crystal_02",
			},
			[2] = {
				["PriceUnite"] = 2250,
				["Link"] = "|cffffffff|Hitem:12359:0:0:0|h[Barre de thorium]|h|r",
				["Name"] = "Barre de thorium",
				["Texture"] = "Interface\\Icons\\INV_Ingot_07",
			},
			[3] = {
				["PriceUnite"] = 4500,
				["Link"] = "|cff1eff00|Hitem:6037:0:0:0|h[Barre de vrai-argent]|h|r",
				["Name"] = "Barre de vrai-argent",
				["Texture"] = "Interface\\Icons\\INV_Ingot_08",
			},
			[4] = {
				["PriceUnite"] = 4500,
				["Link"] = "|cffffffff|Hitem:11291:0:0:0|h[Bois d'étoile]|h|r",
				["Name"] = "Bois d'étoile",
				["Texture"] = "Interface\\Icons\\INV_TradeskillItem_03",
			},
			[5] = {
				["PriceUnite"] = 38,
				["Link"] = "|cffffffff|Hitem:4470:0:0:0|h[Bois simple]|h|r",
				["Name"] = "Bois simple",
				["Texture"] = "Interface\\Icons\\INV_TradeskillItem_01",
			},
			[6] = {
				["PriceUnite"] = 3333,
				["Link"] = "|cffffffff|Hitem:13467:0:0:0|h[Calot de glace]|h|r",
				["Name"] = "Calot de glace",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_IceCap",
			},
			[7] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cffffffff|Hitem:8170:0:0:0|h[Cuir grossier]|h|r",
				["Name"] = "Cuir grossier",
				["Texture"] = "Interface\\Icons\\INV_Misc_LeatherScrap_02",
			},
			[8] = {
				["PriceUnite"] = 200,
				["Link"] = "|cffffffff|Hitem:7392:0:0:0|h[Ecaille de Dragonnet vert]|h|r",
				["Name"] = "Ecaille de Dragonnet vert",
				["Texture"] = "Interface\\Icons\\INV_Misc_MonsterScales_03",
			},
			[9] = {
				["PriceUnite"] = 14500,
				["Link"] = "|cffffffff|Hitem:9224:0:0:0|h[Elixir de Tueur de Démons]|h|r",
				["Name"] = "Elixir de Tueur de Démons",
				["Texture"] = "Interface\\Icons\\INV_Potion_27",
			},
			[10] = {
				["PriceUnite"] = 2000,
				["Link"] = "|cff1eff00|Hitem:10998:0:0:0|h[Essence astrale inférieure]|h|r",
				["Name"] = "Essence astrale inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralSmall",
			},
			[11] = {
				["PriceUnite"] = 6000,
				["Link"] = "|cff1eff00|Hitem:11082:0:0:0|h[Essence astrale supérieure]|h|r",
				["Name"] = "Essence astrale supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
			},
			[12] = {
				["PriceUnite"] = 250000,
				["Link"] = "|cff1eff00|Hitem:7082:0:0:0|h[Essence d'air]|h|r",
				["Name"] = "Essence d'air",
				["Texture"] = "Interface\\Icons\\Spell_Nature_EarthBind",
			},
			[13] = {
				["PriceUnite"] = 50600,
				["Link"] = "|cff1eff00|Hitem:7080:0:0:0|h[Essence d'eau]|h|r",
				["Name"] = "Essence d'eau",
				["Texture"] = "Interface\\Icons\\Spell_Nature_Acid_01",
			},
			[14] = {
				["PriceUnite"] = 600,
				["Link"] = "|cff1eff00|Hitem:10938:0:0:0|h[Essence de magie inférieure]|h|r",
				["Name"] = "Essence de magie inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicSmall",
			},
			[15] = {
				["PriceUnite"] = 1800,
				["Link"] = "|cff1eff00|Hitem:10939:0:0:0|h[Essence de magie supérieure]|h|r",
				["Name"] = "Essence de magie supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
			},
			[16] = {
				["PriceUnite"] = 8000,
				["Link"] = "|cff1eff00|Hitem:11174:0:0:0|h[Essence du néant inférieure]|h|r",
				["Name"] = "Essence du néant inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherSmall",
			},
			[17] = {
				["PriceUnite"] = 24000,
				["Link"] = "|cff1eff00|Hitem:11175:0:0:0|h[Essence du néant supérieure]|h|r",
				["Name"] = "Essence du néant supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherLarge",
			},
			[18] = {
				["PriceUnite"] = 4000,
				["Link"] = "|cff1eff00|Hitem:11134:0:0:0|h[Essence mystique inférieure]|h|r",
				["Name"] = "Essence mystique inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalSmall",
			},
			[19] = {
				["PriceUnite"] = 12000,
				["Link"] = "|cff1eff00|Hitem:11135:0:0:0|h[Essence mystique supérieure]|h|r",
				["Name"] = "Essence mystique supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge",
			},
			[20] = {
				["PriceUnite"] = 12000,
				["Link"] = "|cff1eff00|Hitem:16202:0:0:0|h[Essence éternelle inférieure]|h|r",
				["Name"] = "Essence éternelle inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceEternalSmall",
			},
			[21] = {
				["PriceUnite"] = 36000,
				["Link"] = "|cff1eff00|Hitem:16203:0:0:0|h[Essence éternelle supérieure]|h|r",
				["Name"] = "Essence éternelle supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceEternalLarge",
			},
			[22] = {
				["PriceUnite"] = 1200,
				["Link"] = "|cffffffff|Hitem:7068:0:0:0|h[Feu élémentaire]|h|r",
				["Name"] = "Feu élémentaire",
				["Texture"] = "Interface\\Icons\\Spell_Fire_Fire",
			},
			[23] = {
				["PriceUnite"] = 1500,
				["Link"] = "|cffffffff|Hitem:5637:0:0:0|h[Grand croc]|h|r",
				["Name"] = "Grand croc",
				["Texture"] = "Interface\\Icons\\INV_Misc_Bone_08",
			},
			[24] = {
				["PriceUnite"] = 85000,
				["Link"] = "|cff0070dd|Hitem:14344:0:0:0|h[Grand éclat brillant]|h|r",
				["Name"] = "Grand éclat brillant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardBrilliantLarge",
			},
			[25] = {
				["PriceUnite"] = 50000,
				["Link"] = "|cff0070dd|Hitem:11178:0:0:0|h[Gros éclat irradiant]|h|r",
				["Name"] = "Gros éclat irradiant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientLarge",
			},
			[26] = {
				["PriceUnite"] = 220,
				["Link"] = "|cff0070dd|Hitem:11139:0:0:0|h[Gros éclat lumineux]|h|r",
				["Name"] = "Gros éclat lumineux",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingLarge",
			},
			[27] = {
				["PriceUnite"] = 9000,
				["Link"] = "|cff0070dd|Hitem:11084:0:0:0|h[Gros éclat scintillant]|h|r",
				["Name"] = "Gros éclat scintillant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringLarge",
			},
			[28] = {
				["PriceUnite"] = 506,
				["Link"] = "|cffffffff|Hitem:6370:0:0:0|h[Huile de Bouche-noire]|h|r",
				["Name"] = "Huile de Bouche-noire",
				["Texture"] = "Interface\\Icons\\INV_Drink_12",
			},
			[29] = {
				["PriceUnite"] = 2505,
				["Link"] = "|cffffffff|Hitem:6371:0:0:0|h[Huile de feu]|h|r",
				["Name"] = "Huile de feu",
				["Texture"] = "Interface\\Icons\\INV_Potion_38",
			},
			[30] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cff1eff00|Hitem:1210:0:0:0|h[Oeil ténébreux]|h|r",
				["Name"] = "Oeil ténébreux",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Amethyst_01",
			},
			[31] = {
				["PriceUnite"] = 290000,
				["Link"] = "|cff1eff00|Hitem:12811:0:0:0|h[Orbe de piété]|h|r",
				["Name"] = "Orbe de piété",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_03",
			},
			[32] = {
				["PriceUnite"] = 40000,
				["Link"] = "|cff1eff00|Hitem:13926:0:0:0|h[Perle dorée]|h|r",
				["Name"] = "Perle dorée",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_04",
			},
			[33] = {
				["PriceUnite"] = 9500,
				["Link"] = "|cff1eff00|Hitem:5500:0:0:0|h[Perle iridescente]|h|r",
				["Name"] = "Perle iridescente",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_02",
			},
			[34] = {
				["PriceUnite"] = 8000,
				["Link"] = "|cff1eff00|Hitem:7971:0:0:0|h[Perle noire]|h|r",
				["Name"] = "Perle noire",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_01",
			},
			[35] = {
				["PriceUnite"] = 60000,
				["Link"] = "|cff0070dd|Hitem:14343:0:0:0|h[Petit éclat brillant]|h|r",
				["Name"] = "Petit éclat brillant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardBrilliantSmall",
			},
			[36] = {
				["PriceUnite"] = 27000,
				["Link"] = "|cff0070dd|Hitem:11177:0:0:0|h[Petit éclat irradiant]|h|r",
				["Name"] = "Petit éclat irradiant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientSmall",
			},
			[37] = {
				["PriceUnite"] = 15000,
				["Link"] = "|cff0070dd|Hitem:11138:0:0:0|h[Petit éclat lumineux]|h|r",
				["Name"] = "Petit éclat lumineux",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingSmall",
			},
			[38] = {
				["PriceUnite"] = 3500,
				["Link"] = "|cff0070dd|Hitem:10978:0:0:0|h[Petit éclat scintillant]|h|r",
				["Name"] = "Petit éclat scintillant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringSmall",
			},
			[39] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cffffffff|Hitem:6048:0:0:0|h[Potion de protection contre les ténèbres]|h|r",
				["Name"] = "Potion de protection contre les ténèbres",
				["Texture"] = "Interface\\Icons\\INV_Potion_44",
			},
			[40] = {
				["PriceUnite"] = 10075,
				["Link"] = "|cffffffff|Hitem:16204:0:0:0|h[Poudre d'illusion]|h|r",
				["Name"] = "Poudre d'illusion",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustIllusion",
			},
			[41] = {
				["PriceUnite"] = 800,
				["Link"] = "|cffffffff|Hitem:11083:0:0:0|h[Poussière d'âme]|h|r",
				["Name"] = "Poussière d'âme",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustSoul",
			},
			[42] = {
				["PriceUnite"] = 5000,
				["Link"] = "|cffffffff|Hitem:11176:0:0:0|h[Poussière de rêve]|h|r",
				["Name"] = "Poussière de rêve",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustDream",
			},
			[43] = {
				["PriceUnite"] = 1590,
				["Link"] = "|cffffffff|Hitem:11137:0:0:0|h[Poussière de vision]|h|r",
				["Name"] = "Poussière de vision",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustVision",
			},
			[44] = {
				["PriceUnite"] = 500,
				["Link"] = "|cffffffff|Hitem:10940:0:0:0|h[Poussière étrange]|h|r",
				["Name"] = "Poussière étrange",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustStrange",
			},
			[45] = {
				["PriceUnite"] = 175,
				["Link"] = "|cffffffff|Hitem:3356:0:0:0|h[Sang-royal]|h|r",
				["Name"] = "Sang-royal",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_03",
			},
			[46] = {
				["PriceUnite"] = 8400,
				["Link"] = "|cffffffff|Hitem:8153:0:0:0|h[Sauvageonne]|h|r",
				["Name"] = "Sauvageonne",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_03",
			},
			[47] = {
				["PriceUnite"] = 3500,
				["Link"] = "|cffffffff|Hitem:8838:0:0:0|h[Soleillette]|h|r",
				["Name"] = "Soleillette",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_18",
			},
			[48] = {
				["PriceUnite"] = 1200,
				["Link"] = "|cffffffff|Hitem:7067:0:0:0|h[Terre élémentaire]|h|r",
				["Name"] = "Terre élémentaire",
				["Texture"] = "Interface\\Icons\\INV_Ore_Iron_01",
			},
			[49] = {
				["PriceUnite"] = 800000,
				["Link"] = "|cffffffff|Hitem:16206:0:0:0|h[Bâtonnet en arcanite]|h|r",
				["Name"] = "Bâtonnet en arcanite",
				["Texture"] = "Interface\\Icons\\INV_Staff_19",
			},
			[50] = {
				["PriceUnite"] = 29900,
				["Link"] = "|cff1eff00|Hitem:12803:0:0:0|h[Essence de vie]|h|r",
				["Name"] = "Essence de vie",
				["Texture"] = "Interface\\Icons\\Spell_Nature_AbolishMagic",
			},
			[51] = {
				["PriceUnite"] = 2500,
				["Link"] = "|cffffffff|Hitem:6338:0:0:0|h[Bâtonnet en argent]|h|r",
				["Name"] = "Bâtonnet en argent",
				["Texture"] = "Interface\\Icons\\INV_Staff_01",
			},
			[52] = {
				["PriceUnite"] = 124,
				["Link"] = "|cffffffff|Hitem:6217:0:0:0|h[Bâtonnet en cuivre]|h|r",
				["Name"] = "Bâtonnet en cuivre",
				["Texture"] = "Interface\\Icons\\INV_Misc_Flute_01",
			},
			[53] = {
				["PriceUnite"] = 7711,
				["Link"] = "|cffffffff|Hitem:11128:0:0:0|h[Bâtonnet en or]|h|r",
				["Name"] = "Bâtonnet en or",
				["Texture"] = "Interface\\Icons\\INV_Staff_10",
			},
			[54] = {
				["PriceUnite"] = 12250,
				["Link"] = "|cffffffff|Hitem:11144:0:0:0|h[Bâtonnet en vrai-argent]|h|r",
				["Name"] = "Bâtonnet en vrai-argent",
				["Texture"] = "Interface\\Icons\\INV_Staff_11",
			},
			["Nb"] = 54,
		};
		Enchantes = {
			[1] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers augmentent de 1 la Défense.",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence de magie inférieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Poussière étrange",
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Déviation mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Défence",
			},
			[2] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de 5 aux points de vie.",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Poussière étrange",
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Vie mineure)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vie",
			},
			[3] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:6218:0:0:0|h[Bâtonnet runique en cuivre]|h|r",
				["LongName"] = "Bâtonnet runique en cuivre",
				["Name"] = "Bâtonnet runique en cuivre",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Bâtonnet en cuivre",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Poussière étrange",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Essence de magie inférieure",
					},
					["Etat"] = -2,
				},
				["Icon"] = "Interface\\Icons\\INV_Staff_Goldfeathered_01",
				["Bonus"] = "runiq cuivre",
			},
			[4] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée. Lorsque vous attaquez, elle vous rend régulièrement 75 à 125 points de vie et augmente votre Force de 100 pendant 15 sec.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Grand éclat brillant",
						["Count"] = 4,
					},
					[2] = {
						["Name"] = "Orbe de piété",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Croisé)",
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en arcanite",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Croisé",
			},
			[5] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée (+1 points de dégâts supplémentaire).",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Essence de magie supérieure",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Petit éclat scintillant",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Frappe mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dégats",
			},
			[6] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière inflige 2 points de dégâts supplémentaires..",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Gros éclat scintillant",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Frappe inférieure)",
				["BonusNb"] = 2,
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dégats",
			},
			[7] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière inflige 3 points de dégâts supplémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique supérieure",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Gros éclat lumineux",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Frappe)",
				["BonusNb"] = 3,
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dégats",
			},
			[8] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière confère un bonus de 4 points de dégâts supplémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Gros éclat irradiant",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Essence du néant supérieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Frappe supérieure)",
				["BonusNb"] = 4,
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dégats",
			},
			[9] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière gèle la cible régulièrement et réduit sa vitesse de déplacement et d'attaque.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Petit éclat brillant",
						["Count"] = 4,
					},
					[2] = {
						["Name"] = "Essence d'eau",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Essence d'air",
						["Count"] = 1,
					},
					[4] = {
						["Name"] = "Calot de glace",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Frisson glacial)",
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Frisson glacial",
			},
			[10] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée (+2 points de dégâts supplémentaires aux bêtes).",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 4,
					},
					[2] = {
						["Name"] = "Essence de magie supérieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Tueur de bête mineur)",
				["BonusNb"] = 2,
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "T Bête",
			},
			[11] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière inflige 6 points de dégâts supplémentaires aux bêtes.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Grand croc",
						["Count"] = 2,
					},
					[3] = {
						["Name"] = "Petit éclat lumineux",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Tueur de bête inférieur)",
				["BonusNb"] = 6,
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "T Bête",
			},
			[12] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière vous confère une chance d'assommer et d'infliger beaucoup de dégâts aux démons.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Petit éclat irradiant",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 2,
					},
					[3] = {
						["Name"] = "Elixir de Tueur de Démons",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Tueur de démons)",
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "T Demons",
			},
			[13] = {
				["OnThis"] = "Arme",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière inflige 6 points de dégâts supplémentaires contre les Elémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Terre élémentaire",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Petit éclat lumineux",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme (Tueur d'élémentaire inférieur)",
				["BonusNb"] = 6,
				["Name"] = "Ench. d'arme ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "T Elément",
			},
			[14] = {
				["OnThis"] = "Arme 2M",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains (+2 points de dégâts supplémentaires).",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 4,
					},
					[2] = {
						["Name"] = "Petit éclat scintillant",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme 2M (impact mineur)",
				["BonusNb"] = 2,
				["Name"] = "Ench. d'arme 2M ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dégats",
			},
			[15] = {
				["OnThis"] = "Arme 2M",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière inflige 3 points de dégâts supplémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 3,
					},
					[2] = {
						["Name"] = "Gros éclat scintillant",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme 2M (Impact inférieur)",
				["BonusNb"] = 3,
				["Name"] = "Ench. d'arme 2M ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dégats",
			},
			[16] = {
				["OnThis"] = "Arme 2M",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière inflige 5 points de dégâts supplémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de vision",
						["Count"] = 4,
					},
					[2] = {
						["Name"] = "Gros éclat lumineux",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme 2M (Impact)",
				["BonusNb"] = 5,
				["Name"] = "Ench. d'arme 2M ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dégats",
			},
			[17] = {
				["OnThis"] = "Arme 2M",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière inflige 7 points de dégâts supplémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Gros éclat irradiant",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme 2M (Impact supérieur)",
				["BonusNb"] = 7,
				["Name"] = "Ench. d'arme 2M ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dégats",
			},
			[18] = {
				["OnThis"] = "Arme 2M",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière inflige 9 points de dégâts supplémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Grand éclat brillant",
						["Count"] = 4,
					},
					[2] = {
						["Name"] = "Poudre d'illusion",
						["Count"] = 10,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme 2M (Impact excellent)",
				["BonusNb"] = 9,
				["Name"] = "Ench. d'arme 2M ",
				["Required"] = "Bâtonnet runique en arcanite",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dégats",
			},
			[19] = {
				["OnThis"] = "Arme 2M",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière ajoute 3 à l'Esprit.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence astrale inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière étrange",
						["Count"] = 6,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme 2M (Esprit inférieur)",
				["BonusNb"] = 3,
				["Name"] = "Ench. d'arme 2M ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Esprit",
			},
			[20] = {
				["OnThis"] = "Arme 2M",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière ajoute 3 à l'Intelligence.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence de magie supérieure",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. d'arme 2M (Intelligence inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. d'arme 2M ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Int",
			},
			[21] = {
				["OnThis"] = "Autres",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Link"] = "|cffffffff|Hitem:12810:0:0:0|h[Cuir enchanté]|h|r",
				["LongName"] = "Cuir enchanté",
				["Name"] = "Cuir enchanté",
				["Icon"] = "Interface\\Icons\\INV_Misc_Rune_05",
				["Reagents"] = {
					[1] = {
						["Name"] = "Cuir grossier",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence éternelle inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
			},
			[22] = {
				["OnThis"] = "Autres",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Thorium enchanté",
				["Name"] = "Thorium enchanté",
				["Icon"] = "Interface\\Icons\\INV_Ingot_Eternium",
				["Reagents"] = {
					[1] = {
						["Name"] = "Barre de thorium",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
			},
			[23] = {
				["OnThis"] = "Baguette",
				["Description"] = "Crée une Baguette magique inférieure.",
				["Link"] = "|cffffffff|Hitem:11287:0:0:0|h[Baguette magique inférieure]|h|r",
				["Reagents"] = {
					[1] = {
						["Name"] = "Bois simple",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence de magie inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Baguette magique inférieure",
				["Name"] = "Baguette magique inférieure",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\INV_Staff_02",
				["Bonus"] = "(Arc)dps:05.7",
			},
			[24] = {
				["OnThis"] = "Baguette",
				["Description"] = "Crée une Baguette magique supérieure.",
				["Link"] = "|cffffffff|Hitem:11288:0:0:0|h[Baguette magique supérieure]|h|r",
				["Reagents"] = {
					[1] = {
						["Name"] = "Bois simple",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence de magie supérieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Baguette magique supérieure",
				["Name"] = "Baguette magique supérieure",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\INV_Staff_07",
				["Bonus"] = "(Arc)dps:11.9",
			},
			[25] = {
				["OnThis"] = "Baguette",
				["Description"] = "Crée une Baguette mystique inférieure.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Bois d'étoile",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence mystique inférieure",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Baguette mystique inférieure",
				["Name"] = "Baguette mystique inférieure",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\INV_Staff_02",
				["Bonus"] = "(Arc)dps:23.1",
			},
			[26] = {
				["OnThis"] = "Baguette",
				["Description"] = "Crée une Baguette mystique supérieure.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Bois d'étoile",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence mystique supérieure",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Poussière de vision",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Baguette mystique supérieure",
				["Name"] = "Baguette mystique supérieure",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\INV_Wand_07",
				["Bonus"] = "(Arc)dps:27.2",
			},
			[27] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement une paire de bottes. Cette dernière augmente de 1 l'Agilité du porteur.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 6,
					},
					[2] = {
						["Name"] = "Essence astrale inférieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Agilité mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Agi",
			},
			[28] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement des bottes. Ces dernières vous confèrent un bonus de +3 en Agilité.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence mystique inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Agilité inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Agi",
			},
			[29] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement des bottes. Ces dernières vous confèrent un bonus de +5 en Agilité.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant supérieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Agilité)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Agi",
			},
			[30] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement une paire de bottes. Cette dernière augmente de 1 l'Endurance du porteur.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 8,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Endurance mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[31] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +3 en Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 4,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Endurance inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[32] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +5 en Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de vision",
						["Count"] = 5,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Endurance)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[33] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +7 à l'Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 10,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Endurance supérieure)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[34] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +3 en Esprit.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique supérieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence mystique inférieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Esprit inférieur)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Esprit",
			},
			[35] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +5 à l'Esprit.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence éternelle supérieure",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Essence éternelle inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Esprit)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Esprit",
			},
			[36] = {
				["OnThis"] = "Bottes",
				["Description"] = "Enchante définitivement des bottes, ce qui augmente la vitesse de déplacement du porteur.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Petit éclat irradiant",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Aquamarine",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Essence du néant inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bottes (Vitesse mineure)",
				["Name"] = "Ench. de bottes ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vitesse mineure",
			},
			[37] = {
				["OnThis"] = "Bouclier",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus supplémentaire de 30 à l'armure.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence astrale inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière étrange",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Petit éclat scintillant",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bouclier (Protection inférieure)",
				["BonusNb"] = 30,
				["Name"] = "Ench. de bouclier ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Armure",
			},
			[38] = {
				["OnThis"] = "Bouclier",
				["Description"] = "Augmente définitivement un bouclier. Ce dernier vous confère 2% de chances supplémentaires de bloquer.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique supérieure",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Poussière de vision",
						["Count"] = 2,
					},
					[3] = {
						["Name"] = "Gros éclat lumineux",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bouclier (Blocage inférieur)",
				["BonusNb"] = "2%",
				["Name"] = "Ench. de bouclier ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Blocage",
			},
			[39] = {
				["OnThis"] = "Bouclier",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de 1 en Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence astrale inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière étrange",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bouclier (Endurance mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bouclier ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[40] = {
				["OnThis"] = "Bouclier",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier vous confère un bonus de 3 en Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bouclier (Endurance inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bouclier ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[41] = {
				["OnThis"] = "Bouclier",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de +5 en Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de vision",
						["Count"] = 5,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bouclier (Endurance)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bouclier ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[42] = {
				["OnThis"] = "Bouclier",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de 3 en Esprit.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence astrale inférieure",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Poussière étrange",
						["Count"] = 4,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bouclier (Esprit inférieur)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bouclier ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Esprit",
			},
			[43] = {
				["OnThis"] = "Bouclier",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de +5 en Esprit.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique supérieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière de vision",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bouclier (Esprit)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bouclier ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Esprit",
			},
			[44] = {
				["OnThis"] = "Bouclier",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de +7 en Esprit.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant supérieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bouclier (Esprit supérieur)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bouclier ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Esprit",
			},
			[45] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de 1 à l'Agilité.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Essence de magie supérieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Agilité mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Agi",
			},
			[46] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +2 en Défense.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Déviation inférieure)",
				["BonusNb"] = 2,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Défence",
			},
			[47] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers vous confèrent un bonus de +3 en Défense.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant supérieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Déviation)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Défence",
			},
			[48] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets qui augmentent de 1 l'Endurance du porteur.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Endurance mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[49] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de 3 en Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Endurance inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[50] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers vous confèrent un bonus de +5 en Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 6,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Endurance)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[51] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +7 en Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 5,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Endurance supérieure)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[52] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +9 à l'Endurance.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poudre d'illusion",
						["Count"] = 15,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Endurance excellente)",
				["BonusNb"] = 9,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "End",
			},
			[53] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de 1 à l'Esprit.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence de magie inférieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Esprit mineur)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Esprit",
			},
			[54] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +5 en Esprit.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Esprit)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Esprit",
			},
			[55] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +7 en Esprit.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant inférieure",
						["Count"] = 3,
					},
					[2] = {
						["Name"] = "Poussière de vision",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Esprit supérieur)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Esprit",
			},
			[56] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets qui augmentent de 1 la force du porteur.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 5,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Force mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Force",
			},
			[57] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement un bracelet. Ce dernier confère un bonus de +3 en Force.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Force inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Force",
			},
			[58] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers vous confèrent un bonus de +5 en Force.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de vision",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Force)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Force",
			},
			[59] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers vous confèrent un bonus de +7 en Force.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Essence du néant supérieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Force supérieure)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Force",
			},
			[60] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement un bracelet. Ce dernier confère un bonus de 3 en Intelligence.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence astrale supérieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Intelligence inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Int",
			},
			[61] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +5 en Intelligence.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant inférieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Intelligence)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Int",
			},
			[62] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers augmentent les effets de vos sorts de guérison de 24.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Grand éclat brillant",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Poudre d'illusion",
						["Count"] = 20,
					},
					[3] = {
						["Name"] = "Essence éternelle supérieure",
						["Count"] = 4,
					},
					[4] = {
						["Name"] = "Essence de vie",
						["Count"] = 6,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Pouvoir de guérison)",
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en arcanite",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Pouvoir de guérison",
			},
			[63] = {
				["OnThis"] = "Bracelets",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers restaurent 4 points de mana toutes les 5 sec.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poudre d'illusion",
						["Count"] = 16,
					},
					[2] = {
						["Name"] = "Essence éternelle supérieure",
						["Count"] = 4,
					},
					[3] = {
						["Name"] = "Essence d'eau",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de bracelets (Régénération de mana)",
				["Name"] = "Ench. de bracelets ",
				["Required"] = "Bâtonnet runique en arcanite",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Régénération de mana",
			},
			[64] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:16207:0:0:0|h[Bâtonnet runique en arcanite]|h|r",
				["LongName"] = "Bâtonnet runique en arcanite",
				["Name"] = "Bâtonnet runique en arcanite",
				["Reagents"] = {
					[1] = {
						["Name"] = "Bâtonnet en arcanite",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Perle dorée",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Poudre d'illusion",
						["Count"] = 10,
					},
					[4] = {
						["Name"] = "Essence éternelle supérieure",
						["Count"] = 4,
					},
					[5] = {
						["Name"] = "Petit éclat brillant",
						["Count"] = 4,
					},
					[6] = {
						["Name"] = "Grand éclat brillant",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["Icon"] = "Interface\\Icons\\INV_Wand_09",
				["Bonus"] = "runiq arcanite",
			},
			[65] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:6339:0:0:0|h[Bâtonnet runique en argent]|h|r",
				["LongName"] = "Bâtonnet runique en argent",
				["Name"] = "Bâtonnet runique en argent",
				["Reagents"] = {
					[1] = {
						["Name"] = "Bâtonnet en argent",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière étrange",
						["Count"] = 6,
					},
					[3] = {
						["Name"] = "Essence de magie supérieure",
						["Count"] = 3,
					},
					[4] = {
						["Name"] = "Oeil ténébreux",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["Icon"] = "Interface\\Icons\\INV_Staff_01",
				["Bonus"] = "runiq argent",
			},
			[66] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:11130:0:0:0|h[Bâtonnet runique en or]|h|r",
				["LongName"] = "Bâtonnet runique en or",
				["Name"] = "Bâtonnet runique en or",
				["Reagents"] = {
					[1] = {
						["Name"] = "Bâtonnet en or",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Perle iridescente",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Essence astrale supérieure",
						["Count"] = 2,
					},
					[4] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["Icon"] = "Interface\\Icons\\INV_Staff_10",
				["Bonus"] = "runiq or",
			},
			[67] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:11145:0:0:0|h[Bâtonnet runique en vrai-argent]|h|r",
				["LongName"] = "Bâtonnet runique en vrai-argent",
				["Name"] = "Bâtonnet runique en vrai-argent",
				["Reagents"] = {
					[1] = {
						["Name"] = "Bâtonnet en vrai-argent",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Perle noire",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Essence mystique supérieure",
						["Count"] = 2,
					},
					[4] = {
						["Name"] = "Poussière de vision",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["Icon"] = "Interface\\Icons\\INV_Staff_11",
				["Bonus"] = "runiq v-argent",
			},
			[68] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 1 en Agilité.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence astrale inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Agilité mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Agi",
			},
			[69] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 3 en Agilité.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant inférieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Agilité inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Agi",
			},
			[70] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante un manteau pour qu'il donne 10 points d'armure supplémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 3,
					},
					[2] = {
						["Name"] = "Essence de magie supérieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Protection mineure)",
				["BonusNb"] = 10,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Armure",
			},
			[71] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère 20 points d'armure supplémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 6,
					},
					[2] = {
						["Name"] = "Petit éclat scintillant",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Protection inférieure)",
				["BonusNb"] = 20,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Armure",
			},
			[72] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière vous confère un bonus de 30 en armure.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Petit éclat lumineux",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Défense)",
				["BonusNb"] = 30,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Armure",
			},
			[73] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière vous confère un bonus de 50 points d'Armure supplémentaires.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de vision",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Défense supérieure)",
				["BonusNb"] = 50,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Armure",
			},
			[74] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 70 à l'armure.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poudre d'illusion",
						["Count"] = 8,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Défense excellente)",
				["BonusNb"] = 70,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Armure",
			},
			[75] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière vous confère un bonus de 1 aux Résistances à toutes les écoles de magie.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence de magie inférieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Résistance mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rési",
			},
			[76] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 3 à toutes les résistances.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Résistance)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rési",
			},
			[77] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière vous confère un bonus de 5 à la Résistance au feu.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Huile de feu",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence astrale inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Résistance au feu inf.)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rési  feu",
			},
			[78] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 7 en Résistance au feu.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Feu élémentaire",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Résistance au feu)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rési  feu",
			},
			[79] = {
				["OnThis"] = "Cape",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 10 en Résistance à l'ombre.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence astrale supérieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Potion de protection contre les ténèbres",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de cape (Résistance à l'ombre inf.)",
				["BonusNb"] = 10,
				["Name"] = "Ench. de cape ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rési omb",
			},
			[80] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +5 en Agilité.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière de vision",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Agilité)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Agi",
			},
			[81] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +7 à l'Agilité.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence éternelle inférieure",
						["Count"] = 3,
					},
					[2] = {
						["Name"] = "Poudre d'illusion",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Agilité supérieure)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Agi",
			},
			[82] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +5 en Dépeçage.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de vision",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Ecaille de Dragonnet vert",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Dépeçage)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dépeçage",
			},
			[83] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un léger bonus de déplacement lorsque vous êtes sur une monture.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Gros éclat irradiant",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Equitation)",
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Equitation",
			},
			[84] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent +5 à la Force.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant inférieure",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Poussière de vision",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Force)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Force",
			},
			[85] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers vous confèrent un bonus de +2 en Herboristerie.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Sang-royal",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Herboristerie)",
				["BonusNb"] = 2,
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Herbo",
			},
			[86] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +5 en Herboristerie.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de vision",
						["Count"] = 3,
					},
					[2] = {
						["Name"] = "Soleillette",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Herboristerie avancée)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Herbo",
			},
			[87] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +5 en minage.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de vision",
						["Count"] = 3,
					},
					[2] = {
						["Name"] = "Barre de vrai-argent",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Minage avancé)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Minage",
			},
			[88] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers vous confèrent un bonus de +2 en pêche.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Huile de Bouche-noire",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Pêche)",
				["BonusNb"] = 2,
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Pêche",
			},
			[89] = {
				["OnThis"] = "Gants",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +1% à la vitesse d'attaque.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Gros éclat irradiant",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Sauvageonne",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de gants (Hâte mineure)",
				["BonusNb"] = "1%",
				["Name"] = "Ench. de gants ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vit d'atta",
			},
			[90] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +1 à toutes les caractéristiques.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence astrale supérieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Gros éclat scintillant",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Caract. mineures)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Carac",
			},
			[91] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +2 à toutes les caractéristiques.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique supérieure",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Poussière de vision",
						["Count"] = 2,
					},
					[3] = {
						["Name"] = "Gros éclat lumineux",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Caract. inférieures)",
				["BonusNb"] = 2,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Carac",
			},
			[92] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +3 à toutes les caractéristiques.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Gros éclat irradiant",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière de rêve",
						["Count"] = 3,
					},
					[3] = {
						["Name"] = "Essence du néant supérieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Caractéristiques)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Carac",
			},
			[93] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de 5 aux points de mana.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence de magie inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Mana mineur)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[94] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement un plastron (+20 en mana pour le porteur).",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence de magie supérieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence de magie inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Mana inférieur)",
				["BonusNb"] = 20,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[95] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de 30 aux points de mana du porteur.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence astrale supérieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence astrale inférieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Mana)",
				["BonusNb"] = 30,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[96] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de 50 aux points de mana.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence mystique supérieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Mana supérieur)",
				["BonusNb"] = 50,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[97] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +65 points de mana.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence du néant supérieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Essence du néant inférieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Mana excellent)",
				["BonusNb"] = 65,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[98] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de 5 aux points de vie.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Vie mineure)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vie",
			},
			[99] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +15 aux points de vie.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Essence de magie inférieure",
						["Count"] = 2,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Vie inférieure)",
				["BonusNb"] = 15,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vie",
			},
			[100] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +25 aux points de vie du porteur.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 4,
					},
					[2] = {
						["Name"] = "Essence astrale inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Vie)",
				["BonusNb"] = 25,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vie",
			},
			[101] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +35 aux points de vie.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière d'âme",
						["Count"] = 3,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Vie supérieure)",
				["BonusNb"] = 35,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en or",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vie",
			},
			[102] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +50 points de vie.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière de vision",
						["Count"] = 6,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Santé excellente)",
				["BonusNb"] = 50,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vie",
			},
			[103] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +100 aux points de vie.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poudre d'illusion",
						["Count"] = 6,
					},
					[2] = {
						["Name"] = "Petit éclat brillant",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Vie majeure)",
				["BonusNb"] = 100,
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vie",
			},
			[104] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante une pièce d'armure de torse. Cette dernière a 2% de chances d'absorber 10 points de dégâts lorsque vous êtes touché.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Essence de magie inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Absorption mineure)",
				["BonusNb"] = "2% Abs10pv",
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en cuivre",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "",
			},
			[105] = {
				["OnThis"] = "Plastron",
				["Description"] = "Enchante une pièce d'armure de torse. Cette dernière a 5% de chances d'absorber 25 points de dégâts lorsque vous êtes touché.",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 2,
					},
					[2] = {
						["Name"] = "Essence astrale supérieure",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Gros éclat scintillant",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
				["LongName"] = "Ench. de plastron (Absorption inférieure)",
				["BonusNb"] = "5% Abs25pv",
				["Name"] = "Ench. de plastron ",
				["Required"] = "Bâtonnet runique en argent",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "",
			},
		}
	};
end
