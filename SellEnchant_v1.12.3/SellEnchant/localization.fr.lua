if (GetLocale() == "frFR") then 
	SELLENCHANT_MINIMAPBUTTON_TOOLTIP 						= "Lancer SellEnchant";
	
	SELLENCHANT_MSG_RESETDB									= "Base de donn\195\169es effac\195\169e.";
	SELLENCHANT_MSG_LOADDEFAULT_ENCHANT_DATA				= "Chargement de la base de composant par default.";
	SELLENCHANT_MSG_LOADDEFAULT_REAGENT_DATA				= "Chargement de la base de composant par default.";
	SELLENCHANT_MSG_RESETALLDATACONFIRM						= "Ete vous sur de vouloir r\195\169initialiser ce mod ?";
	SELLENCHANT_MSG_LOADDEFAULTCOMPONANTDBCONFIRM			= "Charger la base de composant avec prix par d\195\169faut ecrasera celle en cours; Ete vous sur de vouloir continuer ?";
	SELLENCHANT_MSG_LOADDEFAULTENCHANTDBCONFIRM				= "Charger la base d'enchantement par d\195\169faut ecrasera celle en cours; Ete vous sur de vouloir continuer ?";
	
	SELLENCHANT_MSG_ERROR_DEFAULTDBNOTLOADED				= "Aucune base de composant par Default n'existe chargement impossible";
	SELLENCHANT_MSG_ERROR_NEWASKIMPOSSIBLE					= "Une Question est d\195\169j\195\162 pos\195\169e; repondez y avant de lancer une nouvelle action";
	SELLENCHANT_MSG_ERROR_PRICELOADCANCEL					= "Autre Action la modification de prix en cours a \195\169t\195\169 annul\195\169";
	
	SELLENCHANT_TITLE										= "Sell Enchant "..SELLENCHANT_VERSION;
	SELLENCHANT_TAB_ENCHANT_NAME							= "Enchantements";
	SELLENCHANT_TAB_REAGENT_NAME							= "Composants";
	SELLENCHANT_TAB_OPTION_NAME								= "Option";
	
	SELLENCHANT_ENCHANT_MARKUPPRICE_HEADER					= "Prix calcul\195\169 avec le % de B\195\169n\195\169f :";
	SELLENCHANT_ENCHANT_MARKUPPRICE_CHECKBOX				= "Prendre le prix par calcul.";
	
	SELLENCHANT_LABEL_GOLD									= "Po"; -- Piece of Gold
	SELLENCHANT_LABEL_SILVER								= "Pa"; -- Piece of Silver
	SELLENCHANT_LABEL_COPPER								= "Pc"; -- Piece of Copper
	
	SELLENCHANT_ENCHANT_BUTTON_LABEL						= "Enchanter";
	SELLENCHANT_ENCHANT_SHOWPOSSIBLE						= "Trie par faisabilit\195\169";
	
	SELLENCHANT_ENCHANT_HEADER_NAME							= "Nom enchantement";
	SELLENCHANT_ENCHANT_HEADER_TYPE							= " "; -- Used to say "Type", but removed for 100g bug
	SELLENCHANT_ENCHANT_HEADER_ATTRIBUTE					= "Bonus";
	SELLENCHANT_ENCHANT_HEADER_PRICE						= "Prix";
	
	SELLENCHANT_ENCHANT_TOOLNEEDED_HEADER					= "N\195\169cessite :";
	SELLENCHANT_ENCHANT_DETAIL_TOOLNEED_ADDNAMEFORINBANK	= "(en banque)";
	SELLENCHANT_ENCHANT_DETAIL_TOOLNEED_ADDDOESNOTKNOW		= "(Apprendre cette enchante)";
	
	SELLENCHANT_ENCHANT_TOOLTIP_HEADER						= "Ent\195\170te Enchantements\n\r\n\rClic: Trie cette colonne\n\rUn deuxi\195\168me clic: Inverse le trie Croissant\n\r  en D\195\169croissant ou inversement";
	SELLENCHANT_ENCHANT_TOOLTIP_LIST						= "Enchantement\n\r\n\rShift Clic: Copie les infos de cette enchantement dans le chat\n\r\n\rCouleur:\n\rVert Clair-> Tous les composants sont dans les sacs.(Faisable)\n\rVert Fonc\195\169-> Certains composants sont en banque.\n\rMarron-> Insuffisant dans sac/banque mais possible avec ceux des ReRolls.\n\rRouge-> Ingredients insuffisant\n\rGris-> Enchantement non connu par l'enchanteur s\195\169lectionn\195\169.";
	SELLENCHANT_ENCHANT_TOOLTIP_DETAIL_NAMEDESCRIPTION		= "D\195\169tail Enchantement\n\r\n\rShift Clic: Copie le (Nom complet et Description) dans le chat";
	SELLENCHANT_ENCHANT_TOOLTIP_REAGENTS					= "Composant n\195\169cessaires\n\r\n\rShift Clic: Copie, pour ce composant,\n\r  le (Nom et Quantit\195\169) n\195\169cessaire dans le chat\n\rDouble Clic: Affiche le d\195\169tail de\n\r  ce composant";
	SELLENCHANT_ENCHANT_TOOLTIP_REAGENTSHEADER				= "Ent\195\170te Composants\n\r\n\rShift Clic: Copie, pour tous les composants\n\r  le (Nom et Quantit\195\169) n\195\169cessaire dans le chat.";
	SELLENCHANT_ADVERT_PREPOSITION							= " \195\160 "; -- " � "
	SELLENCHANT_ENCHANT_TOOLTIP_TOTALPRICE					= "Prix de l'enchantement\n\r\n\rDouble Clic: Modifier le prix de cette enchantement,\n\ravec un prix perso.\n\r\n\rCouleur:\n\rBlanc-> Prix par calcul.\n\rVert-> Prix Perso."
	
	SELLENCHANT_ENCHANT_REAGENT_HEADER_NAME					= "Nom Composant";
	SELLENCHANT_ENCHANT_REAGENT_HEADER_BAGANDNEEDED			= "S/QN";
	SELLENCHANT_ENCHANT_REAGENT_HEADER_BANKANDALTERNATE		= "B-RR";
	SELLENCHANT_ENCHANT_REAGENT_HEADER_ONEREAGENT			= "Prix U";
	SELLENCHANT_ENCHANT_REAGENT_HEADER_TOTAL				= "Prix T";
	
	SELLENCHANT_ENCHANT_REAGENT_HEADER_NOMARKUP				= "PT sans Benef";
	
	SELLENCHANT_REAGENT_HEADER_NAME							= "Nom Composant";
	SELLENCHANT_REAGENT_HEADER_BAG							= "Nb";
	SELLENCHANT_REAGENT_HEADER_BANK							= "Bank";
	SELLENCHANT_REAGENT_HEADER_ALTERNATE					= "ReRoll";
	SELLENCHANT_REAGENT_HEADER_COST							= "Prix U";
	
	SELLENCHANT_REAGENT_HEADER_PLAYERNAME					= "Nom du joueur";
	SELLENCHANT_REAGENT_HEADER_INBAG						= "Sacs";
	SELLENCHANT_REAGENT_HEADER_INBANK						= "Banque";
	
	SELLENCHANT_OPTION_LABEL_MARKUPPERCENTAGE				= "% de B\195\169n\195\169fice :";
	
	SELLENCHANT_OPTION_LABEL_SELECTEDENCHANTER				= "Enchanteur S\195\169l\195\169ctionn\195\169 :";
	SELLENCHANT_NOT_ENCHANTER				= "Aucun";
	SELLENCHANT_SELLENCHANT_OPTION_JOINPLAYERANDSERVER	= " sur ";
	SELLENCHANT_OPTION_MESSAGE_CONFIRMCHANGESERVER			= "Cette enchanteur est sur un autre serveur, les quantit\165\169s Sac, Banque et ReRoll seront effac\165\169s.\n\rVoulez vous continuer ?"
	
	SELLENCHANT_OPTION_SHOWPRICEINADVERT					= "Envoyer le prix lors du transfert chat";
	SELLENCHANT_OPTION_LABEL_USEMINIMAP						= "Disable MiniMap button.";
	SELLENCHANT_OPTION_USEAUCTIONEERDATA					= "Use auction house prices.";
	SELLENCHANT_OPTION_PRICE_ROUNDUPFORMAT					= "Arrondi sur les prix calcul�s";
	SELLENCHANT_OPTION_PRICE_ROUNDUPFORMAT_TYPE1			= "Aucun (1Go 56Si 33Co)";
	SELLENCHANT_OPTION_PRICE_ROUNDUPFORMAT_TYPE2			= "Arrondi xx.xx (1Go57)";
	SELLENCHANT_OPTION_PRICE_ROUNDUPFORMAT_TYPE3			= "Arrondi xx (2Go)";
	
	SELLENCHANT_OPTION_BUTTONG_DBRESET						= "Effacer toutes les donn\195\169es sauvegard\195\169es"
	SELLENCHANT_OPTION_BUTTON_DEFAULTREAGENT				= "Prendre la BD ingredients par defaut"
	SELLENCHANT_OPTION_BUTTON_DEFAULTENCHANT				= "Prendre la BD enchantements par defaut"
		
	SELLENCHANT_OPTION_MINIMAPBUTTONPOSITION				= "Bouton MiniMap -> Position";
	
	SELLENCHANT_TOOLTIPADD_TITLE							= "Ingredients d'enchantement";
	SELLENCHANT_TOOLTIPADD_ONCHARACTER						= "Sur Moi";
	SELLENCHANT_TOOLTIPADD_INBANK							= "En banque";
	SELLENCHANT_TOOLTIPADD_ALTERNATE						= "Les autres perso";
	SELLENCHANT_TOOLTIPADD_PRICEUNIT						= "Prix Unitaire";
	
	SELLENCHANT_NAME_OF_ENCHANT_CRAFT						= "Enchantement";
	
	SELLENCHANT_MSG_ERROR_INCOMPATIBLESORTENCHANT			= "Ne peut lancer SellEnchant !\n\rSortEnchante n'est pas compatible avec SellEnchant par mesure de securit\165\169 Enchanting ne se lancera pas."


	SellEnchant_ToolsEnchanting = {
		{"B\195\162tonnet runique en cuivre"},
		{"B\195\162tonnet runique en argent"},
		{"B\195\162tonnet runique en or"},
		{"B\195\162tonnet runique en vrai-argent"},
		{"B\195\162tonnet runique en arcanite"},
	};
	
	SellEnchant_ArmorCarac = {
		[1] = {"bottes", "Bottes"};
		[2] = {"bracelets", "Bracelets"};
		[3] = {"plastron", "Plastron"};
		[4] = {"cape", "Cape"};
		[5] = {"gants", "Gants"};
		[6] = {"bouclier", "Bouclier"};
		[7] = {"arme 2M", "Arme 2M"};
		[8] = {"arme", "Arme"};
		[9] = {"Baguette", "Baguette"};
		[10] = {"B\195\162tonnet", "B\195\162tonnet"};
		[11] = {"Huile", "Huile"};
		[12] = {"", "Autres"};
		All = "Tous";
	};
	
	SellEnchant_Objet = {
		{"B\195\162tonnet runique en cuivre", "runiq cuivre", "B\195\162tonnet"},
		{"B\195\162tonnet runique en argent", "runiq argent", "B\195\162tonnet"},
		{"B\195\162tonnet runique en or", "runiq or", "B\195\162tonnet"},
		{"B\195\162tonnet runique en vrai-argent", "runiq v-argent", "B\195\162tonnet"},
		{"B\195\162tonnet runique en arcanite", "runiq arcanite", "B\195\162tonnet"},
		{"Baguette magique inf\195\169rieure", "(Arc)dps:05.7", "Baguette"},
		{"Baguette magique sup\195\169rieure", "(Arc)dps:11.9", "Baguette"},
		{"Baguette mystique inf\195\169rieure", "(Arc)dps:23.1", "Baguette"},
		{"Baguette mystique sup\195\169rieure", "(Arc)dps:27.2", "Baguette"},
	};
	
	SellEnchant_Quality = {
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
	};

	SellEnchant_ForTakeNameCaracBonusModel = "^(.+)%(.+%)";
	SellEnchant_ForTakeQualityBonusModel = "^.+%((.+)%)";
	
	SellEnchant_BonusCarac = {
		{"Protection";							"Armure";					{[1] = {"inf\195\169rieur"; 30}};					"Bouclier"};
		{"Agilit\195\169";						"Agi";						{[1] = {"None"; 15}};								"Arme"};
		{"Force";								"Force";					{[1] = {"None"; 15}};								"Arme"};
		{"Intelligence";						"Int";						SellEnchant_Quality["Quality_Int_Weapon"];		"Arme"};
		{"Esprit";								"Esprit";					SellEnchant_Quality["Quality_Spirit_Weapon"];	"Arme"};
		{"Agilit\195\169";						"Agi";						SellEnchant_Quality["Quality_OneCarac"];			nil};
		{"Intelligence";						"Int";						SellEnchant_Quality["Quality_OneCarac"];			nil};
		{"Esprit";								"Esprit";					SellEnchant_Quality["Quality_OneCarac"];			nil};
		{"Endurance";							"End";						SellEnchant_Quality["Quality_OneCarac"];			nil};
		{"Force";								"Force";					SellEnchant_Quality["Quality_OneCarac"];			nil};
		{"Vie";									"Vie";						SellEnchant_Quality["Quality_Life"];				nil};
		{"Sant\195\169";						"Vie";						SellEnchant_Quality["Quality_Life"];				nil};
		{"Mana";								"Mana";						SellEnchant_Quality["Quality_Mana"];				nil};
		{"Caract\195\169ristiques";				"Carac";					SellEnchant_Quality["Quality_Caract"];			nil};
		{"Caract.";								"Carac";					SellEnchant_Quality["Quality_Caract"];			nil};
		{"D\195\169fense";						"Armure";					SellEnchant_Quality["Quality_Armure"];			nil};
		{"Protection";							"Armure";					SellEnchant_Quality["Quality_Armure"];			nil};
		{"D\195\169viation";					"D\195\169fence";			SellEnchant_Quality["Quality_Defence"];			nil};
		{"R\195\169sistance \195\160 l'ombre";	"R\195\169si omb";			{[1] = {"inf."; 10}};								nil};
		{"R\195\169sistance au feu";			"R\195\169si  feu";			SellEnchant_Quality["Quality_ResistFeu"];		nil};
		{"R\195\169sistance";					"R\195\169si";				SellEnchant_Quality["Quality_AllResist"];		nil};
		{"Frappe";								"D\195\169gats";			SellEnchant_Quality["Quality_Degat1M"];			nil};
		{"Impact";								"D\195\169gats";			SellEnchant_Quality["Quality_Degat2M"];			nil};
		{"impact";								"D\195\169gats";			SellEnchant_Quality["Quality_Degat2M"];			nil};
		{"Tueur de d\195\169mons";				"T Demons";					nil;												nil};
		{"Tueur de b\195\170te";				"T B\195\170te";			SellEnchant_Quality["Quality_Tueur"];			nil};
		{"Tueur d'\195\169l\195\169mentaire";	"T El\195\169ment";			SellEnchant_Quality["Quality_Tueur"];			nil};
		{"Blocage";								"Blocage";					{[1] = {"inf\195\169rieur"; "2%"}};					nil};
		{"D\195\169pe\195\167age";				"D\195\169pe\195\167age";	{[1] = {"None"; 5}};								nil};
		{"Absorption";							"";							SellEnchant_Quality["Quality_Absorption"];		nil};
		{"Herboristerie";						"Herbo";					SellEnchant_Quality["Quality_Metier"];			nil};
		{"Minage";								"Minage";					SellEnchant_Quality["Quality_Metier"];			nil};
		{"P\195\170che";						"P\195\170che";				SellEnchant_Quality["Quality_Metier"];			nil};
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
	SellEnchant_DefaultList = {
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
				["PriceUnite"] = 800000,
				["Link"] = "|cffffffff|Hitem:16206:0:0:0|h[Bâtonnet en arcanite]|h|r",
				["Name"] = "Bâtonnet en arcanite",
				["Texture"] = "Interface\\Icons\\INV_Staff_19",
			},
			[7] = {
				["PriceUnite"] = 2500,
				["Link"] = "|cffffffff|Hitem:6338:0:0:0|h[Bâtonnet en argent]|h|r",
				["Name"] = "Bâtonnet en argent",
				["Texture"] = "Interface\\Icons\\INV_Staff_01",
			},
			[8] = {
				["PriceUnite"] = 124,
				["Link"] = "|cffffffff|Hitem:6217:0:0:0|h[Bâtonnet en cuivre]|h|r",
				["Name"] = "Bâtonnet en cuivre",
				["Texture"] = "Interface\\Icons\\INV_Misc_Flute_01",
			},
			[9] = {
				["PriceUnite"] = 7711,
				["Link"] = "|cffffffff|Hitem:11128:0:0:0|h[Bâtonnet en or]|h|r",
				["Name"] = "Bâtonnet en or",
				["Texture"] = "Interface\\Icons\\INV_Staff_10",
			},
			[10] = {
				["PriceUnite"] = 12250,
				["Link"] = "|cffffffff|Hitem:11144:0:0:0|h[Bâtonnet en vrai-argent]|h|r",
				["Name"] = "Bâtonnet en vrai-argent",
				["Texture"] = "Interface\\Icons\\INV_Staff_11",
			},
			[11] = {
				["PriceUnite"] = 3333,
				["Link"] = "|cffffffff|Hitem:13467:0:0:0|h[Calot de glace]|h|r",
				["Name"] = "Calot de glace",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_IceCap",
			},
			[12] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cffffffff|Hitem:8170:0:0:0|h[Cuir grossier]|h|r",
				["Name"] = "Cuir grossier",
				["Texture"] = "Interface\\Icons\\INV_Misc_LeatherScrap_02",
			},
			[13] = {
				["PriceUnite"] = 200,
				["Link"] = "|cffffffff|Hitem:7392:0:0:0|h[Ecaille de Dragonnet vert]|h|r",
				["Name"] = "Ecaille de Dragonnet vert",
				["Texture"] = "Interface\\Icons\\INV_Misc_MonsterScales_03",
			},
			[14] = {
				["PriceUnite"] = 14500,
				["Link"] = "|cffffffff|Hitem:9224:0:0:0|h[Elixir de Tueur de Démons]|h|r",
				["Name"] = "Elixir de Tueur de Démons",
				["Texture"] = "Interface\\Icons\\INV_Potion_27",
			},
			[15] = {
				["PriceUnite"] = 2000,
				["Link"] = "|cff1eff00|Hitem:10998:0:0:0|h[Essence astrale inférieure]|h|r",
				["Name"] = "Essence astrale inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralSmall",
			},
			[16] = {
				["PriceUnite"] = 6000,
				["Link"] = "|cff1eff00|Hitem:11082:0:0:0|h[Essence astrale supérieure]|h|r",
				["Name"] = "Essence astrale supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
			},
			[17] = {
				["PriceUnite"] = 250000,
				["Link"] = "|cff1eff00|Hitem:7082:0:0:0|h[Essence d'air]|h|r",
				["Name"] = "Essence d'air",
				["Texture"] = "Interface\\Icons\\Spell_Nature_EarthBind",
			},
			[18] = {
				["PriceUnite"] = 50600,
				["Link"] = "|cff1eff00|Hitem:7080:0:0:0|h[Essence d'eau]|h|r",
				["Name"] = "Essence d'eau",
				["Texture"] = "Interface\\Icons\\Spell_Nature_Acid_01",
			},
			[19] = {
				["PriceUnite"] = 600,
				["Link"] = "|cff1eff00|Hitem:10938:0:0:0|h[Essence de magie inférieure]|h|r",
				["Name"] = "Essence de magie inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicSmall",
			},
			[20] = {
				["PriceUnite"] = 1800,
				["Link"] = "|cff1eff00|Hitem:10939:0:0:0|h[Essence de magie supérieure]|h|r",
				["Name"] = "Essence de magie supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
			},
			[21] = {
				["PriceUnite"] = 29900,
				["Link"] = "|cff1eff00|Hitem:12803:0:0:0|h[Essence de vie]|h|r",
				["Name"] = "Essence de vie",
				["Texture"] = "Interface\\Icons\\Spell_Nature_AbolishMagic",
			},
			[22] = {
				["PriceUnite"] = 8000,
				["Link"] = "|cff1eff00|Hitem:11174:0:0:0|h[Essence du néant inférieure]|h|r",
				["Name"] = "Essence du néant inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherSmall",
			},
			[23] = {
				["PriceUnite"] = 24000,
				["Link"] = "|cff1eff00|Hitem:11175:0:0:0|h[Essence du néant supérieure]|h|r",
				["Name"] = "Essence du néant supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherLarge",
			},
			[24] = {
				["PriceUnite"] = 4000,
				["Link"] = "|cff1eff00|Hitem:11134:0:0:0|h[Essence mystique inférieure]|h|r",
				["Name"] = "Essence mystique inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalSmall",
			},
			[25] = {
				["PriceUnite"] = 12000,
				["Link"] = "|cff1eff00|Hitem:11135:0:0:0|h[Essence mystique supérieure]|h|r",
				["Name"] = "Essence mystique supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge",
			},
			[26] = {
				["PriceUnite"] = 12000,
				["Link"] = "|cff1eff00|Hitem:16202:0:0:0|h[Essence éternelle inférieure]|h|r",
				["Name"] = "Essence éternelle inférieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceEternalSmall",
			},
			[27] = {
				["PriceUnite"] = 36000,
				["Link"] = "|cff1eff00|Hitem:16203:0:0:0|h[Essence éternelle supérieure]|h|r",
				["Name"] = "Essence éternelle supérieure",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceEternalLarge",
			},
			[28] = {
				["PriceUnite"] = 1200,
				["Link"] = "|cffffffff|Hitem:7068:0:0:0|h[Feu élémentaire]|h|r",
				["Name"] = "Feu élémentaire",
				["Texture"] = "Interface\\Icons\\Spell_Fire_Fire",
			},
			[29] = {
				["PriceUnite"] = 1500,
				["Link"] = "|cffffffff|Hitem:5637:0:0:0|h[Grand croc]|h|r",
				["Name"] = "Grand croc",
				["Texture"] = "Interface\\Icons\\INV_Misc_Bone_08",
			},
			[30] = {
				["PriceUnite"] = 85000,
				["Link"] = "|cff0070dd|Hitem:14344:0:0:0|h[Grand éclat brillant]|h|r",
				["Name"] = "Grand éclat brillant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardBrilliantLarge",
			},
			[31] = {
				["PriceUnite"] = 50000,
				["Link"] = "|cff0070dd|Hitem:11178:0:0:0|h[Gros éclat irradiant]|h|r",
				["Name"] = "Gros éclat irradiant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientLarge",
			},
			[32] = {
				["PriceUnite"] = 220,
				["Link"] = "|cff0070dd|Hitem:11139:0:0:0|h[Gros éclat lumineux]|h|r",
				["Name"] = "Gros éclat lumineux",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingLarge",
			},
			[33] = {
				["PriceUnite"] = 9000,
				["Link"] = "|cff0070dd|Hitem:11084:0:0:0|h[Gros éclat scintillant]|h|r",
				["Name"] = "Gros éclat scintillant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringLarge",
			},
			[34] = {
				["PriceUnite"] = 506,
				["Link"] = "|cffffffff|Hitem:6370:0:0:0|h[Huile de Bouche-noire]|h|r",
				["Name"] = "Huile de Bouche-noire",
				["Texture"] = "Interface\\Icons\\INV_Drink_12",
			},
			[35] = {
				["PriceUnite"] = 2505,
				["Link"] = "|cffffffff|Hitem:6371:0:0:0|h[Huile de feu]|h|r",
				["Name"] = "Huile de feu",
				["Texture"] = "Interface\\Icons\\INV_Potion_38",
			},
			[36] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cff1eff00|Hitem:1210:0:0:0|h[Oeil ténébreux]|h|r",
				["Name"] = "Oeil ténébreux",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Amethyst_01",
			},
			[37] = {
				["PriceUnite"] = 290000,
				["Link"] = "|cff1eff00|Hitem:12811:0:0:0|h[Orbe de piété]|h|r",
				["Name"] = "Orbe de piété",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_03",
			},
			[38] = {
				["PriceUnite"] = 40000,
				["Link"] = "|cff1eff00|Hitem:13926:0:0:0|h[Perle dorée]|h|r",
				["Name"] = "Perle dorée",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_04",
			},
			[39] = {
				["PriceUnite"] = 9500,
				["Link"] = "|cff1eff00|Hitem:5500:0:0:0|h[Perle iridescente]|h|r",
				["Name"] = "Perle iridescente",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_02",
			},
			[40] = {
				["PriceUnite"] = 8000,
				["Link"] = "|cff1eff00|Hitem:7971:0:0:0|h[Perle noire]|h|r",
				["Name"] = "Perle noire",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_01",
			},
			[41] = {
				["PriceUnite"] = 60000,
				["Link"] = "|cff0070dd|Hitem:14343:0:0:0|h[Petit éclat brillant]|h|r",
				["Name"] = "Petit éclat brillant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardBrilliantSmall",
			},
			[42] = {
				["PriceUnite"] = 27000,
				["Link"] = "|cff0070dd|Hitem:11177:0:0:0|h[Petit éclat irradiant]|h|r",
				["Name"] = "Petit éclat irradiant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientSmall",
			},
			[43] = {
				["PriceUnite"] = 15000,
				["Link"] = "|cff0070dd|Hitem:11138:0:0:0|h[Petit éclat lumineux]|h|r",
				["Name"] = "Petit éclat lumineux",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingSmall",
			},
			[44] = {
				["PriceUnite"] = 3500,
				["Link"] = "|cff0070dd|Hitem:10978:0:0:0|h[Petit éclat scintillant]|h|r",
				["Name"] = "Petit éclat scintillant",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringSmall",
			},
			[45] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cffffffff|Hitem:6048:0:0:0|h[Potion de protection contre les ténèbres]|h|r",
				["Name"] = "Potion de protection contre les ténèbres",
				["Texture"] = "Interface\\Icons\\INV_Potion_44",
			},
			[46] = {
				["PriceUnite"] = 10075,
				["Link"] = "|cffffffff|Hitem:16204:0:0:0|h[Poudre d'illusion]|h|r",
				["Name"] = "Poudre d'illusion",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustIllusion",
			},
			[47] = {
				["PriceUnite"] = 800,
				["Link"] = "|cffffffff|Hitem:11083:0:0:0|h[Poussière d'âme]|h|r",
				["Name"] = "Poussière d'âme",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustSoul",
			},
			[48] = {
				["PriceUnite"] = 5000,
				["Link"] = "|cffffffff|Hitem:11176:0:0:0|h[Poussière de rêve]|h|r",
				["Name"] = "Poussière de rêve",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustDream",
			},
			[49] = {
				["PriceUnite"] = 1590,
				["Link"] = "|cffffffff|Hitem:11137:0:0:0|h[Poussière de vision]|h|r",
				["Name"] = "Poussière de vision",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustVision",
			},
			[50] = {
				["PriceUnite"] = 500,
				["Link"] = "|cffffffff|Hitem:10940:0:0:0|h[Poussière étrange]|h|r",
				["Name"] = "Poussière étrange",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustStrange",
			},
			[51] = {
				["PriceUnite"] = 175,
				["Link"] = "|cffffffff|Hitem:3356:0:0:0|h[Sang-royal]|h|r",
				["Name"] = "Sang-royal",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_03",
			},
			[52] = {
				["PriceUnite"] = 8400,
				["Link"] = "|cffffffff|Hitem:8153:0:0:0|h[Sauvageonne]|h|r",
				["Name"] = "Sauvageonne",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_03",
			},
			[53] = {
				["PriceUnite"] = 3500,
				["Link"] = "|cffffffff|Hitem:8838:0:0:0|h[Soleillette]|h|r",
				["Name"] = "Soleillette",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_18",
			},
			[54] = {
				["PriceUnite"] = 1200,
				["Link"] = "|cffffffff|Hitem:7067:0:0:0|h[Terre élémentaire]|h|r",
				["Name"] = "Terre élémentaire",
				["Texture"] = "Interface\\Icons\\INV_Ore_Iron_01",
			},
		};
		Enchantes = {
			[1] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en arcanite",
				["LongName"] = "Ench. d'arme (Croisé)",
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "Croisé",
				["Description"] = "Enchante définitivement une arme de mêlée. Lorsque vous attaquez, elle vous rend régulièrement 75 à 125 points de vie et augmente votre Force de 100 pendant 15 sec.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Grand éclat brillant",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Orbe de piété",
					},
					["Etat"] = -2,
				},
			},
			[2] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. d'arme (Frappe mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "Dégats",
				["Description"] = "Enchante définitivement une arme de mêlée (+1 points de dégâts supplémentaire).",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence de magie supérieure",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Petit éclat scintillant",
					},
					["Etat"] = -2,
				},
			},
			[3] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. d'arme (Frappe inférieure)",
				["BonusNb"] = 2,
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "Dégats",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière inflige 2 points de dégâts supplémentaires..",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Poussière d'âme",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Gros éclat scintillant",
					},
					["Etat"] = -2,
				},
			},
			[4] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. d'arme (Frappe)",
				["BonusNb"] = 3,
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "Dégats",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière inflige 3 points de dégâts supplémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence mystique supérieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Gros éclat lumineux",
					},
					["Etat"] = -2,
				},
			},
			[5] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. d'arme (Frappe supérieure)",
				["BonusNb"] = 4,
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "Dégats",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière confère un bonus de 4 points de dégâts supplémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Gros éclat irradiant",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Essence du néant supérieure",
					},
					["Etat"] = -2,
				},
			},
			[6] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. d'arme (Frisson glacial)",
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "Frisson glacial",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière gèle la cible régulièrement et réduit sa vitesse de déplacement et d'attaque.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Petit éclat brillant",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence d'eau",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Essence d'air",
					},
					[4] = {
						["Count"] = 1,
						["Name"] = "Calot de glace",
					},
					["Etat"] = -2,
				},
			},
			[7] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. d'arme (Tueur de bête mineur)",
				["BonusNb"] = 2,
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "T Bête",
				["Description"] = "Enchante définitivement une arme de mêlée (+2 points de dégâts supplémentaires aux bêtes).",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Essence de magie supérieure",
					},
					["Etat"] = -2,
				},
			},
			[8] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. d'arme (Tueur de bête inférieur)",
				["BonusNb"] = 6,
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "T Bête",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière inflige 6 points de dégâts supplémentaires aux bêtes.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence mystique inférieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Grand croc",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Petit éclat lumineux",
					},
					["Etat"] = -2,
				},
			},
			[9] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. d'arme (Tueur de démons)",
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "T Demons",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière vous confère une chance d'assommer et d'infliger beaucoup de dégâts aux démons.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Petit éclat irradiant",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Poussière de rêve",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Elixir de Tueur de Démons",
					},
					["Etat"] = -2,
				},
			},
			[10] = {
				["OnThis"] = "Arme",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. d'arme (Tueur d'élémentaire inférieur)",
				["BonusNb"] = 6,
				["Name"] = "Ench. d'arme ",
				["Bonus"] = "T Elément",
				["Description"] = "Enchante définitivement une arme de mêlée. Cette dernière inflige 6 points de dégâts supplémentaires contre les Elémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence mystique inférieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Terre élémentaire",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Petit éclat lumineux",
					},
					["Etat"] = -2,
				},
			},
			[11] = {
				["OnThis"] = "Arme 2M",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. d'arme 2M (impact mineur)",
				["BonusNb"] = 2,
				["Name"] = "Ench. d'arme 2M ",
				["Bonus"] = "Dégats",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains (+2 points de dégâts supplémentaires).",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Petit éclat scintillant",
					},
					["Etat"] = -2,
				},
			},
			[12] = {
				["OnThis"] = "Arme 2M",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. d'arme 2M (Impact inférieur)",
				["BonusNb"] = 3,
				["Name"] = "Ench. d'arme 2M ",
				["Bonus"] = "Dégats",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière inflige 3 points de dégâts supplémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Poussière d'âme",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Gros éclat scintillant",
					},
					["Etat"] = -2,
				},
			},
			[13] = {
				["OnThis"] = "Arme 2M",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. d'arme 2M (Impact)",
				["BonusNb"] = 5,
				["Name"] = "Ench. d'arme 2M ",
				["Bonus"] = "Dégats",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière inflige 5 points de dégâts supplémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Poussière de vision",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Gros éclat lumineux",
					},
					["Etat"] = -2,
				},
			},
			[14] = {
				["OnThis"] = "Arme 2M",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. d'arme 2M (Impact supérieur)",
				["BonusNb"] = 7,
				["Name"] = "Ench. d'arme 2M ",
				["Bonus"] = "Dégats",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière inflige 7 points de dégâts supplémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Gros éclat irradiant",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Poussière de rêve",
					},
					["Etat"] = -2,
				},
			},
			[15] = {
				["OnThis"] = "Arme 2M",
				["Required"] = "Bâtonnet runique en arcanite",
				["LongName"] = "Ench. d'arme 2M (Impact excellent)",
				["BonusNb"] = 9,
				["Name"] = "Ench. d'arme 2M ",
				["Bonus"] = "Dégats",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière inflige 9 points de dégâts supplémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Grand éclat brillant",
					},
					[2] = {
						["Count"] = 10,
						["Name"] = "Poudre d'illusion",
					},
					["Etat"] = -2,
				},
			},
			[16] = {
				["OnThis"] = "Arme 2M",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. d'arme 2M (Esprit inférieur)",
				["BonusNb"] = 3,
				["Name"] = "Ench. d'arme 2M ",
				["Bonus"] = "Esprit",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière ajoute 3 à l'Esprit.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence astrale inférieure",
					},
					[2] = {
						["Count"] = 6,
						["Name"] = "Poussière étrange",
					},
					["Etat"] = -2,
				},
			},
			[17] = {
				["OnThis"] = "Arme 2M",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. d'arme 2M (Intelligence inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. d'arme 2M ",
				["Bonus"] = "Int",
				["Description"] = "Enchante définitivement une arme de mêlée à deux mains. Cette dernière ajoute 3 à l'Intelligence.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Essence de magie supérieure",
					},
					["Etat"] = -2,
				},
			},
			[18] = {
				["OnThis"] = "Autres",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["Link"] = "|cffffffff|Hitem:12810:0:0:0|h[Cuir enchanté]|h|r",
				["LongName"] = "Cuir enchanté",
				["Name"] = "Cuir enchanté",
				["Icon"] = "Interface\\Icons\\INV_Misc_Rune_05",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Cuir grossier",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence éternelle inférieure",
					},
					["Etat"] = -2,
				},
			},
			[19] = {
				["OnThis"] = "Autres",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Thorium enchanté",
				["Name"] = "Thorium enchanté",
				["Icon"] = "Interface\\Icons\\INV_Ingot_Eternium",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Barre de thorium",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Poussière de rêve",
					},
					["Etat"] = -2,
				},
			},
			[20] = {
				["OnThis"] = "Baguette",
				["Required"] = "Bâtonnet runique en cuivre",
				["Link"] = "|cffffffff|Hitem:11287:0:0:0|h[Baguette magique inférieure]|h|r",
				["LongName"] = "Baguette magique inférieure",
				["Name"] = "Baguette magique inférieure",
				["Bonus"] = "(Arc)dps:05.7",
				["Description"] = "Crée une Baguette magique inférieure.",
				["Icon"] = "Interface\\Icons\\INV_Staff_02",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Bois simple",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence de magie inférieure",
					},
					["Etat"] = -2,
				},
			},
			[21] = {
				["OnThis"] = "Baguette",
				["Required"] = "Bâtonnet runique en cuivre",
				["Link"] = "|cffffffff|Hitem:11288:0:0:0|h[Baguette magique supérieure]|h|r",
				["LongName"] = "Baguette magique supérieure",
				["Name"] = "Baguette magique supérieure",
				["Bonus"] = "(Arc)dps:11.9",
				["Description"] = "Crée une Baguette magique supérieure.",
				["Icon"] = "Interface\\Icons\\INV_Staff_07",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Bois simple",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence de magie supérieure",
					},
					["Etat"] = -2,
				},
			},
			[22] = {
				["OnThis"] = "Baguette",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Baguette mystique inférieure",
				["Name"] = "Baguette mystique inférieure",
				["Bonus"] = "(Arc)dps:23.1",
				["Description"] = "Crée une Baguette mystique inférieure.",
				["Icon"] = "Interface\\Icons\\INV_Staff_02",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Bois d'étoile",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence mystique inférieure",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[23] = {
				["OnThis"] = "Baguette",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Baguette mystique supérieure",
				["Name"] = "Baguette mystique supérieure",
				["Bonus"] = "(Arc)dps:27.2",
				["Description"] = "Crée une Baguette mystique supérieure.",
				["Icon"] = "Interface\\Icons\\INV_Wand_07",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Bois d'étoile",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence mystique supérieure",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[24] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de bottes (Agilité mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "Agi",
				["Description"] = "Enchante définitivement une paire de bottes. Cette dernière augmente de 1 l'Agilité du porteur.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Essence astrale inférieure",
					},
					["Etat"] = -2,
				},
			},
			[25] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bottes (Agilité inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "Agi",
				["Description"] = "Enchante définitivement des bottes. Ces dernières vous confèrent un bonus de +3 en Agilité.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Poussière d'âme",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence mystique inférieure",
					},
					["Etat"] = -2,
				},
			},
			[26] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bottes (Agilité)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "Agi",
				["Description"] = "Enchante définitivement des bottes. Ces dernières vous confèrent un bonus de +5 en Agilité.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence du néant supérieure",
					},
					["Etat"] = -2,
				},
			},
			[27] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de bottes (Endurance mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement une paire de bottes. Cette dernière augmente de 1 l'Endurance du porteur.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 8,
						["Name"] = "Poussière étrange",
					},
					["Etat"] = -2,
				},
			},
			[28] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bottes (Endurance inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +3 en Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[29] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bottes (Endurance)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +5 en Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 5,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[30] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bottes (Endurance supérieure)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +7 à l'Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 10,
						["Name"] = "Poussière de rêve",
					},
					["Etat"] = -2,
				},
			},
			[31] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bottes (Esprit inférieur)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "Esprit",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +3 en Esprit.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence mystique supérieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Essence mystique inférieure",
					},
					["Etat"] = -2,
				},
			},
			[32] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bottes (Esprit)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "Esprit",
				["Description"] = "Enchante définitivement des bottes. Ces dernières confèrent un bonus de +5 à l'Esprit.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence éternelle supérieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence éternelle inférieure",
					},
					["Etat"] = -2,
				},
			},
			[33] = {
				["OnThis"] = "Bottes",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bottes (Vitesse mineure)",
				["Name"] = "Ench. de bottes ",
				["Bonus"] = "Vitesse mineure",
				["Description"] = "Enchante définitivement des bottes, ce qui augmente la vitesse de déplacement du porteur.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Petit éclat irradiant",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Aquamarine",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Essence du néant inférieure",
					},
					["Etat"] = -2,
				},
			},
			[34] = {
				["OnThis"] = "Bouclier",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de bouclier (Protection inférieure)",
				["BonusNb"] = 30,
				["Name"] = "Ench. de bouclier ",
				["Bonus"] = "Armure",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus supplémentaire de 30 à l'armure.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence astrale inférieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Poussière étrange",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Petit éclat scintillant",
					},
					["Etat"] = -2,
				},
			},
			[35] = {
				["OnThis"] = "Bouclier",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bouclier (Blocage inférieur)",
				["BonusNb"] = "2%",
				["Name"] = "Ench. de bouclier ",
				["Bonus"] = "Blocage",
				["Description"] = "Augmente définitivement un bouclier. Ce dernier vous confère 2% de chances supplémentaires de bloquer.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence mystique supérieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Poussière de vision",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Gros éclat lumineux",
					},
					["Etat"] = -2,
				},
			},
			[36] = {
				["OnThis"] = "Bouclier",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de bouclier (Endurance mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bouclier ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de 1 en Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence astrale inférieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Poussière étrange",
					},
					["Etat"] = -2,
				},
			},
			[37] = {
				["OnThis"] = "Bouclier",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bouclier (Endurance inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bouclier ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier vous confère un bonus de 3 en Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence mystique inférieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[38] = {
				["OnThis"] = "Bouclier",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bouclier (Endurance)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bouclier ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de +5 en Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 5,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[39] = {
				["OnThis"] = "Bouclier",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de bouclier (Esprit inférieur)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bouclier ",
				["Bonus"] = "Esprit",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de 3 en Esprit.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence astrale inférieure",
					},
					[2] = {
						["Count"] = 4,
						["Name"] = "Poussière étrange",
					},
					["Etat"] = -2,
				},
			},
			[40] = {
				["OnThis"] = "Bouclier",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bouclier (Esprit)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bouclier ",
				["Bonus"] = "Esprit",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de +5 en Esprit.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence mystique supérieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[41] = {
				["OnThis"] = "Bouclier",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bouclier (Esprit supérieur)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bouclier ",
				["Bonus"] = "Esprit",
				["Description"] = "Enchante définitivement un bouclier. Ce dernier confère un bonus de +7 en Esprit.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence du néant supérieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Poussière de rêve",
					},
					["Etat"] = -2,
				},
			},
			[42] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de bracelets (Agilité mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Agi",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de 1 à l'Agilité.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence de magie supérieure",
					},
					["Etat"] = -2,
				},
			},
			[43] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de bracelets (Déviation mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Défence",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers augmentent de 1 la Défense.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Name"] = "Essence de magie inférieure",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière étrange",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
			},
			[44] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bracelets (Déviation inférieure)",
				["BonusNb"] = 2,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Défence",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +2 en Défense.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence mystique inférieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[45] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bracelets (Déviation)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Défence",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers vous confèrent un bonus de +3 en Défense.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence du néant supérieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Poussière de rêve",
					},
					["Etat"] = -2,
				},
			},
			[46] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de bracelets (Endurance mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement des bracelets qui augmentent de 1 l'Endurance du porteur.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Poussière étrange",
					},
					["Etat"] = -2,
				},
			},
			[47] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de bracelets (Endurance inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de 3 en Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[48] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bracelets (Endurance)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers vous confèrent un bonus de +5 en Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[49] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bracelets (Endurance supérieure)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +7 en Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 5,
						["Name"] = "Poussière de rêve",
					},
					["Etat"] = -2,
				},
			},
			[50] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bracelets (Endurance excellente)",
				["BonusNb"] = 9,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "End",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +9 à l'Endurance.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 15,
						["Name"] = "Poudre d'illusion",
					},
					["Etat"] = -2,
				},
			},
			[51] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de bracelets (Esprit mineur)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Esprit",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de 1 à l'Esprit.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence de magie inférieure",
					},
					["Etat"] = -2,
				},
			},
			[52] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bracelets (Esprit)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Esprit",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +5 en Esprit.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence mystique inférieure",
					},
					["Etat"] = -2,
				},
			},
			[53] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bracelets (Esprit supérieur)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Esprit",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +7 en Esprit.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Essence du néant inférieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[54] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de bracelets (Force mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Force",
				["Description"] = "Enchante définitivement des bracelets qui augmentent de 1 la force du porteur.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 5,
						["Name"] = "Poussière étrange",
					},
					["Etat"] = -2,
				},
			},
			[55] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de bracelets (Force inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Force",
				["Description"] = "Enchante définitivement un bracelet. Ce dernier confère un bonus de +3 en Force.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[56] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de bracelets (Force)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Force",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers vous confèrent un bonus de +5 en Force.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[57] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bracelets (Force supérieure)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Force",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers vous confèrent un bonus de +7 en Force.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Poussière de rêve",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence du néant supérieure",
					},
					["Etat"] = -2,
				},
			},
			[58] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de bracelets (Intelligence inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Int",
				["Description"] = "Enchante définitivement un bracelet. Ce dernier confère un bonus de 3 en Intelligence.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence astrale supérieure",
					},
					["Etat"] = -2,
				},
			},
			[59] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de bracelets (Intelligence)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Int",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de +5 en Intelligence.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence du néant inférieure",
					},
					["Etat"] = -2,
				},
			},
			[60] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en arcanite",
				["LongName"] = "Ench. de bracelets (Pouvoir de guérison)",
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Pouvoir de guérison",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers augmentent les effets de vos sorts de guérison de 24.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Grand éclat brillant",
					},
					[2] = {
						["Count"] = 20,
						["Name"] = "Poudre d'illusion",
					},
					[3] = {
						["Count"] = 4,
						["Name"] = "Essence éternelle supérieure",
					},
					[4] = {
						["Count"] = 6,
						["Name"] = "Essence de vie",
					},
					["Etat"] = -2,
				},
			},
			[61] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en arcanite",
				["LongName"] = "Ench. de bracelets (Régénération de mana)",
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Régénération de mana",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers restaurent 4 points de mana toutes les 5 sec.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 16,
						["Name"] = "Poudre d'illusion",
					},
					[2] = {
						["Count"] = 4,
						["Name"] = "Essence éternelle supérieure",
					},
					[3] = {
						["Count"] = 2,
						["Name"] = "Essence d'eau",
					},
					["Etat"] = -2,
				},
			},
			[62] = {
				["OnThis"] = "Bracelets",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de bracelets (Vie mineure)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de bracelets ",
				["Bonus"] = "Vie",
				["Description"] = "Enchante définitivement des bracelets. Ces derniers confèrent un bonus de 5 aux points de vie.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Name"] = "Poussière étrange",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
			},
			[63] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:16207:0:0:0|h[Bâtonnet runique en arcanite]|h|r",
				["LongName"] = "Bâtonnet runique en arcanite",
				["Name"] = "Bâtonnet runique en arcanite",
				["Bonus"] = "runiq arcanite",
				["Icon"] = "Interface\\Icons\\INV_Wand_09",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Bâtonnet en arcanite",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Perle dorée",
					},
					[3] = {
						["Count"] = 10,
						["Name"] = "Poudre d'illusion",
					},
					[4] = {
						["Count"] = 4,
						["Name"] = "Essence éternelle supérieure",
					},
					[5] = {
						["Count"] = 4,
						["Name"] = "Petit éclat brillant",
					},
					[6] = {
						["Count"] = 2,
						["Name"] = "Grand éclat brillant",
					},
					["Etat"] = -2,
				},
			},
			[64] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:6339:0:0:0|h[Bâtonnet runique en argent]|h|r",
				["LongName"] = "Bâtonnet runique en argent",
				["Name"] = "Bâtonnet runique en argent",
				["Bonus"] = "runiq argent",
				["Icon"] = "Interface\\Icons\\INV_Staff_01",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Bâtonnet en argent",
					},
					[2] = {
						["Count"] = 6,
						["Name"] = "Poussière étrange",
					},
					[3] = {
						["Count"] = 3,
						["Name"] = "Essence de magie supérieure",
					},
					[4] = {
						["Count"] = 1,
						["Name"] = "Oeil ténébreux",
					},
					["Etat"] = -2,
				},
			},
			[65] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:6218:0:0:0|h[Bâtonnet runique en cuivre]|h|r",
				["LongName"] = "Bâtonnet runique en cuivre",
				["Name"] = "Bâtonnet runique en cuivre",
				["Bonus"] = "runiq cuivre",
				["Icon"] = "Interface\\Icons\\INV_Staff_Goldfeathered_01",
				["Reagents"] = {
					[1] = {
						["Name"] = "Bâtonnet en cuivre",
						["Count"] = 1,
					},
					[2] = {
						["Name"] = "Poussière étrange",
						["Count"] = 1,
					},
					[3] = {
						["Name"] = "Essence de magie inférieure",
						["Count"] = 1,
					},
					["Etat"] = -2,
				},
			},
			[66] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:11130:0:0:0|h[Bâtonnet runique en or]|h|r",
				["LongName"] = "Bâtonnet runique en or",
				["Name"] = "Bâtonnet runique en or",
				["Bonus"] = "runiq or",
				["Icon"] = "Interface\\Icons\\INV_Staff_10",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Bâtonnet en or",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Perle iridescente",
					},
					[3] = {
						["Count"] = 2,
						["Name"] = "Essence astrale supérieure",
					},
					[4] = {
						["Count"] = 2,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[67] = {
				["OnThis"] = "Bâtonnet",
				["Link"] = "|cffffffff|Hitem:11145:0:0:0|h[Bâtonnet runique en vrai-argent]|h|r",
				["LongName"] = "Bâtonnet runique en vrai-argent",
				["Name"] = "Bâtonnet runique en vrai-argent",
				["Bonus"] = "runiq v-argent",
				["Icon"] = "Interface\\Icons\\INV_Staff_11",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Bâtonnet en vrai-argent",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Perle noire",
					},
					[3] = {
						["Count"] = 2,
						["Name"] = "Essence mystique supérieure",
					},
					[4] = {
						["Count"] = 2,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[68] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de cape (Agilité mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Agi",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 1 en Agilité.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence astrale inférieure",
					},
					["Etat"] = -2,
				},
			},
			[69] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de cape (Agilité inférieure)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Agi",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 3 en Agilité.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence du néant inférieure",
					},
					["Etat"] = -2,
				},
			},
			[70] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de cape (Protection mineure)",
				["BonusNb"] = 10,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Armure",
				["Description"] = "Enchante un manteau pour qu'il donne 10 points d'armure supplémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence de magie supérieure",
					},
					["Etat"] = -2,
				},
			},
			[71] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de cape (Protection inférieure)",
				["BonusNb"] = 20,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Armure",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère 20 points d'armure supplémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Petit éclat scintillant",
					},
					["Etat"] = -2,
				},
			},
			[72] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de cape (Défense)",
				["BonusNb"] = 30,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Armure",
				["Description"] = "Enchante définitivement une cape. Cette dernière vous confère un bonus de 30 en armure.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Petit éclat lumineux",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[73] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de cape (Défense supérieure)",
				["BonusNb"] = 50,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Armure",
				["Description"] = "Enchante définitivement une cape. Cette dernière vous confère un bonus de 50 points d'Armure supplémentaires.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[74] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de cape (Défense excellente)",
				["BonusNb"] = 70,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Armure",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 70 à l'armure.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 8,
						["Name"] = "Poudre d'illusion",
					},
					["Etat"] = -2,
				},
			},
			[75] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de cape (Résistance mineure)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Rési",
				["Description"] = "Enchante définitivement une cape. Cette dernière vous confère un bonus de 1 aux Résistances à toutes les écoles de magie.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Essence de magie inférieure",
					},
					["Etat"] = -2,
				},
			},
			[76] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de cape (Résistance)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Rési",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 3 à toutes les résistances.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence du néant inférieure",
					},
					["Etat"] = -2,
				},
			},
			[77] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de cape (Résistance au feu inf.)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Rési  feu",
				["Description"] = "Enchante définitivement une cape. Cette dernière vous confère un bonus de 5 à la Résistance au feu.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Huile de feu",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence astrale inférieure",
					},
					["Etat"] = -2,
				},
			},
			[78] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de cape (Résistance au feu)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Rési  feu",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 7 en Résistance au feu.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence mystique inférieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Feu élémentaire",
					},
					["Etat"] = -2,
				},
			},
			[79] = {
				["OnThis"] = "Cape",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de cape (Résistance à l'ombre inf.)",
				["BonusNb"] = 10,
				["Name"] = "Ench. de cape ",
				["Bonus"] = "Rési omb",
				["Description"] = "Enchante définitivement une cape. Cette dernière confère un bonus de 10 en Résistance à l'ombre.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence astrale supérieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Potion de protection contre les ténèbres",
					},
					["Etat"] = -2,
				},
			},
			[80] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de gants (Agilité)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Agi",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +5 en Agilité.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence du néant inférieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[81] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de gants (Agilité supérieure)",
				["BonusNb"] = 7,
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Agi",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +7 à l'Agilité.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Essence éternelle inférieure",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Poudre d'illusion",
					},
					["Etat"] = -2,
				},
			},
			[82] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de gants (Dépeçage)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Dépeçage",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +5 en Dépeçage.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Poussière de vision",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Ecaille de Dragonnet vert",
					},
					["Etat"] = -2,
				},
			},
			[83] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de gants (Equitation)",
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Equitation",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un léger bonus de déplacement lorsque vous êtes sur une monture.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Gros éclat irradiant",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Poussière de rêve",
					},
					["Etat"] = -2,
				},
			},
			[84] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de gants (Force)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Force",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent +5 à la Force.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence du néant inférieure",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[85] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de gants (Herboristerie)",
				["BonusNb"] = 2,
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Herbo",
				["Description"] = "Enchante définitivement des gants. Ces derniers vous confèrent un bonus de +2 en Herboristerie.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Poussière d'âme",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Sang-royal",
					},
					["Etat"] = -2,
				},
			},
			[86] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de gants (Herboristerie avancée)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Herbo",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +5 en Herboristerie.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Poussière de vision",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Soleillette",
					},
					["Etat"] = -2,
				},
			},
			[87] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de gants (Minage avancé)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Minage",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +5 en minage.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Poussière de vision",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Barre de vrai-argent",
					},
					["Etat"] = -2,
				},
			},
			[88] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de gants (Pêche)",
				["BonusNb"] = 2,
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Pêche",
				["Description"] = "Enchante définitivement des gants. Ces derniers vous confèrent un bonus de +2 en pêche.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Poussière d'âme",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Huile de Bouche-noire",
					},
					["Etat"] = -2,
				},
			},
			[89] = {
				["OnThis"] = "Gants",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de gants (Hâte mineure)",
				["BonusNb"] = "1%",
				["Name"] = "Ench. de gants ",
				["Bonus"] = "Vit d'atta",
				["Description"] = "Enchante définitivement des gants. Ces derniers confèrent un bonus de +1% à la vitesse d'attaque.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Gros éclat irradiant",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Sauvageonne",
					},
					["Etat"] = -2,
				},
			},
			[90] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de plastron (Caract. mineures)",
				["BonusNb"] = 1,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Carac",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +1 à toutes les caractéristiques.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence astrale supérieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Poussière d'âme",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Gros éclat scintillant",
					},
					["Etat"] = -2,
				},
			},
			[91] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de plastron (Caract. inférieures)",
				["BonusNb"] = 2,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Carac",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +2 à toutes les caractéristiques.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Essence mystique supérieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Poussière de vision",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Gros éclat lumineux",
					},
					["Etat"] = -2,
				},
			},
			[92] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de plastron (Caractéristiques)",
				["BonusNb"] = 3,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Carac",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +3 à toutes les caractéristiques.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Gros éclat irradiant",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Poussière de rêve",
					},
					[3] = {
						["Count"] = 2,
						["Name"] = "Essence du néant supérieure",
					},
					["Etat"] = -2,
				},
			},
			[93] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de plastron (Mana mineur)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Mana",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de 5 aux points de mana.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence de magie inférieure",
					},
					["Etat"] = -2,
				},
			},
			[94] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de plastron (Mana inférieur)",
				["BonusNb"] = 20,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Mana",
				["Description"] = "Enchante définitivement un plastron (+20 en mana pour le porteur).",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence de magie supérieure",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence de magie inférieure",
					},
					["Etat"] = -2,
				},
			},
			[95] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de plastron (Mana)",
				["BonusNb"] = 30,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Mana",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de 30 aux points de mana du porteur.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence astrale supérieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Essence astrale inférieure",
					},
					["Etat"] = -2,
				},
			},
			[96] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de plastron (Mana supérieur)",
				["BonusNb"] = 50,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Mana",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de 50 aux points de mana.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence mystique supérieure",
					},
					["Etat"] = -2,
				},
			},
			[97] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de plastron (Mana excellent)",
				["BonusNb"] = 65,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Mana",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +65 points de mana.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Essence du néant supérieure",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Essence du néant inférieure",
					},
					["Etat"] = -2,
				},
			},
			[98] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de plastron (Vie mineure)",
				["BonusNb"] = 5,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Vie",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de 5 aux points de vie.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Poussière étrange",
					},
					["Etat"] = -2,
				},
			},
			[99] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de plastron (Vie inférieure)",
				["BonusNb"] = 15,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Vie",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +15 aux points de vie.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Essence de magie inférieure",
					},
					["Etat"] = -2,
				},
			},
			[100] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de plastron (Vie)",
				["BonusNb"] = 25,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Vie",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +25 aux points de vie du porteur.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence astrale inférieure",
					},
					["Etat"] = -2,
				},
			},
			[101] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en or",
				["LongName"] = "Ench. de plastron (Vie supérieure)",
				["BonusNb"] = 35,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Vie",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +35 aux points de vie.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Poussière d'âme",
					},
					["Etat"] = -2,
				},
			},
			[102] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de plastron (Santé excellente)",
				["BonusNb"] = 50,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Vie",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +50 points de vie.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Poussière de vision",
					},
					["Etat"] = -2,
				},
			},
			[103] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en vrai-argent",
				["LongName"] = "Ench. de plastron (Vie majeure)",
				["BonusNb"] = 100,
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "Vie",
				["Description"] = "Enchante définitivement une pièce d'armure de torse. Cette dernière confère un bonus de +100 aux points de vie.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Poudre d'illusion",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Petit éclat brillant",
					},
					["Etat"] = -2,
				},
			},
			[104] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en cuivre",
				["LongName"] = "Ench. de plastron (Absorption mineure)",
				["BonusNb"] = "2% Abs10pv",
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "",
				["Description"] = "Enchante une pièce d'armure de torse. Cette dernière a 2% de chances d'absorber 10 points de dégâts lorsque vous êtes touché.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence de magie inférieure",
					},
					["Etat"] = -2,
				},
			},
			[105] = {
				["OnThis"] = "Plastron",
				["Required"] = "Bâtonnet runique en argent",
				["LongName"] = "Ench. de plastron (Absorption inférieure)",
				["BonusNb"] = "5% Abs25pv",
				["Name"] = "Ench. de plastron ",
				["Bonus"] = "",
				["Description"] = "Enchante une pièce d'armure de torse. Cette dernière a 5% de chances d'absorber 25 points de dégâts lorsque vous êtes touché.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Poussière étrange",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essence astrale supérieure",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Gros éclat scintillant",
					},
					["Etat"] = -2,
				},
			},
		}
	};
end