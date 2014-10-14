---------------------------------------------------
-- La Vendetta BossMods GUI Language File        --
-- GUI by LV|Nitram                              --
--                                               --
-- Translations by:                              --
--   LV|Nitram  -> EN                            --
--   LV|Tandanu -> DE                            --
--   LV|Tandanu -> fixed typos                   --
---------------------------------------------------

----------------------------------
-- Translation FR --
----------------------------------

if( GetLocale() == "frFR" ) then

-- LVBM_GUI.lua for Bossmod List Frame (LVBMBossModListFrame)
LVBMGUI_TAB_1_TITLE_TEXT		= "Boss Mods Naxxramas";
LVBMGUI_TAB_2_TITLE_TEXT		= "Boss Mods Temple d'Ahn'Qiraj";
LVBMGUI_TAB_3_TITLE_TEXT		= "Boss Mods Repaire de l'Aile Noire";
LVBMGUI_TAB_4_TITLE_TEXT		= "Boss Mods Coeur du Magma";
LVBMGUI_TAB_5_TITLE_TEXT		= "Boss Mods Zul'Gurub et Ahn'Qiraj";
LVBMGUI_TAB_6_TITLE_TEXT		= "Autres Boss Mods";

-- Tooltips
LVBMGUI_FRAMETAB_1_TT			= "Boss Mods Naxxramas";
LVBMGUI_FRAMETAB_1_TD			= "Une liste de nos Boss Mods pour Naxxramas. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";
LVBMGUI_FRAMETAB_2_TT			= "Boss Mods Temple d'Ahn'Qiraj";
LVBMGUI_FRAMETAB_2_TD			= "Une liste de nos Boss Mods pour le Temple d'Ahn'Qiraj. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";
LVBMGUI_FRAMETAB_3_TT			= "Boss Mods Repaire de l'Aile Noire";
LVBMGUI_FRAMETAB_3_TD			= "Une liste de nos Boss Mods pour le Repaire de l'Aile Noire. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";
LVBMGUI_FRAMETAB_4_TT			= "Boss Mods Coeur du Magma";
LVBMGUI_FRAMETAB_4_TD			= "Une liste de nos Boss Mods pour le Coeur du Magma. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";
LVBMGUI_FRAMETAB_5_TT			= "Boss Mods Zul'Gurub et Ahn'Qiraj";
LVBMGUI_FRAMETAB_5_TD			= "Une liste de nos Boss Mods pour Zul'Gurub et Ahn'Qiraj 20. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";

LVBMGUI_DISABLE_ADDON			= "D\195\169sactiver AddOn";
LVBMGUI_ENABLE_ADDON			= "Activer AddOn";
LVBMGUI_STOP_ADDON				= "Arr\195\170ter AddOn";
LVBMGUI_DISABLE_ANNOUNCE		= "D\195\169sactiver Annonce";
LVBMGUI_ENABLE_ANNOUNCE			= "Activer Annonce";
LVBMGUI_SHOW_DROPDOWNMENU		= "Options add.";
LVBMGUI_DROPDOWNMENU_TITLE		= "Boss Mod Menu";

-- LVBMBossModFrame
LVBMGUI_HIDE_OPTIONS				= "<<< Options";
LVBMGUI_SHOW_OPTIONS				= "Options >>>";

-- Options Frame (LVBMOptionsFrame)
LVBMGUI_OPTIONS					= "Options (GUI v"..LVBMGUI_VERSION.." / Boss Mod v"..LVBM.Version..")";
LVBMGUI_SIDEFRAME_TAB1				= "General";
LVBMGUI_SIDEFRAME_TAB2				= "Barres";
LVBMGUI_SIDEFRAME_TAB3				= "Alertes";
LVBMGUI_SIDEFRAME_TAB4				= "Autres";

