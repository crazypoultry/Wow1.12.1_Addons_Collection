--[[
--------------------------------------------------
	File: localization.fr.lua
	Addon: Wardrobe
	Language: French
	Translation by : X\195\169lakis
	Last Update : 05/29/2006
--------------------------------------------------
]]--

if (not WardrobeText) then
	WardrobeText = {};
end

--Localization.RegisterGlobalAddonStrings("frFR", "Wardrobe", {
if (GetLocale() == "frFR") then

	-- Binding Configuration
	BINDING_HEADER_WARDROBE_HEADER = "Wardrobe";
	BINDING_NAME_WARDROBE_AUTO_SWAP_BINDING = "Toggle Echange Automatique";
	BINDING_NAME_WARDROBE1_BINDING = "Tenue 1";
	BINDING_NAME_WARDROBE2_BINDING = "Tenue 2";
	BINDING_NAME_WARDROBE3_BINDING = "Tenue 3";
	BINDING_NAME_WARDROBE4_BINDING = "Tenue 4";
	BINDING_NAME_WARDROBE5_BINDING = "Tenue 5";
	BINDING_NAME_WARDROBE6_BINDING = "Tenue 6";
	BINDING_NAME_WARDROBE7_BINDING = "Tenue 7";
	BINDING_NAME_WARDROBE8_BINDING = "Tenue 8";
	BINDING_NAME_WARDROBE9_BINDING = "Tenue 9";
	BINDING_NAME_WARDROBE10_BINDING = "Tenue 10";
	BINDING_NAME_WARDROBE11_BINDING = "Tenue 11";
	BINDING_NAME_WARDROBE12_BINDING = "Tenue 12";
	BINDING_NAME_WARDROBE13_BINDING = "Tenue 13";
	BINDING_NAME_WARDROBE14_BINDING = "Tenue 14";
	BINDING_NAME_WARDROBE15_BINDING = "Tenue 15";
	BINDING_NAME_WARDROBE16_BINDING = "Tenue 16";
	BINDING_NAME_WARDROBE17_BINDING = "Tenue 17";
	BINDING_NAME_WARDROBE18_BINDING = "Tenue 18";
	BINDING_NAME_WARDROBE19_BINDING = "Tenue 19";
	BINDING_NAME_WARDROBE20_BINDING = "Tenue 20";

end
--})
	
