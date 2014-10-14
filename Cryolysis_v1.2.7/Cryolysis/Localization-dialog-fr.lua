------------------------------------------------------------------------------------------------------
-- Cryolysis
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Cryolysis Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.05.2006
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Cryolysis_Localization_Dialog_Fr()

	function CryolysisLocalization()
		Cryolysis_Localization_Speech_Fr();
	end

	CRYOLYSIS_COOLDOWN = {
		["Evocation"] = "Temps de recharge d'Evocation",
		["Manastone"] = "Temps de recharge des Pierres de Mana"
	};

	CryolysisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFCryolysis|r",
			Stone = {
				[true] = "Oui";
				[false] = "Non";
			},
			Hellspawn = {
				[true] = "On";
				[false] = "Off";
			},
			["Food"] = "Nourriture Invoqu\195\169e: ",
			["Drink"] = "Eau Invoqu\195\169e: ",
			["RuneOfTeleportation"] = "Runes de T\195\169l\195\169portation: ",
			["RuneOfPortals"] = "Runes de Portails: ",
			["ArcanePowder"] = "Poudre des Arcanes: ",
			["LightFeather"] = "Plumes L\195\169g\195\168res: ",
			["Manastone"] = "Pierre de Mana: ",
  		},
		["Alt"] = {
			Left = "Clic droit pour ",
			Right = "",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFPierre d'\195\162me|r",
			Text = {"Créer","Utiliser","Utilis\195\169e","En attente"}			
		},
		["Manastone"] = {
			Label = "|c00FFFFFFPierre de Mana|r",
			Text = {": Invoquer - ",": Utiliser", ": En attente", ": Indisponible"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFDur\195\169es des Sorts|r",
			Text = "Temps de recharge et sorts actifs sur la cible",
			Right = "Clic droit sur la Pierre de Foyer pour "
		},
		["Armor"] = {
			Label = "|c00FFFFFFArmure de glace|r"
		},
		["MageArmor"] = {
			Label = "|c00FFFFFFArmure du mage|r"
		},
		["ArcaneInt"] = {
			Label = "|c00FFFFFFIntelligence des arcanes|r"
		},
		["ArcaneBrilliance"] = {
			Label = "|c00FFFFFFIllumination des arcanes|r"
		},
		["DampenMagic"] = {
			Label = "|c00FFFFFFAtt\195\169nuer la magie|r"
		},
		["AmplifyMagic"] = {
			Label = "|c00FFFFFFAmplification de la magie|r"
		},
		["SlowFall"] = {
			Label = "|c00FFFFFFChute lente|r"
		},
		["FireWard"] = {
			Label = "|c00FFFFFFGardien de feu|r"
		},
		["FrostWard"] = {
			Label = "|c00FFFFFFGardien de glace|r"
		},
		["ConjureFood"] = {
			Label = "|c00FFFFFFInvocation de nourriture|r"
		},
		["ConjureDrink"] = {
			Label = "|c00FFFFFFInvocation d'eau|r"
		},
		["Evocation"] = {
			Label = "|c00FFFFFFEvocation|r",
			Text = "Use"
		},
		["ColdSnap"] = {
			Label = "|c00FFFFFFMorsure de glace|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFFBarri\195\168re de glace|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[25].Name.."|r"
		},
		["DetectMagic"] = {
			Label = "|c00FFFFFFD\195\169tection de la magie|r"
		},
		["RemoveCurse"] = {
			Label = "|c00FFFFFFD\195\169livrance de la mal\195\169diction mineure|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFMonture: "
		},
		["Buff"] = {
			Label = "|c00FFFFFFMenu des Sorts|r\nClic droit pour laisser ce menu ouvert"
		},
		["Portal"] = {
			Label = "|c00FFFFFFMenu des Portails|r\nClic droit pour laisser ce menu ouvert"
		},
		["T:Org"] = {
		    Label = "|c00FFFFFFT\195\169l\195\169portation: Orgrimmar|r"
		},
		["T:UC"] = {
		    Label = "|c00FFFFFFT\195\169l\195\169portation: Undercity|r"
		},
		["T:TB"] = {
		    Label = "|c00FFFFFFT\195\169l\195\169portation: Thunder Bluff|r"
		},
		["T:IF"] = {
		    Label = "|c00FFFFFFT\195\169l\195\169portation: Ironforge|r"
		},
		["T:SW"] = {
		    Label = "|c00FFFFFFT\195\169l\195\169portation: Stormwind|r"
		},
		["T:Darn"] = {
		    Label = "|c00FFFFFFT\195\169l\195\169portation: Darnassus|r"
		},
		["P:Org"] = {
		    Label = "|c00FFFFFFPortail: Orgrimmar|r"
		},
		["P:UC"] = {
		    Label = "|c00FFFFFFPortail: Undercity|r"
		},
		["P:TB"] = {
		    Label = "|c00FFFFFFPortail: Thunder Bluff|r"
		},
		["P:IF"] = {
		    Label = "|c00FFFFFFPortail: Ironforge|r"
		},
		["P:SW"] = {
		    Label = "|c00FFFFFFPortail: Stormwind|r"
		},
		["P:Darn"] = {
		    Label = "|c00FFFFFFPortail: Darnassus|r"
		},
		["EvocationCooldown"] = "Clic droit pour incantation rapide",
		["LastSpell"] = {
			Left = "Clic bouton du milieu pour relancer ",
			Right = "",
		},
		["Food"] = {
			Label = "|c00FFFFFFNourriture|r",
			Right = "Clic droit pour invoquer",
			Middle = "Clic bouton du milieu pour \195\169changer",
		},
		["Drink"] = {
			Label = "|c00FFFFFFEau|r",
			Right = "Clic droit pour invoquer",
			Middle = "Clic bouton du milieu pour \195\169changer",
		},
	};


	CRYOLYSIS_SOUND = {
		["SheepWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep01.mp3",
		["SheepBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep02.mp3",
		["PigWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig01.mp3",
		["PigBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig02.mp3",
	};


--	CRYOLYSIS_NIGHTFALL_TEXT = {
--		["NoBoltSpell"] = "Il semble que vous ne poss\195\169dez pas le Sort Trait de l'Ombre.",
--		["Message"] = "<white>S<lightPurple1>h<lightPurple2>a<purple>d<darkPurple1>o<darkPurple2>w T<darkPurple1>r<purple>a<lightPurple2>n<lightPurple1>c<white>e"
--	};


	CRYOLYSIS_MESSAGE = {
		["Error"] = {
			["RuneOfTeleportationNotPresent"] = "Il vous faut une Rune de T\195\169l\195\169portation pour \195\167a!",
			["RuneOfPortals"] = "Il vous faut une Rune de Portails pour \195\167a!",
			["LightFeatherNotPresent"] = "Il vous faut une Plume L\195\169g\195\168re pour \195\167a!",
			["ArcanePowderNotPresent"] = "Il vous faut de la Poudre des Arcanes pour \195\167a!",
			["NoRiding"] = "Vous n'avez aucune monture \195\160 chevaucher",
			["NoFoodSpell"] = "Vous ne poss\195\169dez pas de sort d'invocation de nourriture",
			["NoDrinkSpell"] = "Vous ne poss\195\169dez pas de sort d'invocation d'eau",
			["NoManaStoneSpell"] = "Vous ne poss\195\169dez pas d'invocation de Pierre de Mana",
			["NoEvocationSpell"] = "Vous ne poss\195\169dez pas de sort d'Evocation",
			["FullMana"] = "Vous ne pouvez utiliser de Pierre de Mana car votre Mana est au maximum",
			["BagAlreadySelect"] = "Erreur : Ce sac est d\195\169j\195\160 s\195\169lectionn\195\169.",
			["WrongBag"] = "Erreur: Le nombre doit \195\170tre compris entre 0 et 4.",
			["BagIsNumber"] = "Erreur: Entrez un nombre.",
			["NoHearthStone"] = "Erreur: Il n'y a pas de Pierre de Foyer dans votre inventaire",
			["NoFood"] = "Erreur: Il n'y a pas de nourriture invoqu\195\169e de dernier rang dans votre inventaire",
			["NoDrink"] = "Erreur: Il n'y a pas d'eau invoqu\195\169e de dernier rang dans votre inventaire",
			["ManaStoneCooldown"] = "Erreur : Temps de recharge des Pierres de Mana en cours"
		},
		["Bag"] = {
			["FullPrefix"] = "Votre ",
			["FullSuffix"] = " est plein !",
			["FullDestroySuffix"] = " est plein; La prochaine eau/nourriture sera d\195\169truite !",
			["SelectedPrefix"] = "Vous avez s\195\169lectionn\195\169 votre ",
			["SelectedSuffix"] = " pour stocker votre nourriture et votre eau."
		},
		["Interface"] = {
			["Welcome"] = "<white>/cryo pour afficher les r\195\169glages!",
			["TooltipOn"] = "Bulles d'aide affich\195\169es" ,
			["TooltipOff"] = "Bulles d'aide cach\195\169es",
			["MessageOn"] = "Messages de Dialogue en marche",
			["MessageOff"] = "Messages de Dialogue stopp\195\169s",
			["MessagePosition"] = "<- Les messages syst\195\168me de Cryolysis s'afficheront ici->",
			["DefaultConfig"] = "<lightYellow>Configuration standard charg\195\169e.",
			["UserConfig"] = "<lightYellow>Configuration charg\195\169e."
		},
		["Help"] = {
			"/cryo recall -- Centrer Cryolisis et tous les boutons au milieu de l'\195\169cran",
			"/cryo sm -- Remplacer les messages par une version courte \195\160 utiliser en Raid"
		},
		["EquipMessage"] = "Equiper ",
		["SwitchMessage"] = " au lieu de ",
		["Information"] = {
			["PolyWarn"] = "M\195\169tamorphose quasi termin\195\169e",
			["PolyBreak"] = "M\195\169tamorphose interrompue...",
			["Restock"] = "Achet\195\169 "
		},
	};


	-- Gestion XML - Menu de configuration

	CRYOLYSIS_COLOR_TOOLTIP = {
		["Purple"] = "Violet",
		["Blue"] = "Bleu",
		["Pink"] = "Rose",
		["Orange"] = "Orange",
		["Turquoise"] = "Turquoise",
		["X"] = "X"
	};
	
	CRYOLYSIS_CONFIGURATION = {
		["Menu1"] = "R\195\169glages de l'Inventaire",
		["Menu2"] = "R\195\169glages des Messages",
		["Menu3"] = "R\195\169glages des Boutons",
		["Menu4"] = "R\195\169glages des Compte \195\160 Rebours",
		["Menu5"] = "R\195\169glages de l'Affichage",
		["MainRotation"] = "S\195\169lection de l'Angle de Cryolysis",
		["ProvisionMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFai|CFFFF00FFr|CFFB700B7e :",
		["ProvisionMenu2"] = "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7ns :",
		["ProvisionMove"] = "Ranger la nourriture et l'eau dans le sac s\195\169lectionn\195\169.",
		["ProvisionDestroy"] = "D\195\169truire la nourriture et l'eau lorsque le sac est plein.",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFo|CFFFF50FFr|CFFFF99FFt|CFFFFC4FFs :",
		["SpellMenu2"] = "|CFFB700B7J|CFFFF00FFo|CFFFF50FFu|CFFFF99FFe|CFFFFC4FFu|CFFFF99FFr :",
		["TimerMenu"] = "T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs |CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFqu|CFFFF00FFe|CFFB700B7s:",
		["TimerColor"] = "Utiliser un texte blanc au lieu de jaune pour les timers",
		["TimerDirection"] = "Les timers s'ajoutent par le haut",
		["TranseWarning"] = "Avertir quand j'entre dans un Etat de Trance",
		["SpellTime"] = "Activer les indicateurs de dur\195\169e des sorts",
		["AntiFearWarning"] = "Avertir quand ma cible est immunis\195\169e \195\160 la peur.",
		["GraphicalTimer"] = "Afficher des timers graphiques et non du texte",	
		["TranceButtonView"] = "Afficher les boutons cach\195\169s pour les d\195\169placer.",
		["ButtonLock"] = "V\195\169rouiller les boutons autour de la sph\195\168re de Cryolysis.",
		["MainLock"] = "V\195\169rouiller la sph\195\168re de Cryolysis.",
		["BagSelect"] = "S\195\169lection du sac pour la nourriture et l'eau.",
		["BuffMenu"] = "Disposer le menu des buffs sur la gauche",
		["PortalMenu"] = "Disposer le menu des portails sur la gauche",
		["STimerLeft"] = "Afficher les timers du c\195\180t\195\169 gauche des boutons",
		["ShowCount"] = "Afficher le nombre d'objets dans Cryolysis",
		["CountType"] = "Ev\195\169nements affich\195\169s sur la Sph\195\168re",
        ["Food"] = "Seuil Nourriture",
		["Sound"] = "Activer les sons",
		["ShowMessage"] = "Messages al\195\169atoires",
		["ShowPortalMessage"] = "Activer les messages al\195\169atoires (Portail)",
		["ShowSteedMessage"] = "Activer les messages al\195\169atoires (Monture)",
		["ShowPolyMessage"] = "Activer les messages al\195\169atoires (M\195\169tamorphose)",
		["CryolysisSize"] = "Taille des boutons de Cryolysis",
		["StoneScale"] = "Size of other buttons",
		["PolymorphSize"] = "Taille du bouton de M\195\169tamorphose",
		["TranseSize"] = "Taile des boutons de Trance et d'AntiFear",
		["Skin"] = "Seuil Eau",
		["ManaStoneOrder"] = "Utiliser cette pierre de mana d'abord",
		["Show"] = {
			["Text"] = "Afficher",
			["Food"] = "le bouton Nourriture",
			["Drink"] = "le bouton Eau",
			["Manastone"] = "le bouton de Pierre de Mana",
			["Evocation"] = "le bouton d'Evocation",
			["Steed"] = "le bouton Monture",
			["Buff"] = "le bouton des Sorts",
			["Portal"] = "le bouton des Portails",
			["Tooltips"] = "Afficher les bulles d'aide"
		},
		["Text"] = {
			["Text"] = "On Button:",
			["Food"] = "Food Count",
			["Drink"] = "Drink Count",
			["Manastone"] = "Mana Gem Cooldown",
			["Evocation"] = "Evocation Cooldown",
			["Powder"] = "Arcane Powder",
			["Feather"] = "Light Feathers",
			["Rune"] = "Portal Runes",
		},
		["QuickBuff"] = "Ouvrir/Fermer le menu des buffs au passage de la souris",
		["Count"] = {
		    ["None"] = "Aucun",
			["Provision"] = "Nourriture et Eau",
			["Provision2"] = "Eau et Nourriture",
			["Health"] = "Current Health",
			["HealthPercent"] = "Health Percent",
			["Mana"] = "Current Mana",
			["ManaPercent"] = "Mana Percent",
			["Manastone"] = "Temps de recharge de Pierre de Mana",
			["Rune"] = "Runes de T\195\169l\195\169portation et de Portails",
			["Reagent"] = "Poudre des Arcanes et Plumes L\195\169g\195\168res",
		},
		["Circle"] = {
			["Text"] = "Ev\195\169nements affich\195\169s sur la shp\195\168re",
			["None"] = "Aucun",
			["Mana"] = "Mana",
			["Manastone"] = "Temps de recharge de Pierre de Mana",
			["Evocation"] = "Temps de recharge d'Evocation",

		},
		["Polymorph"] = {
			["Warn"] = "Avertir avant que la m\195\169tamorphose ne disparaisse",
			["Break"] = "M'avertir lorsque la m\195\169tamorphose est interrompue",
		},
		["Button"] = {
			["Text"] = "Fonction du bouton principal",
			["Consume"] = "Manger et Boire",
			["Evocation"] = "Utiliser Evocation",
			["Polymorph"] = "Lancer M\195\169tamorphose",
			["Manastone"] = "Pierre de Mana",
		},
		["Restock"] = {
			["Restock"] = "Refaire automatiquement le stock de composants",
			["Confirm"] = "Confirmation avant chaque achat",
		},
		["SpellButton"] = {	
			["Armor"] = CRYOLYSIS_SPELL_TABLE[22].Name.."/"..CRYOLYSIS_SPELL_TABLE[24].Name, -- "Ice Armor / Mage Armor"
			["ArcaneInt"] = CRYOLYSIS_SPELL_TABLE[4].Name.."/"..CRYOLYSIS_SPELL_TABLE[2].Name, --"Arcane Int / Arcane Brilliance",
			["DampenMagic"] = CRYOLYSIS_SPELL_TABLE[13].Name.."/"..CRYOLYSIS_SPELL_TABLE[1].Name, -- "Dampen Magic / Amplify Magic",
			["IceBarrier"] = CRYOLYSIS_SPELL_TABLE[23].Name.."/"..CRYOLYSIS_SPELL_TABLE[25].Name, -- "Ice Barrier / Mana Shield",
			["FireWard"] = CRYOLYSIS_SPELL_TABLE[15].Name.."/"..CRYOLYSIS_SPELL_TABLE[20].Name, -- "Fire Ward / Frost Ward",
			["DetectMagic"] = CRYOLYSIS_SPELL_TABLE[50].Name, -- "Detect Magic"
			["RemoveCurse"] = CRYOLYSIS_SPELL_TABLE[33].Name, -- Remove Lesser curse
			["SlowFall"] = CRYOLYSIS_SPELL_TABLE[35].Name, -- Slow Fall
		},	
	};
end
