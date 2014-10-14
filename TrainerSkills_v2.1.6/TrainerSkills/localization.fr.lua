if ( GetLocale() == "frFR" ) then
--French translation by WarLink
--Keybinding
BINDING_HEADER_TRAINERSKILLS = "Raccourci TrainerSkills";
BINDING_NAME_TOGGLETRAINERSKILLS = "Panneau TrainerSkills";

--UI strings
TRAINERSKILLS_FRAME_TITLE = "TrainerSkills version "..TRAINERSKILLS_VERSIONNUMBER;
TRAINERSKILLS_MYADDONS_DESCRIPTION = "Affiche la fen\195\170tre d\'entraîneur de n\'importe où";
TRAINERSKILLS_CHOOSE_TRAINER = "Choisissez l\'entraîneur";
TRAINERSKILLS_TRAINER_DROPDOWN = "Entraîneur";
TRAINERSKILLS_CHARACTER_DROPDOWN = "Choisissez le personnage";
TRAINERSKILLS_CHARACTER_DROPDOWN_FIRST_ENTRY = "Choisissez un personnage";
TRAINERSKILLS_CHARACTER_DROPDOWN_ON = "sur"; --e.g. Huntelly <on> Aszune
TRAINERSKILLS_FILTER_DROPDOWN = "N\'afficher que:";
TRAINERSKILLS_DELETE_BUTTON_CONFIRM = "Supprimer : "; --Selected trainer is added after this string

--Chat output
TRAINERSKILLS_NOTIFICATION_ON = "TrainerSkills: Notification activ\195\169";
TRAINERSKILLS_NOTIFICATION_OFF = "TrainerSkills: Notification d\195\169sactiv\195\169";

TRAINERSKILLS_CHAT_HELP_LINE1 = "Utilisez /ts ou /TrainerSkills ou assignez une touche raccourci pour ouvrir la fen\195\170tre TrainerSkills";
TRAINERSKILLS_CHAT_HELP_LINE2 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts reset"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - va supprimer toutes les donn\195\169es pour ce personnage";
TRAINERSKILLS_CHAT_HELP_LINE3 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts delete trainerType <trainer>"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - ex: /ts delete trainerType expert leatherworker - vas supprimer cet entraîneur de du personnage";
TRAINERSKILLS_CHAT_HELP_LINE4 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts delete <character> "..TRAINERSKILLS_CHARACTER_DROPDOWN_ON.." <realm>"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - ex: /ts delete Buller "..TRAINERSKILLS_CHARACTER_DROPDOWN_ON.." Aszune - vas supprimer les entraîneur du personnage";
TRAINERSKILLS_CHAT_HELP_LINE5 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts delete selected"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - Supprime l\'entraîneur selectionn\195\169";
TRAINERSKILLS_CHAT_HELP_LINE6 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts notify"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - D\195\169s/Active l\'affichage de la notification des nouvelles aptitude disponibles";
TRAINERSKILLS_CHAT_HELP_LINE7 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts cleanUp"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - Supprime les doublons si il y a eu une utilisation pr\195\169c\195\169dente de TrainerSkills 1.9.1 et avant";

TRAINERSKILLS_CHAT_DELETE_DROPPED_TRAINER = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."TrainerSkills: Supprimez manuellement l\'entraîneur selectionn\195\169."..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE;
TRAINERSKILLS_CHAT_LOADED = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."Razzer\'s TrainerSkills version "..TRAINERSKILLS_VERSIONNUMBER.." charg\195\169e. Utilisez /ts help ou /trainerSkills help pour plus d\'infos"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE;
TRAINERSKILLS_CHAT_CORUPT_DATA = "Les donn\195\169es son corrompues, allez revoir l\'entraîneur pour faire une mise \195\160 jour.";
TRAINERSKILLS_CHAT_CHAR_DELETED = "Donn\195\169es supprim\195\169es pour"; --User input is added after this string.
TRAINERSKILLS_CHAT_CHAR_NOT_FOUND = "n\'as pas \195\169t\195\169 trouv\195\169(e)"; --User input added in front of string.
TRAINERSKILLS_CAHT_TRAINER_DELETED = "\195\160 \195\169t\195\169 supprim\195\169 du personnage"; --User input added in front of string.
TRAINERSKILLS_CHAT_TRAINER_NOT_FOUND = "n\'as pas \195\169t\195\169 trouv\195\169(e) sur ce personnage"; --User input in front of string
TRAINERSKILLS_CHAT_CLEANUP = "entr\195\169e(s) supprim\195\169e(s)"; --Number is added in front of string
TRAINERSKILLS_CHAT_CHAR_CLEARED = "La base de donn\195\169e a \195\169t\195\169 vid\195\169e pour ce personnage";
TRAINERSKILLS_CHAT_NEW_LEARNABLE_SKILL = "Vous pouvez maintenant apprendre:"; --Skill name is added after this sting
TRAINERSKILLS_CHAT_NEW_LERANABLE_SKILL_FROM = "par"; --Trainertype added after this string

--Tooltips
TRAINERSKILLS_TRAINER_NAMES = "Nom et sp\195\169cialit\195\169 des entraîneur";
TRAINERSKILLS_CHARACTER_LEVEL = "Niveau du personnage:";
TRAINERSKILLS_CHARACTER_INFO = "Infos du personnage:";
TRAINERSKILLS_IN = "\195\160"; --Used in the trainer names and location tooltip (Bubber <in> Stormwind)
TRAINERSKILLS_DELETE_BUTTON = "Supprime l\'entraîneur s\195\169lectionn\195\169";

--Start added in version 1.9.5
	--Chat outputs
TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST = "Coût total:"; --Total cost for learning new avaiable skills
TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST_EXPLANATION = "Le coût peut varier en fonction de la r\195\169putation"; --Added to the total cost line
	--Tooltips