--Localization.RegisterAddonStrings("frFR", "Wardrobe", 
WardrobeText["frFR"] = {
	
	-- Configuration

	CONFIG_HEADER = "Wardrobe";
	CONFIG_HEADER_INFO = "Wardrobe vous permet de d\195\169finir et d'\195\169changer jusqu'\195\160 10 tenues diff\195\169rentes.";

	CONFIG_ENABLED = "Active Wardrobe";
	CONFIG_ENABLED_INFO = "Check to enable the plugin.";

	CONFIG_RESET_BUTTON = "Reset";
	CONFIG_RESET = "Reset Wardrobe Data";
	CONFIG_RESET_INFO = "Efface toutes les tenues !";
	CONFIG_RESET_FEEDBACK = "Toutes les donn\195\169es de wardrobe ont \195\169t\195\169 remises \195\160 z\195\169ro.";

	CONFIG_KEY_HEADER = "Couleur des tenues";

	CONFIG_OPTIONS_HEADER = "Options";

	CONFIG_WEAROUTFIT = "Equipe les tenues";
	CONFIG_WEAROUTFIT_INFO = "Equipe les objets de la tenue choisie.";
	CONFIG_WEAROUTFIT_FEEDBACK = "Vous avez \195\169quip\195\169 \"%s\".";

	CONFIG_EDIT_BUTTON = "Edit";
	CONFIG_EDIT = "Edit les tenues Wardrobe";
	CONFIG_EDIT_INFO = "Ouvre le panneau de contr\195\180le des tenues.";
	CONFIG_EDIT_FEEDBACK = "Ouverture du panneau de contr\195\180le des tenues.";
	
	CONFIG_AUTOSWAP = "Echange Automatique";
	CONFIG_AUTOSWAP_INFO = "Permettez aux tenues sp\195\169ciaux d'\195\169changer automatiquement.";
	
	CONFIG_REQCLICK = "Cliquez pour voir la liste des tenues";
	CONFIG_REQCLICK_INFO = "Permet de ne plus voir la liste des tenues qu'en cliquant sur le bouton de la minicarte.";

	CONFIG_LOCKBUTTON = "Verrouille la position du bouton de la minicarte";
	CONFIG_LOCKBUTTON_INFO = "Interdit le d\195\169placement du bouton de la minicarte.";

	CONFIG_DROPDOWNSCALE = "Ajuste l'\195\169chelle du menu d\195\169roulant";
	CONFIG_DROPDOWNSCALE_INFO = "Ajuste l'\195\169chelle du menu d\195\169roulant";
	CONFIG_DROPDOWNSCALE_FEEDBACK = "Echelle du menu d\195\169roulant : %s%%.";

	CHAT_COMMAND_INFO = "";

	TEXT_MENU_TITLE = " Tenues";
	TEXT_MENU_OPEN = "[MENU]";
	NAME_LABEL = "Nom de la tenue actuelle";


	PLAGUEBUTTON_TIP1 = "Equipe la tenue choisie\nquand vous entrez dans\nles Maleterres.";
	MOUNTBUTTON_TIP1 = "Equipe la tenue choisie\nquand vous \195\170tes sur\nvotre monture.";
	MOUNTBUTTON_TIP2 = "Le changement automatique de tenue sur une monture requi\195\168re l'Addon IsMounted.";
	EATDRINKBUTTON_TIP1 = "Equipe la tenue s\195\169lectionn\195\169e\nquand vous mangez\nou buvez.";
	COLORBUTTON_TIP1 = "Choisi la couleur de\nla tenue s\195\169lectionn\195\169e.";
	EDITBUTTON_TIP1 = "Edite la tenue s\195\169lectionn\195\169e.";
	UPDATEBUTTON_TIP1 = "Met \195\160 jour la tenue s\195\169lectionn\195\169e\navec ce que vous portez actuellement.";
	DELETEBUTTON_TIP1 = "Supprime la tenue s\195\169lectionn\195\169e.";
	DOWNBUTTON_TIP1 = "D\195\169place la tenue s\195\169lectionn\195\169e\nvers le bas de la liste.";
	UPBUTTON_TIP1 = "D\195\169place la tenue s\195\169lectionn\195\169e\nvers le haut de la liste.";
	
	TXT_ACCEPT = "Accepter";
	TXT_CANCEL = "Annuler";
	TXT_TOGGLE = "Toggle";
	TXT_COLOR = "Couleur";
	TXT_EDITOUTFITS = "Edite les tenues";
	TXT_NEW = "Nouveau";
	TXT_CLOSE = "Fermer";
	TXT_SELECTCOLOR = "S\195\169lectionne une Couleur";
	TXT_OK = "OK";
	TXT_WPLAGUELANDS = "Maleterres de l'ouest (Western Plaguelands)";
	TXT_EPLAGUELANDS = "Maleterres de l'est (Eastern Plaguelands)";
	TXT_STRATHOLME = "Stratholme";
	TXT_SCHOLOMANCE = "Scholomance";
	TXT_WARDROBEVERSION = "Wardrobe version";
	TXT_OUTFITNAMEEXISTS = "Une tenue avec le m\195\170me nom existe d\195\169j\195\160! Veuillez choisir un autre nom.";
	TXT_USEDUPALL = "Vous avez d\195\169fini le maximum";
	TXT_OFYOUROUTFITS = "de tenues pour ce personnage. Veuillez en supprimer une avant d'en cr\195\169er une nouvelle.";
	TXT_OUTFIT = "Tenue";
	TXT_PLEASEENTERNAME = "Veuillez entrer un nom de tenue \195\160 mettre \195\160 jour avec l'\195\169quipement que vous portez actuellement.";
	TXT_OUTFITNOTEXIST = "Ce nom de tenue n'existe pas ! Veuillez choisir une tenue existante \195\160 mettre \195\160 jour avec l'\195\169quipement que vous portez actuellement.";
	TXT_NOTEXISTERROR = "Ce nom de tenue n'existe pas!";
	TXT_UPDATED = "mis \195\160 jour";
	TXT_DELETED = "supprim\195\169.";
	TXT_UNABLETOFIND = "Impossible de trouver un nom de tenue";
	TXT_UNABLEFINDERROR = "Impossible de trouver la tenue !";
	TXT_ALLOUTFITSDELETED = "Toutes les tenues sont supprim\195\169es !";
	TXT_YOURCURRENTARE = "Vos tenues sont actuellement :";
	TXT_NOOUTFITSFOUND = "Aucune tenue trouv\195\169e !";
	TXT_SPECIFYOUTFITTOWEAR = "Veuillez indiquer une tenue \195\160 \195\169quiper.";
	TXT_UNABLEFIND = "Impossible de trouver";
	TXT_INYOURLISTOFOUTFITS = "dans votre liste de tenues !";
	TXT_SWITCHINGTOOUTFIT = "Switching to outfit";
	TXT_WARNINGUNABLETOFIND = "Avertissement : Impossible de trouver ";
	TXT_INYOURBAGS = "dans vos sacs !";
	TXT_SWITCHEDTOOUTFIT = "Wardrobe: Switched to outfit";
	TXT_PROBLEMSCHANGING = "Wardrobe: Probl\195\168me durant le changement de tenue. Vos sacs sont peut-\195\170tre pleins.";
	TXT_OUTFITRENAMEDERROR = "Tenue renomm\195\169e.";
	TXT_OUTFITRENAMEDTO = "Renommer une tenue";
	TXT_TOWORDONLY = "to";
	TXT_UNABLETOFINDOUTFIT = "Impossible de trouver la tenue";
	TXT_WILLBEWORNWHENMOUNTED = "sera \195\169quip\195\169 sur votre monture.";
	TXT_BUTTONLOCKED = "Bouton Wardrobe bloqu\195\169. Pour repositionner, taper /wardrobe unlock";
	TXT_BUTTONUNLOCKED = "Bouton Wardrobe d\195\169bloqu\195\169. Vous pouvez repositionner le bouton wardrobe. Pour bloquer le bouton \195\160 sa place, taper /wardrobe lock";
	TXT_BUTTONONCLICK = "Affichage du menu Wardrobe avec un click.";
	TXT_BUTTONONMOUSEOVER = "Affichage du menu Wardrobe par mouseover.";
	TXT_MOUNTEDNOTEXIST = "Cette tenue n'existe pas. Veuillez choisir une tenue \195\160 \195\169quiper quand vous \195\170tes sur votre monture.";
	TXT_ERRORINCONFIG = "Erreur dans Wardrobe_ShowWardrobeConfigurationScreen: Wardrobe_Config.DefaultCheckboxState a une valeur inconnue de ";
	TXT_CHANGECANCELED = "Modification de Wardrobe annul\195\169e !";
	TXT_NEWOUTFITNAME = "Nouveau nom de tenue";
	TXT_NOLONGERWORNMOUNTERR = "ne sera plus \195\169quip\195\169e sur votre monture.";
	TXT_WORNWHENMOUNTERR = "sera \195\169quip\195\169e sur votre monture.";
	TXT_NOLONGERWORNPLAGUEERR = "ne sera plus \195\169quip\195\169e quand vous \195\170tes aux maleterrres.";
	TXT_WORNPLAGUEERR = "sera \195\169quip\195\169e quand vous \195\170tes aux maleterrres.";
	TXT_NOLONGERWORNEATERR = "ne sera plus \195\169quip\195\169e quand vous mangez ou buvez.";
	TXT_WORNEATERR = "sera \195\169quip\195\169e quand vous mangez ou buvez.";
	TXT_REALLYDELETEOUTFIT = "Voulez-vous supprimer cette tenue ?";
	TXT_PLEASESELECTDELETE = "Veuillez s\195\169lectionner une tenue \195\160 supprimer !";
	TXT_WARDROBENAME = "Wardrobe";
	TXT_WARDROBEBUTTON = "Bouton Wardrobe";
	TXT_ENABLED = "Wardrobe Activ\195\169.";
	TXT_DISABLED = "Wardrobe D\195\169sactiv\195\169.";
	TXT_AUTO_ENABLED = "Echange Automatique Activ\195\169.";
	TXT_AUTO_DISABLED = "Echange Automatique D\195\169sactiv\195\169.";

	TXT_WORNSWIMR = "sera \195\169quip\195\169e quand vous nagez.";
	TXT_NOLONGERWORNSWIMR = "ne sera plus \195\169quip\195\169e quand vous nagez.";
	TXT_NO_OUTFIT = "<pas de tenue>";
	
	HELP_1 = "Wardrobe, AddOn par AnduinLothar, Miravlix et Cragganmore, Version ";
	HELP_2 = "Wardrobe vous permet de d\195\169finir et d'\195\169changer jusqu'\195\160 10 tenues diff\195\169rentes.";
	HELP_3 = "L'interface principale est accessible par l'ic\195\180ne Wardrobe qui se trouve par d\195\169faut";
	HELP_4 = "sous la minicarte. Vous pouvez \195\169galement utiliser les commandes suivantes :";
	HELP_5 = "Syntaxe : /wardrobe <wear/list/reset/lock/unlock/click/mouseover/scale>";
	HELP_6 = " wear [nom de tenue] - Equipe la tenue choisie.";
	HELP_7 = " list - Liste des tenues.";
	HELP_8 = " reset - Supprime toutes les tenues d\195\169finies.";
	HELP_9 = " lock/unlock - Verrouille/D\195\169verrouille le bouton de la minicarte.";
	HELP_10 = " click/mouseover - Montre la liste des tenues en cliquant ou en passant le curseur de la souris sur le bouton.";
	HELP_11 = " scale [0.5 - 1.0] - Ajuste l'\195\169chelle de la liste des tenues.";
	HELP_12 = "Dans l'interface, les noms de tenues sont color\195\169s comme suit :";
	HELP_13 = " Couleur Brillante : la tenue actuellement \195\169quip\195\169e.";
	HELP_14 = " Couleur Sombre: Une tenue dont un ou plusieurs objets ne sont pas \195\169quip\195\169s.";
	HELP_15 = " Gris: Une tenue dont un ou plusieurs objets ne sont pas pr\195\169sents dans votre inventaire.";
	HELP_16 = " Les tenues gris\195\169es peuvent \195\170tre \195\169quip\195\169es (il manquera juste les objets absents de l'inventaire).";

}--)
