--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
---- Für die deutsche Version --------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
if (GetLocale() == "deDE") then 
	MINIMAPBUTTON_TOOLTIP 											= "EnchantingSeller";
	
	ENCHANTINGSELL_MSG_LAUNCH										= "EnchantingSeller gestartet";
	ENCHANTINGSELL_MSG_RESETBD										= "Stammdaten gel\195\182scht.";
	ENCHANTINGSELL_MSG_LOADDEFAULTBD								= "Stammdaten der Komponenten werder geladen.";
	ENCHANTINGSELL_MSG_RESETALLDATAAREYOUSURE						= "Soll das Mod wirklich zur\195\188ckgesetzt werden?";
	ENCHANTINGSELL_MSG_LOADDEFAULTDATACOMPONANTAREYOUSURE			= "Das Laden der Stammdaten der Komponenten inclusive Preisen wird die alten Komponentendaten l\195\182schen. Fortfahren?";
	ENCHANTINGSELL_MSG_LOADDEFAULTDATAENCHANTEAREYOUSURE			= "Das Laden der Stammdaten der Verzauberungen wird die alten Verzauberungsdaten l\195\182schen. Fortfahren?";
	
	ENCHANTINGSELL_MSG_ERREUR_NOTLOADDEFAULTBD						= "Keine Stammdaten von Komponenten gefunden - laden nicht m\195\182glich."
	ENCHANTINGSELL_MSG_ERREUR_NEWASKIMPOSSIBLE						= "Eine Frage steht noch aus; diese muss beantwortet werden, bevor eine neue Aktion ausgef\195\188hrt werden kann.";
	ENCHANTINGSELL_MSG_ERREUR_PRICEMODIFCANCEL						= "Another Action! The modification of price in progress was cancelled";
	ENCHANTINGSELL_ERRORMSG_INCOMPATIBLESORTENCHANTE				= "EnchantingSell kann nicht gestartet werden!\n\rSortEnchante ist nicht mit EnchantingSell kompatibel - bitte deaktivieren."
	
	ENCHANTINGSELL_TITLE 											= "Enchanting Sell "..ENCHANTINGSELL_VERSION;
	ENCHANTINGSELL_TAB_LIST_ENCHANTE								= "Verzauberungen";
	ENCHANTINGSELL_TAB_LIST_COMPONENT								= "Komponenten";
	ENCHANTINGSELL_TAB_OPTION										= "Optionen";
	
	ENCHANTINGSELL_CHANGEPRICEFRAME_PRICEWITHPOURCENTHEADER			= "Preis berechnet mit Prozentsatz: ";
	ENCHANTINGSELL_CHANGEPRICEFRAME_PRICEWITHPOURCENTCHECKBOX		= "Berechneten Preis benutzen.";
	
	ENCHANTINGSELL_PRICE_UNITEGOLD									= "G"; -- Goldst\195\188cke
	ENCHANTINGSELL_PRICE_UNITESILVER								= "S"; -- Silberst\195\188cke
	ENCHANTINGSELL_PRICE_UNITECOPPER								= "C"; -- Kupferst\195\188cke
	
	ENCHANTINGSELL_ENCHANTE_BUTTON_CREATEENCHANTE					= "Verzaubern";
	ENCHANTINGSELL_ENCHANTE_CHECK_SORTBYCRAFT						= "Sortiere nach M\195\182glichkeit";
	
	ENCHANTINGSELL_ENCHANTE_HEADER_NAME								= "Verzauberungsname";
	ENCHANTINGSELL_ENCHANTE_HEADER_ONTHIS							= "Auf";
	ENCHANTINGSELL_ENCHANTE_HEADER_BONUS							= "Bonus";
	ENCHANTINGSELL_ENCHANTE_HEADER_MONEY							= "Preis";
	
	ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_HEADER				= "Ben\195\182tigt :";
	ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_ADDNAMEFORINBANK		= "(auf der Bank)";
	ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_ADDNOKNOW				= "(um diese Verzauberungen zu lernen)";
	
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_HEADER							= "Kopfzeile Verzauberungen\n\r\n\rKlick: Sortiere diese Spalte\n\rNochmaliges Klicken: Umgekehrte Sortierung";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_LIST							= "Verzauberung\n\r\n\rShift+Klick: Kopiert die Verzauberungsinformationen in den Chat\n\r\n\rFarbe:\n\rKlares gr\195\188n -> Es sind alle Zutaten und Ruten im den Beuteln.\n\rDunkles gr\195\188n -> Einige n\195\182tige Zutaten sind auf der Bank.\n\rBraun -> Einige n\195\182tige Zutaten sind auf einem anderen Charakter.\n\Grau -> Dieser Verzauberer kennt diese Verzauberung nicht.";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_DETAIL_NAMEDESCRIPTION			= "Verzauberungsdetail\n\r\n\rShift+Klick: Kopiert (Kompletter Name und Beschreibung) in den Chat";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_REAGENTS						= "Ben\195\182tigte Komponenten\n\r\n\rShift+Klick: Kopiert f\195\188r diese Komponente\n\r  (Name und ben\195\182tigte Anzahl) in den Chat\n\rDoppelklick: Zeige Komponentendetails";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_REAGENTSHEADER					= "Kopfzeile Komponenten\n\r\n\rShift+Klick: Kopiert f\195\188r alle Komponenten\n\r  (Name und ben\195\182tigte Anzahl) in den Chat";
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_SEPARATORFORPRICE				= " zu "; -- " à "
	ENCHANTINGSELL_ENCHANTE_TOOLTIP_TOTALPRICE						= "Verzauberungspreis\n\r\n\rDoppelklick: \195\132ndere den Verzauberungspreis manuell.\n\r\n\rFarbe:\n\rWei\195\159 -> Automatisch berechnet.\n\rGr\195\188 -> Dein Preis."
	
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_NAME				= "Komponentenname";
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_NB					= "B/CT";
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_NBOTHER				= "B-RR";
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_PRICEUNITE			= "Preis U";
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_PRICETOTAL			= "Preis T";
	
	ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_PRICETOTALNOBENEF 	= "ohne Gewinn";
	
	ENCHANTINGSELL_COMPONANT_HEADER_NAME							= "Komponentenname";
	ENCHANTINGSELL_COMPONANT_HEADER_NB								= "Inv";
	ENCHANTINGSELL_COMPONANT_HEADER_NBBANK							= "Bank";
	ENCHANTINGSELL_COMPONANT_HEADER_NBREROLL						= "ReRoll";
	ENCHANTINGSELL_COMPONANT_HEADER_PRICEUNITE						= "Preis E";
	--ENCHANTINGSELL_COMPONANT_HEADER_PRICETOTAL						= "Preis T";
	
	ENCHANTINGSELL_COMPONANT_DETAIL_HEADER_NAMEPLAYER				= "Spielername";
	ENCHANTINGSELL_COMPONANT_DETAIL_HEADER_INBAG					= "Beutel";
	ENCHANTINGSELL_COMPONANT_DETAIL_HEADER_INBANK					= "Bank";
	
	ENCHANTINGSELL_OPTION_ENCHANTING_POURCENTBENEFICE				= "% Gewinn :";
	
	ENCHANTINGSELL_OPTION_ENCHANTING_ENCHANTORSELECTED				= "Gew\195\164hlter Verzauberer :";
	ENCHANTINGSELL_OPTION_ENCHANTING_NOTHINGPLAYER					= "keiner";
	ENCHANTINGSELL_OPTION_ENCHANTING_FORJOINTPLAYERANDSERVER_OF		= " auf ";
	ENCHANTINGSELL_OPTION_ENCHANTING_MSGYESORNOTCHANGESERVER		= "Dieser Verzauberer ist auf einem anderen Server; die Anzahl in den Beuteln, der Bank und ReRoll wurde gel\195\182.\n\rWillst du fortfahren ?"
	ENCHANTINGSELL_OPTION_USE_AUCTIONEER						= "Benutzen Sie AuktioncDatenbank? ";
	ENCHANTINGSELL_OPTION_USE_MINIMAP_BUTTON					= "Minimap-Icon anzeigen? ";
	ENCHANTINGSELL_OPTION_CHAT_SHOWPRICEFORCHATINFO					= "Verzauberungspreis im Dialogchat ausgebent ";
	ENCHANTINGSELL_OPTION_BD_RESETBUTTON							= "L\195\182sche alle gespeicherten Daten"
	ENCHANTINGSELL_OPTION_BD_DEFAULTCOMPONANTEBUTTON				= "Lade Komponenten-Stammdaten"
	ENCHANTINGSELL_OPTION_BD_DEFAULTENCHANTEBUTTON					= "Lade Verzauberungen-Stammdaten"
	ENCHANTINGSELL_OPTION_UI_MINIMAPPOSITION						= "MiniMap Knopf  -> Position";
	ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE					= "Kalkulationsgrundlage Preis";
	ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE_TYPE1					= "ungerundet (1G 56S 33K)";
	ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE_TYPE2					= "gerundet xx.xx (1,57G)";
	ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE_TYPE3					= "gerundet xx (G)";
	
	ENCHANTINGSELL_TOOLTIPADD_TITLE									= "EnchantingSell AddInfo";
	ENCHANTINGSELL_TOOLTIPADD_ONME									= "Im Inv";
	ENCHANTINGSELL_TOOLTIPADD_INBANK								= "Auf der Bank";
	ENCHANTINGSELL_TOOLTIPADD_OTHERPLAYER							= "ReRoll";
	ENCHANTINGSELL_TOOLTIPADD_PRICEUNITE							= "Price Unite";

	NAME_SPELL_CRAFT_ENCHANTE										= "Verzauberkunst";
	

	EnchantingSell_ToolsEnchanting = {
		{"Runenverzierte Kupferrute"},
		{"Runenverzierte Silberrute"},
		{"Runenverzierte Goldrute"},
		{"Runenverzierte Echtsilberrute"},
		{"Runenverzierte Arkanitrute"},
	};	

	--LordRod translations 1/7/2006
	EnchantingSell_ArmorCarac = {
		[1] = {"Armschiene", "Armschiene"};		--bracers
		[2] = {"Brust", "Brust"};			--chest
		[3] = {"Gemischt", "Gemischt"};			--Other		
		[4] = {"Handschuhe", "Handschuhe"};		--gloves
		[5] = {"Ã–l", "Ã–l"};				--Oil
		[6] = {"Rute", "Rute"};				--Rod
		[7] = {"Schild", "Schild"};			--shield
		[8] = {"Stab", "Stab"};				--Wand
		[9] = {"Stiefel", "Stiefel"};			--boots
		[10] = {"Umhang", "Umhang"};			--cloak
		[11] = {"Waffe", "Waffe"};			--weapon
		[12] = {"Zweihandwaffe", "Zweihandwaffe"};	--2h weapon
		Other = "Gemischt";
		All = "Alle";
	};
	
	--LordRod translations 1/7/2006
	EnchantingSell_Objet = {
		{"Runenverzierte Kupferrute", "Runenverzierte Kupferrute", "Rute"},
		{"Runenverzierte Silberrute", "Runenverzierte Silberrute", "Rute"},
		{"Runenverzierte Goldrute", "Runenverzierte Goldrute", "Rute"},
		{"Runenverzierte Echtsilberrute", "Runenverzierte Echtsilberrute", "Rute"},
		{"Runenverzierte Arkanitrute", "Runenverzierte Arkanitrute", "Rute"},
		{"Geringer Magiezauberstab", "(Arc)dps:11.3", "Stab"},
		{"Gro\195\159er Magiezauberstab", "(Arc)dps:17.5", "Stab"},
		{"Geringer Mystikerzauberstab", "(Arc)dps:25.4", "Stab"},
		{"Gro\195\159er Mystikerzauberstab", "(Arc)dps:29.0", "Stab"},
		{"Schwaches Zauber\195\182l", "Z. Sch. +8", "Ã–l"},
		{"Geringes Zauber\195\182l", "Z. Sch. +16", "Ã–l"},
		{"Zauber\195\182l", "Z. Sch. +24", "Ã–l"},
		{"Hervorragendes Zauber\195\182l", "Z. Sch. +36", "Ã–l"},		--Brilliant
		{"Schwaches Mana\195\182l", "4 Mana 5 Sek", "Ã–l"},
		{"Geringes Mana\195\182l", "8 Mana 5 Sek", "Ã–l"},
		{"Hervorragendes Mana\195\182l", "12 Mana 5 Sek", "Ã–l"},	--Brilliant
		--{"Armschiene- Schwache Beweglichkeit", "Beweglichk +1", "Armschiene"},	-- 29.01.2007 LordRod misspelled bye blizzard
	};

	EnchantingSell_Quality = {
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
		["Quality_Armschiene"] = {
			[1] = {"Manaregenaration"; "4 Mana 5 Sek"};
			[2] = {"Heilkraft"; "Heilkraft +24"};
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
			[6] = {"Erhebliche"; 9}; --added Lordrod 29.01.2006
		};
		["Quality_Maechtige20"] = {
			[1] = {"Schwache"; 1};
			[2] = {"Geringe"; 3};
			[3] = {"None"; 5};
			[4] = {"Gro\195\159e"; 7};
			[5] = {"\195\156berragende"; 9};
			[6] = {"Erhebliche"; 9}; --added Lordrod 29.01.2006
			[0] = {"M\195\164chtige"; 20}; --added Lordrod 29.01.2006 Blizzard's Deutschübersetzter haben keine Ahnung vom Spiel und was sie schon mal übersetzt haben!
		};
		["Quality_Maechtige22"] = {
			[0] = {"M\195\164chtige"; 22}; --added Lordrod 29.01.2006 Blizzard's Deutschübersetzter haben keine Ahnung vom Spiel und was sie schon mal übersetzt haben!
		};
		["Quality_None15"] = { --added LordRod 2006-08-15 add so its possible to see the difference between 15 and 25
			[0] = {"None"; 15};
		};
		["Quality_None25"] = { --added LordRod 2006-08-15 add so its possible to see the difference between 15 and 25
			[0] = {"None"; 25};
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
			[1] = {"Schwache"; 0};
			[2] = {"Geringer"; 30};
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
			[2] = {"Geringer"; 6};
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
			[4] = {"Hochentwickelte"; 5}; --fixed Lordrod 29.01.2006
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
			[4] = {"Gro\195\159e"; 15}; --added Lordrod 29.01.2006
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
		["Quality_Agility_Gloves"] = {
			[1] = {"None"; 5};
			[2] = {"Gro\195\159e"; 7};
			[3] = {"\195\156berragende"; 15};
		};	
	};

	--german
	--2H-Waffe - Schwacher Einschlag
	EnchantingSell_ForTakeNameCaracBonusModel = "^(.+)%s%-%s.+"; 	-- Take name			[(name) - Quality add]
	EnchantingSell_ForTakeQualityBonusModel = 	"^.+%s%-%s(.+)";	-- Take Quality add		[name - (Quality add)]
	
	EnchantingSell_BonusCarac = {
		{"Schutz";														"Schutz";														EnchantingSell_Quality["Quality_Armure_Bouclier"];	"Schild"};
		{"Schutz";														"R\195\188stung";										EnchantingSell_Quality["Quality_Armure"];						nil};
		{"Verteidigung";											"R\195\188stung";										EnchantingSell_Quality["Quality_Armure"];						nil};
		{"Deflect";														"Def";															EnchantingSell_Quality["Quality_Defence"];					nil};
		{"Abwehr";														"Vert";															EnchantingSell_Quality["Quality_Defence"];					nil};
		{"Hast";															"Angriffst.";												EnchantingSell_Quality["Quality_Haste"];						nil};
		{"Tempo";															"Tempo";														EnchantingSell_Quality["Quality_Haste"];						nil};
		{"Ausdauer";													"Ausdauer";													EnchantingSell_Quality["Quality_OneCarac"];					nil};
		{"Willenskraft";											"Willen";														EnchantingSell_Quality["Quality_Maechtige20"];					  "Waffe"};
		{"Willenskraft";											"Willen";														EnchantingSell_Quality["Quality_OneCarac"];					  nil};
		{"Beweglichkeit";											"Bewegl.";												EnchantingSell_Quality["Quality_None15"];					"Waffe"};
		{"Beweglichkeit";											"Bewegl.";												EnchantingSell_Quality["Quality_None25"];					"Zweihandwaffe"};
		{"Beweglichkeit";											"Bewegl.";												EnchantingSell_Quality["Quality_OneCarac"];					nil};
		{"St\195\164rke";											"St\195\164rke";										EnchantingSell_Quality["Quality_None15"];					"Waffe"};
		{"St\195\164rke";											"St\195\164rke";										EnchantingSell_Quality["Quality_OneCarac"];					nil};
		{"Intelligenz";												"Int";															EnchantingSell_Quality["Quality_Maechtige22"];					"Waffe"};
		{"Intelligenz";												"Int";															EnchantingSell_Quality["Quality_OneCarac"];					nil};
		{"Werte";															"Werte";														EnchantingSell_Quality["Quality_Caract"];						nil};
		{"Manaregeneration";									"4 Mana 5 Sek";											nil;																								nil};
		{"Mana";															"Mana";															EnchantingSell_Quality["Quality_Mana"];							nil};
		{"Heilkraft";													"Heilkraft +55";										nil;																								"Waffe"};
		{"Heilkraft";													"Heilkraft +24";										nil;																								"Armschiene"};
		{"Gesundheit";												"Gesundh.";													EnchantingSell_Quality["Quality_Health"];						nil};
		{"Absorption";												"Absorb.";													EnchantingSell_Quality["Quality_Absorption"];				nil};
		{"Wildtiert\195\182ter";							"Wildtier.";							EnchantingSell_Quality["Quality_Tueur"];						nil};
		{"Elementart\195\182ter";							"Elementar.";				EnchantingSell_Quality["Quality_Tueur"];						nil};
		{"D\195\164monent\195\182ten";				"D\195\164monent\195\182ten";				nil;																								nil};
		{"Wintermacht";				"Frostsch. +7";				nil;																								nil};
		{"Schlagen";													"Schlagen";													EnchantingSell_Quality["Quality_Degat1M"];					nil};
		{"Einschlag";													"Einschlag";												EnchantingSell_Quality["Quality_Degat2M"];					nil};
		{"Feuerwiderstand";										"Feuerr";														EnchantingSell_Quality["Quality_ResistFeu"];				nil};
		{"Frostwiderstand";										"Frostr";														EnchantingSell_Quality["Quality_ResistFroid"];			nil};
		{"Schattenwiderstand";								"Schattenr";												EnchantingSell_Quality["Quality_ResistOmbre"];			nil};
		{"Widerstand";												"Widerstand";												EnchantingSell_Quality["Quality_AllResist"];				nil};
		{"Kr\195\164uterkunde";								"Kr\195\164uterk.";									EnchantingSell_Quality["Quality_Metier"];						nil};
		{"Bergbau";														"Bergbau";													EnchantingSell_Quality["Quality_Metier"];						nil};
		{"Angeln";														"Angeln";														EnchantingSell_Quality["Quality_Metier"];						nil};
		{"K\195\188rschnerei";								"K\195\188rschn.";										EnchantingSell_Quality["Quality_Depecage"];					nil};
		{"Blocken";														"Blocken";													EnchantingSell_Quality["Quality_Blocage"];					nil};
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
			["Name"] = "Geringe Magieessenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 1-10.",
		},
		[7] = {
			["Name"] = "Gro\195\159e Magieessenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 11-15.",
		},
		[8] = {
			["Name"] = "Geringe Astralessenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 16-20.",
		},
		[9] = {
			["Name"] = "Gro\195\159e Astralessenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 21-25.",
		},
		[10] = {
			["Name"] = "Geringe Mystikeressenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 26-30.",
		},
		[11] = {
			["Name"] = "Gro\195\159e Mystikeressenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 31-35.",
		},
		[12] = {
			["Name"] = "Geringe Netheressenz",
			["Description"] = "Wird i.A. von Waffen entzaubert. Gr\195\188nes Item lvl 36-40.",
		},
		[13] = {
			["Name"] = "Gro\195\159e Netheressenz",
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
		[23] = { -- changed LordRod 29.01.2006
			["Name"] = "Gro\195\159er gl\195\164nzender Splitter",
			["Description"] = "Wird von blauen Items entzaubert. Blaues Item lvl 51-60.",
		},
		[24] = { -- added LordRod 29.01.2006
				["Name"] = "Nexuskristall",
				["Description"] = "Wird von lila Items entzaubert. Lila Item 51-60 ",
		},		
		[25] = {
			["Name"] = "Kupferrute",
			["Description"] = "Wird vom Verzauberkunstbedarfsh\195\164ndler f\195\188r 99 Kupfer verkauft.",
		},
		[26] = {
			["Name"] = "Silberrute",
			["Description"] = "Wird von Schmieden mit Mindestskill 100 hergestellt.",
		},
		[27] = {
			["Name"] = "Goldrute",
			["Description"] = "Wird von Schmieden mit Mindestskill 150 hergestellt.",
		},
		[28] = {
			["Name"] = "Echtsilberrute",
			["Description"] = "Wird von Schmieden mit Mindestskill 200 hergestellt.",
		},
		[29] = {
			["Name"] = "Arkanitrute",
			["Description"] = "Wird von Schmieden mit Mindestskill 275 hergestellt.",
		},
		[30] = {
			["Name"] = "Einfaches Holz",
			["Description"] = "Wird vom Verzauberkunstbedarfsh\195\164ndler f\195\188r 30 Kupfer verkauft.",
		},
		[31] = {
			["Name"] = "Sternenholz",
			["Description"] = "Wird vom Verzauberkunstbedarfsh\195\164ndler f\195\188r 36 Silber verkauft.",
		},
	};

	EnchantingSell_DefaultList = {
		Componantes = {
			[1] = {
				["PriceUnite"] = 2500,
				["Link"] = "|cff1eff00|Hitem:7909:0:0:0|h[Aquamarin]|h|r",
				["Name"] = "Aquamarin",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Crystal_02",
			},
			[2] = {
				["PriceUnite"] = 2250,
				["Link"] = "|cffffffff|Hitem:12359:0:0:0|h[Thoriumbarren]|h|r",
				["Name"] = "Thoriumbarren",
				["Texture"] = "Interface\\Icons\\INV_Ingot_07",
			},
			[3] = {
				["PriceUnite"] = 4500,
				["Link"] = "|cff1eff00|Hitem:6037:0:0:0|h[Echtsilberbarren]|h|r",
				["Name"] = "Echtsilberbarren",
				["Texture"] = "Interface\\Icons\\INV_Ingot_08",
			},
			[4] = {
				["PriceUnite"] = 4500,
				["Link"] = "|cffffffff|Hitem:11291:0:0:0|h[Sternenholz]|h|r",
				["Name"] = "Sternenholz",
				["Texture"] = "Interface\\Icons\\INV_TradeskillItem_03",
			},
			[5] = {
				["PriceUnite"] = 38,
				["Link"] = "|cffffffff|Hitem:4470:0:0:0|h[Einfaches Holz]|h|r",
				["Name"] = "Einfaches Holz",
				["Texture"] = "Interface\\Icons\\INV_TradeskillItem_01",
			},
			[6] = {
				["PriceUnite"] = 3333,
				["Link"] = "|cffffffff|Hitem:13467:0:0:0|h[Eiskappe]|h|r",
				["Name"] = "Eiskappe",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_IceCap",
			},
			[7] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cffffffff|Hitem:8170:0:0:0|h[Unverw\195\188stliches Leder]|h|r",
				["Name"] = "Unverw\195\188stliches Leder",
				["Texture"] = "Interface\\Icons\\INV_Misc_LeatherScrap_02",
			},
			[8] = {
				["PriceUnite"] = 200,
				["Link"] = "|cffffffff|Hitem:7392:0:0:0|h[Gr\195\188nwelpenschuppe]|h|r",
				["Name"] = "Gr\195\188nwelpenschuppe",
				["Texture"] = "Interface\\Icons\\INV_Misc_MonsterScales_03",
			},
			[9] = {
				["PriceUnite"] = 14500,
				["Link"] = "|cffffffff|Hitem:9224:0:0:0|h[Elixier des D\195\164monent\195\182tens]|h|r",
				["Name"] = "Elixier des D\195\164monent\195\182tens",
				["Texture"] = "Interface\\Icons\\INV_Potion_27",
			},
			[10] = {
				["PriceUnite"] = 2000,
				["Link"] = "|cff1eff00|Hitem:10998:0:0:0|h[Geringe Astralessenz]|h|r",
				["Name"] = "Geringe Astral-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralSmall",
			},
			[11] = {
				["PriceUnite"] = 6000,
				["Link"] = "|cff1eff00|Hitem:11082:0:0:0|h[Gro\195\159e Astralessenz]|h|r",
				["Name"] = "Gro\195\159e Astral-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
			},
			[12] = {
				["PriceUnite"] = 250000,
				["Link"] = "|cff1eff00|Hitem:7082:0:0:0|h[Essenz der Luft]|h|r",
				["Name"] = "Essenz der Luft",
				["Texture"] = "Interface\\Icons\\Spell_Nature_EarthBind",
			},
			[13] = {
				["PriceUnite"] = 50600,
				["Link"] = "|cff1eff00|Hitem:7080:0:0:0|h[Essenz des Wassers]|h|r",
				["Name"] = "Essenz des Wassers",
				["Texture"] = "Interface\\Icons\\Spell_Nature_Acid_01",
			},
			[14] = {
				["PriceUnite"] = 600,
				["Link"] = "|cff1eff00|Hitem:10938:0:0:0|h[Geringe Magieessenz]|h|r",
				["Name"] = "Geringe Magie-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicSmall",
			},
			[15] = {
				["PriceUnite"] = 1800,
				["Link"] = "|cff1eff00|Hitem:10939:0:0:0|h[Gro\195\159e Magieessenz]|h|r",
				["Name"] = "Gro\195\159e Magie-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
			},
			[16] = {
				["PriceUnite"] = 8000,
				["Link"] = "|cff1eff00|Hitem:11174:0:0:0|h[Geringe Netheressenz]|h|r",
				["Name"] = "Geringe Nether-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherSmall",
			},
			[17] = {
				["PriceUnite"] = 24000,
				["Link"] = "|cff1eff00|Hitem:11175:0:0:0|h[Gro\195\159e Netheressenz]|h|r",
				["Name"] = "Gro\195\159e Nether-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherLarge",
			},
			[18] = {
				["PriceUnite"] = 4000,
				["Link"] = "|cff1eff00|Hitem:11134:0:0:0|h[Geringe Mystikeressenz]|h|r",
				["Name"] = "Geringe Mystiker-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalSmall",
			},
			[19] = {
				["PriceUnite"] = 12000,
				["Link"] = "|cff1eff00|Hitem:11135:0:0:0|h[Gro\195\159e Mystikeressenz]|h|r",
				["Name"] = "Gro\195\159e Mystiker-Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge",
			},
			[20] = {
				["PriceUnite"] = 12000,
				["Link"] = "|cff1eff00|Hitem:16202:0:0:0|h[Geringe ewige Essenz]|h|r",
				["Name"] = "Geringe ewige Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceEternalSmall",
			},
			[21] = {
				["PriceUnite"] = 36000,
				["Link"] = "|cff1eff00|Hitem:16203:0:0:0|h[Gro\195\159e ewige Essenz]|h|r",
				["Name"] = "Gro\195\159e ewige Essenz",
				["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceEternalLarge",
			},
			[22] = {
				["PriceUnite"] = 1200,
				["Link"] = "|cffffffff|Hitem:7068:0:0:0|h[Elementargeist-Feuer]|h|r",
				["Name"] = "Elementargeist-Feuer",
				["Texture"] = "Interface\\Icons\\Spell_Fire_Fire",
			},
			[23] = {
				["PriceUnite"] = 1500,
				["Link"] = "|cffffffff|Hitem:5637:0:0:0|h[Gro\195\159er Fangzahn]|h|r",
				["Name"] = "Gro\195\159er Fangzahn",
				["Texture"] = "Interface\\Icons\\INV_Misc_Bone_08",
			},
			[24] = {
				["PriceUnite"] = 45000,
				["Link"] = "|cff0070dd|Hitem:14344:0:0:0|h[Gro\195\159er gl\195\164nzender Splitter]|h|r",
				["Name"] = "Gro\195\159er gl\195\164nzender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardBrilliantLarge",
			},
			[25] = {
				["PriceUnite"] = 70000,
				["Link"] = "|cff0070dd|Hitem:11178:0:0:0|h[Gro\195\159er strahlender Splitter]|h|r",
				["Name"] = "Gro\195\159er strahlender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientLarge",
			},
			[26] = {
				["PriceUnite"] = 38000,
				["Link"] = "|cff0070dd|Hitem:11139:0:0:0|h[Gro\195\159er leuchtender Splitter]|h|r",
				["Name"] = "Gro\195\159er leuchtender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingLarge",
			},
			[27] = {
				["PriceUnite"] = 15000,
				["Link"] = "|cff0070dd|Hitem:11084:0:0:0|h[Gro\195\159er glei\195\159ender Splitter]|h|r",
				["Name"] = "Gro\195\159er glei\195\159ender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringLarge",
			},
			[28] = {
				["PriceUnite"] = 506,
				["Link"] = "|cffffffff|Hitem:6370:0:0:0|h[Schwarzmaul\195\182l]|h|r",
				["Name"] = "Schwarzmaul\195\182l",
				["Texture"] = "Interface\\Icons\\INV_Drink_12",
			},
			[29] = {
				["PriceUnite"] = 2505,
				["Link"] = "|cffffffff|Hitem:6371:0:0:0|h[Feuer\195\182l]|h|r",
				["Name"] = "Feuer\195\182l",
				["Texture"] = "Interface\\Icons\\INV_Potion_38",
			},
			[30] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cff1eff00|Hitem:1210:0:0:0|h[Schattenedelstein]|h|r",
				["Name"] = "Schattenedelstein",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Amethyst_01",
			},
			[31] = {
				["PriceUnite"] = 290000,
				["Link"] = "|cff1eff00|Hitem:12811:0:0:0|h[Rechtschaffene Kugel]|h|r",
				["Name"] = "Rechtschaffene Kugel",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_03",
			},
			[32] = {
				["PriceUnite"] = 40000,
				["Link"] = "|cff1eff00|Hitem:13926:0:0:0|h[Goldene Perle]|h|r",
				["Name"] = "Goldene Perle",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_04",
			},
			[33] = {
				["PriceUnite"] = 9500,
				["Link"] = "|cff1eff00|Hitem:5500:0:0:0|h[Schillernde Perle]|h|r",
				["Name"] = "Schillernde Perle",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_02",
			},
			[34] = {
				["PriceUnite"] = 8000,
				["Link"] = "|cff1eff00|Hitem:7971:0:0:0|h[Schwarze Perle]|h|r",
				["Name"] = "Schwarze Perle",
				["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_01",
			},
			[35] = {
				["PriceUnite"] = 60000,
				["Link"] = "|cff0070dd|Hitem:14343:0:0:0|h[Kleiner gl\195\164nzender Splitter]|h|r",
				["Name"] = "Kleiner gl\195\164nzender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardBrilliantSmall",
			},
			[36] = {
				["PriceUnite"] = 27000,
				["Link"] = "|cff0070dd|Hitem:11177:0:0:0|h[Kleiner strahlender Splitter]|h|r",
				["Name"] = "Kleiner strahlender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientSmall",
			},
			[37] = {
				["PriceUnite"] = 15000,
				["Link"] = "|cff0070dd|Hitem:11138:0:0:0|h[Kleiner leuchtender Splitter]|h|r",
				["Name"] = "Kleiner leuchtender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingSmall",
			},
			[38] = {
				["PriceUnite"] = 3500,
				["Link"] = "|cff0070dd|Hitem:10978:0:0:0|h[Kleiner glei\195\159ender Splitter]|h|r",
				["Name"] = "Kleiner glei\195\159ender Splitter",
				["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringSmall",
			},
			[39] = {
				["PriceUnite"] = 1000,
				["Link"] = "|cffffffff|Hitem:6048:0:0:0|h[Schattenschutztrank]|h|r",
				["Name"] = "Schattenschutztrank",
				["Texture"] = "Interface\\Icons\\INV_Potion_44",
			},
			[40] = {
				["PriceUnite"] = 10075,
				["Link"] = "|cffffffff|Hitem:16204:0:0:0|h[Illusionsstaub]|h|r",
				["Name"] = "Illusionsstaub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustIllusion",
			},
			[41] = {
				["PriceUnite"] = 800,
				["Link"] = "|cffffffff|Hitem:11083:0:0:0|h[Seelenstaub]|h|r",
				["Name"] = "Seelenstaub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustSoul",
			},
			[42] = {
				["PriceUnite"] = 5000,
				["Link"] = "|cffffffff|Hitem:11176:0:0:0|h[Traumstaub]|h|r",
				["Name"] = "Traumstaub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustDream",
			},
			[43] = {
				["PriceUnite"] = 1590,
				["Link"] = "|cffffffff|Hitem:11137:0:0:0|h[Visionenstaub]|h|r",
				["Name"] = "Visionenstaub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustVision",
			},
			[44] = {
				["PriceUnite"] = 500,
				["Link"] = "|cffffffff|Hitem:10940:0:0:0|h[Seltsamer Staub]|h|r",
				["Name"] = "Seltsamer Staub",
				["Texture"] = "Interface\\Icons\\INV_Enchant_DustStrange",
			},
			[45] = {
				["PriceUnite"] = 175,
				["Link"] = "|cffffffff|Hitem:3356:0:0:0|h[K\195\182nigsblut]|h|r",
				["Name"] = "K\195\182nigsblut",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_03",
			},
			[46] = {
				["PriceUnite"] = 8400,
				["Link"] = "|cffffffff|Hitem:8153:0:0:0|h[Wildranke]|h|r",
				["Name"] = "Wildranke",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_03",
			},
			[47] = {
				["PriceUnite"] = 3500,
				["Link"] = "|cffffffff|Hitem:8838:0:0:0|h[Sonnengras]|h|r",
				["Name"] = "Sonnengras",
				["Texture"] = "Interface\\Icons\\INV_Misc_Herb_18",
			},
			[48] = {
				["PriceUnite"] = 1200,
				["Link"] = "|cffffffff|Hitem:7067:0:0:0|h[Elementargeist-Erde]|h|r",
				["Name"] = "Elementargeist-Erde",
				["Texture"] = "Interface\\Icons\\INV_Ore_Iron_01",
			},
			[49] = {
				["PriceUnite"] = 800000,
				["Link"] = "|cffffffff|Hitem:16206:0:0:0|h[Runenverzierte Arkanitrute]|h|r",
				["Name"] = "Runenverzierte Arkanitrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_19",
			},
			[50] = {
				["PriceUnite"] = 29900,
				["Link"] = "|cff1eff00|Hitem:12803:0:0:0|h[Lebende Essenz]|h|r",
				["Name"] = "Lebende Essenz",
				["Texture"] = "Interface\\Icons\\Spell_Nature_AbolishMagic",
			},
			[51] = {
				["PriceUnite"] = 2500,
				["Link"] = "|cffffffff|Hitem:6338:0:0:0|h[Runenverzierte Silberrute]|h|r",
				["Name"] = "Runenverzierte Silberrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_01",
			},
			[52] = {
				["PriceUnite"] = 124,
				["Link"] = "|cffffffff|Hitem:6217:0:0:0|h[Runenverzierte Kupferrute]|h|r",
				["Name"] = "Runenverzierte Kupferrute",
				["Texture"] = "Interface\\Icons\\INV_Misc_Flute_01",
			},
			[53] = {
				["PriceUnite"] = 7711,
				["Link"] = "|cffffffff|Hitem:11128:0:0:0|h[Runenverzierte Goldrute]|h|r",
				["Name"] = "Runenverzierte Goldrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_10",
			},
			[54] = {
				["PriceUnite"] = 12250,
				["Link"] = "|cffffffff|Hitem:11144:0:0:0|h[Runenverzierte Echtsilberrute]|h|r",
				["Name"] = "Runenverzierte Echtsilberrute",
				["Texture"] = "Interface\\Icons\\INV_Staff_11",
			},
			["Nb"] = 54,
		};
		Enchantes = {
		[1] = {
		["OnThis"] = "Zweihandwaffe",
		["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass damit 2 zusätzliche Schadenspunkte verursacht werden.",
		["Link"] = "|cffffffff|Henchant:7745|h[Zweihandwaffe - Schwacher Einschlag]|h|r",
		["Price"] = 5700,
		["IdOriginal"] = 123,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 4,
			},
			[2] = {
				["Name"] = "Kleiner gleißender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Zweihandwaffe - Schwacher Einschlag",
		["PriceNoBenef"] = 4720,
		["Name"] = "Zweihandwaffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 2,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Einschlag",
	},
	[2] = {
		["OnThis"] = "Zweihandwaffe",
		["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass damit 3 zusätzliche Punkte Schaden zugefügt werden.",
		["Link"] = "|cffffffff|Henchant:13529|h[Zweihandwaffe - Geringer Einschlag]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 120,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Großer gleißender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Zweihandwaffe - Geringer Einschlag",
		["PriceNoBenef"] = 14950,
		["Name"] = "Zweihandwaffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Einschlag",
	},
	[3] = {
		["OnThis"] = "Zweihandwaffe",
		["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass damit 5 zusätzliche Punkte Schaden zugefügt werden.",
		["Link"] = "|cffffffff|Henchant:13695|h[Zweihandwaffe - Einschlag]|h|r",
		["Price"] = 60000,
		["IdOriginal"] = 118,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 4,
			},
			[2] = {
				["Name"] = "Großer leuchtender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Zweihandwaffe - Einschlag",
		["PriceNoBenef"] = 48000,
		["Name"] = "Zweihandwaffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Einschlag",
	},
	[4] = {
		["OnThis"] = "Zweihandwaffe",
		["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass damit +7 Schaden zugefügt wird.",
		["Link"] = "|cffffffff|Henchant:13937|h[Zweihandwaffe - Großer Einschlag]|h|r",
		["Price"] = 140000,
		["IdOriginal"] = 122,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer strahlender Splitter",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Traumstaub",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Zweihandwaffe - Großer Einschlag",
		["PriceNoBenef"] = 109000,
		["Name"] = "Zweihandwaffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 7,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Einschlag",
	},
	[5] = {
		["OnThis"] = "Zweihandwaffe",
		["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass sie die Intelligenz um 3 erhöht.",
		["Link"] = "|cffffffff|Henchant:7793|h[Zweihandwaffe - Geringe Intelligenz]|h|r",
		["Price"] = 6500,
		["IdOriginal"] = 119,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Magie-Essenz",
				["Count"] = 3,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Zweihandwaffe - Geringe Intelligenz",
		["PriceNoBenef"] = 5400,
		["Name"] = "Zweihandwaffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Int",
	},
	[6] = {
		["OnThis"] = "Zweihandwaffe",
		["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass sie die Willenskraft um 3 erhöht.",
		["Link"] = "|cffffffff|Henchant:13380|h[Zweihandwaffe - Geringer Willen]|h|r",
		["Price"] = 9100,
		["IdOriginal"] = 121,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 6,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Zweihandwaffe - Geringer Willen",
		["PriceNoBenef"] = 7580,
		["Name"] = "Zweihandwaffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[7] = {
		["OnThis"] = "Zweihandwaffe",
		["Description"] = "Eine Zweihand-Nahkampfwaffe dauerhaft verzaubern, sodass sie die Willenskraft um 9 erhöht.",
		["Link"] = "|cffffffff|Henchant:20035|h[Zweihandwaffe - Erheblicher Willen]|h|r",
		["Price"] = 870000,
		["IdOriginal"] = 15,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 12,
			},
			[2] = {
				["Name"] = "Großer glänzender Splitter",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Zweihandwaffe - Erheblicher Willen",
		["PriceNoBenef"] = 720000,
		["Name"] = "Zweihandwaffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Arkanitrute",
		["BonusNb"] = 0,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[8] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass der Feuerwiderstand um 7 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13657|h[Umhang - Feuerwiderstand]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 97,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Mystikeressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Elementarfeuer",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Feuerwiderstand",
		["PriceNoBenef"] = 12700,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 7,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Feuerr",
	},
	[9] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Angelfertigkeit um +2 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13620|h[Handschuhe - Angeln]|h|r",
		["Price"] = 8100,
		["IdOriginal"] = 66,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Schwarzmaulöl",
				["Count"] = 3,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Handschuhe - Angeln",
		["PriceNoBenef"] = 6750,
		["Name"] = "Handschuhe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 2,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Angeln",
	},
	[10] = {
		["OnThis"] = "Umhang",
		["Description"] = "Umhang dauerhaft verzaubern, sodass der Feuerwiderstand um 15 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:25081|h[Formel: Umhang verzaubern - Großer Feuerwiderstand]|h|r",
		["Price"] = 3050000,
		["IdOriginal"] = 6,
		["Reagents"] = {
			[1] = {
				["Name"] = "Nexuskristall",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Großer glänzender Splitter",
				["Count"] = 8,
			},
			[3] = {
				["Name"] = "Essenz des Feuers",
				["Count"] = 4,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Formel: Umhang verzaubern - Großer Feuerwiderstand",
		["PriceNoBenef"] = 2540000,
		["Name"] = "Formel: Umhang verzaubern",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Arkanitrute",
		["BonusNb"] = 0,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Feuerr",
	},
	[11] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang verzaubern, sodass 10 zusätzliche Rüstungspunkte gewährt werden.",
		["Link"] = "|cffffffff|Henchant:7771|h[Umhang - Schwacher Schutz]|h|r",
		["Price"] = 3800,
		["IdOriginal"] = 104,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Große Magie-Essenz",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Schwacher Schutz",
		["PriceNoBenef"] = 3090,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 10,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Rüstung",
	},
	[12] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Rüstung um 20 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13421|h[Umhang - Schwacher Schutz]|h|r",
		["Price"] = 6700,
		["IdOriginal"] = 103,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 6,
			},
			[2] = {
				["Name"] = "Kleiner gleißender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Schwacher Schutz",
		["PriceNoBenef"] = 5580,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 10,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Rüstung",
	},
	[13] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit um +50 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13858|h[Brust - Überragende Gesundheit]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 58,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 6,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Überragende Gesundheit",
		["PriceNoBenef"] = 10200,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 50,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Gesundh.",
	},
	[14] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Beweglichkeit um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13815|h[Handschuhe - Beweglichkeit]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 68,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Netheressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Visionenstaub",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Handschuhe - Beweglichkeit",
		["PriceNoBenef"] = 12700,
		["Name"] = "Handschuhe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Beweglichk",
	},
	[15] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Rüstung zusätzlich um 30 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13635|h[Umhang - Verteidigung]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 106,
		["Reagents"] = {
			[1] = {
				["Name"] = "Kleiner leuchtender Splitter",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seelenstaub",
				["Count"] = 3,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Verteidigung",
		["PriceNoBenef"] = 8750,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 30,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Rüstung",
	},
	[16] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Rüstung zusätzlich um 50 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13746|h[Umhang - Große Verteidigung]|h|r",
		["Price"] = 6200,
		["IdOriginal"] = 101,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Große Verteidigung",
		["PriceNoBenef"] = 5100,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 50,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Rüstung",
	},
	[17] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Rüstung zusätzlich um 70 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20015|h[Umhang - Überragende Verteidigung]|h|r",
		["Price"] = 90000,
		["IdOriginal"] = 9,
		["Reagents"] = {
			[1] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 8,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Überragende Verteidigung",
		["PriceNoBenef"] = 72000,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 70,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Rüstung",
	},
	[18] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Beweglichkeit um +7 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20012|h[Handschuhe verzaubern - Große Beweglichkeit]|h|r",
		["Price"] = 90000,
		["IdOriginal"] = 18,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe ewige Essenz",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Handschuhe verzaubern - Große Beweglichkeit",
		["PriceNoBenef"] = 75000,
		["Name"] = "Handschuhe verzaubern",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 7,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Beweglichk",
	},
	[19] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Stiefel dauerhaft verzaubern, sodass die Ausdauer um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13836|h[Stiefel - Ausdauer]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 89,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 5,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Ausdauer",
		["PriceNoBenef"] = 8500,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[20] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass sich der Schattenwiderstand um 10 erhöht.",
		["Link"] = "|cffffffff|Henchant:13522|h[Umhang - Geringer Schattenwiderstand]|h|r",
		["Price"] = 0,
		["IdOriginal"] = 100,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Astralessenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Schattenschutztrank",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["LongName"] = "Umhang - Geringer Schattenwiderstand",
		["PriceNoBenef"] = 0,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 10,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Schattenr",
	},
	[21] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass sich der Widerstand gegen alle Arten von Magie um 1 erhöht.",
		["Link"] = "|cffffffff|Henchant:7454|h[Umhang - Schwacher Widerstand]|h|r",
		["Price"] = 2000,
		["IdOriginal"] = 105,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Geringe Magie-Essenz",
				["Count"] = 2,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Schwacher Widerstand",
		["PriceNoBenef"] = 1630,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Widerstand",
	},
	[22] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Kräuterkundefertigkeit um +2 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13617|h[Handschuhe - Kräuterkunde]|h|r",
		["Price"] = 900,
		["IdOriginal"] = 71,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Königsblut",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["LongName"] = "Handschuhe - Kräuterkunde",
		["PriceNoBenef"] = 750,
		["Name"] = "Handschuhe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 2,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Kräuterk.",
	},
	[23] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, um eine Chance zu haben, Dämonen zu betäuben und ihnen schweren Schaden zuzufügen.",
		["Link"] = "|cffffffff|Henchant:13915|h[Waffe - Dämonentöten]|h|r",
		["Price"] = 80000,
		["IdOriginal"] = 110,
		["Reagents"] = {
			[1] = {
				["Name"] = "Kleiner strahlender Splitter",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Traumstaub",
				["Count"] = 2,
			},
			[3] = {
				["Name"] = "Elixier des Dämonentötens",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["LongName"] = "Waffe - Dämonentöten",
		["PriceNoBenef"] = 61800,
		["Name"] = "Waffe",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Echtsilberrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Dämonentöten",
	},
	[24] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass alle Widerstände um 3 erhöht werden.",
		["Link"] = "|cffffffff|Henchant:13794|h[Umhang - Widerstand]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 107,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Netheressenz",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Widerstand",
		["PriceNoBenef"] = 11000,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Widerstand",
	},
	[25] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass alle Widerstände um 5 erhöht werden.",
		["Link"] = "|cffffffff|Henchant:20014|h[Umhang - Großer Widerstand]|h|r",
		["Price"] = 110000,
		["IdOriginal"] = 22,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe ewige Essenz",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Herz des Feuers",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Erdenkern",
				["Count"] = 1,
			},
			[4] = {
				["Name"] = "Kugel des Wassers",
				["Count"] = 1,
			},
			[5] = {
				["Name"] = "Odem des Windes",
				["Count"] = 1,
			},
			[6] = {
				["Name"] = "Sekret des Untodes",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Großer Widerstand",
		["PriceNoBenef"] = 83500,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Widerstand",
	},
	[26] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Willenskraft um +9 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20016|h[Schild - Erheblicher Willen]|h|r",
		["Price"] = 180000,
		["IdOriginal"] = 20,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 4,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Schild - Erheblicher Willen",
		["PriceNoBenef"] = 146000,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 0,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[27] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Ein Paar Stiefel dauerhaft verzaubern, sodass sich die Beweglichkeit des Trägers um 1 erhöht.",
		["Link"] = "|cffffffff|Henchant:7867|h[Stiefel - Schwache Beweglichkeit]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 95,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 6,
			},
			[2] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Schwache Beweglichkeit",
		["PriceNoBenef"] = 12580,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Beweglichk",
	},
	[28] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, um seine Rüstung um 30 zu erhöhen.",
		["Link"] = "|cffffffff|Henchant:13464|h[Schild - Schwacher Schutz]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 85,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Kleiner gleißender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Schild - Schwacher Schutz",
		["PriceNoBenef"] = 8430,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 30,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Schutz",
	},
	[29] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung verzaubern, sodass bei jedem Treffer eine Chance von 2% besteht, Euch 10 Punkte Schadensabsorption zu geben.",
		["Link"] = "|cffffffff|Henchant:7426|h[Brust - Schwache Absorption]|h|r",
		["Price"] = 1800,
		["IdOriginal"] = 54,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Geringe Magie-Essenz",
				["Count"] = 1,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Schwache Absorption",
		["PriceNoBenef"] = 1460,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = "2%",
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Absorb.",
	},
	[30] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Stiefel dauerhaft verzaubern, sodass die Ausdauer um +3 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13644|h[Stiefel - Geringe Ausdauer]|h|r",
		["Price"] = 3600,
		["IdOriginal"] = 91,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 4,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Geringe Ausdauer",
		["PriceNoBenef"] = 3000,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[31] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit des Trägers um 25 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:7857|h[Brust - Gesundheit]|h|r",
		["Price"] = 8100,
		["IdOriginal"] = 50,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 4,
			},
			[2] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 1,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Gesundheit",
		["PriceNoBenef"] = 6720,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 25,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Gesundh.",
	},
	[32] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Stiefel dauerhaft verzaubern, sodass die Ausdauer um +7 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20020|h[Stiefel - Große Ausdauer]|h|r",
		["Price"] = 60000,
		["IdOriginal"] = 26,
		["Reagents"] = {
			[1] = {
				["Name"] = "Traumstaub",
				["Count"] = 10,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Große Ausdauer",
		["PriceNoBenef"] = 45000,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 7,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[33] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit um +35 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13640|h[Brust - Große Gesundheit]|h|r",
		["Price"] = 2700,
		["IdOriginal"] = 51,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 3,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Große Gesundheit",
		["PriceNoBenef"] = 2250,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 35,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Gesundh.",
	},
	[34] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Stiefel dauerhaft verzaubern, um eine kleine Erhöhung des Bewegungstempos zu erhalten.",
		["Link"] = "|cffffffff|Henchant:13890|h[Stiefel - Schwaches Tempo]|h|r",
		["Price"] = 60000,
		["IdOriginal"] = 96,
		["Reagents"] = {
			[1] = {
				["Name"] = "Kleiner strahlender Splitter",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Aquamarin",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Geringe Netheressenz",
				["Count"] = 1,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Schwaches Tempo",
		["PriceNoBenef"] = 46800,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = "1%",
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Tempo",
	},
	[35] = {
		["OnThis"] = "Gemischt",
		["Required"] = "Runenverzierte Echtsilberrute",
		["Link"] = "|cffffffff|Henchant:17181|h[Verzaubertes Leder]|h|r",
		["Price"] = 30000,
		["IdOriginal"] = 108,
		["LongName"] = "Verzaubertes Leder",
		["PriceNoBenef"] = 16850,
		["Name"] = "Verzaubertes Leder",
		["TypePrice"] = 1,
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Misc_Rune_05",
		["Reagents"] = {
			[1] = {
				["Name"] = "Unverwüstliches Leder",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Geringe ewige Essenz",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
	},
	[36] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Ausdauer um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13648|h[Armschiene - Ausdauer]|h|r",
		["Price"] = 5400,
		["IdOriginal"] = 30,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 6,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Ausdauer",
		["PriceNoBenef"] = 4500,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[37] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Ausdauer um +7 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13945|h[Armschiene - Große Ausdauer]|h|r",
		["Price"] = 30000,
		["IdOriginal"] = 23,
		["Reagents"] = {
			[1] = {
				["Name"] = "Traumstaub",
				["Count"] = 5,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Große Ausdauer",
		["PriceNoBenef"] = 22500,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 7,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[38] = {
		["OnThis"] = "Öl",
		["Description"] = "Erstellt schwaches Zauberöl",
		["Link"] = "|cffffffff|Henchant:25124|h[Schwaches Zauberöl]|h|r",
		["Price"] = 1300,
		["IdOriginal"] = 88,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Ahornsamenkorn",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Leere Phiole",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Schwaches Zauberöl",
		["PriceNoBenef"] = 1064,
		["Name"] = "Schwaches Zauberöl",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Kupferrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Z. Sch. +8",
	},
	[39] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Ausdauer um +9 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20011|h[Armschiene - Überragende Ausdauer]|h|r",
		["Price"] = 170000,
		["IdOriginal"] = 1,
		["Reagents"] = {
			[1] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 15,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Überragende Ausdauer",
		["PriceNoBenef"] = 135000,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 9,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[40] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Stiefel dauerhaft verzaubern, sodass die Beweglichkeit um +3 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13637|h[Stiefel - Geringe Beweglichkeit]|h|r",
		["Price"] = 4200,
		["IdOriginal"] = 92,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Geringe Mystikeressenz",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Geringe Beweglichkeit",
		["PriceNoBenef"] = 3450,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Beweglichk",
	},
	[41] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Armschienen dauerhaft verzaubern, sodass sie den Effekt Eurer Heilzauber um 24 erhöhen.",
		["Link"] = "|cffffffff|Henchant:23802|h[Armschiene verzaubern - Heilkraft]|h|r",
		["Price"] = 990000,
		["IdOriginal"] = 3,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer glänzender Splitter",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 20,
			},
			[3] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 4,
			},
			[4] = {
				["Name"] = "Essenz des Lebens",
				["Count"] = 6,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Armschiene verzaubern - Heilkraft",
		["PriceNoBenef"] = 820000,
		["Name"] = "Armschiene verzaubern",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Arkanitrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Heilkraft",
	},
	[42] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Eine Armschiene dauerhaft verzaubern, sodass sich die Intelligenz des Trägers um 3 erhöht.",
		["Link"] = "|cffffffff|Henchant:13622|h[Armschiene - Geringe Intelligenz]|h|r",
		["Price"] = 0,
		["IdOriginal"] = 33,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Astralessenz",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = -1,
		["LongName"] = "Armschiene - Geringe Intelligenz",
		["PriceNoBenef"] = 0,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Int",
	},
	[43] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Bergbaufertigkeit um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13841|h[Handschuhe - Hochentwickelter Bergbau]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 70,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Echtsilberbarren",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Handschuhe - Hochentwickelter Bergbau",
		["PriceNoBenef"] = 12300,
		["Name"] = "Handschuhe",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Echtsilberrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Bergbau",
	},
	[44] = {
		["OnThis"] = "Gemischt",
		["Required"] = "Runenverzierte Echtsilberrute",
		["Link"] = "|cffffffff|Henchant:17180|h[Verzaubertes Thorium]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 109,
		["LongName"] = "Verzaubertes Thorium",
		["PriceNoBenef"] = 13500,
		["Name"] = "Verzaubertes Thorium",
		["TypePrice"] = -1,
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Ingot_Eternium",
		["Reagents"] = {
			[1] = {
				["Name"] = "Thoriumbarren",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Traumstaub",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
	},
	[45] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Kürschnereifertigkeit um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13698|h[Handschuhe - Kürschnerei]|h|r",
		["Price"] = 10000,
		["IdOriginal"] = 72,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Grünwelpenschuppe",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Handschuhe - Kürschnerei",
		["PriceNoBenef"] = 8300,
		["Name"] = "Handschuhe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Kürschn.",
	},
	[46] = {
		["OnThis"] = "Öl",
		["Description"] = "Erstellt Geringes Manaöl.",
		["Link"] = "|cffffffff|Henchant:25127|h[Geringes Manaöl]|h|r",
		["Price"] = 30000,
		["IdOriginal"] = 62,
		["Reagents"] = {
			[1] = {
				["Name"] = "Traumstaub",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Lila Lotus",
				["Count"] = 2,
			},
			[3] = {
				["Name"] = "Kristallphiole",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["LongName"] = "Geringes Manaöl",
		["PriceNoBenef"] = 22000,
		["Name"] = "Geringes Manaöl",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Echtsilberrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "8 Mana 5 Sek",
	},
	[47] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Stiefel dauerhaft verzaubern, sodass die Beweglichkeit um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13935|h[Stiefel - Beweglichkeit]|h|r",
		["Price"] = 90000,
		["IdOriginal"] = 90,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Netheressenz",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Beweglichkeit",
		["PriceNoBenef"] = 70000,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Beweglichk",
	},
	[48] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Armschienen dauerhaft verzaubern, sodass die Gesundheit des Trägers um 5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:7418|h[Armschiene - Schwache Gesundheit]|h|r",
		["Price"] = 600,
		["IdOriginal"] = 41,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Schwache Gesundheit",
		["PriceNoBenef"] = 430,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Gesundh.",
	},
	[49] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Armschienen dauerhaft verzaubern, sodass sie alle 5 Sek. 4 Punkt(e) Mana wiederherstellen.",
		["Link"] = "|cffffffff|Henchant:23801|h[Armschiene verzaubern - Manaregeneration]|h|r",
		["Price"] = 610000,
		["IdOriginal"] = 4,
		["Reagents"] = {
			[1] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 16,
			},
			[2] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 4,
			},
			[3] = {
				["Name"] = "Essenz des Wassers",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Armschiene verzaubern - Manaregeneration",
		["PriceNoBenef"] = 504000,
		["Name"] = "Armschiene verzaubern",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Arkanitrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Mana",
	},
	[50] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit des Trägers um 5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:7420|h[Brust - Schwache Gesundheit]|h|r",
		["Price"] = 600,
		["IdOriginal"] = 55,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Schwache Gesundheit",
		["PriceNoBenef"] = 430,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Gesundh.",
	},
	[51] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Stärke um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13661|h[Armschiene - Stärke]|h|r",
		["Price"] = 2100,
		["IdOriginal"] = 44,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Stärke",
		["PriceNoBenef"] = 1700,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Stärke",
	},
	[52] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, um +7 Stärke zu erhalten.",
		["Link"] = "|cffffffff|Henchant:13939|h[Armschiene - Große Stärke]|h|r",
		["Price"] = 60000,
		["IdOriginal"] = 36,
		["Reagents"] = {
			[1] = {
				["Name"] = "Traumstaub",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Große Netheressenz",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Große Stärke",
		["PriceNoBenef"] = 44000,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 7,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Stärke",
	},
	[53] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, um +9 Stärke zu erhalten.",
		["Link"] = "|cffffffff|Henchant:20010|h[Armschiene - Überragende Stärke]|h|r",
		["Price"] = 470000,
		["IdOriginal"] = 2,
		["Reagents"] = {
			[1] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 6,
			},
			[2] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 6,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Überragende Stärke",
		["PriceNoBenef"] = 384000,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 9,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Stärke",
	},
	[54] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Willenskraft um +7 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13905|h[Schild - Große Willenskraft]|h|r",
		["Price"] = 60000,
		["IdOriginal"] = 83,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Netheressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Traumstaub",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Schild - Große Willenskraft",
		["PriceNoBenef"] = 44000,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 7,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[55] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Dauerhaft Handschuhe verzaubern, um einen Angriffstempo-Bonus von +1% zu erlangen.",
		["Link"] = "|cffffffff|Henchant:13948|h[Handschuhe - Schwache Hast]|h|r",
		["Price"] = 140000,
		["IdOriginal"] = 25,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer strahlender Splitter",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Wildranke",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Handschuhe - Schwache Hast",
		["PriceNoBenef"] = 110200,
		["Name"] = "Handschuhe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = "1%",
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Angriffst.",
	},
	[56] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Verteidigung um +2 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13646|h[Armschiene - Geringe Abwehr]|h|r",
		["Price"] = 5100,
		["IdOriginal"] = 31,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Mystikeressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seelenstaub",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Geringe Abwehr",
		["PriceNoBenef"] = 4200,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Vert",
	},
	[57] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Armschienen dauerhaft verzaubern, sodass die Verteidigungsfertigkeit des Trägers um 1 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:7428|h[Armschiene - Schwache Abwehr]|h|r",
		["Price"] = 1300,
		["IdOriginal"] = 39,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Magie-Essenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 1,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Schwache Abwehr",
		["PriceNoBenef"] = 1030,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 2,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Vert",
	},
	[58] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit des Trägers um 15 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:7748|h[Brust - Geringe Gesundheit]|h|r",
		["Price"] = 2500,
		["IdOriginal"] = 48,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Geringe Magie-Essenz",
				["Count"] = 2,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Geringe Gesundheit",
		["PriceNoBenef"] = 2060,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 15,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Gesundh.",
	},
	[59] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Stiefel dauerhaft verzaubern, sodass die Willenskraft um +3 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13687|h[Stiefel - Geringer Willen]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 93,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Mystikeressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Geringe Mystikeressenz",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Geringer Willen",
		["PriceNoBenef"] = 11400,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[60] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Willenskraft um 3 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13485|h[Schild - Geringer Willen]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 81,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 4,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Schild - Geringer Willen",
		["PriceNoBenef"] = 11720,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[61] = {
		["OnThis"] = "Öl",
		["Description"] = "Erstellt geringes Zauberöl",
		["Link"] = "|cffffffff|Henchant:25126|h[Geringes Zauberöl]|h|r",
		["Price"] = 7000,
		["IdOriginal"] = 63,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Schlingendornsamenkorn",
				["Count"] = 2,
			},
			[3] = {
				["Name"] = "Verbleite Phiole",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Geringes Zauberöl",
		["PriceNoBenef"] = 5775,
		["Name"] = "Geringes Zauberöl",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Goldrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Z. Sch. +16",
	},
	[62] = {
		["OnThis"] = "Öl",
		["Description"] = "Erstellt Zauberöl.",
		["Link"] = "|cffffffff|Henchant:25128|h[Zauberöl]|h|r",
		["Price"] = 40000,
		["IdOriginal"] = 28,
		["Reagents"] = {
			[1] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Feuerblüte",
				["Count"] = 2,
			},
			[3] = {
				["Name"] = "Kristallphiole",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Zauberöl",
		["PriceNoBenef"] = 29500,
		["Name"] = "Zauberöl",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Echtsilberrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Z. Sch. +24",
	},
	[63] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Armschienen dauerhaft verzaubern, sodass sich die Stärke des Trägers um 1 erhöht.",
		["Link"] = "|cffffffff|Henchant:7782|h[Armschiene - Schwache Stärke]|h|r",
		["Price"] = 2600,
		["IdOriginal"] = 42,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 5,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Schwache Stärke",
		["PriceNoBenef"] = 2150,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Stärke",
	},
	[64] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung verzaubern, sodass bei jedem Treffer eine Chance von 5% besteht, Euch 25 Punkte Schadensabsorption zu geben.",
		["Link"] = "|cffffffff|Henchant:13538|h[Brust - Geringe Absorption]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 47,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Große Astralessenz",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Großer gleißender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = -1,
		["LongName"] = "Brust - Geringe Absorption",
		["PriceNoBenef"] = 13560,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = "5%",
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Absorb.",
	},
	[65] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Eine Armschiene dauerhaft verzaubern, sodass sich die Stärke des Trägers um 3 erhöht.",
		["Link"] = "|cffffffff|Henchant:13536|h[Armschiene - Geringe Stärke]|h|r",
		["Price"] = 1800,
		["IdOriginal"] = 34,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Geringe Stärke",
		["PriceNoBenef"] = 1500,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Stärke",
	},
	[66] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Stiefel dauerhaft verzaubern, sodass die Willenskraft um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20024|h[Stiefel - Willen]|h|r",
		["Price"] = 160000,
		["IdOriginal"] = 21,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Geringe ewige Essenz",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Willen",
		["PriceNoBenef"] = 126000,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[67] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass sich der Feuerwiderstand um 5 erhöht.",
		["Link"] = "|cffffffff|Henchant:7861|h[Umhang - Geringer Feuerwiderstand]|h|r",
		["Price"] = 6000,
		["IdOriginal"] = 99,
		["Reagents"] = {
			[1] = {
				["Name"] = "Feueröl",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["LongName"] = "Umhang - Geringer Feuerwiderstand",
		["PriceNoBenef"] = 5000,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Feuerr",
	},
	[68] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass die Gesundheit um +100 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20026|h[Brust - Erhebliche Gesundheit]|h|r",
		["Price"] = 130000,
		["IdOriginal"] = 17,
		["Reagents"] = {
			[1] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 6,
			},
			[2] = {
				["Name"] = "Kleiner glänzender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Erhebliche Gesundheit",
		["PriceNoBenef"] = 101000,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 100,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Gesundh.",
	},
	[69] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, um +8 Frostwiderstand zu erhalten.",
		["Link"] = "|cffffffff|Henchant:13933|h[Schild - Frostwiderstand]|h|r",
		["Price"] = 60000,
		["IdOriginal"] = 79,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer strahlender Splitter",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Frostöl",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["LongName"] = "Schild - Frostwiderstand",
		["PriceNoBenef"] = 50000,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 8,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Frostr",
	},
	[70] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit 2 zusätzliche Punkte Schaden zugefügt werden.",
		["Link"] = "|cffffffff|Henchant:13503|h[Waffe - Geringes Schlagen]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 113,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Großer gleißender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Waffe - Geringes Schlagen",
		["PriceNoBenef"] = 14200,
		["Name"] = "Waffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 2,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Schlagen",
	},
	[71] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit 3 zusätzliche Punkte Schaden zugefügt werden.",
		["Link"] = "|cffffffff|Henchant:13693|h[Waffe - Schlagen]|h|r",
		["Price"] = 70000,
		["IdOriginal"] = 114,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Mystikeressenz",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Großer leuchtender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Waffe - Schlagen",
		["PriceNoBenef"] = 53200,
		["Name"] = "Waffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Schlagen",
	},
	[72] = {
		["OnThis"] = "Stab",
		["Description"] = "Lässt einen geringen Mystikerzauberstab entstehen.",
		["Link"] = "|cffffffff|Henchant:14809|h[Geringer Mystikerzauberstab]|h|r",
		["Price"] = 4200,
		["IdOriginal"] = 61,
		["Reagents"] = {
			[1] = {
				["Name"] = "Sternenholz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Geringe Mystikeressenz",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Seelenstaub",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Geringer Mystikerzauberstab",
		["PriceNoBenef"] = 3450,
		["Name"] = "Geringer Mystikerzauberstab",
		["TypePrice"] = -1,
		["Required"] = "Runenverzierte Goldrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Staff_02",
		["Bonus"] = "(Arc)dps:25.4",
	},
	[73] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit 4 zusätzliche Punkte Schaden zugefügt werden.",
		["Link"] = "|cffffffff|Henchant:13943|h[Waffe - Großes Schlagen]|h|r",
		["Price"] = 210000,
		["IdOriginal"] = 27,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer strahlender Splitter",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Große Netheressenz",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Waffe - Großes Schlagen",
		["PriceNoBenef"] = 170000,
		["Name"] = "Waffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 4,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Schlagen",
	},
	[74] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, sodass sich die Ausdauer des Trägers um 1 erhöht.",
		["Link"] = "|cffffffff|Henchant:13378|h[Schild - Schwache Ausdauer]|h|r",
		["Price"] = 7100,
		["IdOriginal"] = 84,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 2,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Schild - Schwache Ausdauer",
		["PriceNoBenef"] = 5860,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[75] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass sie die Stärke um 15 erhöht.",
		["Link"] = "|cffffffff|Henchant:23799|h[Waffe verzaubern - Stärke]|h|r",
		["Price"] = 800000,
		["IdOriginal"] = 14,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer glänzender Splitter",
				["Count"] = 6,
			},
			[2] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 6,
			},
			[3] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 4,
			},
			[4] = {
				["Name"] = "Essenz der Erde",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Waffe verzaubern - Stärke",
		["PriceNoBenef"] = 666000,
		["Name"] = "Waffe verzaubern",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Arkanitrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Stärke",
	},
	[76] = {
		["OnThis"] = "Stab",
		["Description"] = "Lässt einen großen Magiezauberstab entstehen.",
		["Link"] = "|cffffffff|Henchant:14807|h[Großer Magiezauberstab]|h|r",
		["Price"] = 2200,
		["IdOriginal"] = 64,
		["Reagents"] = {
			[1] = {
				["Name"] = "Einfaches Holz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Große Magie-Essenz",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Großer Magiezauberstab",
		["PriceNoBenef"] = 1800,
		["Name"] = "Großer Magiezauberstab",
		["TypePrice"] = -1,
		["Required"] = "Runenverzierte Kupferrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Staff_07",
		["Bonus"] = "(Arc)dps:17.5",
	},
	[77] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Eine Armschiene dauerhaft verzaubern, sodass sich die Willenskraft des Trägers um 3 erhöht.",
		["Link"] = "|cffffffff|Henchant:7859|h[Armschiene - Geringer Willen]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 35,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Geringer Willen",
		["PriceNoBenef"] = 10000,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[78] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Beweglichkeit um +1 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13419|h[Umhang - Schwache Beweglichkeit]|h|r",
		["Price"] = 6000,
		["IdOriginal"] = 102,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 1,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Schwache Beweglichkeit",
		["PriceNoBenef"] = 5000,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Beweglichk",
	},
	[79] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass das Ziel oft mit Kälteeffekten belegt wird und sein Bewegungstempo sowie sein Angriffstempo verringert wird.",
		["Link"] = "|cffffffff|Henchant:20029|h[Waffe - Eisiger Hauch]|h|r",
		["Price"] = 500000,
		["IdOriginal"] = 10,
		["Reagents"] = {
			[1] = {
				["Name"] = "Kleiner glänzender Splitter",
				["Count"] = 4,
			},
			[2] = {
				["Name"] = "Essenz des Wassers",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Essenz der Luft",
				["Count"] = 1,
			},
			[4] = {
				["Name"] = "Eiskappe",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["LongName"] = "Waffe - Eisiger Hauch",
		["PriceNoBenef"] = 414100,
		["Name"] = "Waffe",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Echtsilberrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Eisiger Hauch",
	},
	[80] = {
		["OnThis"] = "Rute",
		["Link"] = "|cffffffff|Henchant:20051|h[Runenverzierte Arkanitrute]|h|r",
		["Price"] = 1690000,
		["IdOriginal"] = 7,
		["LongName"] = "Runenverzierte Arkanitrute",
		["PriceNoBenef"] = 1408000,
		["Name"] = "Runenverzierte Arkanitrute",
		["Reagents"] = {
			[1] = {
				["Name"] = "Arkanitrute",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Goldene Perle",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 10,
			},
			[4] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 4,
			},
			[5] = {
				["Name"] = "Kleiner glänzender Splitter",
				["Count"] = 4,
			},
			[6] = {
				["Name"] = "Großer glänzender Splitter",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Wand_09",
		["Bonus"] = "Runenverzierte Arkanitrute",
	},
	[81] = {
		["OnThis"] = "Stab",
		["Description"] = "Lässt einen großen Mystikerzauberstab entstehen.",
		["Link"] = "|cffffffff|Henchant:14810|h[Großer Mystikerzauberstab]|h|r",
		["Price"] = 9300,
		["IdOriginal"] = 65,
		["Reagents"] = {
			[1] = {
				["Name"] = "Sternenholz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Große Mystikeressenz",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Visionenstaub",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Großer Mystikerzauberstab",
		["PriceNoBenef"] = 7700,
		["Name"] = "Großer Mystikerzauberstab",
		["TypePrice"] = -1,
		["Required"] = "Runenverzierte Goldrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Wand_07",
		["Bonus"] = "(Arc)dps:29.0",
	},
	[82] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit Elementaren 6 zusätzliche Punkte Schaden zugefügt werden.",
		["Link"] = "|cffffffff|Henchant:13655|h[Waffe - Geringer Elementartöter]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 111,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Mystikeressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Elementarerde",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Kleiner leuchtender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["LongName"] = "Waffe - Geringer Elementartöter",
		["PriceNoBenef"] = 9200,
		["Name"] = "Waffe",
		["TypePrice"] = -1,
		["Required"] = "Runenverzierte Goldrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Geringer Elementartöter",
	},
	[83] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass sie bei Nahkampfangriffen oft 75 bis 125 Punkt(e) heilt und 15 Sek. lang die Stärke um 100 erhöht.",
		["Link"] = "|cffffffff|Henchant:20034|h[Waffe - Kreuzfahrer]|h|r",
		["Price"] = 1350000,
		["IdOriginal"] = 11,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer glänzender Splitter",
				["Count"] = 4,
			},
			[2] = {
				["Name"] = "Rechtschaffene Kugel",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["LongName"] = "Waffe - Kreuzfahrer",
		["PriceNoBenef"] = 1120000,
		["Name"] = "Waffe",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Arkanitrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Kreuzfahrer",
	},
	[84] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit 1 zusätzlicher Schadenspunkt zugefügt wird.",
		["Link"] = "|cffffffff|Henchant:7788|h[Waffe - Schwaches Schlagen]|h|r",
		["Price"] = 6800,
		["IdOriginal"] = 116,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Große Magie-Essenz",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Kleiner gleißender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Waffe - Schwaches Schlagen",
		["PriceNoBenef"] = 5660,
		["Name"] = "Waffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Schlagen",
	},
	[85] = {
		["OnThis"] = "Gemischt",
		["Required"] = "Schwarze Schmiede",
		["Link"] = "|cffffffff|Henchant:15596|h[Rauchendes Herz des Berges]|h|r",
		["Price"] = 830000,
		["IdOriginal"] = 19,
		["LongName"] = "Rauchendes Herz des Berges",
		["PriceNoBenef"] = 691000,
		["Name"] = "Rauchendes Herz des Berges",
		["TypePrice"] = 1,
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Misc_Gem_Bloodstone_01",
		["Reagents"] = {
			[1] = {
				["Name"] = "Blut des Berges",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Essenz des Feuers",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Kleiner glänzender Splitter",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
	},
	[86] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass das Ziel oft mit einem Fluch belegt und der angerichtete Nahkampfschaden verringert wird.",
		["Link"] = "|cffffffff|Henchant:20033|h[Waffe - Unheilige Waffe]|h|r",
		["Price"] = 220000,
		["IdOriginal"] = 12,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer glänzender Splitter",
				["Count"] = 4,
			},
			[2] = {
				["Name"] = "Essenz des Untodes",
				["Count"] = 4,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Waffe - Unheilige Waffe",
		["PriceNoBenef"] = 180000,
		["Name"] = "Waffe",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Arkanitrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Unheilige Waffe",
	},
	[87] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass sie die Willenskraft um 20 erhöht.",
		["Link"] = "|cffffffff|Henchant:23803|h[Waffe verzaubern - mächtige Willenskraft]|h|r",
		["Price"] = 1050000,
		["IdOriginal"] = 13,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer glänzender Splitter",
				["Count"] = 10,
			},
			[2] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 8,
			},
			[3] = {
				["Name"] = "Illusionsstaub",
				["Count"] = 15,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Waffe verzaubern - mächtige Willenskraft",
		["PriceNoBenef"] = 875000,
		["Name"] = "Waffe verzaubern",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Arkanitrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[88] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Waffe dauerhaft verzaubern, sodass sie beim Wirken von Frostzaubern bis zu 7 Punkte zusätzlichen Frostschaden verursacht.",
		["Link"] = "|cffffffff|Henchant:21931|h[Waffe - Wintermacht]|h|r",
		["Price"] = 100000,
		["IdOriginal"] = 117,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Mystikeressenz",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Visionenstaub",
				["Count"] = 3,
			},
			[3] = {
				["Name"] = "Großer leuchtender Splitter",
				["Count"] = 1,
			},
			[4] = {
				["Name"] = "Winterbiss",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Waffe - Wintermacht",
		["PriceNoBenef"] = 76300,
		["Name"] = "Waffe",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Goldrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Wintermacht",
	},
	[89] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass alle Werte um +3 erhöht werden.",
		["Link"] = "|cffffffff|Henchant:13941|h[Brust - Werte]|h|r",
		["Price"] = 170000,
		["IdOriginal"] = 24,
		["Reagents"] = {
			[1] = {
				["Name"] = "Großer strahlender Splitter",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Traumstaub",
				["Count"] = 3,
			},
			[3] = {
				["Name"] = "Große Netheressenz",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Werte",
		["PriceNoBenef"] = 133500,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Werte",
	},
	[90] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Armschienen dauerhaft verzaubern, sodass sich die Ausdauer des Trägers um 1 erhöht.",
		["Link"] = "|cffffffff|Henchant:7457|h[Armschiene - Schwache Ausdauer]|h|r",
		["Price"] = 1600,
		["IdOriginal"] = 40,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 3,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Schwache Ausdauer",
		["PriceNoBenef"] = 1290,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[91] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Eine Armschiene dauerhaft verzaubern, sodass sich die Ausdauer des Trägers um 3 erhöht.",
		["Link"] = "|cffffffff|Henchant:13501|h[Armschiene - Geringe Ausdauer]|h|r",
		["Price"] = 1800,
		["IdOriginal"] = 32,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Geringe Ausdauer",
		["PriceNoBenef"] = 1500,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[92] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit Wildtieren 2 zusätzliche Schadenspunkte zugefügt werden.",
		["Link"] = "|cffffffff|Henchant:7786|h[Waffe - Schwacher Wildtiertöter]|h|r",
		["Price"] = 6400,
		["IdOriginal"] = 115,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 4,
			},
			[2] = {
				["Name"] = "Große Magie-Essenz",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Waffe - Schwacher Wildtiertöter",
		["PriceNoBenef"] = 5320,
		["Name"] = "Waffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 2,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Wildtiertöter",
	},
	[93] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Intelligenz um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13822|h[Armschiene - Intelligenz]|h|r",
		["Price"] = 30000,
		["IdOriginal"] = 38,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Netheressenz",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Intelligenz",
		["PriceNoBenef"] = 22000,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Int",
	},
	[94] = {
		["OnThis"] = "Waffe",
		["Description"] = "Eine Nahkampfwaffe dauerhaft verzaubern, sodass damit Wildtieren 6 zusätzliche Punkte Schaden zugefügt werden.",
		["Link"] = "|cffffffff|Henchant:13653|h[Waffe - Geringer Wildtiertöter]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 112,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Mystikeressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Großer Fangzahn",
				["Count"] = 2,
			},
			[3] = {
				["Name"] = "Kleiner leuchtender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Waffe - Geringer Wildtiertöter",
		["PriceNoBenef"] = 13600,
		["Name"] = "Waffe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 6,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Wildtiertöter",
	},
	[95] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Verteidigung um +3 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13931|h[Armschiene - Abwehr]|h|r",
		["Price"] = 60000,
		["IdOriginal"] = 29,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Netheressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Traumstaub",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Abwehr",
		["PriceNoBenef"] = 44000,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Vert",
	},
	[96] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass alle Werte um +2 erhöht werden.",
		["Link"] = "|cffffffff|Henchant:13700|h[Brust - Geringe Werte]|h|r",
		["Price"] = 70000,
		["IdOriginal"] = 49,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Mystikeressenz",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Visionenstaub",
				["Count"] = 2,
			},
			[3] = {
				["Name"] = "Großer leuchtender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Geringe Werte",
		["PriceNoBenef"] = 56600,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 2,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Werte",
	},
	[97] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Armschienen dauerhaft verzaubern, sodass sich die Willenskraft des Trägers um 1 erhöht.",
		["Link"] = "|cffffffff|Henchant:7766|h[Armschiene - Schwacher Willen]|h|r",
		["Price"] = 1500,
		["IdOriginal"] = 43,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Magie-Essenz",
				["Count"] = 2,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Schwacher Willen",
		["PriceNoBenef"] = 1200,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[98] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Willenskraft um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13642|h[Armschiene - Willen]|h|r",
		["Price"] = 3300,
		["IdOriginal"] = 45,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Mystikeressenz",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Willen",
		["PriceNoBenef"] = 2700,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[99] = {
		["OnThis"] = "Umhang",
		["Description"] = "Einen Umhang dauerhaft verzaubern, sodass die Beweglichkeit um 3 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13882|h[Umhang - Geringe Beweglichkeit]|h|r",
		["Price"] = 30000,
		["IdOriginal"] = 98,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Netheressenz",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Umhang - Geringe Beweglichkeit",
		["PriceNoBenef"] = 22000,
		["Name"] = "Umhang",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Beweglichk",
	},
	[100] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana um +50 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13663|h[Brust - Großes Mana]|h|r",
		["Price"] = 7200,
		["IdOriginal"] = 52,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Mystikeressenz",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Großes Mana",
		["PriceNoBenef"] = 6000,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 50,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Mana",
	},
	[101] = {
		["OnThis"] = "Öl",
		["Description"] = "Erstelllt schwaches Manaöl",
		["Link"] = "|cffffffff|Henchant:25125|h[Schwaches Manaöl]|h|r",
		["Price"] = 3300,
		["IdOriginal"] = 87,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Ahornsamenkorn",
				["Count"] = 2,
			},
			[3] = {
				["Name"] = "Verbleite Phiole",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Schwaches Manaöl",
		["PriceNoBenef"] = 2685,
		["Name"] = "Schwaches Manaöl",
		["TypePrice"] = 1,
		["Required"] = "Runenverzierte Silberrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "4 Mana 5 Sek",
	},
	[102] = {
		["OnThis"] = "Rute",
		["Link"] = "|cffffffff|Henchant:7795|h[Runenverzierte Silberrute]|h|r",
		["Price"] = 9600,
		["IdOriginal"] = 77,
		["LongName"] = "Runenverzierte Silberrute",
		["PriceNoBenef"] = 7980,
		["Name"] = "Runenverzierte Silberrute",
		["Reagents"] = {
			[1] = {
				["Name"] = "Silberrute",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 6,
			},
			[3] = {
				["Name"] = "Große Magie-Essenz",
				["Count"] = 3,
			},
			[4] = {
				["Name"] = "Schattenedelstein",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Staff_01",
		["Bonus"] = "Runenverzierte Silberrute",
	},
	[103] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, um eine Chance von +2% zum Blocken zu erhalten.",
		["Link"] = "|cffffffff|Henchant:13689|h[Schild - Geringes Blocken]|h|r",
		["Price"] = 70000,
		["IdOriginal"] = 82,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Mystikeressenz",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Visionenstaub",
				["Count"] = 2,
			},
			[3] = {
				["Name"] = "Großer leuchtender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Schild - Geringes Blocken",
		["PriceNoBenef"] = 56600,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = "2%",
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Blocken",
	},
	[104] = {
		["OnThis"] = "Stab",
		["Description"] = "Lässt einen geringen Zauberstab entstehen.",
		["Link"] = "|cffffffff|Henchant:14293|h[Geringer Magiezauberstab]|h|r",
		["Price"] = 800,
		["IdOriginal"] = 60,
		["Reagents"] = {
			[1] = {
				["Name"] = "Einfaches Holz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Geringe Magie-Essenz",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Geringer Magiezauberstab",
		["PriceNoBenef"] = 600,
		["Name"] = "Geringer Magiezauberstab",
		["TypePrice"] = -1,
		["Required"] = "Runenverzierte Kupferrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Staff_02",
		["Bonus"] = "(Arc)dps:11.3",
	},
	[105] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Willenskraft um +9 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20009|h[Armschiene - Überragender Willen]|h|r",
		["Price"] = 120000,
		["IdOriginal"] = 16,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe ewige Essenz",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Traumstaub",
				["Count"] = 10,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Überragender Willen",
		["PriceNoBenef"] = 93000,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 9,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[106] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana des Trägers um 5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:7443|h[Brust - Schwaches Mana]|h|r",
		["Price"] = 800,
		["IdOriginal"] = 57,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Magie-Essenz",
				["Count"] = 1,
			},
			["Etat"] = 3,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Schwaches Mana",
		["PriceNoBenef"] = 600,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Mana",
	},
	[107] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Ein Paar Stiefel dauerhaft verzaubern, sodass sich die Ausdauer des Trägers um 1 erhöht.",
		["Link"] = "|cffffffff|Henchant:7863|h[Stiefel - Schwache Ausdauer]|h|r",
		["Price"] = 4200,
		["IdOriginal"] = 94,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 8,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Schwache Ausdauer",
		["PriceNoBenef"] = 3440,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[108] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana des Trägers um 30 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13607|h[Brust - Mana]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 53,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Astralessenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Geringe Astralessenz",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["LongName"] = "Brust - Mana",
		["PriceNoBenef"] = 10000,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 30,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Mana",
	},
	[109] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Bergbaufertigkeit um +2 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13612|h[Handschuhe - Bergbau]|h|r",
		["Price"] = 900,
		["IdOriginal"] = 67,
		["Reagents"] = {
			[1] = {
				["Name"] = "Seelenstaub",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Eisenerz",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["LongName"] = "Handschuhe - Bergbau",
		["PriceNoBenef"] = 750,
		["Name"] = "Handschuhe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 2,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Bergbau",
	},
	[110] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Armschienen dauerhaft verzaubern, sodass sich die Beweglichkeit des Trägers um 1 erhöht.",
		["Link"] = "|cffffffff|Henchant:7779|h[Armschiene- Schwache Beweglichkeit]|h|r",
		["Price"] = 3200,
		["IdOriginal"] = 46,
		["LongName"] = "Armschiene- Schwache Beweglichkeit",
		["PriceNoBenef"] = 2660,
		["Name"] = "Armschiene- Schwache Beweglichkeit",
		["TypePrice"] = 1,
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Kupferrute",
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Reagents"] = {
			[1] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Große Magie-Essenz",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
	},
	[111] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Kräuterkundefertigkeit um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13868|h[Handschuhe - Hochentwickelte Kräuterkunde]|h|r",
		["Price"] = 6200,
		["IdOriginal"] = 69,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Sonnengras",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
		["LongName"] = "Handschuhe - Hochentwickelte Kräuterkunde",
		["PriceNoBenef"] = 5100,
		["Name"] = "Handschuhe",
		["TypePrice"] = -1,
		["Required"] = "Runenverzierte Echtsilberrute",
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Kräuterk.",
	},
	[112] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana um +65 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13917|h[Brust - Überragendes Mana]|h|r",
		["Price"] = 70000,
		["IdOriginal"] = 59,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Netheressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Geringe Netheressenz",
				["Count"] = 2,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Überragendes Mana",
		["PriceNoBenef"] = 57000,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 65,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Mana",
	},
	[113] = {
		["OnThis"] = "Brust",
		["Description"] = "Einen Teil der Brustrüstung dauerhaft verzaubern, sodass das Mana um +100 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20028|h[Brust - Erhebliches Mana]|h|r",
		["Price"] = 260000,
		["IdOriginal"] = 5,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Kleiner glänzender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Brust - Erhebliches Mana",
		["PriceNoBenef"] = 212000,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 100,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Mana",
	},
	[114] = {
		["OnThis"] = "Armschiene",
		["Description"] = "Verzaubert Armschienen dauerhaft, sodass die Willenskraft um +7 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13846|h[Armschiene - Große Willenskraft]|h|r",
		["Price"] = 50000,
		["IdOriginal"] = 37,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Netheressenz",
				["Count"] = 3,
			},
			[2] = {
				["Name"] = "Visionenstaub",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Armschiene - Große Willenskraft",
		["PriceNoBenef"] = 34700,
		["Name"] = "Armschiene",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 7,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[115] = {
		["OnThis"] = "Handschuhe",
		["Description"] = "Handschuhe dauerhaft verzaubern, sodass die Stärke um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13887|h[Handschuhe - Stärke]|h|r",
		["Price"] = 40000,
		["IdOriginal"] = 73,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Netheressenz",
				["Count"] = 2,
			},
			[2] = {
				["Name"] = "Visionenstaub",
				["Count"] = 3,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Handschuhe - Stärke",
		["PriceNoBenef"] = 27100,
		["Name"] = "Handschuhe",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Stärke",
	},
	[116] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Ausdauer um 3 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13631|h[Schild - Geringe Ausdauer]|h|r",
		["Price"] = 4200,
		["IdOriginal"] = 80,
		["Reagents"] = {
			[1] = {
				["Name"] = "Geringe Mystikeressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seelenstaub",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Schild - Geringe Ausdauer",
		["PriceNoBenef"] = 3450,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 3,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[117] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Ausdauer um +5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13817|h[Schild - Ausdauer]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 78,
		["Reagents"] = {
			[1] = {
				["Name"] = "Visionenstaub",
				["Count"] = 5,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Schild - Ausdauer",
		["PriceNoBenef"] = 8500,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Ausdauer",
	},
	[118] = {
		["OnThis"] = "Rute",
		["Link"] = "|cffffffff|Henchant:13702|h[Runenverzierte Echtsilberrute]|h|r",
		["Price"] = 30000,
		["IdOriginal"] = 74,
		["LongName"] = "Runenverzierte Echtsilberrute",
		["PriceNoBenef"] = 20200,
		["Name"] = "Runenverzierte Echtsilberrute",
		["Reagents"] = {
			[1] = {
				["Name"] = "Echtsilberrute",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Schwarze Perle",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Große Mystikeressenz",
				["Count"] = 2,
			},
			[4] = {
				["Name"] = "Visionenstaub",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Staff_11",
		["Bonus"] = "Runenverzierte Echtsilberrute",
	},
	[119] = {
		["OnThis"] = "Schild",
		["Description"] = "Einen Schild dauerhaft verzaubern, sodass die Willenskraft um 5 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:13659|h[Schild - Willen]|h|r",
		["Price"] = 9300,
		["IdOriginal"] = 86,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Mystikeressenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Visionenstaub",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = 1,
		["LongName"] = "Schild - Willen",
		["PriceNoBenef"] = 7700,
		["Name"] = "Schild",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Goldrute",
		["BonusNb"] = 5,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Willen",
	},
	[120] = {
		["OnThis"] = "Brust",
		["Description"] = "Ein Teil der Brustrüstung dauerhaft verzaubern, sodass alle Werte um 1 erhöht werden.",
		["Link"] = "|cffffffff|Henchant:13626|h[Brust - Schwache Werte]|h|r",
		["Price"] = 20000,
		["IdOriginal"] = 56,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große Astralessenz",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seelenstaub",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Großer gleißender Splitter",
				["Count"] = 1,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = -1,
		["LongName"] = "Brust - Schwache Werte",
		["PriceNoBenef"] = 13450,
		["Name"] = "Brust",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Silberrute",
		["BonusNb"] = 1,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Werte",
	},
	[121] = {
		["OnThis"] = "Rute",
		["Link"] = "|cffffffff|Henchant:13628|h[Runenverzierte Goldrute]|h|r",
		["Price"] = 6600,
		["IdOriginal"] = 75,
		["LongName"] = "Runenverzierte Goldrute",
		["PriceNoBenef"] = 5500,
		["Name"] = "Runenverzierte Goldrute",
		["Reagents"] = {
			[1] = {
				["Name"] = "Goldrute",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Schillernde Perle",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Große Astralessenz",
				["Count"] = 2,
			},
			[4] = {
				["Name"] = "Seelenstaub",
				["Count"] = 2,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Staff_10",
		["Bonus"] = "Runenverzierte Goldrute",
	},
	[122] = {
		["OnThis"] = "Rute",
		["Link"] = "|cffffffff|Henchant:7421|h[Runenverzierte Kupferrute]|h|r",
		["Price"] = 1300,
		["IdOriginal"] = 76,
		["LongName"] = "Runenverzierte Kupferrute",
		["PriceNoBenef"] = 1030,
		["Name"] = "Runenverzierte Kupferrute",
		["Reagents"] = {
			[1] = {
				["Name"] = "Kupferrute",
				["Count"] = 1,
			},
			[2] = {
				["Name"] = "Seltsamer Staub",
				["Count"] = 1,
			},
			[3] = {
				["Name"] = "Geringe Magie-Essenz",
				["Count"] = 1,
			},
			["Etat"] = 4,
		},
		["TypePrice"] = -1,
		["IsKnow"] = true,
		["Icon"] = "Interface\\Icons\\INV_Staff_Goldfeathered_01",
		["Bonus"] = "Runenverzierte Kupferrute",
	},
	[123] = {
		["OnThis"] = "Stiefel",
		["Description"] = "Stiefel dauerhaft verzaubern, sodass die Beweglichkeit um +7 erhöht wird.",
		["Link"] = "|cffffffff|Henchant:20023|h[Stiefel - Große Beweglichkeit]|h|r",
		["Price"] = 530000,
		["IdOriginal"] = 8,
		["Reagents"] = {
			[1] = {
				["Name"] = "Große ewige Essenz",
				["Count"] = 8,
			},
			["Etat"] = 2,
		},
		["TypePrice"] = 1,
		["LongName"] = "Stiefel - Große Beweglichkeit",
		["PriceNoBenef"] = 440000,
		["Name"] = "Stiefel",
		["IsKnow"] = true,
		["Required"] = "Runenverzierte Echtsilberrute",
		["BonusNb"] = 7,
		["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		["Bonus"] = "Beweglichk",
	},
}
};
end