TRAINERSKILLS_TT_TOTAL_TRAIN_COST = "Coût total pour les aptitudes"..TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."disponibles"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." :";
TRAINERSKILLS_TT_UNAVAILABLE_TOTAL_COST = "Coût total pour les aptitudes "..RED_FONT_COLOR_CODE.."non-disponibles"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." :";
TRAINERSKILLS_TT_COST_STUFF = "Coût de l'entraînement"; --Headline for the tooltip by the moneylabel in the TS frame
--End added in version 1.9.5

--Start added in version 1.9.7
	--Tooltips
TRAINERSKILLS_MINIMAP_BUTTON = "Ouvre la fentre de TraineSkills";
	--Chat outputs
TRAINERSKILLS_MINIMAP_BUTTON_OFF = "TrainerSkills: Bonton de la Minimap Cach\195\169";
TRAINERSKILLS_MINIMAP_BUTTON_ON = "TrainerSkills: Bouton de la Minimap Visible";
TRAINERSKILLS_CHAT_HELP_LINE8 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts mmb"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - D\195\169s/Active le bouton de la minimap";
--End added in version 1.9.7

--Start added in version 2.0.1
	--Chat outputs
TRAINERSKILLS_MINIMAP_BUTTON_MOVEABLE_ON = "TrainerSkills: Bouton de la minimap d\195\169placable";
TRAINERSKILLS_MINIMAP_BUTTON_MOVEABLE_OFF = "TrainerSkills: Bouton de la minimap ancr\195\169";
TRAINERSKILLS_CHAT_HELP_LINE9 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts mmbMov"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - D\195\169s/Ancre le bouton de la minimap";
	--Config panel
TRAINERSKILLS_CONFIG_HEADER = "Pram\195\168tres de TrainerSkills";
TRAINERSKILLS_OPEN_CONFIG = "Param\195\168tres";
TRAINERSKILLSCONFIG_CB_NOTIFY_LABEL = "Activer la notification";
TRAINERSKILLSCONFIG_CB_NOTIFY_TOOLTIP = "Indique les aptitudes \ndisponibles chez l\'entraîneur";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTON_LABEL = "Affiche le bouton autour de la minimap";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTON_TOOLTIP = "Facilite l\'affichage de TrainerSkills via \nle bouton de la minimap";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTONMOVEABLE_LABEL = "D\195\169s/Ancre le bouton de la minimap";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTONMOVEABLE_TOOLTIP = "Donne la possibilit\195\169 de d\195\169placer \nle bouton de la minimap";
TRAINERSKILLSCONFIG_CB_GRAPTOOLTIPS_LABEL = "Sauver les donn\195\169 des aptitudes";
TRAINERSKILLSCONFIG_CB_GRAPTOOLTIPS_TOOLTIP = "Donn\195\169es visiblent lors du survol de l'aptitude \ndans la fen\195\170tre de TrainerSkills";
TRAINERSKILLSCONFIG_CB_GRAPDESCRIPTION_LABEL = "Sauver la description des aptitudes";
TRAINERSKILLSCONFIG_CB_GRAPDESCRIPTION_TOOLTIP = "";
TRAINERSKILLSCONFIG_CB_GRABNPCNAMESANDLOCATIONS_LABEL = "Sauver le nom et la localisation du PNJ";
TRAINERSKILLSCONFIG_CB_GRABNPCNAMESANDLOCATIONS_TOOLTIP = "Donn\195\169es visible lors du survol des \nentraîneurs dans le menu d\195\169roulant";
TRAINERSKILLSCONFIG_CB_SAVEPLAYERSKILLS_LABEL = "Sauver l\'avancement des joueurs";
TRAINERSKILLSCONFIG_CB_SAVEPLAYERSKILLS_TOOLTIP = "Donn\195\169es visible lors du survol des joueurs dans le menu d\195\169roulant";
TRAINERSKILLSCONFIG_CB_KEEPGREYS_LABEL = "Sauver les aptitudes d\195\169j\195\160 connues";
TRAINERSKILLSCONFIG_CB_KEEPGREYS_TOOLTIP = "";
TRAINERSKILLS_CONFIG_PURGE_BUTTON = "Purge";
TRAINERSKILLS_CONFIG_PURGE_TOOLTIP = "Supprimes toutes les donn\195\169es non slectionn\195\169es";
--End added in version 2.0.1

--Start added in version 2.0.3
TRAINERSKILLS_CHAT_ALL_GREY_DEL = "Toutes les aptitudes de cet entraîneurs sont connues, et celles-ci ne sont pas sauvegard\195\169s. Vous pouvez supprimer cet entraîneurs.";
--End added in version 2.0.3

--Start version 2.0.4
TRAINERSKILLS_CHAT_COMPLEATERESET = "Toutes les donn\195\169es ont \195\169t\195\169 supprimm\195\169es. R\195\169initialisation..."
TRAINERSKILLS_CHAT_HELP_LINE10 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts completeReset"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - Supprime toutes les donn\195\169 de TrainerSkills ! (Attention : Irr\195\169versible !)";
--end version 2.0.4

TRAINERSKILLSCONFIG_CB_TRAINERFILTER_LABEL = "Transfert des filtress";
TRAINERSKILLSCONFIG_CB_TRAINERFILTER_TOOLTIP = "Sauvegarde les options des filtres et change\nles filtres de l\'entraineur en fonction\ndes r\195\169glages de TrainerSkill"
TRAINERSKILLS_TITAN_MENU = "TrainerSkills (Droit)";

--Start added in version 2.1.3
TRAINERSKILLS_DELETE_CHARACTER_BUTTON = "Supprimer le Personnage selectionn\195\169";
--end 
end