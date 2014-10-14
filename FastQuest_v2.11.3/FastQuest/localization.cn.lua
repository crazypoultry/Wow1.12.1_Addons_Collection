-- [[
-- Simplified Chinese
-- Externalized by: Arith Hsu
-- Original translated and maintained by: Alfred (http://statue.sayya.org/QuestLibrary)
-- Last Updated: 2006/09/01
-- ]]
--------------------------
-- Translatable strings --
--------------------------

if (GetLocale() == "zhCN") then
--
FQ_FORMAT0 = 		"任务名称";
FQ_FORMAT1 = 		"[任务等级] 任务名称";
FQ_FORMAT2 =		"[任务等级+] 任务名称";
FQ_FORMAT3 =		"[任务等级] 任务名称 (精英)";
--
FQ_EPA_PATTERN1 = 	"^(.+): %s*[-%d]+%s*/%s*[-%d]+%s*$";
FQ_EPA_PATTERN2 = 	"^(.+)\(已完成\)%s$";
FQ_EPA_PATTERN3 = 	"^(.+)完成。$";
FQ_EPA_PATTERN4 = 	"^获得经验值: .+$";
FQ_EPA_PATTERN5 = 	"^发现.+$";
FQ_EPA_PATTERN6 = 	"^(.+)\(完成\)%s$";
FQ_EPA_PATTERN7 = 	"^接受任务：.+$";
--
FQ_LOADED = 		"|cff00ffffFastQuest 2.11.3 载入. 输入 /fq 以取得更多的设定信息.";
FQ_INFO =			"|cff00ffff任务追踪: |r|cffffffff";
--
FQ_INFO_QUEST_TAG =		"显示任务追踪视窗困难度: ";
FQ_INFO_AUTOADD = 		"自动添加当前的任务到任务追踪视窗并移出已完成的任务: ";
FQ_INFO_AUTONOTIFY = 	"自动通知队友任务进展情况于队伍频道中: ";
FQ_INFO_AUTOCOMPLETE = 	"自动完成提交任务: ";
FQ_INFO_ALLOWGUILD = 	"在公会频道中通知任务进展: ";
FQ_INFO_ALLOWRAID = 	"在团队频道中通知任务进展: ";
FQ_INFO_ALWAYSNOTIFY = 	"总是通知任务进展: ";
FQ_INFO_DETAIL =		"详细的通知任务进展: ";
FQ_INFO_LOCK =			"任务追踪视窗已|cffff0000锁定|r|cffffffff";
FQ_INFO_UNLOCK =		"任务追踪视窗已|cff00ff00解锁|r|cffffffff";
FQ_INFO_NODRAG =		"移动任务追踪视窗现在是: ";
FQ_INFO_RESET = 		"重新设定任务追踪视窗为可移动";
FQ_INFO_FORMAT =		"选择在聊天框中显示任务名称的格式";
FQ_INFO_DISPLAY_AS =	"任务显示格式: ";
FQ_INFO_CLEAR =			"清除所有任务追踪视窗中的任务";
FQ_INFO_USAGE = 		"指令 /fastquest [command] 或 /fq [command]";
FQ_INFO_COLOR =			"在任务追踪视窗依任务难易度以不同的颜色显示任务标题: ";
--
FQ_MUST_RELOAD =		"你必需输入 /console reloadui 本功能才可作用";
--
FQ_USAGE_TAG =			"显示任务追踪视窗困难度 (菁英, 团队,等等) ";
FQ_USAGE_LOCK =			"任务追踪视窗";
FQ_USAGE_NODRAG =		"可否移动任务追踪视窗, 设定后须打 /console reloadui 才可作用";
FQ_USAGE_AUTOADD =		"添加当前的任务到任务跟踪栏并移出已完成的任务";
FQ_USAGE_AUTONOTIFY =	"通知队友任务进展于队伍频道中";
FQ_USAGE_AUTOCOMPLETE =	"自动完成提交任务";
FQ_USAGE_ALLOWGUILD =	"在公会频道中通知任务进展";
FQ_USAGE_ALLOWRAID =	"在团队频道中通知任务进展";
FQ_USAGE_ALWAYSNOTIFY =	"通知任务进展于非队伍频道";
FQ_USAGE_DETAIL =		"详细的通知任务进展情况";
FQ_USAGE_RESET =		"重新设定任务追踪视窗为可移动, 任务追踪视窗必须设为可移动";
FQ_USAGE_STATUS =		"显示所有任务追踪的设定状态";
FQ_USAGE_CLEAR =		"清除所有任务追踪视窗中的任务";
FQ_USAGE_FORMAT =		"(按 Ctrl 点选任务) 在聊天框中显示任务名称格式共4种每输入一次切换一种, 如:[10+]任务名称,[10]任务名称(精英)";
FQ_USAGE_COLOR =		"设定在任务追踪视窗中是否依任务难易度以不同的颜色显示任务标题.";
--
FQ_BINDING_CATEGORY_FASTQUEST		= "任务增强";
FQ_BINDING_HEADER_FASTQUEST			= "快速任务";
FQ_BINDING_NAME_FASTQUEST_T			= "任务追踪视窗困难度";
FQ_BINDING_NAME_FASTQUEST_F			= "选择聊天任务名称格式";
FQ_BINDING_NAME_FASTQUEST_AOUTP		= "自动通知队友";
FQ_BINDING_NAME_FASTQUEST_AOUTC		= "自动完成提交任务";
FQ_BINDING_NAME_FASTQUEST_AOUTA		= "自动添加任务追踪视窗";
FQ_BINDING_NAME_FASTQUEST_NOHEADERS	= "任务追踪视窗解锁/锁定";
--
FQ_SELECT_FORMAT =		"选择显示聊天任务名称的格式 (按住 Ctrl 点选任务)";
--
FQ_QUEST_PROGRESS =		"任务进度: ";
--
FQ_QUEST = 				"任务追踪: ";
FQ_QUEST_ISDONE =		"已完成! ";
FQ_QUEST_COMPLETED =	" (任务完成)";
FQ_DRAG_DISABLED =		"任务追踪: 移动任务追踪视窗现在是关闭的, 输入 /fq nodrag 来设定. 你必须重新载入 UI 来使这改变生效.";
--
FQ_ENABLED =			"|cff00ff00启动|r|cffffffff";
FQ_DISABLED =			"|cffff0000关闭|r|cffffffff";
FQ_LOCK =				"|cffff0000锁定|r|cffffffff";
FQ_UNLOCK =				"|cff00ff00解除|r|cffffffff";
--
end
