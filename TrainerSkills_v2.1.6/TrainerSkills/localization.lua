--Trainerskills by Razzer (http://wow.pchjaelp.dk)
--If you translate this pleace mail me a copy of this file and i'll put it up with the next version =)

TRAINERSKILLS_VERSIONNUMBER = "2.1.5";
--Colors
TRAINERSKILLS_GREEN_FONT_COLOR_CODE = "|cff00FF00";
TRAINERSKILLS_FONT_COLOR_CODE_CLOSE = "|r";

--Keybinding
BINDING_HEADER_TRAINERSKILLS = "TrainerSkills Bindings";
BINDING_NAME_TOGGLETRAINERSKILLS = "Toggle TrainerSkills";

--UI strings
TRAINERSKILLS_FRAME_TITLE = "TrainerSkills version "..TRAINERSKILLS_VERSIONNUMBER;
TRAINERSKILLS_MYADDONS_DESCRIPTION = "Shows the trainerFrame from annywhere";
TRAINERSKILLS_CHOOSE_TRAINER = "Choose a trainer";
TRAINERSKILLS_TRAINER_DROPDOWN = "Trainer";
TRAINERSKILLS_CHARACTER_DROPDOWN = "Select Character";
TRAINERSKILLS_CHARACTER_DROPDOWN_FIRST_ENTRY = "Choose a character";
TRAINERSKILLS_CHARACTER_DROPDOWN_ON = "on"; --e.g. Huntelly <on> Aszune
TRAINERSKILLS_FILTER_DROPDOWN = "Show only:";
TRAINERSKILLS_DELETE_BUTTON_CONFIRM = "Really delete"; --Selected trainer is added after this string

--Chat output
TRAINERSKILLS_NOTIFICATION_ON = "TrainerSkills: Notification turned on";
TRAINERSKILLS_NOTIFICATION_OFF = "TrainerSkills: Notification turned off";

TRAINERSKILLS_CHAT_HELP_LINE1 = "Type /ts or /TrainerSkills or make a keybinding to open the TrainerSkills frame";
TRAINERSKILLS_CHAT_HELP_LINE2 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts reset"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - will clear all data gathered by TrainerSkills for this character";
TRAINERSKILLS_CHAT_HELP_LINE3 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts delete trainerType <trainer>"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - e.g.: /ts delete trainerType expert leatherworker - will delete that trainer from the current character";
TRAINERSKILLS_CHAT_HELP_LINE4 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts delete <character> "..TRAINERSKILLS_CHARACTER_DROPDOWN_ON.." <realm>"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - e.g.: /ts delete Buller "..TRAINERSKILLS_CHARACTER_DROPDOWN_ON.." Aszune - will delete that character in TrainerSkills";
TRAINERSKILLS_CHAT_HELP_LINE5 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts delete selected"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - will delete the trainer selected in the trainerDropDown";
TRAINERSKILLS_CHAT_HELP_LINE6 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts notify"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - this will toggle the notifications from TS (about new skills available) on and off";
TRAINERSKILLS_CHAT_HELP_LINE7 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts cleanUp"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - this will delete redundant data if you have used a version of TrainerSkills earlier than 1.9.1";

TRAINERSKILLS_CHAT_DELETE_DROPPED_TRAINER = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."TrainerSkills: Please manually delete the trainers in TS who train in the proffession you have just unlearned."..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE;
TRAINERSKILLS_CHAT_LOADED = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."Razzer's TrainerSkills version "..TRAINERSKILLS_VERSIONNUMBER.." loaded. Type /ts help or /trainerSkills help for more info"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE;
TRAINERSKILLS_CHAT_CORUPT_DATA = "The data from this trainertype is corupt and has now been deleted. Please visit the trainer again to get the data.";
TRAINERSKILLS_CHAT_CHAR_DELETED = "The database has been cleared for"; --User input is added after this string.
TRAINERSKILLS_CHAT_CHAR_NOT_FOUND = "was not found in TrainerSkills"; --User input added in front of string.
TRAINERSKILLS_CAHT_TRAINER_DELETED = "has been deletet from this character"; --User input added in front of string.
TRAINERSKILLS_CHAT_TRAINER_NOT_FOUND = "was not found on this character"; --User input in front of string
TRAINERSKILLS_CHAT_CLEANUP = "entries deleted"; --Number is added in front of string
TRAINERSKILLS_CHAT_CHAR_CLEARED = "The database has been cleared for this character";
TRAINERSKILLS_CHAT_NEW_LEARNABLE_SKILL = "You can now learn:"; --Skill name is added after this sting
TRAINERSKILLS_CHAT_NEW_LERANABLE_SKILL_FROM = "from"; --Trainertype added after this string

--Tooltips
TRAINERSKILLS_TRAINER_NAMES = "Trainer names and location";
TRAINERSKILLS_CHARACTER_LEVEL = "Character level:";
TRAINERSKILLS_CHARACTER_INFO = "Character info:";
TRAINERSKILLS_IN = "in"; --Used in the trainer names and location tooltip (Bubber <in> Stormwind)
TRAINERSKILLS_DELETE_BUTTON = "Delete the selected trainer";

--Start added in version 1.9.5
	--Chat outputs
TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST = "Total cost:"; --Total cost for learning new avaiable skills
TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST_EXPLANATION = "Cost may vary because of reputation"; --Added to the total cost line
	--Tooltips
TRAINERSKILLS_TT_TOTAL_TRAIN_COST = "Total for "..TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."avaiable"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." skills:";
TRAINERSKILLS_TT_UNAVAILABLE_TOTAL_COST = "Total for "..RED_FONT_COLOR_CODE.."unavailable"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." skills:";
TRAINERSKILLS_TT_COST_STUFF = "Cost stuff"; --Headline for the tooltip by the moneylabel in the TS frame
--End added in version 1.9.5

--Start added in version 1.9.7
	--Tooltips
TRAINERSKILLS_MINIMAP_BUTTON = "Opens the TrainerSkills Panel";
	--Chat outputs
TRAINERSKILLS_MINIMAP_BUTTON_OFF = "TrainerSkills: Minimap button turned off";
TRAINERSKILLS_MINIMAP_BUTTON_ON = "TrainerSkills: Minimap button turned on";
TRAINERSKILLS_CHAT_HELP_LINE8 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts mmb"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - toggles the minimap button";
--End added in version 1.9.7

--Start added in version 2.0.1
	--Chat outputs
TRAINERSKILLS_MINIMAP_BUTTON_MOVEABLE_ON = "TrainerSkills: Minimap button is now moveable";
TRAINERSKILLS_MINIMAP_BUTTON_MOVEABLE_OFF = "TrainerSkills: Minimap button is no longer moveable";
TRAINERSKILLS_CHAT_HELP_LINE9 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts mmbMov"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - toggles the moveable abilities of the minimap button on and off";
	--Config panel
TRAINERSKILLS_CONFIG_HEADER = "TrainerSkills Settings";
TRAINERSKILLS_OPEN_CONFIG = "Settings";
TRAINERSKILLSCONFIG_CB_NOTIFY_LABEL = "Enable notification";
TRAINERSKILLSCONFIG_CB_NOTIFY_TOOLTIP = "Prints skills in the chat\nwhen you can learn them";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTON_LABEL = "Show button at the minimap";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTON_TOOLTIP = "Makes TrainerSkills easy accessible\nvia a minimap button";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTONMOVEABLE_LABEL = "Set the minimap button moveable";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTONMOVEABLE_TOOLTIP = "Ability to drag and drop the minimap\nbutton to another location";
TRAINERSKILLSCONFIG_CB_GRAPTOOLTIPS_LABEL = "Save skill tooltips";
TRAINERSKILLSCONFIG_CB_GRAPTOOLTIPS_TOOLTIP = "This is shown when you mouseover the icon\nfor a skill in the TS frame";
TRAINERSKILLSCONFIG_CB_GRAPDESCRIPTION_LABEL = "Save skill descriptions";
TRAINERSKILLSCONFIG_CB_GRAPDESCRIPTION_TOOLTIP = "";
TRAINERSKILLSCONFIG_CB_GRABNPCNAMESANDLOCATIONS_LABEL = "Save NPC names and locations";
TRAINERSKILLSCONFIG_CB_GRABNPCNAMESANDLOCATIONS_TOOLTIP = "This is the tooltip shown when you\nmouseover the trainers in the\ntrainer dropdown menu";
TRAINERSKILLSCONFIG_CB_SAVEPLAYERSKILLS_LABEL = "Save player skill advancements";
TRAINERSKILLSCONFIG_CB_SAVEPLAYERSKILLS_TOOLTIP = "Tooltip with player skills.\nShown when you mouseover your characters in\nthe character dropdown menu";
TRAINERSKILLS_CONFIG_PURGE_BUTTON = "Purge";
TRAINERSKILLS_CONFIG_PURGE_TOOLTIP = "Deletes all unselected data";
--End added in version 2.0.1

--Start added in version 2.0.3
TRAINERSKILLS_CHAT_ALL_GREY_DEL = "All skills from this trainer is grey and you have chosen not to save grey skills. Please manually delete the trainer.";
--End added in version 2.0.3

--start added in version 2.0.4
TRAINERSKILLS_CHAT_COMPLEATERESET = "All data has been cleared. Reinitializing...";
TRAINERSKILLS_CHAT_HELP_LINE10 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts completeReset"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - completely wipes all TS data! (Caution. Not reversible!)";
--end added in version 2.0.4

--start added in version 2.1.0
TRAINERSKILLSCONFIG_CB_TRAINERFILTER_LABEL = "Save your filtersettings at the trainer";
TRAINERSKILLSCONFIG_CB_TRAINERFILTER_TOOLTIP = "Saves your filtersettings for weather or not\nto show available/unavailable/already known\nskills at the trainer so the next time you visit\na trainer the same filtersettings is used";
TRAINERSKILLS_TITAN_MENU = "TrainerSkills (Right)";
--end added in version 2.1.0

--Start added in version 2.1.3
TRAINERSKILLS_DELETE_CHARACTER_BUTTON = "Delete the selected character";
--end 
