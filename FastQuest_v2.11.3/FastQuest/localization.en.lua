-- [[
-- Language: English, and default language
-- Externalized by: Arith Hsu
-- Last Updated: 2006/09/01
-- ]]
--------------------------
-- Translatable strings --
--------------------------
-- if (GetLocale() == "enUS") then
--
FQ_FORMAT0 = 		"QuestName";
FQ_FORMAT1 = 		"[QuestLevel] QuestName";
FQ_FORMAT2 =		"[QuestLevel+] QuestName";
FQ_FORMAT3 =		"[QuestLevel] QuestName (Tag)";
--
FQ_EPA_PATTERN1 = 	"^(.+): %s*[-%d]+%s*/%s*[-%d]+%s*$";
FQ_EPA_PATTERN2 = 	"^(.+)\(Is now complete\)%s$";
FQ_EPA_PATTERN3 = 	"^(.+)complete.$";
FQ_EPA_PATTERN4 = 	"^Experience awarded: .+$";
FQ_EPA_PATTERN5 = 	"^Found: .+$";
FQ_EPA_PATTERN6 = 	"^(.+)\(Completed\)%s$";
FQ_EPA_PATTERN7 = 	"^Accept Quest: .+$";
--
FQ_LOADED = 		"|cff00ffffFastQuest 2.11.3 is now loaded. Type /fq for more details.";
FQ_INFO =			"|cff00ffffFast Quest: |r|cffffffff";
--
FQ_INFO_QUEST_TAG =		"Display of quest-tags in the QuestTracker has been ";
FQ_INFO_AUTOADD = 		"Automatic addition/removal of changed quests to QuestTracker has been ";
FQ_INFO_AUTONOTIFY = 	"Automatic notification of party members regarding your quest progress has been ";
FQ_INFO_AUTOCOMPLETE = 	"Automatic quest completion has been ";
FQ_INFO_ALLOWGUILD = 	"Automatic notification of guild members regarding your quest progress has been ";
FQ_INFO_ALLOWRAID = 	"Automatic notification of raid members regarding your quest progress has been ";
FQ_INFO_ALWAYSNOTIFY = 	"Always notify quest progress has been ";
FQ_INFO_DETAIL =		"Notify quest progress' detail has been ";
FQ_INFO_LOCK =			"Movable components have been |cffff0000Locked|r|cffffffff";
FQ_INFO_UNLOCK =		"Movable components have been |cff00ff00Unlocked|r|cffffffff";
FQ_INFO_NODRAG =		"Dragging is now ";
FQ_INFO_RESET = 		"Movable components have been Reset";
FQ_INFO_FORMAT =		"Toggle beetween output formats ";
FQ_INFO_DISPLAY_AS =	"Selected format: ";
FQ_INFO_CLEAR =			"All quest tracker quests have been removed ";
FQ_INFO_USAGE = 		"|cffffff00usage: /fastquest [command] or /fq [command]|r|cffffffff";
FQ_INFO_COLOR =			"Quest title to be displayed with different color has been ";
--
FQ_MUST_RELOAD =		"You must reload UI for this change to apply. Type /console reloadui";
--
FQ_USAGE_TAG =			"Toggle display of quest tags (elite, raid,etc) ";
FQ_USAGE_LOCK =			"Locks/Unlocks quest tracker window.";
FQ_USAGE_NODRAG =		"Toggle dragging of quest tracker, you must reload UI to apply.";
FQ_USAGE_AUTOADD =		"Toggle automatic addition of changed quests to QuestTracker.";
FQ_USAGE_AUTONOTIFY =	"Toggle automatic notification of party members.";
FQ_USAGE_AUTOCOMPLETE =	"Toggle automatic completion of quests when turning them in. (You will not see the quest completion information from NPC.)";
FQ_USAGE_ALLOWGUILD =	"Toggle automatic notification of guild members.";
FQ_USAGE_ALLOWRAID =	"Toggle automatic notification of raid members.";
FQ_USAGE_ALWAYSNOTIFY =	"Toggle automatic notification for non-party channel.";
FQ_USAGE_DETAIL =		"Toggle quest notification in brief or in detail.";
FQ_USAGE_RESET =		"Resets FastQuest moving components, draging must be enabled.";
FQ_USAGE_STATUS =		"Display all the FastQuest configuration status.";
FQ_USAGE_CLEAR =		"Clear QuestTracker window from all quests.";
FQ_USAGE_FORMAT =		"Toggle quest notification output format.";
FQ_USAGE_COLOR =		"Toggle colorful quest title in QuestTracker window.";
--
FQ_BINDING_CATEGORY_FASTQUEST		= "Quest Enhancement";
FQ_BINDING_HEADER_FASTQUEST			= "FastQuest";
FQ_BINDING_NAME_FASTQUEST_T			= "Quest Tag";
FQ_BINDING_NAME_FASTQUEST_F			= "Quest Format";
FQ_BINDING_NAME_FASTQUEST_AOUTP		= "Auto Notify Party";
FQ_BINDING_NAME_FASTQUEST_AOUTC		= "Auto Commit Quest";
FQ_BINDING_NAME_FASTQUEST_AOUTA		= "Auto Add QuestTracker";
FQ_BINDING_NAME_FASTQUEST_NOHEADERS	= "Lock/Unlock QuestTracker";
--
FQ_SELECT_FORMAT =		"Select Format";
--
FQ_QUEST_PROGRESS =		"FastQuest progress: ";
--
FQ_QUEST = 				"FastQuest : ";
FQ_QUEST_ISDONE =		" is now completed!";
FQ_QUEST_COMPLETED =	" (COMPLETE)";
FQ_DRAG_DISABLED =		"Fast Quest: Draging is disabled, use /fq nodrag to toggle you must also reload UI for changes to take affect";
--
FQ_ENABLED =			"|cff00ff00Enabled|r|cffffffff";
FQ_DISABLED =			"|cffff0000Disabled|r|cffffffff";
FQ_LOCK =				"|cffff0000Locked|r|cffffffff";
FQ_UNLOCK =				"|cff00ff00Unlocked|r|cffffffff";
--
-- end