-- LVBMOptionsFramePage1
LVBMGUI_TITLE_SYNCSETTINGS			= "Options de Synchronization";
LVBMGUI_TITLE_MINIMAPBUTTON			= "Options du Boutton Minimap";
LVBMGUI_TITLE_AGGROALERT			= "Options d'Aggro Alert";
LVBMGUI_CHECKBOX_SYNC_ENABLE			= "Activer synchronization";
LVBMGUI_BUTTON_VERSION_CHECK			= "Recherche";
LVBMGUI_BUTTON_VERSION_CHECK_FAILD		= "Aucun autre utilisateur de Vendetta n'a \195\169t\195\169 trouv\195\169";
LVBMGUI_BUTTON_STATUSBAR_SYNCINFO		= "Infos de synchro";
LVBMGUI_BUTTON_STATUSBAR_SYNCINFO_FAILD 	= "Aucune synchronisation trouv\195\169e.";
LVBMGUI_SLIDER_MINIMAP_1			= "Position";
LVBMGUI_SLIDER_MINIMAP_2			= "Rayon";
LVBMGUI_CHECKBOX_MINIMAP			= "Afficher le bouton";
LVBMGUI_CHECKBOX_AGGROALERT_ENABLE		= "Activer Aggro Alert";
LVBMGUI_BUTTON_AGGROALERT_TEST			= "Tester Aggro Alert";
LVBMGUI_BUTTON_AGGROALERT_RESET			= "Par d\195\169faut";
LVBMGUI_BUTTON_AGGROALERT_RESET_DONE		= "Aggro Alert \195\160 bien \195\169t\195\169 reset";
LVBMGUI_CHECKBOX_AGGROALERT_PLAYSOUND		= "Jouer un son";
LVBMGUI_CHECKBOX_AGGROALERT_FLASH		= "Flash";
LVBMGUI_CHECKBOX_AGGROALERT_SHAKE		= "Secousses";
LVBMGUI_CHECKBOX_AGGROALERT_SPECIALTEXT		= "Afficher les alertes sp\195\169ciales";
LVBMGUI_CHECKBOX_AGGROALERT_LOCALWARNING	= "Afficher les alertes comme des alertes locales";
LVBMGUI_BUTTON_MOVEABLEBAR			= "Barre Mobile";
LVBMGUI_BUTTON_DEFAULTS				= "Par d\195\169faut";

-- LVBMOptionsFramePage2
LVBMGUI_TITLE_STATUSBARS 			= "Options Barres de status";
LVBMGUI_TITLE_PIZZATIMER			= "Cr\195\169er \"Pizza Timer\"";
LVBMGUI_CHECKBOX_STATUSBAR_ENABLE		= "Activers Barres de status";
LVBMGUI_CHECKBOX_STATUSBAR_FILLUP		= "Remplir les barres de status";
LVBMGUI_CHECKBOX_STATUSBAR_FLIPOVER		= "Ajuster hauteur";
LVBMGUI_EDITBOX_PIZZATIMER_TEXT			= "Nom";
LVBMGUI_EDITBOX_PIZZATIMER_MIN			= "Minutes";
LVBMGUI_EDITBOX_PIZZATIMER_SEC			= "Seconds";
LVBMGUI_CHECKBOX_PIZZATIMER_BROADCAST		= "Broadcast timer au raid";
LVBMGUI_BUTTON_PIZZATIMER_START			= "Lancer le timer";

-- LVBMOptionsFramePage3
LVBMGUI_TITLE_RAIDWARNING			= "Alertes Raid";
LVBMGUI_TITLE_SELFWARNING			= "Alerts Locales"; 
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_1		= "RaidWarning (Son par d\195\169faut)";
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_2		= "BellTollNightElf (Son CT_Raid)";
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_3		= "D\195\169sactiver Sons d'alerte";
LVBMGUI_DROPDOWN_RAIDWARNING_INFO_DISABLED	= "Sons d'alerte d\195\169sactiv\195\169s";
LVBMGUI_RAIDWARNING_EXAMPLE			= "*** Exemple d'Alerte Raid ***";
LVBMGUI_BUTTON_SOUND_TEST			= "Sons test\195\169s";
LVBMGUI_BUTTON_SHOW_EXAMPLE			= "Exemple";
LVBMGUI_BUTTON_RAIDWARNING_RESET		= "Reset frame";
LVBMGUI_BUTTON_RAIDWARNING_RESET_DONE		= "Les configurations ont bien \195\169t\195\169 remises \195\170 z\195\169ro";

-- LVBMOptionsFramePage4
LVBMGUI_TITLE_SPECIALWARNING			= "Alertes sp\195\169ciales";
LVBMGUI_TITLE_SHAKESCREEN			= "Effets de secousses de l'\195\169cran";
LVBMGUI_TITLE_FLASHEFFECT			= "Effets de flash";
LVBMGUI_CHECKBOX_SPECWARNING_ENABLE		= "Activers les alertes sp\195\169ciales";
LVBMGUI_BUTTON_SPECWARNING_TEST			= "Test alertes";
LVBMGUI_BUTTON_SPECWARNING_EXAMPLE		= "Message de Test :)";
LVBMGUI_SLIDER_SPECWARNING_DURATION		= "Dur\195\169e";
LVBMGUI_SLIDER_SPECWARNING_FADETIME		= "Temps de fade";
LVBMGUI_SLIDER_SPECWARNING_TEXTSIZE		= "Taille du texte";
LVBMGUI_CHECKBOX_SHAKESCREEN_ENABLE		= "Activers effets de secousses";
LVBMGUI_BUTTON_SHAKESCREEN_TEST			= "Test secousses";
LVBMGUI_SLIDER_SHAKESCREEN_DURATION		= "Dur\195\169e";
LVBMGUI_SLIDER_SHAKESCREEN_INTENSITY		= "Intensit\195\169";
LVBMGUI_CHECKBOX_FLASHEFFECT_ENABLE		= "Activer effets de flash";
LVBMGUI_BUTTON_FLASHEFFECT_TEST			= "Test flash";
LVBMGUI_SLIDER_FLASHEFFECT_DURATION		= "Dur\195\169e";
LVBMGUI_SLIDER_FLASHEFFECT_FLASHES		= "Nombre";

