if (GetLocale() == "deDE") then 
	SELLENCHANT_MINIMAPBUTTON_TOOLTIP 						= "Launch SellEnchant";
	
	SELLENCHANT_MSG_RESETDB									= "Stammdaten gel\195\182scht.";
	SELLENCHANT_MSG_LOADDEFAULT_ENCHANT_DATA				= "Stammdaten der Komponenten werder geladen.";
	SELLENCHANT_MSG_LOADDEFAULT_REAGENT_DATA				= "Stammdaten der Komponenten werder geladen.";
	SELLENCHANT_MSG_RESETALLDATACONFIRM						= "Soll das Mod wirklich zur\195\188ckgesetzt werden?";
	SELLENCHANT_MSG_LOADDEFAULTCOMPONANTDBCONFIRM			= "Das Laden der Stammdaten der Komponenten inclusive Preisen wird die alten Komponentendaten l\195\182schen. Fortfahren?";
	SELLENCHANT_MSG_LOADDEFAULTENCHANTDBCONFIRM				= "Das Laden der Stammdaten der Verzauberungen wird die alten Verzauberungsdaten l\195\182schen. Fortfahren?";
	
	SELLENCHANT_MSG_ERROR_DEFAULTDBNOTLOADED				= "Keine Stammdaten von Komponenten gefunden - laden nicht m\195\182glich.";
	SELLENCHANT_MSG_ERROR_NEWASKIMPOSSIBLE					= "Eine Frage steht noch aus; diese muss beantwortet werden, bevor eine neue Aktion ausgef\195\188hrt werden kann.";
	SELLENCHANT_MSG_ERROR_PRICELOADCANCEL					= "Another Action! The modification of price in progress was cancelled";
	
	SELLENCHANT_TITLE										= "Sell Enchant "..SELLENCHANT_VERSION;
	SELLENCHANT_TAB_ENCHANT_NAME							= "Verzauberungen";
	SELLENCHANT_TAB_REAGENT_NAME							= "Komponenten";
	SELLENCHANT_TAB_OPTION_NAME								= "Optionen";
	
	SELLENCHANT_ENCHANT_MARKUPPRICE_HEADER					= "Preis berechnet mit Prozentsatz: ";
	SELLENCHANT_ENCHANT_MARKUPPRICE_CHECKBOX				= "Berechneten Preis benutzen.";
	
	SELLENCHANT_LABEL_GOLD									= "G"; -- Piece of Gold
	SELLENCHANT_LABEL_SILVER								= "S"; -- Piece of Silver
	SELLENCHANT_LABEL_COPPER								= "K"; -- Piece of Copper
	
	SELLENCHANT_ENCHANT_BUTTON_LABEL						= "Verzaubern";
	SELLENCHANT_ENCHANT_SHOWPOSSIBLE						= "Sortiere nach M\195\182glichkeit";
	
	SELLENCHANT_ENCHANT_HEADER_NAME							= "Verzauberungsname";
	SELLENCHANT_ENCHANT_HEADER_TYPE							= " "; -- Used to say "Type", but removed for 100g bug
	SELLENCHANT_ENCHANT_HEADER_ATTRIBUTE					= "Bonus";
	SELLENCHANT_ENCHANT_HEADER_PRICE						= "Preis";
	
	SELLENCHANT_ENCHANT_TOOLNEEDED_HEADER					= "Ben\195\182tigt :";
	SELLENCHANT_ENCHANT_DETAIL_TOOLNEED_ADDNAMEFORINBANK	= "(auf der Bank)";
	SELLENCHANT_ENCHANT_DETAIL_TOOLNEED_ADDDOESNOTKNOW		= "(um diese Verzauberungen zu lernen)";
	
	SELLENCHANT_ENCHANT_TOOLTIP_HEADER						= "Kopfzeile Verzauberungen\n\r\n\rKlick: Sortiere diese Spalte\n\rNochmaliges Klicken: Umgekehrte Sortierung";
	SELLENCHANT_ENCHANT_TOOLTIP_LIST						= "Verzauberung\n\r\n\rShift+Klick: Kopiert die Verzauberungsinformationen in den Chat\n\r\n\rFarbe:\n\rKlares gr\195\188n -> Es sind alle Zutaten und Ruten im den Beuteln.\n\rDunkles gr\195\188n -> Einige n\195\182tige Zutaten sind auf der Bank.\n\rBraun -> Einige n\195\182tige Zutaten sind auf einem anderen Charakter.\n\Grau -> Dieser Verzauberer kennt diese Verzauberung nicht.";
	SELLENCHANT_ENCHANT_TOOLTIP_DETAIL_NAMEDESCRIPTION		= "Verzauberungsdetail\n\r\n\rShift+Klick: Kopiert (Kompletter Name und Beschreibung) in den Chat";
	SELLENCHANT_ENCHANT_TOOLTIP_REAGENTS					= "Ben\195\182tigte Komponenten\n\r\n\rShift+Klick: Kopiert f\195\188r diese Komponente\n\r  (Name und ben\195\182tigte Anzahl) in den Chat\n\rDoppelklick: Zeige Komponentendetails";
	SELLENCHANT_ENCHANT_TOOLTIP_REAGENTSHEADER				= "Kopfzeile Komponenten\n\r\n\rShift+Klick: Kopiert f\195\188r alle Komponenten\n\r  (Name und ben\195\182tigte Anzahl) in den Chat";
	SELLENCHANT_ADVERT_PREPOSITION							=  " zu "; -- " � "
	SELLENCHANT_ENCHANT_TOOLTIP_TOTALPRICE					= "Verzauberungspreis\n\r\n\rDoppelklick: \195\132ndere den Verzauberungspreis manuell.\n\r\n\rFarbe:\n\rWei\195\159 -> Automatisch berechnet.\n\rGr\195\188 -> Dein Preis.";
	
	SELLENCHANT_ENCHANT_REAGENT_HEADER_NAME					= "Komponentenname";
	SELLENCHANT_ENCHANT_REAGENT_HEADER_BAGANDNEEDED			= "B/CT";
	SELLENCHANT_ENCHANT_REAGENT_HEADER_BANKANDALTERNATE		= "B-RR";
	SELLENCHANT_ENCHANT_REAGENT_HEADER_ONEREAGENT			= "Preis U";
	SELLENCHANT_ENCHANT_REAGENT_HEADER_TOTAL				= "Preis T";
	
	SELLENCHANT_ENCHANT_REAGENT_HEADER_NOMARKUP				= "ohne Gewinn";
	
	SELLENCHANT_REAGENT_HEADER_NAME							= "Komponentenname";
	SELLENCHANT_REAGENT_HEADER_BAG							= "Inv";
	SELLENCHANT_REAGENT_HEADER_BANK							= "Bank";
	SELLENCHANT_REAGENT_HEADER_ALTERNATE					= "ReRoll";
	SELLENCHANT_REAGENT_HEADER_COST							= "Preis E";
	
	SELLENCHANT_REAGENT_HEADER_PLAYERNAME					= "Spielername";
	SELLENCHANT_REAGENT_HEADER_INBAG						= "Beutel";
	SELLENCHANT_REAGENT_HEADER_INBANK						= "Bank";
	
	SELLENCHANT_OPTION_LABEL_MARKUPPERCENTAGE				= "% Gewinn :";
	
	SELLENCHANT_OPTION_LABEL_SELECTEDENCHANTER				= "Gew\195\164hlter Verzauberer :";
	SELLENCHANT_NOT_ENCHANTER				= "keiner";
	SELLENCHANT_SELLENCHANT_OPTION_JOINPLAYERANDSERVER	= " auf ";
	SELLENCHANT_OPTION_MESSAGE_CONFIRMCHANGESERVER			= "Dieser Verzauberer ist auf einem anderen Server; die Anzahl in den Beuteln, der Bank und ReRoll wurde gel\195\182.\n\rWillst du fortfahren ?";
	
	SELLENCHANT_OPTION_SHOWPRICEINADVERT					= "Include price quote.";
	SELLENCHANT_OPTION_LABEL_USEMINIMAP						= "Disable MiniMap button.";
	SELLENCHANT_OPTION_USEAUCTIONEERDATA					= "Use auction house prices.";
	SELLENCHANT_OPTION_PRICE_ROUNDUPFORMAT					= "Round up to:";
	SELLENCHANT_OPTION_PRICE_ROUNDUPFORMAT_TYPE1			= "Copper (#g #s #c)";
	SELLENCHANT_OPTION_PRICE_ROUNDUPFORMAT_TYPE2			= "Silver (#g #s)";
	SELLENCHANT_OPTION_PRICE_ROUNDUPFORMAT_TYPE3			= "Gold (#g)";
	
	SELLENCHANT_OPTION_BUTTONG_DBRESET						= "L\195\182sche alle gespeicherten Daten";
	SELLENCHANT_OPTION_BUTTON_DEFAULTREAGENT				= "Lade Komponenten-Stammdaten";
	SELLENCHANT_OPTION_BUTTON_DEFAULTENCHANT				= "Lade Verzauberungen-Stammdaten";
		
	SELLENCHANT_OPTION_MINIMAPBUTTONPOSITION				= "MiniMap Knopf  -> Position";
	
	SELLENCHANT_TOOLTIPADD_TITLE							= "SellEnchant AddInfo";
	SELLENCHANT_TOOLTIPADD_ONCHARACTER						= "Im Inv";
	SELLENCHANT_TOOLTIPADD_INBANK							= "Auf der Bank";
	SELLENCHANT_TOOLTIPADD_ALTERNATE						= "ReRoll";
	SELLENCHANT_TOOLTIPADD_PRICEUNIT						= "Price Unite";
	
	SELLENCHANT_NAME_OF_ENCHANT_CRAFT						= "Verzauberkunst";
	
	SELLENCHANT_MSG_ERROR_INCOMPATIBLESORTENCHANT			= "SellEnchant kann nicht gestartet werden!\n\rSortEnchante ist nicht mit SellEnchant kompatibel - bitte deaktivieren.";
	
	SellEnchant_ToolsEnchanting = {
		{"Runenverzierte Kupferrute"},
		{"Runenverzierte Silberrute"},
		{"Runenverzierte Goldrute"},
		{"Runenverzierte Echtsilberrute"},
		{"Runenverzierte Arkanitrute"},
	};
	
	SellEnchant_ArmorCarac = {
		[1] = {"Armschiene", "Armschiene"};			-- bracers
		[2] = {"Brust", "Brust"};					-- chest
		[3] = {"Handschuhe", "Handschuhe"};			-- gloves
		[4] = {"Stiefel", "Stiefel"};				-- boots
		[5] = {"Umhang", "Umhang"};					-- cloak
		[6] = {"Schild", "Schild"};					-- shield
		[7] = {"Waffe", "Waffe"};					-- weapon
		[8] = {"Zweihandwaffe", "Zweihandwaffe"};	-- 2h weapon
		[9] = {"Gemischt", "Stab"};						-- wand
		[10] = {"Rute", "Rute"};						-- rod
		[11] = {"Öl", "Öl"};						-- oil
		[12] = {"", "Gemischt"};						-- other		
		All = "Alle";
	};

	SellEnchant_Quality = {
		["Quality_Health"] = {
			[1] = {"Schwache"; 5};
			[2] = {"Geringe"; 15};
			[3] = {"None"; 25};
			[4] = {"Gro\195\159e"; 35};
			[5] = {"\195\156berragende"; 50};
			[6] = {"Erhebliche"; 100};
		};
		["Quality_Defence"] = {
			[1] = {"Geringe"; 1};
			[2] = {"Schwache"; 2};
			[3] = {"None"; 3};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_Mana"] = {
			[1] = {"Schwaches"; 5};
			[2] = {"Geringes"; 20};
			[3] = {"None"; 30};
			[4] = {"Gro\195\159es"; 50};
			[5] = {"\195\156berragendes"; 65};
			[6] = {"Erhebliches"; 100};
		};
		["Quality_Absorption"] = {
			[1] = {"Schwache"; "2%"};
			[2] = {"Geringe"; "5%"};
			[3] = {"None"; 0};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_OneCarac"] = {
			[1] = {"Schwache"; 1};
			[2] = {"Geringe"; 3};
			[3] = {"None"; 5};
			[4] = {"Gro\195\159e"; 7};
			[5] = {"\195\156berragende"; 9};
			[6] = {"Erhebliche"; 0};
		};
		["Quality_Caract"] = {
			[1] = {"Schwache"; 1};
			[2] = {"Geringe"; 2};
			[3] = {"None"; 3};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_Armure"] = {
			[1] = {"Schwache"; 10};
			[2] = {"Geringe"; 20};
			[3] = {"None"; 30};
			[4] = {"Gro\195\159e"; 50};
			[5] = {"\195\156berragende"; 70};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_Armure_Bouclier"] = {
			[1] = {"Schwache"; 30};
			[2] = {"Geringe"; };
			[3] = {"None"; 0};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_Degat1M"] = {
			[1] = {"Schwache"; 1};
			[2] = {"Geringe"; 2};
			[3] = {"None"; 3};
			[4] = {"Gro\195\159e"; 4};
			[5] = {"\195\156berragende"; 5};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_Degat2M"] = {
			[1] = {"Schwache"; 2};
			[2] = {"Geringe"; 3};
			[3] = {"None"; 5};
			[4] = {"Gro\195\159e"; 7};
			[5] = {"\195\156berragende"; 9};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_Blocage"] = {
			[1] = {"Schwache"; "0%"};
			[2] = {"Geringe"; "2%"};
			[3] = {"None"; "0%"};
			[4] = {"Gro\195\159e"; "0%"};
			[5] = {"\195\156berragende"; "0%"};
			[6] = {"Erhebliche"; "0%"};
		};	
		["Quality_Tueur"] = {
			[1] = {"Schwache"; 2};
			[2] = {"Geringe"; 6};
			[3] = {"None"; 0};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_Depecage"] = {
			[1] = {"Schwache"; 0};
			[2] = {"Geringe"; 0};
			[3] = {"None"; 5};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_Metier"] = {
			[1] = {"nul"; 0};
			[2] = {"nul"; 0};
			[3] = {"None"; 2};
			[4] = {"Hoch entwickelte"; 5};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_Haste"] = {
			[1] = {"Schwache"; "1%"};
			[2] = {"Geringe"; 0};
			[3] = {"None"; 0};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_ResistFeu"] = {
			[1] = {"Schwache"; 0};
			[2] = {"Geringe"; 5};
			[3] = {"None"; 7};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Major"; 0};
		};	
		["Quality_ResistOmbre"] = {
			[1] = {"Schwache"; 0};
			[2] = {"Geringe"; 10};
			[3] = {"None"; 0};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_AllResist"] = {
			[1] = {"Schwache"; 1};
			[2] = {"Geringe"; 0};
			[3] = {"None"; 3};
			[4] = {"Gro\195\159e"; 5};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_ResistFroid"] = {
			[1] = {"Schwache"; 0};
			[2] = {"Geringe"; 0};
			[3] = {"None"; 8};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
		["Quality_ForNew"] = {
			[1] = {"Schwache"; 0};
			[2] = {"Geringe"; 0};
			[3] = {"None"; 0};
			[4] = {"Gro\195\159e"; 0};
			[5] = {"\195\156berragende"; 0};
			[6] = {"Erhebliche"; 0};
		};	
	};

	SellEnchant_ForTakeNameCaracBonusModel = "^(.+)%s%-%s.+"; 	-- Take name			[(name) - Quality add]
	SellEnchant_ForTakeQualityBonusModel = 	"^.+%s%-%s(.+)";	-- Take Quality add		[name - (Quality add)]
	
	SellEnchant_BonusCarac = {
		{"Schutz";									"Schutz";									SellEnchant_Quality["Quality_Armure_Bouclier"];		"Schild"};
		{"Schutz";									"R\195\188stung";							SellEnchant_Quality["Quality_Armure"];				nil};
		{"Verteidigung";							"R\195\188stung";							SellEnchant_Quality["Quality_Armure"];				nil};
		{"Deflect";									"Def";										SellEnchant_Quality["Quality_Defence"];				nil};
		{"Abwehr";									"Vert";										SellEnchant_Quality["Quality_Defence"];				nil};
		{"Hast";									"Angriffst.";								SellEnchant_Quality["Quality_Haste"];				nil};
		{"Tempo";									"Tempo";									SellEnchant_Quality["Quality_Haste"];				nil};
		{"Ausdauer";								"Ausdauer";									SellEnchant_Quality["Quality_OneCarac"];				nil};
		{"Willen";									"Willen";									SellEnchant_Quality["Quality_OneCarac"];				nil};
		{"Beweglichkeit";							"Beweglichk";								SellEnchant_Quality["Quality_OneCarac"];				nil};
		{"St\195\164rke";							"St\195\164rke";							SellEnchant_Quality["Quality_OneCarac"];				nil};
		{"Intelligenz";								"Int";										SellEnchant_Quality["Quality_OneCarac"];				nil};
		{"Werte";									"Werte";									SellEnchant_Quality["Quality_Caract"];				nil};
		{"Mana";									"Mana";										SellEnchant_Quality["Quality_Mana"];					nil};
		{"Gesundheit";								"Gesundh.";									SellEnchant_Quality["Quality_Health"];				nil};
		{"Absorption";								"Absorb.";									SellEnchant_Quality["Quality_Absorption"];			nil};
		{"Wildtiert\195\182ter";					"Wildtiert\195\182ter";						SellEnchant_Quality["Quality_Tueur"];				nil};
		{"Elementargeistt\195\182ter";				"Elementargeistt\195\182ter";				SellEnchant_Quality["Quality_Tueur"];				nil};
		{"D\195\164monent\195\182ten";				"D\195\164monent\195\182ten";				nil;													nil};
		{"Schlagen";								"Schlagen";									SellEnchant_Quality["Quality_Degat1M"];				nil};
		{"Einschlag";								"Einschlag";								SellEnchant_Quality["Quality_Degat2M"];				nil};
		{"Feuerwiderstand";							"Feuerr";									SellEnchant_Quality["Quality_ResistFeu"];			nil};
		{"Frostwiderstand";							"Frostr";									SellEnchant_Quality["Quality_ResistFroid"];			nil};
		{"Schattenwiderstand";						"Schattenr";								SellEnchant_Quality["Quality_ResistOmbre"];			nil};
		{"Widerstand";								"Widerstand";								SellEnchant_Quality["Quality_AllResist"];			nil};
		{"Kr\195\164uterkunde";						"Kr\195\164uterk.";							SellEnchant_Quality["Quality_Metier"];				nil};
		{"Bergbau";									"Bergbau";									SellEnchant_Quality["Quality_Metier"];				nil};
		{"Angeln";									"Angeln";									SellEnchant_Quality["Quality_Metier"];				nil};
		{"K\195\188rschnerei";						"K\195\188rschn.";							SellEnchant_Quality["Quality_Depecage"];				nil};
		{"Blocken";									"Blocken";									SellEnchant_Quality["Quality_Blocage"];				nil};
	};
	
	-- This is for componantes descrition add
	DescritionDefaultReagents = {
		[1] = {
			["Name"] = "Seltsamer Staub",
			["Description"] = "Wird i.A. von R\195\188stungen entzaubert. Gr\195\188nes Item lvl 1-20.",
		},
		[2] = {
			["Name"] = "Seelenstaub",
			["Description"] = "Wird i.A. von R\195\188stungen entzaubert. Gr\195\188nes Item lvl 21-30.",
		},
		[3] = {
			["Name"] = "Visionenstaub",
			["Description"] = "Wird i.A. von R\195\188stungen entzaubert. Gr\195\188nes Item lvl 31-40.",
		},
		[4] = {
			["Name"] = "Traumstaub",
			["Description"] = "Wird i.A. von R\195\188stungen entzaubert. Gr\195\188nes Item lvl 41-50.",
		},
		[5] = {
			["Name"] = "Illusionsstaub",
			["Description"] = "Wird i.A. von R\195\188stungen entzaubert. Gr\195\188nes Item lvl 51-60.",
		},
		[6] = {
			["Name"] = "Geringe Magie-Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 1-10.",
		},
		[7] = {
			["Name"] = "Gro\195\159e Magie-Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 11-15.",
		},
		[8] = {
			["Name"] = "Geringe Astral-Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 16-20.",
		},
		[9] = {
			["Name"] = "Gro\195\159e Astral-Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 21-25.",
		},
		[10] = {
			["Name"] = "Geringe Mystiker-Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 26-30.",
		},
		[11] = {
			["Name"] = "Gro\195\159e Mystiker-Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 31-35.",
		},
		[12] = {
			["Name"] = "Geringe Nether-Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 36-40.",
		},
		[13] = {
			["Name"] = "Gro\195\159e Nether-Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 41-45.",
		},
		[14] = {
			["Name"] = "Geringe ewige Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 46-50.",
		},
		[15] = {
			["Name"] = "Gro\195\159e ewige Essenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 51-60.",
		},
		[16] = {
			["Name"] = "Kleiner glei\195\159ender Splitter",
			["Description"] = "Wird von blauen und lilanen Items entzaubert. Blaues Item lvl 1-20.",
		},
		[17] = {
			["Name"] = "Gro\195\159er glei\195\159ender Splitter",
			["Description"] = "Wird von blauen und lilanen Items entzaubert. Blaues Item  21-25.",
		},
		[18] = {
			["Name"] = "Kleiner leuchtender Splitter",
			["Description"] = "Wird von blauen und lilanen Items entzaubert. Blaues Item 26-30.",
		},
		[19] = {
			["Name"] = "Gro\195\159er leuchtender Splitter",
			["Description"] = "Wird von blauen und lilanen Items entzaubert. Blaues Item 31-35.",
		},
		[20] = {
			["Name"] = "Kleiner strahlender Splitter",
			["Description"] = "Wird von blauen und lilanen Items entzaubert. Blaues Item 36-40.",
		},
		[21] = {
			["Name"] = "Gro\195\159er strahlender Splitter",
			["Description"] = "Wird von blauen und lilanen Items entzaubert. Blaues Item 41-45.",
		},
		[22] = {
			["Name"] = "Kleiner gl\195\164nzender Splitter",
			["Description"] = "Wird von blauen und lilanen Items entzaubert. Blaues Item 46-50.",
		},
		[23] = {
			["Name"] = "Gro\195\159er gl\195\164nzender Splitter",
			["Description"] = "Wird von blauen und lilanen Items entzaubert. Blaues Item lvl 51-60.",
		},
		[24] = {
			["Name"] = "Kupferrute",
			["Description"] = "Wird vom Verzauberkunstbedarfsh\195\164ndler f\195\188r 99 Kupfer verkauft.",
		},
		[25] = {
			["Name"] = "Silberrute",
			["Description"] = "Wird von Schmieden mit Mindestskill 100 hergestellt.",
		},
		[26] = {
			["Name"] = "Goldrute",
			["Description"] = "Wird von Schmieden mit Mindestskill 150 hergestellt.",
		},
		[27] = {
			["Name"] = "Echtsilberrute",
			["Description"] = "Wird von Schmieden mit Mindestskill 200 hergestellt.",
		},
		[28] = {
			["Name"] = "Arkanitrute",
			["Description"] = "Wird von Schmieden mit Mindestskill 275 hergestellt.",
		},
		[29] = {
			["Name"] = "Einfaches Holz",
			["Description"] = "Wird vom Verzauberkunstbedarfsh\195\164ndler f\195\188r 30 Kupfer verkauft.",
		},
		[30] = {
			["Name"] = "Sternenholz",
			["Description"] = "Wird vom Verzauberkunstbedarfsh\195\164ndler f\195\188r 36 Silber verkauft.",
		},
	};

	SellEnchant_DefaultList = {
		Componantes = {
			[1] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:3819:0:0:0|h[Winterbiss]|h|r",
				["Name"] = "Winterbiss",
				["Texture"] = "Interface\\Icons\\INV_Misc_Flower_03",
			},
			[2] = {
				["PriceUnite"] = 8400,
				["Link"] = "|cffffffff|Hitem:8153:0:0:0|h[Wildranke]|h|r",
				["Name"] = "Wildranke",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_03",
			},
			[3] = {
				["PriceUnite"] = 1590,
				["Link"] = "|cffffffff|Hitem:11137:0:0:0|h[Visionenstaub]|h|r",
				["Name"] = "Visionenstaub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustVision",
			},
			[4] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cffffffff|Hitem:8170:0:0:0|h[Unverwüstliches Leder]|h|r",
				["Name"] = "Unverwüstliches Leder",
				["Texture"] = "Interface\\Icons\\INV_Misc_LeatherScrap_02",
			},
			[5] = {
				["PriceUnite"] = 5000,
				["Link"] = "|cffffffff|Hitem:11176:0:0:0|h[Traumstaub]|h|r",
				["Name"] = "Traumstaub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustDream",
			},
			[6] = {
				["PriceUnite"] = 2250,
				["Link"] = "|cffffffff|Hitem:12359:0:0:0|h[Thoriumbarren]|h|r",
				["Name"] = "Thoriumbarren",
				["Texture"] = "Interface\\Icons\\INV_Ingot_07",
			},
			[7] = {
				["PriceUnite"] = 4500,
				["Link"] = "|cffffffff|Hitem:11291:0:0:0|h[Sternenholz]|h|r",
				["Name"] = "Sternenholz",
				["Texture"] = "Interface\\Icons\\INV_TradeskillItem_03",
			},
			[8] = {
				["PriceUnite"] = 3500,
				["Link"] = "|cffffffff|Hitem:8838:0:0:0|h[Sonnengras]|h|r",
				["Name"] = "Sonnengras",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_18",
			},
			[9] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:6338:0:0:0|h[Silberrute]|h|r",
				["Name"] = "Silberrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_01",
			},
			[10] = {
				["PriceUnite"] = 500,
				["Link"] = "|cffffffff|Hitem:10940:0:0:0|h[Seltsamer Staub]|h|r",
				["Name"] = "Seltsamer Staub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustStrange",
			},
			[11] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:7972:0:0:0|h[Sekret des Untodes]|h|r",
				["Name"] = "Sekret des Untodes",
				["Texture"] = "Interface\\Icons\\INV_Misc_Slime_01",
			},
			[12] = {
				["PriceUnite"] = 800,
				["Link"] = "|cffffffff|Hitem:11083:0:0:0|h[Seelenstaub]|h|r",
				["Name"] = "Seelenstaub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustSoul",
			},
			[13] = {
				["PriceUnite"] = 506,
				["Link"] = "|cffffffff|Hitem:6370:0:0:0|h[Schwarzmaulöl]|h|r",
				["Name"] = "Schwarzmaulöl",
				["Texture"] = "Interface\\Icons\\INV_Drink_12",
			},
			[14] = {
				["PriceUnite"] = 8000,
				["Link"] = "|cff1eff00|Hitem:7971:0:0:0|h[Schwarze Perle]|h|r",
				["Name"] = "Schwarze Perle",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_01",
			},
			[15] = {
				["PriceUnite"] = 9500,
				["Link"] = "|cff1eff00|Hitem:5500:0:0:0|h[Schillernde Perle]|h|r",
				["Name"] = "Schillernde Perle",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_02",
			},
			[16] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cffffffff|Hitem:6048:0:0:0|h[Schattenschutztrank]|h|r",
				["Name"] = "Schattenschutztrank",
				["Texture"] = "Interface\\Icons\\INV_Potion_44",
			},
			[17] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cff1eff00|Hitem:1210:0:0:0|h[Schattenedelstein]|h|r",
				["Name"] = "Schattenedelstein",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Amethyst_01",
			},
			[18] = {
				["PriceUnite"] = 2500,
				["Link"] = "|cffffffff|Hitem:6338:0:0:0|h[Runenverzierte Silberrute]|h|r",
				["Name"] = "Runenverzierte Silberrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_01",
			},
			[19] = {
				["PriceUnite"] = 124,
				["Link"] = "|cffffffff|Hitem:6217:0:0:0|h[Runenverzierte Kupferrute]|h|r",
				["Name"] = "Runenverzierte Kupferrute",
				["Texture"] = "Interface\\Icons\\INV_Misc_Flute_01",
			},
			[20] = {
				["PriceUnite"] = 7711,
				["Link"] = "|cffffffff|Hitem:11128:0:0:0|h[Runenverzierte Goldrute]|h|r",
				["Name"] = "Runenverzierte Goldrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_10",
			},
			[21] = {
				["PriceUnite"] = 12250,
				["Link"] = "|cffffffff|Hitem:11144:0:0:0|h[Runenverzierte Echtsilberrute]|h|r",
				["Name"] = "Runenverzierte Echtsilberrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_11",
			},
			[22] = {
				["PriceUnite"] = 800000,
				["Link"] = "|cffffffff|Hitem:16206:0:0:0|h[Runenverzierte Arkanitrute]|h|r",
				["Name"] = "Runenverzierte Arkanitrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_19",
			},
			[23] = {
				["PriceUnite"] = 290000,
				["Link"] = "|cff1eff00|Hitem:12811:0:0:0|h[Rechtschaffene Kugel]|h|r",
				["Name"] = "Rechtschaffene Kugel",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_03",
			},
			[24] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:7081:0:0:0|h[Odem des Windes]|h|r",
				["Name"] = "Odem des Windes",
				["Texture"] = "Interface\\Icons\\Spell_Nature_Cyclone",
			},
			[25] = {
				["PriceUnite"] = 29900,
				["Link"] = "|cff1eff00|Hitem:12803:0:0:0|h[Lebende Essenz]|h|r",
				["Name"] = "Lebende Essenz",
				["Texture"] = "Interface\\Icons\\Spell_Nature_AbolishMagic",
			},
			[26] = {
				["PriceUnite"] = 175,
				["Link"] = "|cffffffff|Hitem:3356:0:0:0|h[Königsblut]|h|r",
				["Name"] = "Königsblut",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_03",
			},
			[27] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:6217:0:0:0|h[Kupferrute]|h|r",
				["Name"] = "Kupferrute",
				["Texture"] = "Interface\\Icons\\INV_Misc_Flute_01",
			},
			[28] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:7079:0:0:0|h[Kugel des Wassers]|h|r",
				["Name"] = "Kugel des Wassers",
				["Texture"] = "Interface\\Icons\\INV_Misc_Orb_01",
			},
			[29] = {
				["PriceUnite"] = 27000,
				["Link"] = "|cff0070dd|Hitem:11177:0:0:0|h[Kleiner strahlender Splitter]|h|r",
				["Name"] = "Kleiner strahlender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientSmall",
			},
			[30] = {
				["PriceUnite"] = 15000,
				["Link"] = "|cff0070dd|Hitem:11138:0:0:0|h[Kleiner leuchtender Splitter]|h|r",
				["Name"] = "Kleiner leuchtender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingSmall",
			},
			[31] = {
				["PriceUnite"] = 60000,
				["Link"] = "|cff0070dd|Hitem:14343:0:0:0|h[Kleiner glänzender Splitter]|h|r",
				["Name"] = "Kleiner glänzender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardBrilliantSmall",
			},
			[32] = {
				["PriceUnite"] = 3500,
				["Link"] = "|cff0070dd|Hitem:10978:0:0:0|h[Kleiner gleißender Splitter]|h|r",
				["Name"] = "Kleiner gleißender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringSmall",
			},
			[33] = {
				["PriceUnite"] = 10075,
				["Link"] = "|cffffffff|Hitem:16204:0:0:0|h[Illusionsstaub]|h|r",
				["Name"] = "Illusionsstaub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustIllusion",
			},
			[34] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:7077:0:0:0|h[Herz des Feuers]|h|r",
				["Name"] = "Herz des Feuers",
				["Texture"] = "Interface\\Icons\\Spell_Fire_LavaSpawn",
			},
			[35] = {
				["PriceUnite"] = 200,
				["Link"] = "|cffffffff|Hitem:7392:0:0:0|h[Grünwelpenschuppe]|h|r",
				["Name"] = "Grünwelpenschuppe",
				["Texture"] = "Interface\\Icons\\INV_Misc_MonsterScales_03",
			},
			[36] = {
				["PriceUnite"] = 70000,
				["Link"] = "|cff0070dd|Hitem:11178:0:0:0|h[Großer strahlender Splitter]|h|r",
				["Name"] = "Großer strahlender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientLarge",
			},
			[37] = {
				["PriceUnite"] = 38000,
				["Link"] = "|cff0070dd|Hitem:11139:0:0:0|h[Großer leuchtender Splitter]|h|r",
				["Name"] = "Großer leuchtender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingLarge",
			},
			[38] = {
				["PriceUnite"] = 45000,
				["Link"] = "|cff0070dd|Hitem:14344:0:0:0|h[Großer glänzender Splitter]|h|r",
				["Name"] = "Großer glänzender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardBrilliantLarge",
			},
			[39] = {
				["PriceUnite"] = 15000,
				["Link"] = "|cff0070dd|Hitem:11084:0:0:0|h[Großer gleißender Splitter]|h|r",
				["Name"] = "Großer gleißender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringLarge",
			},
			[40] = {
				["PriceUnite"] = 1500,
				["Link"] = "|cffffffff|Hitem:5637:0:0:0|h[Großer Fangzahn]|h|r",
				["Name"] = "Großer Fangzahn",
				["Texture"] = "Interface\\Icons\\INV_Misc_Bone_08",
			},
			[41] = {
				["PriceUnite"] = 36000,
				["Link"] = "|cff1eff00|Hitem:16203:0:0:0|h[Große ewige Essenz]|h|r",
				["Name"] = "Große ewige Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceEternalLarge",
			},
			[42] = {
				["PriceUnite"] = 24000,
				["Link"] = "|cff1eff00|Hitem:11175:0:0:0|h[Große Nether-Essenz]|h|r",
				["Name"] = "Große Nether-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherLarge",
			},
			[43] = {
				["PriceUnite"] = 0,
				["Link"] = "|cff1eff00|Hitem:11135:0:0:0|h[Große Mystikeressenz]|h|r",
				["Name"] = "Große Mystikeressenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge",
			},
			[44] = {
				["PriceUnite"] = 12000,
				["Link"] = "|cff1eff00|Hitem:11135:0:0:0|h[Große Mystiker-Essenz]|h|r",
				["Name"] = "Große Mystiker-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge",
			},
			[45] = {
				["PriceUnite"] = 1800,
				["Link"] = "|cff1eff00|Hitem:10939:0:0:0|h[Große Magie-Essenz]|h|r",
				["Name"] = "Große Magie-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
			},
			[46] = {
				["PriceUnite"] = 12000,
				["Link"] = "|cff1eff00|Hitem:11082:0:0:0|h[Große Astralessenz]|h|r",
				["Name"] = "Große Astralessenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
			},
			[47] = {
				["PriceUnite"] = 6000,
				["Link"] = "|cff1eff00|Hitem:11082:0:0:0|h[Große Astral-Essenz]|h|r",
				["Name"] = "Große Astral-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
			},
			[48] = {
				["PriceUnite"] = 18000,
				["Link"] = "|cffffffff|Hitem:11128:0:0:0|h[Goldrute]|h|r",
				["Name"] = "Goldrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_10",
			},
			[49] = {
				["PriceUnite"] = 280000,
				["Link"] = "|cff1eff00|Hitem:13926:0:0:0|h[Goldene Perle]|h|r",
				["Name"] = "Goldene Perle",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_04",
			},
			[50] = {
				["PriceUnite"] = 20000,
				["Link"] = "|cff1eff00|Hitem:16202:0:0:0|h[Geringe ewige Essenz]|h|r",
				["Name"] = "Geringe ewige Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceEternalSmall",
			},
			[51] = {
				["PriceUnite"] = 8000,
				["Link"] = "|cff1eff00|Hitem:11174:0:0:0|h[Geringe Nether-Essenz]|h|r",
				["Name"] = "Geringe Nether-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherSmall",
			},
			[52] = {
				["PriceUnite"] = 0,
				["Link"] = "|cff1eff00|Hitem:11134:0:0:0|h[Geringe Mystikeressenz]|h|r",
				["Name"] = "Geringe Mystikeressenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalSmall",
			},
			[53] = {
				["PriceUnite"] = 4000,
				["Link"] = "|cff1eff00|Hitem:11134:0:0:0|h[Geringe Mystiker-Essenz]|h|r",
				["Name"] = "Geringe Mystiker-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalSmall",
			},
			[54] = {
				["PriceUnite"] = 600,
				["Link"] = "|cff1eff00|Hitem:10938:0:0:0|h[Geringe Magie-Essenz]|h|r",
				["Name"] = "Geringe Magie-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicSmall",
			},
			[55] = {
				["PriceUnite"] = 0,
				["Link"] = "|cff1eff00|Hitem:10998:0:0:0|h[Geringe Astralessenz]|h|r",
				["Name"] = "Geringe Astralessenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralSmall",
			},
			[56] = {
				["PriceUnite"] = 2000,
				["Link"] = "|cff1eff00|Hitem:10998:0:0:0|h[Geringe Astral-Essenz]|h|r",
				["Name"] = "Geringe Astral-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralSmall",
			},
			[57] = {
				["PriceUnite"] = 2505,
				["Link"] = "|cffffffff|Hitem:6371:0:0:0|h[Feueröl]|h|r",
				["Name"] = "Feueröl",
				["Texture"] = "Interface\\Icons\\INV_Potion_38",
			},
			[58] = {
				["PriceUnite"] = 50600,
				["Link"] = "|cff1eff00|Hitem:7080:0:0:0|h[Essenz des Wassers]|h|r",
				["Name"] = "Essenz des Wassers",
				["Texture"] = "Interface\\Icons\\Spell_Nature_Acid_01",
			},
			[59] = {
				["PriceUnite"] = 0,
				["Link"] = "|cff1eff00|Hitem:12803:0:0:0|h[Essenz des Lebens]|h|r",
				["Name"] = "Essenz des Lebens",
				["Texture"] = "Interface\\Icons\\Spell_Nature_AbolishMagic",
			},
			[60] = {
				["PriceUnite"] = 0,
				["Link"] = "|cff1eff00|Hitem:7078:0:0:0|h[Essenz des Feuers]|h|r",
				["Name"] = "Essenz des Feuers",
				["Texture"] = "Interface\\Icons\\Spell_Fire_Volcano",
			},
			[61] = {
				["PriceUnite"] = 130000,
				["Link"] = "|cff1eff00|Hitem:7082:0:0:0|h[Essenz der Luft]|h|r",
				["Name"] = "Essenz der Luft",
				["Texture"] = "Interface\\Icons\\Spell_Nature_EarthBind",
			},
			[62] = {
				["PriceUnite"] = 0,
				["Link"] = "|cff1eff00|Hitem:7076:0:0:0|h[Essenz der Erde]|h|r",
				["Name"] = "Essenz der Erde",
				["Texture"] = "Interface\\Icons\\Spell_Nature_StrengthOfEarthTotem02",
			},
			[63] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:7075:0:0:0|h[Erdenkern]|h|r",
				["Name"] = "Erdenkern",
				["Texture"] = "Interface\\Icons\\INV_Stone_05",
			},
			[64] = {
				["PriceUnite"] = 14500,
				["Link"] = "|cffffffff|Hitem:9224:0:0:0|h[Elixier des Dämonentötens]|h|r",
				["Name"] = "Elixier des Dämonentötens",
				["Texture"] = "Interface\\Icons\\INV_Potion_27",
			},
			[65] = {
				["PriceUnite"] = 1200,
				["Link"] = "|cffffffff|Hitem:7068:0:0:0|h[Elementargeist-Feuer]|h|r",
				["Name"] = "Elementargeist-Feuer",
				["Texture"] = "Interface\\Icons\\Spell_Fire_Fire",
			},
			[66] = {
				["PriceUnite"] = 1200,
				["Link"] = "|cffffffff|Hitem:7067:0:0:0|h[Elementargeist-Erde]|h|r",
				["Name"] = "Elementargeist-Erde",
				["Texture"] = "Interface\\Icons\\INV_Ore_Iron_01",
			},
			[67] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:7068:0:0:0|h[Elementarfeuer]|h|r",
				["Name"] = "Elementarfeuer",
				["Texture"] = "Interface\\Icons\\Spell_Fire_Fire",
			},
			[68] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:7067:0:0:0|h[Elementarerde]|h|r",
				["Name"] = "Elementarerde",
				["Texture"] = "Interface\\Icons\\INV_Ore_Iron_01",
			},
			[69] = {
				["PriceUnite"] = 3333,
				["Link"] = "|cffffffff|Hitem:13467:0:0:0|h[Eiskappe]|h|r",
				["Name"] = "Eiskappe",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_IceCap",
			},
			[70] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:2772:0:0:0|h[Eisenerz]|h|r",
				["Name"] = "Eisenerz",
				["Texture"] = "Interface\\Icons\\INV_Ore_Iron_01",
			},
			[71] = {
				["PriceUnite"] = 38,
				["Link"] = "|cffffffff|Hitem:4470:0:0:0|h[Einfaches Holz]|h|r",
				["Name"] = "Einfaches Holz",
				["Texture"] = "Interface\\Icons\\INV_TradeskillItem_01",
			},
			[72] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:11144:0:0:0|h[Echtsilberrute]|h|r",
				["Name"] = "Echtsilberrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_11",
			},
			[73] = {
				["PriceUnite"] = 4500,
				["Link"] = "|cff1eff00|Hitem:6037:0:0:0|h[Echtsilberbarren]|h|r",
				["Name"] = "Echtsilberbarren",
				["Texture"] = "Interface\\Icons\\INV_Ingot_08",
			},
			[74] = {
				["PriceUnite"] = 0,
				["Link"] = "|cff1eff00|Hitem:11382:0:0:0|h[Blut des Berges]|h|r",
				["Name"] = "Blut des Berges",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Bloodstone_03",
			},
			[75] = {
				["PriceUnite"] = 0,
				["Link"] = "|cffffffff|Hitem:16206:0:0:0|h[Arkanitrute]|h|r",
				["Name"] = "Arkanitrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_19",
			},
			[76] = {
				["PriceUnite"] = 2500,
				["Link"] = "|cff1eff00|Hitem:7909:0:0:0|h[Aquamarin]|h|r",
				["Name"] = "Aquamarin",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Crystal_02",
			},
		},
		Enchantes = {
			[1] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass damit 2 zusätzliche Schadenspunkte verursacht werden.",
				["LongName"] = "Zweihandwaffe - Schwacher Einschlag",
				["BonusNb"] = 2,
				["Name"] = "Zweihandwaffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Kleiner gleißender Splitter",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Einschlag",
			},
			[2] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass damit 3 zusätzliche Punkte Schaden zugefügt werden.",
				["LongName"] = "Zweihandwaffe - Geringer Einschlag",
				["BonusNb"] = 3,
				["Name"] = "Zweihandwaffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Seelenstaub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Großer gleißender Splitter",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Einschlag",
			},
			[3] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass damit 5 zusätzliche Punkte Schaden zugefügt werden.",
				["LongName"] = "Zweihandwaffe - Einschlag",
				["BonusNb"] = 5,
				["Name"] = "Zweihandwaffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Visionenstaub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Großer leuchtender Splitter",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Einschlag",
			},
			[4] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass damit +7 Schaden zugefügt wird.",
				["LongName"] = "Zweihandwaffe - Großer Einschlag",
				["BonusNb"] = 7,
				["Name"] = "Zweihandwaffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Großer strahlender Splitter",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Traumstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Einschlag",
			},
			[5] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass damit +9 Schaden zugefügt wird.",
				["LongName"] = "Zweihandwaffe - Überragender Einschlag",
				["BonusNb"] = 9,
				["Name"] = "Zweihandwaffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Großer glänzender Splitter",
					},
					[2] = {
						["Count"] = 10,
						["Name"] = "Illusionsstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Arkanitrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Einschlag",
			},
			[6] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass sie die Intelligenz um 3 erhöht.",
				["LongName"] = "Zweihandwaffe - Geringe Intelligenz",
				["BonusNb"] = 3,
				["Name"] = "Zweihandwaffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Große Magie-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Int",
			},
			[7] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass sie die Willenskraft um 3 erhöht.",
				["LongName"] = "Zweihandwaffe - Geringer Willen",
				["BonusNb"] = 3,
				["Name"] = "Zweihandwaffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Astralessenz",
					},
					[2] = {
						["Count"] = 6,
						["Name"] = "Seltsamer Staub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[8] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Lässt einen geringen Zauberstab entstehen.",
				["Link"] = "|cff1eff00|Hitem:11287:0:0:0|h[Geringer Magie-Zauberstab]|h|r",
				["LongName"] = "Geringer Magie-Zauberstab",
				["Name"] = "Geringer Magie-Zauberstab",
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\INV_Staff_02",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Einfaches Holz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Geringe Magie-Essenz",
					},
					["Etat"] = -2,
				},
			},
			[9] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Lässt einen geringen Mystikerzauberstab entstehen.",
				["Link"] = "|cff1eff00|Hitem:11289:0:0:0|h[Geringer Mystikerzauberstab]|h|r",
				["LongName"] = "Geringer Mystikerzauberstab",
				["Name"] = "Geringer Mystikerzauberstab",
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\INV_Staff_02",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Sternenholz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Geringe Mystikeressenz",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Seelenstaub",
					},
					["Etat"] = -2,
				},
			},
			[10] = {
				["OnThis"] = "Gemischt",
				["Description"] = "Lässt einen großen Magiezauberstab entstehen.",
				["Link"] = "|cff1eff00|Hitem:11288:0:0:0|h[Großer Magie-Zauberstab]|h|r",
				["LongName"] = "Großer Magie-Zauberstab",
				["Name"] = "Großer Magie-Zauberstab",
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\INV_Staff_07",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Einfaches Holz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Große Magie-Essenz",
					},
					["Etat"] = -2,
				},
			},
			[11] = {
				["OnThis"] = "Gemischt",
				["Required"] = "Runenverzierte Goldrute",
				["Link"] = "|cff1eff00|Hitem:11290:0:0:0|h[Großer Mystikerzauberstab]|h|r",
				["LongName"] = "Großer Mystikerzauberstab",
				["Name"] = "Großer Mystikerzauberstab",
				["Description"] = "Lässt einen großen Mystikerzauberstab entstehen.",
				["Icon"] = "Interface\\Icons\\INV_Wand_07",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Sternenholz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Große Mystikeressenz",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
			},
			[12] = {
				["OnThis"] = "Gemischt",
				["Required"] = "Schwarze Schmiede",
				["Link"] = "|cff0070dd|Hitem:11811:0:0:0|h[Rauchendes Herz des Berges]|h|r",
				["LongName"] = "Rauchendes Herz des Berges",
				["Name"] = "Rauchendes Herz des Berges",
				["Icon"] = "Interface\\Icons\\INV_Misc_Gem_Bloodstone_01",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Blut des Berges",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essenz des Feuers",
					},
					[3] = {
						["Count"] = 3,
						["Name"] = "Kleiner glänzender Splitter",
					},
					["Etat"] = -2,
				},
			},
			[13] = {
				["LongName"] = "Runenverzierte Arkanitrute",
				["Name"] = "Runenverzierte Arkanitrute",
				["Link"] = "|cffffffff|Hitem:16207:0:0:0|h[Runenverzierte Arkanitrute]|h|r",
				["OnThis"] = "Gemischt",
				["Icon"] = "Interface\\Icons\\INV_Wand_09",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Arkanitrute",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Goldene Perle",
					},
					[3] = {
						["Count"] = 10,
						["Name"] = "Illusionsstaub",
					},
					[4] = {
						["Count"] = 4,
						["Name"] = "Große ewige Essenz",
					},
					[5] = {
						["Count"] = 4,
						["Name"] = "Kleiner glänzender Splitter",
					},
					[6] = {
						["Count"] = 2,
						["Name"] = "Großer glänzender Splitter",
					},
					["Etat"] = -2,
				},
			},
			[14] = {
				["LongName"] = "Runenverzierte Echtsilberrute",
				["Name"] = "Runenverzierte Echtsilberrute",
				["Link"] = "|cffffffff|Hitem:11145:0:0:0|h[Runenverzierte Echtsilberrute]|h|r",
				["OnThis"] = "Gemischt",
				["Icon"] = "Interface\\Icons\\INV_Staff_11",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Echtsilberrute",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Schwarze Perle",
					},
					[3] = {
						["Count"] = 2,
						["Name"] = "Große Mystikeressenz",
					},
					[4] = {
						["Count"] = 2,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
			},
			[15] = {
				["LongName"] = "Runenverzierte Goldrute",
				["Name"] = "Runenverzierte Goldrute",
				["Link"] = "|cffffffff|Hitem:11130:0:0:0|h[Runenverzierte Goldrute]|h|r",
				["OnThis"] = "Gemischt",
				["Icon"] = "Interface\\Icons\\INV_Staff_10",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Goldrute",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Schillernde Perle",
					},
					[3] = {
						["Count"] = 2,
						["Name"] = "Große Astralessenz",
					},
					[4] = {
						["Count"] = 2,
						["Name"] = "Seelenstaub",
					},
					["Etat"] = -2,
				},
			},
			[16] = {
				["LongName"] = "Runenverzierte Kupferrute",
				["Name"] = "Runenverzierte Kupferrute",
				["Link"] = "|cffffffff|Hitem:6218:0:0:0|h[Runenverzierte Kupferrute]|h|r",
				["OnThis"] = "Gemischt",
				["Icon"] = "Interface\\Icons\\INV_Staff_Goldfeathered_01",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Kupferrute",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Seltsamer Staub",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Geringe Magie-Essenz",
					},
					["Etat"] = -2,
				},
			},
			[17] = {
				["LongName"] = "Runenverzierte Silberrute",
				["Name"] = "Runenverzierte Silberrute",
				["Link"] = "|cffffffff|Hitem:6339:0:0:0|h[Runenverzierte Silberrute]|h|r",
				["OnThis"] = "Gemischt",
				["Icon"] = "Interface\\Icons\\INV_Staff_01",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Silberrute",
					},
					[2] = {
						["Count"] = 6,
						["Name"] = "Seltsamer Staub",
					},
					[3] = {
						["Count"] = 3,
						["Name"] = "Große Magie-Essenz",
					},
					[4] = {
						["Count"] = 1,
						["Name"] = "Schattenedelstein",
					},
					["Etat"] = -2,
				},
			},
			[18] = {
				["OnThis"] = "Gemischt",
				["Required"] = "Runenverzierte Echtsilberrute",
				["Link"] = "|cffffffff|Hitem:12810:0:0:0|h[Verzaubertes Leder]|h|r",
				["LongName"] = "Verzaubertes Leder",
				["Name"] = "Verzaubertes Leder",
				["Icon"] = "Interface\\Icons\\INV_Misc_Rune_05",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Unverwüstliches Leder",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Geringe ewige Essenz",
					},
					["Etat"] = -2,
				},
			},
			[19] = {
				["OnThis"] = "Gemischt",
				["Required"] = "Runenverzierte Echtsilberrute",
				["Link"] = "|cffffffff|Hitem:12655:0:0:0|h[Verzauberter Thoriumbarren]|h|r",
				["LongName"] = "Verzaubertes Thorium",
				["Name"] = "Verzaubertes Thorium",
				["Icon"] = "Interface\\Icons\\INV_Ingot_Eternium",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Thoriumbarren",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Traumstaub",
					},
					["Etat"] = -2,
				},
			},
			[20] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Ein Paar Stiefel dauerhaft verzaubern, sodass sich die Ausdauer des Trägers um 1 erhöht.",
				["LongName"] = "Stiefel - Schwache Ausdauer",
				["BonusNb"] = 1,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 8,
						["Name"] = "Seltsamer Staub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[21] = {
				["OnThis"] = "Schild",
				["Description"] = "Einen Schild dauerhaft verzaubern, sodass sich die Ausdauer des Trägers um 1 erhöht.",
				["LongName"] = "Schild - Schwache Ausdauer",
				["BonusNb"] = 1,
				["Name"] = "Schild",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Astralessenz",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Seltsamer Staub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[22] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Stiefel dauerhaft verzaubern, sodass die Ausdauer um +3 erhöht wird.",
				["LongName"] = "Stiefel - Geringe Ausdauer",
				["BonusNb"] = 3,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Seelenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[23] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Stiefel dauerhaft verzaubern, sodass die Ausdauer um +5 erhöht wird.",
				["LongName"] = "Stiefel - Ausdauer",
				["BonusNb"] = 5,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 5,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[24] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Stiefel dauerhaft verzaubern, sodass die Ausdauer um +7 erhöht wird.",
				["LongName"] = "Stiefel - Große Ausdauer",
				["BonusNb"] = 7,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 10,
						["Name"] = "Traumstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[25] = {
				["OnThis"] = "Schild",
				["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Ausdauer um 3 erhöht wird.",
				["LongName"] = "Schild - Geringe Ausdauer",
				["BonusNb"] = 3,
				["Name"] = "Schild",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Mystikeressenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Seelenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[26] = {
				["OnThis"] = "Schild",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Schild - Ausdauer",
				["BonusNb"] = 5,
				["Name"] = "Schild",
				["Reagents"] = {
					[1] = {
						["Count"] = 5,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Ausdauer um +5 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[27] = {
				["OnThis"] = "Schild",
				["Description"] = "Einen Schild dauerhaft verzaubern, um seine Rüstung um 30 zu erhöhen.",
				["LongName"] = "Schild - Schwacher Schutz",
				["BonusNb"] = 30,
				["Name"] = "Schild",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Astralessenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Seltsamer Staub",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Kleiner gleißender Splitter",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Schutz",
			},
			[28] = {
				["OnThis"] = "Schild",
				["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Willenskraft um 3 erhöht wird.",
				["LongName"] = "Schild - Geringer Willen",
				["BonusNb"] = 3,
				["Name"] = "Schild",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Geringe Astralessenz",
					},
					[2] = {
						["Count"] = 4,
						["Name"] = "Seltsamer Staub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[29] = {
				["OnThis"] = "Schild",
				["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Willenskraft um 5 erhöht wird.",
				["LongName"] = "Schild - Willen",
				["BonusNb"] = 5,
				["Name"] = "Schild",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Große Mystikeressenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[30] = {
				["OnThis"] = "Schild",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Schild - Große Willenskraft",
				["BonusNb"] = 7,
				["Name"] = "Schild",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Große Nether-Essenz",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Traumstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Willenskraft um +7 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[31] = {
				["OnThis"] = "Schild",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Schild - Erheblicher Willen",
				["BonusNb"] = 0,
				["Name"] = "Schild",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Große ewige Essenz",
					},
					[2] = {
						["Count"] = 4,
						["Name"] = "Illusionsstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Willenskraft um +9 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[32] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Ein Paar Stiefel dauerhaft verzaubern, sodass sich die Beweglichkeit des Trägers um 1 erhöht.",
				["LongName"] = "Stiefel - Schwache Beweglichkeit",
				["BonusNb"] = 1,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Geringe Astralessenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Beweglichk",
			},
			[33] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Stiefel dauerhaft verzaubern, sodass die Beweglichkeit um +5 erhöht wird.",
				["LongName"] = "Stiefel - Beweglichkeit",
				["BonusNb"] = 5,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Große Nether-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Beweglichk",
			},
			[34] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Beweglichkeit um +1 erhöht wird.",
				["LongName"] = "Umhang - Schwache Beweglichkeit",
				["BonusNb"] = 1,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Astralessenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Beweglichk",
			},
			[35] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Beweglichkeit um 3 erhöht wird.",
				["LongName"] = "Umhang - Geringe Beweglichkeit",
				["BonusNb"] = 3,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Geringe Nether-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Beweglichk",
			},
			[36] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass sich der Feuerwiderstand um 5 erhöht.",
				["LongName"] = "Umhang - Geringer Feuerwiderstand",
				["BonusNb"] = 5,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Feueröl",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Geringe Astralessenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Feuerr",
			},
			[37] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass der Feuerwiderstand um 7 erhöht wird.",
				["LongName"] = "Umhang - Feuerwiderstand",
				["BonusNb"] = 7,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Mystikeressenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Elementarfeuer",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Feuerr",
			},
			[38] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Rüstung um 20 erhöht wird.",
				["LongName"] = "Umhang - Schwacher Schutz",
				["BonusNb"] = 10,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Kleiner gleißender Splitter",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rüstung",
			},
			[39] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Goldrute",
				["LongName"] = "Waffe - Geringer Elementartöter",
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Mystikeressenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Elementarerde",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Kleiner leuchtender Splitter",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit Elementaren 6 zusätzliche Punkte Schaden zugefügt werden.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Geringer Elementartöter",
			},
			[40] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Kupferrute",
				["LongName"] = "Waffe - Schwaches Schlagen",
				["BonusNb"] = 1,
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Große Magie-Essenz",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Kleiner gleißender Splitter",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit 1 zusätzlicher Schadenspunkt zugefügt wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Schlagen",
			},
			[41] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Silberrute",
				["LongName"] = "Waffe - Geringes Schlagen",
				["BonusNb"] = 2,
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Seelenstaub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Großer gleißender Splitter",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit 2 zusätzliche Punkte Schaden zugefügt werden.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Schlagen",
			},
			[42] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Goldrute",
				["LongName"] = "Waffe - Schlagen",
				["BonusNb"] = 3,
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Große Mystikeressenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Großer leuchtender Splitter",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit 3 zusätzliche Punkte Schaden zugefügt werden.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Schlagen",
			},
			[43] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang verzaubern, sodass 10 zusätzliche Rüstungspunkte gewährt werden.",
				["LongName"] = "Umhang - Schwacher Schutz",
				["BonusNb"] = 10,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Große Magie-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rüstung",
			},
			[44] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Rüstung zusätzlich um 30 erhöht wird.",
				["LongName"] = "Umhang - Verteidigung",
				["BonusNb"] = 30,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Kleiner leuchtender Splitter",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Seelenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rüstung",
			},
			[45] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Rüstung zusätzlich um 70 erhöht wird.",
				["LongName"] = "Umhang - Überragende Verteidigung",
				["BonusNb"] = 70,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 8,
						["Name"] = "Illusionsstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rüstung",
			},
			[46] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass sich der Schattenwiderstand um 10 erhöht.",
				["LongName"] = "Umhang - Geringer Schattenwiderstand",
				["BonusNb"] = 10,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Große Astralessenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Schattenschutztrank",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Schattenr",
			},
			[47] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Waffe - Eisiger Hauch",
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Kleiner glänzender Splitter",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Essenz des Wassers",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Essenz der Luft",
					},
					[4] = {
						["Count"] = 1,
						["Name"] = "Eiskappe",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass das Ziel oft mit Kälteeffekten belegt wird und sein Bewegungstempo sowie sein Angriffstempo verringert wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Eisiger Hauch",
			},
			[48] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Waffe - Großes Schlagen",
				["BonusNb"] = 4,
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Großer strahlender Splitter",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Große Nether-Essenz",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit 4 zusätzliche Punkte Schaden zugefügt werden.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Schlagen",
			},
			[49] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Rüstung zusätzlich um 50 erhöht wird.",
				["LongName"] = "Umhang - Große Verteidigung",
				["BonusNb"] = 50,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Rüstung",
			},
			[50] = {
				["OnThis"] = "Waffe",
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass sie die Stärke um 15 erhöht.",
				["LongName"] = "Waffe verzaubern - Stärke",
				["BonusNb"] = 5,
				["Name"] = "Waffe verzaubern",
				["Bonus"] = "Stärke",
				["Required"] = "Runenverzierte Arkanitrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Großer glänzender Splitter",
					},
					[2] = {
						["Count"] = 6,
						["Name"] = "Große ewige Essenz",
					},
					[3] = {
						["Count"] = 4,
						["Name"] = "Illusionsstaub",
					},
					[4] = {
						["Count"] = 2,
						["Name"] = "Essenz der Erde",
					},
					["Etat"] = -2,
				},
			},
			[51] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Kupferrute",
				["LongName"] = "Waffe - Schwacher Wildtiertöter",
				["BonusNb"] = 2,
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Große Magie-Essenz",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit Wildtieren 2 zusätzliche Schadenspunkte zugefügt werden.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Wildtiertöter",
			},
			[52] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Goldrute",
				["LongName"] = "Waffe - Geringer Wildtiertöter",
				["BonusNb"] = 6,
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Mystikeressenz",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Großer Fangzahn",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Kleiner leuchtender Splitter",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit Wildtieren 6 zusätzliche Punkte Schaden zugefügt werden.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Wildtiertöter",
			},
			[53] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass sich der Widerstand gegen alle Arten von Magie um 1 erhöht.",
				["LongName"] = "Umhang - Schwacher Widerstand",
				["BonusNb"] = 1,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Geringe Magie-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Widerstand",
			},
			[54] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Arkanitrute",
				["LongName"] = "Waffe verzaubern - Beweglichkeit",
				["BonusNb"] = 5,
				["Name"] = "Waffe verzaubern",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Großer glänzender Splitter",
					},
					[2] = {
						["Count"] = 6,
						["Name"] = "Große ewige Essenz",
					},
					[3] = {
						["Count"] = 4,
						["Name"] = "Illusionsstaub",
					},
					[4] = {
						["Count"] = 2,
						["Name"] = "Essenz der Luft",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass sie die Beweglichkeit um 15 erhöht.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Beweglichk",
			},
			[55] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Stiefel dauerhaft verzaubern, sodass die Beweglichkeit um +3 erhöht wird.",
				["LongName"] = "Stiefel - Geringe Beweglichkeit",
				["BonusNb"] = 3,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Seelenstaub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Geringe Mystikeressenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Beweglichk",
			},
			[56] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Stiefel dauerhaft verzaubern, sodass die Beweglichkeit um +7 erhöht wird.",
				["LongName"] = "Stiefel - Große Beweglichkeit",
				["BonusNb"] = 7,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 8,
						["Name"] = "Große ewige Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Beweglichk",
			},
			[57] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Stiefel dauerhaft verzaubern, um eine kleine Erhöhung des Bewegungstempos zu erhalten.",
				["LongName"] = "Stiefel - Schwaches Tempo",
				["BonusNb"] = "1%",
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Kleiner strahlender Splitter",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Aquamarin",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Geringe Nether-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Tempo",
			},
			[58] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Stiefel dauerhaft verzaubern, sodass die Willenskraft um +3 erhöht wird.",
				["LongName"] = "Stiefel - Geringer Willen",
				["BonusNb"] = 3,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Große Mystikeressenz",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Geringe Mystikeressenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[59] = {
				["OnThis"] = "Stiefel",
				["Description"] = "Stiefel dauerhaft verzaubern, sodass die Willenskraft um +5 erhöht wird.",
				["LongName"] = "Stiefel - Willen",
				["BonusNb"] = 5,
				["Name"] = "Stiefel",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Große ewige Essenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Geringe ewige Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[60] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass alle Widerstände um 3 erhöht werden.",
				["LongName"] = "Umhang - Widerstand",
				["BonusNb"] = 3,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Nether-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Widerstand",
			},
			[61] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Waffe - Dämonentöten",
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Kleiner strahlender Splitter",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Traumstaub",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Elixier des Dämonentötens",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, um eine Chance zu haben, Dämonen zu betäuben und ihnen schweren Schaden zuzufügen.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Dämonentöten",
			},
			[62] = {
				["OnThis"] = "Umhang",
				["Description"] = "Einen Umhang dauerhaft verzaubern, sodass alle Widerstände um 5 erhöht werden.",
				["LongName"] = "Umhang - Großer Widerstand",
				["BonusNb"] = 5,
				["Name"] = "Umhang",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Geringe ewige Essenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Herz des Feuers",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Erdenkern",
					},
					[4] = {
						["Count"] = 1,
						["Name"] = "Kugel des Wassers",
					},
					[5] = {
						["Count"] = 1,
						["Name"] = "Odem des Windes",
					},
					[6] = {
						["Count"] = 1,
						["Name"] = "Sekret des Untodes",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Widerstand",
			},
			[63] = {
				["OnThis"] = "Handschuhe",
				["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Stärke um +5 erhöht wird.",
				["LongName"] = "Handschuhe - Stärke",
				["BonusNb"] = 5,
				["Name"] = "Handschuhe",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Geringe Nether-Essenz",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Stärke",
			},
			[64] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Armschienen dauerhaft verzaubern, sodass sich die Ausdauer des Trägers um 1 erhöht.",
				["LongName"] = "Armschiene - Schwache Ausdauer",
				["BonusNb"] = 1,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Seltsamer Staub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[65] = {
				["OnThis"] = "Handschuhe",
				["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Beweglichkeit um +7 erhöht wird.",
				["LongName"] = "Handschuhe - Große Beweglichkeit",
				["BonusNb"] = 7,
				["Name"] = "Handschuhe",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Geringe ewige Essenz",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Illusionsstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Beweglichk",
			},
			[66] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Silberrute",
				["LongName"] = "Armschiene - Geringe Ausdauer",
				["BonusNb"] = 3,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Seelenstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Armschiene dauerhaft verzaubern, sodass sich die Ausdauer des Trägers um 3 erhöht.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[67] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Goldrute",
				["LongName"] = "Armschiene - Ausdauer",
				["BonusNb"] = 5,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Seelenstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Ausdauer um +5 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[68] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Armschiene - Große Ausdauer",
				["BonusNb"] = 7,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 5,
						["Name"] = "Traumstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Ausdauer um +7 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[69] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Armschiene - Überragende Ausdauer",
				["BonusNb"] = 9,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 15,
						["Name"] = "Illusionsstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Ausdauer um +9 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Ausdauer",
			},
			[70] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Kupferrute",
				["LongName"] = "Armschiene - Schwache Gesundheit",
				["BonusNb"] = 5,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Seltsamer Staub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Armschienen dauerhaft verzaubern, sodass die Gesundheit des Trägers um 5 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Gesundh.",
			},
			[71] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Armschienen dauerhaft verzaubern, sodass sie den Effekt Eurer Heilzauber um 24 erhöhen.",
				["LongName"] = "Armschiene verzaubern - Heilkraft",
				["Name"] = "Armschiene verzaubern",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Großer glänzender Splitter",
					},
					[2] = {
						["Count"] = 20,
						["Name"] = "Illusionsstaub",
					},
					[3] = {
						["Count"] = 4,
						["Name"] = "Große ewige Essenz",
					},
					[4] = {
						["Count"] = 6,
						["Name"] = "Essenz des Lebens",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Arkanitrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Heilkraft",
			},
			[72] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Eine Armschiene dauerhaft verzaubern, sodass sich die Intelligenz des Trägers um 3 erhöht.",
				["LongName"] = "Armschiene - Geringe Intelligenz",
				["BonusNb"] = 3,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Große Astralessenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Int",
			},
			[73] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Intelligenz um +5 erhöht wird.",
				["LongName"] = "Armschiene - Intelligenz",
				["BonusNb"] = 5,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Geringe Nether-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Int",
			},
			[74] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Armschienen dauerhaft verzaubern, sodass sie alle 5 Sek. 4 Punkt(e) Mana wiederherstellen.",
				["LongName"] = "Armschiene verzaubern - Manaregeneration",
				["Name"] = "Armschiene verzaubern",
				["Reagents"] = {
					[1] = {
						["Count"] = 16,
						["Name"] = "Illusionsstaub",
					},
					[2] = {
						["Count"] = 4,
						["Name"] = "Große ewige Essenz",
					},
					[3] = {
						["Count"] = 2,
						["Name"] = "Essenz des Wassers",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Arkanitrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[75] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Kupferrute",
				["LongName"] = "Armschiene - Schwache Stärke",
				["BonusNb"] = 1,
				["Name"] = "Armschiene",
				["Bonus"] = "Stärke",
				["Description"] = "Armschienen dauerhaft verzaubern, sodass sich die Stärke des Trägers um 1 erhöht.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 5,
						["Name"] = "Seltsamer Staub",
					},
					["Etat"] = -2,
				},
			},
			[76] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Goldrute",
				["LongName"] = "Armschiene - Stärke",
				["BonusNb"] = 5,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Stärke um +5 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Stärke",
			},
			[77] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Armschiene - Große Stärke",
				["BonusNb"] = 7,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Traumstaub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Große Nether-Essenz",
					},
					["Etat"] = -2,
				},
				["Description"] = "Verzaubert Armschienen dauerhaft, um +7 Stärke zu erhalten.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Stärke",
			},
			[78] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Goldrute",
				["LongName"] = "Armschiene - Geringe Abwehr",
				["BonusNb"] = 1,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Mystikeressenz",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Seelenstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Verteidigung um +2 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vert",
			},
			[79] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Armschienen dauerhaft verzaubern, sodass die Verteidigungsfertigkeit des Trägers um 1 erhöht wird.",
				["LongName"] = "Armschiene - Schwache Abwehr",
				["BonusNb"] = 2,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Magie-Essenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Seltsamer Staub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Vert",
			},
			[80] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Armschienen dauerhaft verzaubern, sodass sich die Willenskraft des Trägers um 1 erhöht.",
				["LongName"] = "Armschiene - Schwacher Willen",
				["BonusNb"] = 1,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Geringe Magie-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[81] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Eine Armschiene dauerhaft verzaubern, sodass sich die Willenskraft des Trägers um 3 erhöht.",
				["LongName"] = "Armschiene - Geringer Willen",
				["BonusNb"] = 3,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Geringe Astralessenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[82] = {
				["OnThis"] = "Armschiene",
				["Required"] = "Runenverzierte Goldrute",
				["LongName"] = "Armschiene - Willen",
				["BonusNb"] = 5,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Mystikeressenz",
					},
					["Etat"] = -2,
				},
				["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Willenskraft um +5 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[83] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Willenskraft um +7 erhöht wird.",
				["LongName"] = "Armschiene - Große Willenskraft",
				["BonusNb"] = 7,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Geringe Nether-Essenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[84] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Willenskraft um +9 erhöht wird.",
				["LongName"] = "Armschiene - Überragender Willen",
				["BonusNb"] = 9,
				["Name"] = "Armschiene",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Geringe ewige Essenz",
					},
					[2] = {
						["Count"] = 10,
						["Name"] = "Traumstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Willen",
			},
			[85] = {
				["OnThis"] = "Armschiene",
				["Description"] = "Armschienen dauerhaft verzaubern, sodass sich die Beweglichkeit des Trägers um 1 erhöht.",
				["LongName"] = "Armschiene- Schwache Beweglichkeit",
				["Name"] = "Armschiene- Schwache Beweglichkeit",
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Große Magie-Essenz",
					},
					["Etat"] = -2,
				},
			},
			[86] = {
				["OnThis"] = "Handschuhe",
				["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Kürschnereifertigkeit um +5 erhöht wird.",
				["LongName"] = "Handschuhe - Kürschnerei",
				["BonusNb"] = 5,
				["Name"] = "Handschuhe",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Visionenstaub",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Grünwelpenschuppe",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Kürschn.",
			},
			[87] = {
				["OnThis"] = "Brust",
				["Required"] = "Runenverzierte Kupferrute",
				["LongName"] = "Brust - Schwache Absorption",
				["BonusNb"] = "2%",
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Geringe Magie-Essenz",
					},
					["Etat"] = -2,
				},
				["Description"] = "Ein Teil der Brustrüstung verzaubern, sodass bei jedem Treffer eine Chance von 2% besteht, Euch 10 Punkte Schadensabsorption zu geben.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Absorb.",
			},
			[88] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung verzaubern, sodass bei jedem Treffer eine Chance von 5% besteht, Euch 25 Punkte Schadensabsorption zu geben.",
				["LongName"] = "Brust - Geringe Absorption",
				["BonusNb"] = "5%",
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Große Astralessenz",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Großer gleißender Splitter",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Absorb.",
			},
			[89] = {
				["OnThis"] = "Handschuhe",
				["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Bergbaufertigkeit um +2 erhöht wird.",
				["LongName"] = "Handschuhe - Bergbau",
				["BonusNb"] = 2,
				["Name"] = "Handschuhe",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Seelenstaub",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Eisenerz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Bergbau",
			},
			[90] = {
				["OnThis"] = "Handschuhe",
				["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Bergbaufertigkeit um +5 erhöht wird.",
				["LongName"] = "Handschuhe - Hoch entwickelter Bergbau",
				["BonusNb"] = 5,
				["Name"] = "Handschuhe",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Visionenstaub",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Echtsilberbarren",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Bergbau",
			},
			[91] = {
				["OnThis"] = "Handschuhe",
				["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Beweglichkeit um +5 erhöht wird.",
				["LongName"] = "Handschuhe - Beweglichkeit",
				["BonusNb"] = 5,
				["Name"] = "Handschuhe",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Nether-Essenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Beweglichk",
			},
			[92] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit des Trägers um 5 erhöht wird.",
				["LongName"] = "Brust - Schwache Gesundheit",
				["BonusNb"] = 5,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Seltsamer Staub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Gesundh.",
			},
			[93] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit des Trägers um 15 erhöht wird.",
				["LongName"] = "Brust - Geringe Gesundheit",
				["BonusNb"] = 15,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Geringe Magie-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Gesundh.",
			},
			[94] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit des Trägers um 25 erhöht wird.",
				["LongName"] = "Brust - Gesundheit",
				["BonusNb"] = 25,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 4,
						["Name"] = "Seltsamer Staub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Geringe Astralessenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Gesundh.",
			},
			[95] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit um +35 erhöht wird.",
				["LongName"] = "Brust - Große Gesundheit",
				["BonusNb"] = 35,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Seelenstaub",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Gesundh.",
			},
			[96] = {
				["OnThis"] = "Brust",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Brust - Überragende Gesundheit",
				["BonusNb"] = 50,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Visionenstaub",
					},
					["Etat"] = -2,
				},
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit um +50 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Gesundh.",
			},
			[97] = {
				["OnThis"] = "Brust",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Brust - Erhebliche Gesundheit",
				["BonusNb"] = 100,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 6,
						["Name"] = "Illusionsstaub",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Kleiner glänzender Splitter",
					},
					["Etat"] = -2,
				},
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit um +100 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Gesundh.",
			},
			[98] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana des Trägers um 5 erhöht wird.",
				["LongName"] = "Brust - Schwaches Mana",
				["BonusNb"] = 5,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Geringe Magie-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Kupferrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[99] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana des Trägers um 30 erhöht wird.",
				["LongName"] = "Brust - Mana",
				["BonusNb"] = 30,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Große Astralessenz",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Geringe Astralessenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[100] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana um +50 erhöht wird.",
				["LongName"] = "Brust - Großes Mana",
				["BonusNb"] = 50,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Große Mystikeressenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[101] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana um +65 erhöht wird.",
				["LongName"] = "Brust - Überragendes Mana",
				["BonusNb"] = 65,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Große Nether-Essenz",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Geringe Nether-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[102] = {
				["OnThis"] = "Handschuhe",
				["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Angelfertigkeit um +2 erhöht wird.",
				["LongName"] = "Handschuhe - Angeln",
				["BonusNb"] = 2,
				["Name"] = "Handschuhe",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Seelenstaub",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Schwarzmaulöl",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Angeln",
			},
			[103] = {
				["OnThis"] = "Handschuhe",
				["Description"] = "Dauerhaft Handschuhe verzaubern, um einen Angriffstempo-Bonus von +1% zu erlangen.",
				["LongName"] = "Handschuhe - Schwache Hast",
				["BonusNb"] = "1%",
				["Name"] = "Handschuhe",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Großer strahlender Splitter",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Wildranke",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Angriffst.",
			},
			[104] = {
				["OnThis"] = "Brust",
				["Required"] = "Runenverzierte Echtsilberrute",
				["LongName"] = "Brust - Erhebliches Mana",
				["BonusNb"] = 100,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Große ewige Essenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Kleiner glänzender Splitter",
					},
					["Etat"] = -2,
				},
				["Description"] = "Einen Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana um +100 erhöht wird.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Mana",
			},
			[105] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass alle Werte um 1 erhöht werden.",
				["LongName"] = "Brust - Schwache Werte",
				["BonusNb"] = 1,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Große Astralessenz",
					},
					[2] = {
						["Count"] = 1,
						["Name"] = "Seelenstaub",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Großer gleißender Splitter",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Silberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Werte",
			},
			[106] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass alle Werte um +2 erhöht werden.",
				["LongName"] = "Brust - Geringe Werte",
				["BonusNb"] = 2,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 2,
						["Name"] = "Große Mystikeressenz",
					},
					[2] = {
						["Count"] = 2,
						["Name"] = "Visionenstaub",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Großer leuchtender Splitter",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Goldrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Werte",
			},
			[107] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Arkanitrute",
				["LongName"] = "Waffe verzaubern - mächtige Willenskraft",
				["Name"] = "Waffe verzaubern",
				["Bonus"] = "Willen",
				["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass sie die Willenskraft um 20 erhöht.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Reagents"] = {
					[1] = {
						["Count"] = 10,
						["Name"] = "Großer glänzender Splitter",
					},
					[2] = {
						["Count"] = 8,
						["Name"] = "Große ewige Essenz",
					},
					[3] = {
						["Count"] = 15,
						["Name"] = "Illusionsstaub",
					},
					["Etat"] = -2,
				},
			},
			[108] = {
				["OnThis"] = "Brust",
				["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass alle Werte um +3 erhöht werden.",
				["LongName"] = "Brust - Werte",
				["BonusNb"] = 3,
				["Name"] = "Brust",
				["Reagents"] = {
					[1] = {
						["Count"] = 1,
						["Name"] = "Großer strahlender Splitter",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Traumstaub",
					},
					[3] = {
						["Count"] = 2,
						["Name"] = "Große Nether-Essenz",
					},
					["Etat"] = -2,
				},
				["Required"] = "Runenverzierte Echtsilberrute",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Werte",
			},
			[109] = {
				["OnThis"] = "Waffe",
				["Required"] = "Runenverzierte Goldrute",
				["LongName"] = "Waffe - Wintermacht",
				["Name"] = "Waffe",
				["Reagents"] = {
					[1] = {
						["Count"] = 3,
						["Name"] = "Große Mystikeressenz",
					},
					[2] = {
						["Count"] = 3,
						["Name"] = "Visionenstaub",
					},
					[3] = {
						["Count"] = 1,
						["Name"] = "Großer leuchtender Splitter",
					},
					[4] = {
						["Count"] = 2,
						["Name"] = "Winterbiss",
					},
					["Etat"] = -2,
				},
				["Description"] = "Eine Waffe dauerhaft verzaubern, sodass sie beim Wirken von Frostzaubern bis zu 7 Punkte zusätzlichen Frostschaden verursacht.",
				["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
				["Bonus"] = "Wintermacht",
			},
		}
	};
end