-- LVBMOptionsFramePage5
LVBMGUI_ABOUTTITLE	= "About";
LVBMGUI_ABOUTTEXT	= {
	"LV Bossmods API (c) by DeadlyMinds Tandanu",
	"LV Bossmods GUI (c) by La Vendetta Nitram",
	"French Translation by Proreborn",
	" ",
	"Merci d'utiliser La Vendetta Boss Mods.",
	" ",
	"                                  Visitez",
	" ",
	"                   www.deadlyminds.net",
	" ",
	"                                   et",
	" ",
	"                 www.curse-gaming.com",
	" ",
	"Si vous avez une suggection, un report de bug ou un commentaire, merci de poster sur www.curse-gaming.com ou sur nos forums @ www.deadlyminds.net",
};

-- Translations added v1.05
LVBMGUI_DISTANCE_FRAME_TITLE		= "Distance";
LVBMGUI_DISTANCE_FRAME_TEXT		= "Trop proches:";

LVBMGUI_INFOFRAME_TOOLTIP_TITLE		= "Info Frame";
LVBMGUI_INFOFRAME_TOOLTIP_TEXT		= "Click droit pour d\195\169placer / Shift + CLick droit pour cacher";

LVBMGUI_STATUSBAR_WIDTH_SLIDER		= "Largeur Barre";
LVBMGUI_STATUSBAR_SCALE_SLIDER		= "Scale Barre";

LVBMGUI_BUTTON_RANGECHECK		= "Port\195\169e";
LVBMGUI_TOOLTIP_RANGECHECK_TITLE	= "V\195\169rification de port\195\169e";
LVBMGUI_TOOLTIP_RANGECHECK_TEXT		= "V\195\169rification de port\195\169e montrant tous les joueurs hors de port\195\169e de vous (\195\170 plus de 30 m\195\168tres).";

LVBMGUI_BUTTON_DISTANCEFRAME		= "Distance";
LVBMGUI_TOOLTIP_DISTANCEFRAME_TITLE	= "Distance";
LVBMGUI_TOOLTIP_DISTANCEFRAME_TEXT	= "Active ou D\195\169sactive la V\195\169rification de DIstance, qui permet de savoir quels joueurs sont trop proches de vous (Moins de 10m). Cette otpion est tr\195\168s utile pour les encounters de C'thun ou de Huhuran.";

-- Translations added v1.10
LVBMGUI_SIDEFRAME_TAB5				= "Misc";
LVBMGUI_SIDEFRAME_TAB6				= "About";

LVBMGUI_SLIDER_STATUSBAR_COUNT			= "Nombre max.";
LVBMGUI_DROPDOWN_STATUSBAR_DESIGN_1		= "Classic Design"; --wird überflüssig mit dem Verwenden des Namens aus der Tabelle
LVBMGUI_DROPDOWN_STATUSBAR_DESIGN_2		= "Modern Style"; 
LVBMGUI_DROPDOWN_STATUSBAR_EXAMPLE_BAR		= "Barre d'exemple";

LVBMGUI_TITLE_AUTORESPOND			= "Options Auto-rep";
LVBMGUI_CHECKBOX_AUTORESPOND_ENABLE		= "Auto-r\195\169pondre aux whisps pendant un encounter";
LVBMGUI_CHECKBOX_AUTORESPOND_SHOW_WHISPERS	= "Afficher les whisps pendant le combat";
LVBMGUI_CHECKBOX_AUTORESPOND_INFORM_USER	= "M'informer des whisps Auto-r\195\169pondus";
LVBMGUI_CHECKBOX_AUTORESPOND_HIDE_REPLY		= "Masquer les R\195\169ponses auto";

LVBMGUI_EDITBOX_AUTORESPOND_TITLE		= "Message à envoyer pendant les encounters de boss";
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_HEADER	= "Les champs suivants seront\nautomatiquement remplac\195\169s:";
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT1	= {"%P", "Votre nom"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT2	= {"%B", "Nom du boss"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT3	= {"%HP", "PdV du boss"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT4	= {"%ALIVE", "Membres du raid en vie"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT5	= {"%RAID", "Membres du raid"};

end
