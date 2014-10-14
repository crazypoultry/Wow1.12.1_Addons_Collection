-- [[
-- AlphaMap v2.11.11100 Traditional Chinese Localization File
-- Initial Translated by: Arith Hsu (2006/07/21)
-- Maintained by: Arith Hsu
-- Last Updated: 2006/07/26
-- Comments:
--    2006/07/27 Arith: 翻譯這個插件的文字，工作量是很龐大的，特別是要去查詢各副本裡的 boss 名稱，還有一些對應的任務名稱和
--                      一些任務注意事項等。期望看到後續有人熱心維護這個翻譯，但是請尊重各個維護翻譯的人的辛勞，你可以把你
--                      的名字加在檔頭，但是請勿移除其他人的名字。
--                      使用簡體中文的朋友如果是拿這個正體中文檔案直接轉簡體，我也沒什麼意見，但是請一樣保留原翻譯者的記錄
--                      另外請注意，正體中文和簡體中文的翻譯還是有諸多的不一致，請自行修正。
-- Revision History:
--    7/26: Complete about 95% translations.
-- ]]

if ( GetLocale() == "zhTW" ) then

	SLASH_ALPHAMAPSLASH1 = "/AlphaMap";
	SLASH_ALPHAMAPSLASH2 = "/am";

	AM_SLASH_LOAD_HELP_USAGE	= "Alpha Map"

	BINDING_HEADER_ALPHAMAP		= "AlphaMap 按鍵設定";
	BINDING_NAME_TOGGLEALPHAMAP	= "顯示 AlphaMap";
	BINDING_NAME_INCREMENTALPHAMAP 	= "增加 AlphaMap 透明度";
	BINDING_NAME_DECREMENTALPHAMAP 	= "降低 AlphaMap 透明度";
	BINDING_NAME_CLEARVIEWALPHAMAP	= "顯示/隱藏所有的註記/圖示";
	BINDING_NAME_CYCLEWMMODE	= "循環切換世界地圖模式";
	BINDING_NAME_HOT_SPOT		= "熱點";

	--Colored State values
	ALPHA_MAP_GREEN_ENABLED = "|c0000FF00啟動|r";
	ALPHA_MAP_RED_DISABLED = "|c00FF0000取消|r";

	--Slash Help
	AM_SLASH_HELP_USAGE         = "AlphaMap 使用語法: /alphamap 或 /am:";
	AM_SLASH_HELP_ENABLE        = "/am enable - 開啟/重新開啟 AlphaMap";
	AM_SLASH_HELP_DISABLE       = "/am disable - 取消 AlphaMap";
	AM_SLASH_HELP_RESET         = "/am reset - 還原 AlphaMap 選項到預設值.";
	AM_SLASH_HELP_RAID          = "/am raid - 顯示團隊標示";
	AM_SLASH_HELP_PTIPS         = "/am ptips - 顯示隊伍提示";
	AM_SLASH_HELP_MNTIPS        = "/am mntips - 顯示地圖註記提示";
	AM_SLASH_HELP_GTIPS         = "/am gtips - 顯示採集提示";
	AM_SLASH_HELP_MNGTIPS       = "/am mngtips - 顯示地圖註記採集類提示";
	AM_SLASH_HELP_MOVESLIDER    = "/am moveslider - 打開移動滑動條";
	AM_SLASH_HELP_SLIDER        = "/am slider - 打開顯示滑動條";
	AM_SLASH_HELP_GATHERER      = "/am gatherer - 打開採集助手的支援";
	AM_SLASH_HELP_MAPNOTES      = "/am mapnotes - 打開地圖註記的支援";
	AM_SLASH_HELP_GATHERING     = "/am gathering - 打開地圖註記採集類的支援";
	AM_SLASH_HELP_AUTOCLOSE     = "/am combat - 啟動戰鬥時自動關閉";
	AM_SLASH_HELP_AUTOOPEN	    = "/am reopen - 啟動戰鬥結束後自動重新打開";
	AM_SLASH_HELP_WMCLOSE       = "/am wmclose - 啟動世界地圖關閉時自動關閉";
	AM_SLASH_HELP_LOCK          = "/am lock - 啟動 AlphaMap 的位置移動";
	AM_SLASH_HELP_SCALE         = "/am scale |c0000AA00<value>|r - 設定 Alphamap 視窗的比例 (範圍 0.0 - 1.0)";
	AM_SLASH_HELP_TOG           = "|c00FF0000/am tog  - 開啟 Alphamap 的顯示|r";
	AM_SLASH_HELP_ALPHA         = "/am alpha |c0000AA00<value>|r - 設定 Alphamap 的透明度 (範圍 0.0 - 1.0)";
	AM_SLASH_HELP_MINIMAP	    = "/am minimap - 開啟小地圖按鍵的顯示";
	AM_SLASH_HELP_HELP	    = "/am help  <OR>  /am ?  - 列出 AlphaMap 的所有命令語法";

	ALPHA_MAP_LOAD_CONFIRM = "|c0000BFFFAlphaMap |c0000FF00v."..ALPHA_MAP_VERSION.."|c0000BFFF 已經載入. - 輸入 "..SLASH_ALPHAMAPSLASH1.." 或 "..SLASH_ALPHAMAPSLASH2.." 以設定進階選項|r";

	ALPHA_MAP_ENABLED = "|c0000BFFFAlphaMap 現在已"..ALPHA_MAP_GREEN_ENABLED;
	ALPHA_MAP_DISABLED = "|c0000BFFFAlphaMap 現在已"..ALPHA_MAP_RED_DISABLED;

	ALPHA_MAP_UI_LOCKED = "AlphaMap: 使用者界面 |c00FF0000鎖定|r.";
	ALPHA_MAP_UI_UNLOCKED = "AlphaMap: 使用者界面 |c0000FF00解鎖|r.";
	ALPHA_MAP_UI_LOCK_HELP = "如果這個選項被勾選, AlphaMap 的顯示位置將會被鎖定並且不能被移動.";

	ALPHA_MAP_DISABLED_HINT = "提示: AlphaMap 已"..ALPHA_MAP_RED_DISABLED..".  輸入 |C0000AA00'/am Enable'|R 來重新啟動.";

	ALPHA_MAP_CONFIG_SLIDER_STATE       = "AlphaMap: 滑動條移動 ";
	ALPHA_MAP_CONFIG_COMBAT_STATE       = "AlphaMap: 戰鬥時自動關閉 ";
	ALPHA_MAP_CONFIG_REOPEN_STATE	    = "AlphaMap: 戰鬥後重新開啟 ";
	ALPHA_MAP_CONFIG_RAID_STATE         = "AlphaMap: 團隊圖示 ";
	ALPHA_MAP_CONFIG_PTIPS_STATE        = "AlphaMap: 小隊/團隊提示資訊 ";
	ALPHA_MAP_CONFIG_MNTIPS_STATE       = "AlphaMap: 地圖標記提示資訊 ";
	ALPHA_MAP_CONFIG_MNGTIPS_STATE      = "AlphaMap: 地圖標記採集類提示資訊 ";
	ALPHA_MAP_CONFIG_GTIPS_STATE        = "AlphaMap: 採集助手提示資訊 ";
	ALPHA_MAP_CONFIG_WMCLOSE_STATE      = "AlphaMap: 關閉世界地圖時關閉 ";
	ALPHA_MAP_CONFIG_GATHERING_STATE    = "AlphaMap: 支援地圖標記採集類";
	ALPHA_MAP_CONFIG_GATHERER_STATE     = "AlphaMap: 支持採集助手 ";
	ALPHA_MAP_CONFIG_MAPNOTES_STATE     = "AlphaMap: 支援地圖標記";

	AM_OPTIONS			= "選項";
	AM_OPTIONS_TITLE		= "AlphaMap "..AM_OPTIONS;
	AM_OPTIONS_RESET		= "重設";
	AM_OPTIONS_CLOSE		= "關閉";
	AM_OPTIONS_MAPNOTES		= "啟動地圖註記";
	AM_OPTIONS_MAPNOTES_TOOLTIPS	= "顯示地圖註記提示資訊";
	AM_OPTIONS_MAPNOTESG		= "啟動地圖註記採集類圖示";
	AM_OPTIONS_MAPNOTESG_TOOLTIPS 	= "顯示地圖註記採集類提示訊息";
	AM_OPTIONS_GATHERER		= "啟動採集助手圖示";
	AM_OPTIONS_GATHERER_TOOLTIPS	= "顯示採集助手提示資訊";
	AM_OPTIONS_PARTY_TOOLTIPS	= "顯示團隊提示資訊";
	AM_OPTIONS_RAID_PINS		= "啟動團隊圖示";
	AM_OPTIONS_SLIDER		= "在地圖上顯示透明度滑動條";
	AM_OPTIONS_SLIDER_MOVE		= "允許移動透明度滑動條";
	AM_OPTIONS_AUTOCLOSE_COMBAT	= "戰鬥開始時自動關閉";
	AM_OPTIONS_AUTOOPEN_COMBAT	= "戰鬥結束後自動打開";
	AM_OPTIONS_AUTOCLOSE_WORLDMAP	= "關閉世界地圖時自動關閉";
	AM_OPTIONS_ANGLESLIDER		= "小地圖角度: ";
	AM_OPTIONS_RADIUSLIDER		= "小地圖半徑: ";
	AM_OPTIONS_ALPHASLIDER		= "地圖透明度: ";
	AM_OPTIONS_SCALESLIDER		= "地圖大小: ";
	AM_OPTIONS_MAP_LOCK		= "鎖定 AlphaMap 位置";
	AM_OPTIONS_MINIMAP		= "顯示小地圖按鍵";
	AM_OPTIONS_CLEARVIEW_OFF	= "隱藏已啟動的圖示";
	AM_OPTIONS_CLEARVIEW_ON		= "|c00FF0000所有的圖示都已隱藏|r";
	AM_OPTIONS_LEGACYPLAYER		= "顯示傳統格式的玩家圖示";
	AM_OPTIONS_ZONE_SELECTOR	= "顯示地圖選擇器";
	AM_OPTIONS_GENERAL		= "一般";
	AM_OPTIONS_GENERAL_CHAT		= "一般對話";
	AM_OPTIONS_DUNGEON		= "地下城";
	AM_OPTIONS_MAPS			= "地圖選擇器";
	AM_OPTIONS_ADDONS		= "世界地圖註記和圖示: ";
	AM_OPTIONS_MISC			= "內部的插件選項: ";
	AM_OPTIONS_DUNGEON_NOTES	= "地下城註記選項: ";
	AM_OPTIONS_DUNGEON_FRAMES	= "地下城額外的資訊: ";
	AM_OPTIONS_DM_NOTES		= "顯示地下城註記";
	AM_OPTIONS_DM_NOTES_TOOLTIPS	= "顯示地下城註記的提示資訊";
	AM_OPTIONS_DM_NOTES_BCKGRND	= "顯示註記的背景";
	AM_OPTIONS_DM_NBG_SET		= "設定註記的背景顏色";
	AM_OPTIONS_DM_HEADER		= "顯示置頂資訊";
	AM_OPTIONS_DM_EXTRA		= "顯示註腳資訊";
	AM_OPTIONS_DM_KEY		= "顯示地圖鑰匙";
	AM_OPTIONS_DM_KEY_TOOLTIPS	= "顯示地圖要時提示資訊";
	AM_OPTIONS_DM_SAVE_LABEL	= "所有副本地圖的控制設定: ";
	AM_OPTIONS_DM_ALL		= "套用變更到所有副本地圖";
	AM_OPTIONS_DM_SAVE		= "套用到所有的副本地圖";
	AM_OPTIONS_RESTORE		= "套用";
	AM_MISC				= "雜項";
	AM_OPTIONS_DM_MISC		= AM_MISC.." : ";
	AM_OPTIONS_DM_MAP_BCKGRND	= "顯示地圖背景";
	AM_OPTIONS_DM_MBG_SET		= "設定地圖背景顏色";
	AM_OPTIONS_MAP_BOXES		= "AlphaMap 的位置調整:";
	AM_OPTIONS_UNDOCKED		= "AlphaMap 的位置調整現在已";
	AM_OPTIONS_FREE			= "自由浮動";
	AM_OPTIONS_FREE_LOCKED		= "(鎖定)";
	AM_OPTIONS_MAPPED		= "依附於 AlphaMap";
	AM_OPTIONS_DOCK_IT		= "與選項窗隔連結";
	AM_OPTIONS_FREE_IT		= "自由浮動";
	AM_OPTIONS_MAP_IT		= "依附於 AlphaMap";
	AM_OPTIONS_HOW_TO_MAP		= "AlphaMap 固定於: ";
	AM_OPTIONS_MAP_LINK		= "到";
	AM_OPTIONS_HOTSPOT_BEHAVE	= "熱點的行為: ";
	AM_OPTIONS_HOTSPOT_DISABLE	= "啟動熱點功能";
	AM_OPTIONS_HOTSPOT_OPEN		= "若 AlphaMap 關閉則開啟";
	AM_OPTIONS_HOTSPOT_OPACITY	= "完整顯示 AlphaMap";
	AM_OPTIONS_HOTSPOT_WORLDI	= "開啟世界圖示/註記";
	AM_OPTIONS_HOTSPOT_DUNGI	= "開啟地下城 AlphaMap 註記";
	AM_OPTIONS_HOTSPOT_NBG		= "開啟註記背景";
	AM_OPTIONS_HOTSPOT_MBG		= "開啟地圖背景";
	AM_OPTIONS_HOTSPOT_MINIMAP	= "啟動小地圖按鍵為熱點";
	AM_OPTIONS_HOTSPOT_INFO		= "開啟按鍵/置頂/註腳";
	AM_OPTIONS_BG_USE_AM		= "在戰場使用界面地圖";
	AM_OPTIONS_BG_SAVE_LABEL	= "所有戰場地圖的控制設定: ";
	AM_OPTIONS_BG_ALL		= "將變動套用到所有戰場地圖";
	AM_OPTIONS_BG_SAVE		= "套用到所有的戰場地圖";
	AM_OPTIONS_RAID_SAVE_LABEL	= "Control Settings for all Non-Instance Maps :";
	AM_OPTIONS_RAID_ALL		= "Changes affect ALL Non-Instance Maps";
	AM_OPTIONS_RAID_SAVE		= "Apply to ALL Non-Instance Maps";
	AM_OPTIONS_BG_MESSAGES		= "將戰場訊息送到: ";
	AM_OPTIONS_RAID			= "團隊";
	AM_OPTIONS_PARTY		= "隊伍";
	AM_OPTIONS_GENERAL		= "綜合";
	AM_OPTIONS_GUILD		= "公會";
	AM_OPTIONS_GROUP_DEFAULT	= "Group Dependant";
	AM_OPTIONS_NUN_AUTO		= "自動送出 NuN 註記的設定";
	AM_OPTIONS_NUN_FORMAT		= "送出格式化的註記";
	AM_OPTIONS_NUN_MESSAGES		= "自動送出 NuN 註記給: ";
	AM_OPTIONS_WMAP_MODES		= "世界地圖顯示模式:";
	AM_OPTIONS_GMAP_MODES		= "Blizzard Map Settings :";
	AM_OPTIONS_GMAP_ALLOW		= "Allow changes to Blizzard Map";
	AM_OPTIONS_GMAP_CHANGE		= "Check to change Blizzard Map";
	AM_OPTIONS_WMAP_SMODE		= "標準模式";
	AM_OPTIONS_WMAP_OMODE		= "緊密模式";
	AM_OPTIONS_WMAP_MINIMODE	= "小地圖材質";
	AM_OPTIONS_WMAP_ZMINIMODE	= "放大小地圖";
	AM_OPTIONS_WMOTHER		= "其他的地圖控制: ";
	AM_OPTIONS_WM_ESCAPE		= "啟動 <ESC> 關閉功能";
	AM_OPTIONS_WM_MOUSE		= "啟動滑鼠互動模式";
	AM_OPTIONS_MUTE			= "Mute";
	AM_OPTIONS_COORDS		= "(x, y)";
	AM_OPTIONS_MAPS1		= "AlphaMap 地圖 1";
	AM_OPTIONS_MAPS2		= "  ..... 2";

	AM_INSTANCE_TITLE_LOCATION	= "地點 ";
	AM_INSTANCE_TITLE_LEVELS	= "等級 ";
	AM_INSTANCE_TITLE_PLAYERS	= "玩家上限 ";
	AM_INSTANCE_CHESTS		= "箱子 ";
	AM_INSTANCE_STAIRS		= "階梯";
	AM_INSTANCE_ENTRANCES		= "入口 ";
	AM_INSTANCE_EXITS		= "出口 ";
	AM_LEADSTO			= "通往...";
	AM_INSTANCE_PREREQS		= "前提: ";
	AM_INSTANCE_GENERAL		= "一般註記: ";
	AM_RARE				= "(稀有)";
	AM_VARIES			= "(多個位置)";
	AM_WANDERS			= "(巡邏)";
	AM_OPTIONAL			= "(可選擇)";

	AM_NO_LIMIT			= "沒有玩家限制";

	AM_MOB_LOOT 			= "小怪掉落";
	AM_RBOSS_DROP 			= "首領隨機掉落";
	AM_ENCHANTS			= "附魔";
	AM_CLASS_SETS			= "職業套裝";
	AM_TIER0_SET			= "T0 套裝";
	AM_TIER1_SET			= "T1 套裝";
	AM_TIER2_SET			= "T2 套裝";
	AM_TIER3_SET			= "T3 套裝";
	AM_PVP_SET			= "PVP 套裝";

	AM_ANCHOR_POINT 	= {	{ Display = "頂端",			-- Localise
					  Command = "TOP" },					-- Do NOT Localise
					{ Display = "右上方",		-- Localise
					  Command = "TOPRIGHT" },				-- Do NOT Localise
					{ Display = "右邊",			-- Localise
					  Command = "RIGHT" },					-- Do NOT Localise
					{ Display = "右下方",		-- Localise
					  Command = "BOTTOMRIGHT" },				-- Do NOT Localise
					{ Display = "底端",			-- Localise
					  Command = "BOTTOM" },					-- Do NOT Localise
					{ Display = "左下方",		-- Localise
					  Command = "BOTTOMLEFT" },				-- Do NOT Localise
					{ Display = "左邊",			-- Localise
					  Command = "LEFT" },					-- Do NOT Localise
					{ Display = "左上方",		-- Localise
					  Command = "TOPLEFT" }					-- Do NOT Localise
				};

	AM_BG_BASE			= "Base";
	AM_BG_BASES			= "Bases";
	AM_BG_REQUIRED			= "Required to Win !";

	AM_EXTERIOR = " 外部";

	AM_RCMENU_INC			= " Inc ";		-- as in 5 inc Blacksmith   or  3 inc farm
	AM_RCMENU_ZERG			= "Zerg";		-- as in Zerg Inc Frostwolf GY
	AM_OK				= "OK";
	AM_RCMENU_HIGHLIGHT		= "Highlight";		-- as in leave this note highlighted on the map
	AM_RCMENU_NUN_AUTO		= "自動傳送註記";	-- send the NotesUNeed note for the current map note to Raid/Party/...
	AM_RCMENU_NUN_MAN		= "手動傳送註記";
	AM_RCMENU_NUN_OPEN		= "打開註記";
	AM_RCMENU_AFLAG			= "聯盟旗幟 ";
	AM_RCMENU_HFLAG			= "部落旗幟 ";
	AM_RCMENU_FLAGLOC		= {	"Our Tunnel",
						"Our Roof",
						"Going West",
						"Going East",
						"In Middle",
						"Their Tunnel",
						"Their Roof",
						"Their Flag Room",
						"Their GY"
					};

	AM_OPENING = "AQ Opening Quest Chain";

	AM_HORDE		= "Horde";
	AM_PICKED		= { 	word = "picked",
					posWord = " by ",
					extraChars = 1 };

	-- Deutsch
	--AM_PICKED		= {	word = "aufgenommen" };

	-- Francais
	--AM_PICKED		= {	word = "ramass\195\169",
	--				posWord = " par ",
	--				extraChars = 2 };

	AM_NEUTRAL		= "中立";
	AM_FRIENDLY		= "友善";
	AM_HONOURED		= "尊敬";
	AM_REVERED		= "崇敬";
	AM_EXALTED		= "崇拜";

	AM_CONFIG_SAVED			= "AlphaMap Settings changed for : ";

	AM_CANCEL			= "取消";

	--------------------------------------------------------------------------------------------------------------------------------------
	-- TOOLTIPS															    --
	--------------------------------------------------------------------------------------------------------------------------------------

	AM_TT_MINIMAP_BUTTON		= "AlphaMap\n按滑鼠左鍵開啟 AlphaMap\n按滑鼠右鍵開啟選項設定";
	AM_TT_ALPHA_BUTTON1		= "AlphaMap";
	AM_TT_ALPHA_BUTTON2		= "按滑鼠左鍵開啟 AlphaMap\n按滑鼠右鍵開啟選項設定";


	--------------------------------------------------------------------------------------------------------------------------------------
	-- Everything below should be localised apart from the 'filename', 'lootid' entries which should NOT be changed                               --
	-- The first  'name'  field is used to equate with in game Zone name information to help determine when the player is in a specific --
	-- Instance, and must therefore be spelt IDENTICALLY to the names of the Instances as displayed by the WoW Client in other native   --
	-- frames.															    --
	--------------------------------------------------------------------------------------------------------------------------------------

	AM_TYP_WM			= "世界地圖";
	AM_TYP_INSTANCE 		= "副本";
	AM_TYP_BG			= "戰場";
	AM_TYP_RAID			= "非副本地圖";
	AM_TYP_GM			= "Blizzard Map";

	AM_ALPHAMAP_LIST = {
			{	name = "黑暗深淵",			-- Blackfathom Deeps
				type = AM_TYP_INSTANCE,
				displayname = "黑暗深淵",
				displayshort = "BFD",
				filename = "BlackfathomDeeps",
				location = "梣谷 (14, 14)",
				levels = "24-32",
				players = "10",
				prereq = "",
				general = "一些水下的區域",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {33, 10} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {50, 68} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "加摩拉", colour = AM_RED, coords = { {23.5, 42} }, symbol = { "1" },
						tooltiptxt = "Lvl25 菁英野獸 (巨型烏龜)", lootid = "BFDGhamoora" },
				dtl4  = { text = "潮濕的便箋", colour = AM_ORANGE, coords = { {23.5, 30} }, symbol = { "2" },
						tooltiptxt = "'深淵的知識' 任務物品,\n箱子中" },
				dtl5  = { text = "薩利維絲", colour = AM_RED, coords = { {3, 29} }, symbol = { "3" },
						tooltiptxt = "Lvl25 菁英人形怪", lootid = "BFDLadySarevess" },
				dtl6  = { text = "銀月守衛塞爾瑞德", colour = AM_BLUE, coords = { {11, 51} }, symbol = { "4" },
						tooltiptxt = "'尋找塞爾瑞德'任務的搜尋目標,\n也是'黑暗深淵中的惡魔'任務的開始" },
				dtl7  = { text = "格裏哈斯特", colour = AM_RED, coords = { {43, 40} }, symbol = { "5" },
						tooltiptxt = "Lvl25 菁英人形怪 (魚人)", lootid = "BFDGelihast" },
				dtl8  = { text = "洛古斯‧傑特", colour = AM_RED, coords = { {49, 43}, {55, 46} }, symbol = { "6" },
						tooltiptxt = "Lvl26 菁英人形怪", special = AM_VARIES },
				dtl9  = { text = "阿奎尼斯男爵", colour = AM_RED, coords = { {52, 76} }, symbol = { "7" },
						tooltiptxt = "Lvl28 菁英人形怪", lootid = "BFDBaronAquanis" },
				dtl10 = { text = "深淵之核", colour = AM_BLUE, coords = { {52, 76} }, symbol = { " " },
						tooltiptxt = "部落'廢墟之間'任務物品" },
				dtl11 = { text = "夢遊者克爾裏斯", colour = AM_RED, coords = { {63, 81} }, symbol = { "8" },
						tooltiptxt = "Lvl27 菁英人形怪", lootid = "BFDTwilightLordKelris" },
				dtl12 = { text = "Blackfathom-Tiefen Altar", colour = AM_BLUE, coords = { {63, 81} }, symbol = { " " },
						tooltiptxt = "" },
				dtl13 = { text = "瑟拉吉斯", colour = AM_RED, coords = { {63, 74} }, symbol = { "9" },
						tooltiptxt = "Lvl26 菁英野獸", lootid = "BFDOldSerrakis" },
				dtl14 = { text = "阿庫邁爾", colour = AM_RED, coords = { {95, 85} }, symbol = { "10" },
						tooltiptxt = "Lvl29 菁英野獸 (水蛇)", lootid = "BFDAkumai", leaveGap = 1 },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "BFDTrash", leaveGap = 1 }
			},

			{	name = "黑石深淵",			-- Blackrock Depths
				type = AM_TYP_INSTANCE,
				displayname = "黑石深淵",
				displayshort = "BRD",
				filename = "BlackrockDepths",
				location = "黑石山",
				levels = "52-60",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {21, 83} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "洛考爾", colour = AM_RED, coords = { {33, 80} }, symbol = { "1" },
						tooltiptxt = "Lvl51 菁英元素怪", lootid = "BRDLordRoccor" },
				dtl3  = { text = "審訊官格斯塔恩", colour = AM_RED, coords = { {38, 95} }, symbol = { "2" },
						tooltiptxt = "Lvl52 菁英人形怪", lootid = "BRDHighInterrogatorGerstahn" },
				dtl4  = { text = "溫德索爾元帥", colour = AM_BLUE, coords = { {46, 95} }, symbol = { "3" },
						tooltiptxt = "將連結到奧妮克希亞系列任務" },
				dtl5  = { text = "指揮官哥沙克", colour = AM_BLUE, coords = { {40, 90} }, symbol = { "4" },
						tooltiptxt = "部落'指揮官哥沙克'任務" },
				dtl6  = { text = "卡蘭‧巨錘", colour = AM_BLUE, coords = { {44, 86} }, symbol = { "5" },
						tooltiptxt = "聯盟'卡蘭‧巨錘'任務" },
				dtl7  = { text = "法律之環", colour = AM_GREEN, coords = { {42, 73.4} }, symbol = { "6" },
						tooltiptxt = "在此將所有怪物殺死以使\n上層的觀眾從紅色的侵略形轉為\n黃色中立", lootid = "BRDArena" },
				dtl8  = { text = "瑟爾倫", colour = AM_RED, coords = { {42, 73.4} }, symbol = { " " },
						tooltiptxt = "NPC 群領隊", lootid = "BRDArena" },
				dtl9  = { text = "弗蘭克羅恩‧鑄鐵", colour = AM_BLUE, coords = { {45.8, 78.1} }, symbol = { "7" },
						tooltiptxt = "'黑鐵的遺產' 任務" },
				dtl10  = { text = "控火師羅格雷恩", colour = AM_RED, coords = { {48, 78} }, symbol = { "8" },
						tooltiptxt = "Lvl52 菁英人形怪", special = AM_RARE, lootid = "BRDPyromantLoregrain" },
				dtl11 = { text = "黑色寶庫", colour = AM_GREEN, coords = { {54, 54} }, symbol = { "9" },
						tooltiptxt = "" },
				dtl12  = { text = "弗諾斯‧達克維爾", colour = AM_RED, coords = { {55, 41} }, symbol = { "10" },
						tooltiptxt = "Lvl54 菁英人形怪", lootid = "BRDFineousDarkvire" },
				dtl13 = { text = "典獄官斯迪爾基斯", colour = AM_RED, coords = { {48, 55} }, symbol = { "11" },
						tooltiptxt = "Lvl56 菁英人形怪", lootid = "BRDWarderStilgiss" },
				dtl14 = { text = "維雷克", colour = AM_RED, coords = { {54, 54} }, symbol = { " " },
						tooltiptxt = "Lvl55 菁英" },
				dtl15 = { text = "伊森迪奧斯", colour = AM_RED, coords = { {48.7, 48.1} }, symbol = { "12" },
						tooltiptxt = "'伊森迪奧斯!' 任務", lootid = "BRDLordIncendius" },
				dtl16 = { text = "黑鐵砧", colour = AM_RED, coords = { {48.7, 48.1} }, symbol = { " " },
						tooltiptxt = "" },
				dtl17 = { text = "暗爐之鎖", colour = AM_GREEN, coords = { {31, 72.4} }, symbol = { "13" },
						tooltiptxt = "打開鎖以使你可以進入更高層的區域\n需要暗爐鑰匙" },
				dtl18 = { text = "貝爾加", colour = AM_RED, coords = { {8, 62} }, symbol = { "14" },
						tooltiptxt = "Lvl57 菁英巨人", lootid = "BRDBaelGar" },
				dtl19 = { text = "安格弗將軍", colour = AM_RED, coords = { {24, 64} }, symbol = { "15" },
						tooltiptxt = "Lvl57 菁英矮人", lootid = "BRDGeneralAngerforge" },
				dtl20 = { text = "傀儡統帥阿格曼奇", colour = AM_RED, coords = { {24, 51} }, symbol = { "16" },
						tooltiptxt = "Lvl58 菁英矮人", lootid = "BRDGolemLordArgelmach" },
				dtl21 = { text = "黑鐵酒吧", colour = AM_GREEN, coords = { {40, 50} }, symbol = { "17" },
						tooltiptxt = "購買六個黑鐵酒杯\n並且將其給予羅克諾特下士", lootid = "BRDGuzzler" },
				dtl22 = { text = "弗萊拉斯大使", colour = AM_RED, coords = { {46, 38} }, symbol = { "18" },
						tooltiptxt = "Lvl57 菁英人形怪", lootid = "BRDFlamelash" },
				dtl23 = { text = "無敵的潘佐爾", colour = AM_RED, coords = { {40, 27} }, symbol = { "19" },
						tooltiptxt = "Lvl57 菁英傀儡", special = AM_RARE, lootid = "BRDPanzor" },
				dtl24 = { text = "召喚者之墓", colour = AM_GREEN, coords = { {46, 18} }, symbol = { "20" },
						tooltiptxt = "依序擊敗七個小王後便可進入夠深處\n箱子", lootid = "BRDTomb" },
				dtl25 = { text = "講學廳", colour = AM_GREEN, coords = { {61, 8.5} }, symbol = { "21" },
						tooltiptxt = "找到並且擊敗兩個暗爐持火者\n並點燃兩個火炬\n打死地一個持火者後只有三分鐘的時間" },
				dtl26 = { text = "瑪格姆斯", colour = AM_RED, coords = { {78, 8.5} }, symbol = { "22" },
						tooltiptxt = "Lvl57 菁英巨人", lootid = "BRDMagmus" },
				dtl27 = { text = "鐵爐堡公主茉艾拉‧銅鬚", colour = AM_RED, coords = { {90, 8} }, symbol = { "23" },
						tooltiptxt = "Lvl58 菁英人形怪", lootid = "BRDPrincess" },
				dtl28 = { text = "達格蘭‧索瑞森大帝", colour = AM_RED, coords = { {93, 8.5} }, symbol = { "24" },
						tooltiptxt = "Lvl59 菁英人形怪", lootid = "BRDImperatorDagranThaurissan" },
				dtl29 = { text = "黑熔爐", colour = AM_GREEN, coords = { {63, 22} }, symbol = { "23" },
						tooltiptxt = "融煉黑鐵錠,\n也是製作濃煙山脈之心的地方" },
				dtl30 = { text = "熔火之心", colour = AM_ORANGE, coords = { {65, 30} }, symbol = { "24" },
						tooltiptxt = "'熔火之心的傳送門' 任務\n熔火之心入口", toMap = "熔火之心", leaveGap = 1 }
			},

			{	name = "黑石塔",		-- Blackrock Spire
				type = AM_TYP_INSTANCE,
				displayname = "黑石塔 (下層)",
				displayshort = "LBRS",
				filename = "LBRS",			-- LBRS
				location = "黑石山",
				levels = "53-60",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {9, 10} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "黑石塔 (上層)", colour = AM_BLUE, coords = { {22, 4} }, symbol = { "U" },
						tooltiptxt = "", toMap = "黑石塔 (上層)" },
				dtl3  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {45.2, 29}, {73, 46} }, symbol = { "x1" },
						tooltiptxt = "" },
				dtl4  = { text = "通往歐莫克大王的橋", colour = AM_GREEN, coords = { {38, 32.1}, {15, 32.1} }, symbol = { "B" },
						tooltiptxt = "" },
				dtl5  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {71, 22}, {94, 26} }, symbol = { "x2" },
						tooltiptxt = "下層" },
				dtl6  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {29, 53}, {29, 77} }, symbol = { "x3" },
						tooltiptxt = "" },
				dtl7  = { text = "斜坡", colour = AM_BLUE, coords = { {86, 40}, {89, 58} }, symbol = { "R" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "維埃蘭", colour = AM_RED, coords = { {31, 17} }, symbol = { "1" },
						tooltiptxt = "Lvl55 菁英\n'晉升印章'任務"  },
				dtl9  = { text = "瓦羅什", colour = AM_RED, coords = { {53, 14} }, symbol = { "2" },
						tooltiptxt = "Lvl60 菁英人形怪"  },
				dtl10 = { text = "尖銳長矛", colour = AM_ORANGE, coords = { {69, 29} }, symbol = { "3" },
						tooltiptxt = "任務物品"  },
				dtl11 = { text = "寶鑽", colour = AM_BLUE, coords = { {62, 25 } }, symbol = { "4" },
						tooltiptxt = "寶鑽任務系列\n不在下層" },
				dtl12 = { text = "尖石屠夫", colour = AM_RED, coords = { {42, 32.1} }, symbol = { "5" },
						tooltiptxt = "Lvl59 菁英人形怪\n在通往歐莫克大王的橋上巡邏", lootid = "LBRSSpirestoneButcher", special = AM_RARE  },
				dtl13 = { text = "歐莫克大王", colour = AM_RED, coords = { {2, 32.1} }, symbol = { "6" },
						tooltiptxt = "Lvl?? 菁英人形怪", lootid = "LBRSOmokk"  },
				dtl14 = { text = "尖石統帥", colour = AM_RED, coords = { {2, 32.1} }, symbol = { " " },
						tooltiptxt = "在歐莫克大王附近的小丘上", lootid = "LBRSSpirestoneLord", special = AM_RARE },
				dtl15 = { text = "暗影獵手沃什加斯", colour = AM_RED, coords = { {77, 64} }, symbol = { "7" },
						tooltiptxt = "Lvl?? 菁英人形怪", lootid = "LBRSVosh"  },
				dtl16 = { text = "第五塊摩沙魯石板", colour = AM_ORANGE, coords = { {77, 68} }, symbol = { "8" },
						tooltiptxt = "任務物品"  },
				dtl17 = { text = "班諾克‧巨斧", colour = AM_RED, coords = { {41.5, 26.5} }, symbol = { "9" },
						tooltiptxt = "Lvl59 菁英人形怪\n在下層", lootid = "LBRSGrimaxe", special = AM_RARE },
				dtl18 = { text = "維姆薩拉克", colour = AM_RED, coords = { {73, 32} }, symbol = { "10" },
						tooltiptxt = "Lvl59 菁英人形怪", lootid = "LBRSVoone" },
				dtl19 = { text = "第六塊摩沙魯石板", colour = AM_ORANGE, coords = { {75, 29} }, symbol = { "11" },
						tooltiptxt = "任務物品"  },
				dtl20 = { text = "莫爾‧灰蹄", colour = AM_RED, coords = { {75, 35} }, symbol = { "12" },
						tooltiptxt = "Lvl60 菁英\n需要召喚火盆\n需中斷其治療", lootid = "LBRSGrayhoof" },
				dtl21  = { text = "煙網蛛后", colour = AM_RED, coords = { {54, 58} }, symbol = { "13" },
						tooltiptxt = "Lvl59 菁英野獸", lootid = "LBRSSmolderweb"  },
				dtl22 = { text = "水晶之牙", colour = AM_RED, coords = { {36, 49} }, symbol = { "14" },
						tooltiptxt = "Lvl60 菁英野獸", special = AM_RARE, lootid = "LBRSCrystalFang"  },
				dtl23 = { text = "烏洛克", colour = AM_RED, coords = { {30, 30} }, symbol = { "15" },
						tooltiptxt = "Lvl60 菁英人形怪", lootid = "LBRSDoomhowl"  },
				dtl24 = { text = "軍需官茲格雷斯", colour = AM_RED, coords = { {50, 89} }, symbol = { "16" },
						tooltiptxt = "Lvl59 菁英人形怪", lootid = "LBRSZigris"  },
				dtl25 = { text = "哈雷肯", colour = AM_RED, coords = { {19, 92} }, symbol = { "17" },
						tooltiptxt = "Lvl59 菁英野獸\nKill to trigger spawn of Gizrul", lootid = "LBRSHalycon"  },
				dtl26 = { text = "奴役者基茲盧爾", colour = AM_RED, coords = { {19, 92} }, symbol = { " " },
						tooltiptxt = "Lvl60 菁英野獸\n在哈雷肯死後被觸發產生", lootid = "LBRSSlavener"  },
				dtl27 = { text = "維姆薩拉克", colour = AM_RED, coords = { {42, 62} }, symbol = { "18" },
						tooltiptxt = "Lvl?? 菁英龍", lootid = "LBRSWyrmthalak", leaveGap = 1  },
				dtl28 = { text = AM_TIER0_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T0SET", leaveGap = 1 },
				dtl29 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "LBRSTrash", leaveGap = 1 }
			},

			{	name = "黑石塔 (上層)",
				type = AM_TYP_INSTANCE,
				displayname = "黑石塔 (上層)",
				displayshort = "UBRS",
				filename = "UBRS",			-- UBRS
				location = "黑石山",
				levels = "53-60",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {3, 80.7} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "黑石塔 (下層)", colour = AM_BLUE, coords = { {18.2, 86.6} }, symbol = { "L" },
						tooltiptxt = "", toMap = "黑石塔", leaveGap = 1 },
				dtl3  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {11.9, 58.4}, {8.65, 25} }, symbol = { "x1" },
						tooltiptxt = "" },
				dtl4  = { text = "烈焰衛士艾博希爾", colour = AM_RED, coords = { {8.2, 31.0} }, symbol = { "1" },
						tooltiptxt = "Lvl?? 菁英元素怪", lootid = "UBRSEmberseer", leaveGap = 1  },
				dtl5  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {8.6, 38.9}, {36.4, 61.2} }, symbol = { "x2" },
						tooltiptxt = "" },
				dtl6  = { text = "末日扣環", colour = AM_ORANGE, coords = { {41.3, 68.65} }, symbol = { "2" },
						tooltiptxt = "任務物品\n在一堆傾倒的柱子附近的箱子裡\n不是很容易可以被看見\n可以從達基薩斯將軍的房間跳下"  },
				dtl7  = { text = "烈焰之父", colour = AM_ORANGE, coords = { {50, 65.45} }, symbol = { "3" },
						tooltiptxt = "在靠近通到的底端\n先避免龍蛋孵化再去開啟", lootid = "UBRSFLAME"  },
				dtl8  = { text = "索拉卡‧火冠", colour = AM_RED, coords = { {50, 65.45} }, symbol = { " " },
						tooltiptxt = "Lvl60 菁英龍族\n在拾取烈焰之父之後出現", lootid = "UBRSSolakar" },
				dtl9  = { text = "傑德", colour = AM_RED, coords = { {47, 52.6} }, symbol = { "4" },
						tooltiptxt = "Lvl59 菁英人形怪", special = AM_RARE, lootid = "UBRSRunewatcher"  },
				dtl10 = { text = "古拉魯克", colour = AM_RED, coords = { {34, 52.6} }, symbol = { "5" },
						tooltiptxt = "Lvl61 菁英人形怪", lootid = "UBRSAnvilcrack"  },
				dtl11 = { text = "大酋長雷德‧黑手", colour = AM_RED, coords = { {67.5, 51} }, symbol = { "6" },
						tooltiptxt = "首領\n僅限部落的'為了部落'任務\n騎著蓋斯下來", lootid = "UBRSRend"  },
				dtl12  = { text = "蓋斯", colour = AM_RED, coords = { {67.5, 51} }, symbol = { " " },
						tooltiptxt = "Lvl?? 菁英龍", lootid = "UBRSGyth" },
				dtl13 = { text = "奧比", colour = AM_BLUE, coords = { {68.1, 65.9} }, symbol = { "7" },
						tooltiptxt = "僅限於'監護者'任務"  },
				dtl14 = { text = "比斯巨獸", colour = AM_RED, coords = { {95.7, 60.8} }, symbol = { "8" },
						tooltiptxt = "Lvl?? 菁英野獸", lootid = "UBRSBeast"  },
				dtl15 = { text = "瓦薩拉克", colour = AM_RED, coords = { {95.7, 56.5} }, symbol = { "9" },
						tooltiptxt = "Lvl?? 菁英\n需有任務才可召喚\n先將黑手大廳清完後再召喚", lootid = "UBRSValthalak" },
				dtl16  = { text = "達基薩斯將軍", colour = AM_RED, coords = { {41.6, 73.2} }, symbol = { "10" },
						tooltiptxt = "Lvl?? 菁英龍", lootid = "UBRSDrakkisath"  },
				dtl17 = { text = "黑翼之巢", colour = AM_BLUE, coords = { {78.5, 27.6} }, symbol = { "BWL" },
						tooltiptxt = "", toMap = "黑翼之巢", leaveGap = 1 },
				dtl18 = { text = AM_TIER0_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T0SET", leaveGap = 1 },
				dtl19 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "UBRSTrash", leaveGap = 1 }
			},

			{	name = "黑翼之巢",		-- Blackwing Lair
				type = AM_TYP_INSTANCE,
				displayname = "黑翼之巢",
				displayshort = "BWL",
				filename = "BlackwingLair",
				location = "黑石塔",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {65, 72} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "黑石塔 (上層)", leaveGap = 1 },
				dtl2 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {32.8, 78}, {61, 48} }, symbol = { "x1" },
						tooltiptxt = "" },
				dtl3 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {40, 96}, {68, 65} }, symbol = { "x2" },
						tooltiptxt = "" },
				dtl4 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {47, 51}, {17, 52} }, symbol = { "x3" },
						tooltiptxt = "", leaveGap = 1 },
				dtl5  = { text = "狂野的拉佐格爾", colour = AM_RED, coords = { {51, 66} }, symbol = { "1" },
						tooltiptxt = "首領", lootid = "BWLRazorgore"  },
				dtl6  = { text = "墮落的瓦拉斯塔茲", colour = AM_RED, coords = { {32.5, 67} }, symbol = { "2" },
						tooltiptxt = "首領", lootid = "BWLVaelastrasz"  },
				dtl7  = { text = "勒西雷爾", colour = AM_RED, coords = { {77, 42} }, symbol = { "3" },
						tooltiptxt = "首領", lootid = "BWLLashlayer"  },
				dtl8  = { text = "費爾默", colour = AM_RED, coords = { {12, 44} }, symbol = { "4" },
						tooltiptxt = "首領", lootid = "BWLFiremaw"  },
				dtl9  = { text = "埃博諾克", colour = AM_RED, coords = { {10, 29} }, symbol = { "5" },
						tooltiptxt = "首領", lootid = "BWLEbonroc"  },
				dtl10 = { text = "弗萊格爾", colour = AM_RED, coords = { {18, 29} }, symbol = { "6" },
						tooltiptxt = "首領", lootid = "BWLFlamegor"  },
				dtl11 = { text = "克洛瑪古斯", colour = AM_RED, coords = { {33, 40} }, symbol = { "7" },
						tooltiptxt = "首領", lootid = "BWLChromaggus"  },
				dtl12 = { text = "奈法利安", colour = AM_RED, coords = { {60, 14} }, symbol = { "8" },
						tooltiptxt = "首領", lootid = "BWLNefarian", leaveGap = 1 },
				dtl13 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "BWLTrashMobs", leaveGap = 1 },
				dtl14 = { text = AM_TIER2_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T2SET", leaveGap = 1 }
			},

			{	name = "厄運之槌"..AM_EXTERIOR,		-- Dire Maul Exterior
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 厄運之槌",
				displayshort = "DM",
				filename = "DireMaulExt",
				location = "菲拉斯 (59, 44)",
				levels = "",
				players = "",
				prereq = "",
				general = "",
				area = "Kalimdor",
				wmData = { minX = 0.4268, maxX = 0.441, minY =  0.6648, maxY = 0.696 },
				amData = { minX = 0.29, maxX = 0.97, minY = 0.025, maxY = 0.98 },
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {32, 97}  }, symbol = { "X" },
						tooltiptxt = "", toMap = "厄運之槌", leaveGap = 1 },
				dtl2  = { text = "Eldereth Row", colour = AM_BLUE, coords = { {57, 73} }, symbol = { "1" },
						tooltiptxt = "" },
				dtl3  = { text = "Broken Commons", colour = AM_BLUE, coords = { {62, 50} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl4  = { text = "Skarr the Unbreakable", colour = AM_RED, coords = { {62, 33} }, symbol = { "3" },
						tooltiptxt = "Lvl58 菁英人形怪" },
				dtl5  = { text = "The Maul", colour = AM_RED, coords = { {62, 26} }, symbol = { "4" },
						tooltiptxt = "PvP 區域" },
				dtl6  = { text = "Path to The Maul", colour = AM_BLUE, coords = { {44, 47}, {58, 33} }, symbol = { "P" },
						tooltiptxt = "Sleeping Hyena Guards" },
				dtl7  = { text = "Chamber with roof Exit from DM East", colour = AM_BLUE, coords = { {85, 19.4} }, symbol = { "5" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "厄運之槌 (東)", colour = AM_GREEN, coords = { {84, 32}, {96, 62} }, symbol = { "E" },
						tooltiptxt = "按下以打開 '厄運之槌 (東)' 的地圖", toMap = "厄運之槌 (東)" },
				dtl9  = { text = "厄運之槌 (北)", colour = AM_GREEN, coords = { {62, 4} }, symbol = { "N" },
						tooltiptxt = "按下以打開 '厄運之槌 (北)' 的地圖", toMap = "厄運之槌 (北)" },
				dtl10 = { text = "厄運之槌 (西)", colour = AM_GREEN, coords = { {42, 40} }, symbol = { "W" },
						tooltiptxt = "按下以打開 '厄運之槌 (西)' 的地圖", toMap = "厄運之槌 (西)", leaveGap = 1 }
			},

			{	name = "厄運之槌",		-- Dire Maul
				type = AM_TYP_INSTANCE,
				displayname = "厄運之槌 - 概觀",
				displayshort = "DM",
				filename = "DireMaul",
				location = "菲拉斯 (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "",
				general = "",
				dtl1  = { text = "厄運之槌 (東)", colour = AM_GREEN, coords = { {53, 81}, {57, 96}, {100, 80} }, symbol = { "E" },
						tooltiptxt = "按下以打開 '厄運之槌 (東)' 的地圖", toMap = "厄運之槌 (東)" },
				dtl2  = { text = "厄運之槌 (北)", colour = AM_GREEN, coords = { {67.5, 38} }, symbol = { "N" },
						tooltiptxt = "按下以打開 '厄運之槌 (北)' 的地圖", toMap = "厄運之槌 (北)" },
				dtl3  = { text = "厄運之槌 (西)", colour = AM_GREEN, coords = { {47, 88} }, symbol = { "W" },
						tooltiptxt = "按下以打開 '厄運之槌 (西)' 的地圖", toMap = "厄運之槌 (西)", leaveGap = 1 },
				dtl4  = { text = "圖書館", colour = AM_BLUE, coords = { {24, 58}, {41, 41} }, symbol = { "L" },
						tooltiptxt = "從北厄/西厄可以抵達", leaveGap = 1 }
			},


			{	name = "厄運之槌 (東)",		-- Dire Maul East
				type = AM_TYP_INSTANCE,
				displayname = "厄運之槌 (東)",
				displayshort = "DM",
				filename = "DMEast",		--DMEast
				location = "菲拉斯 (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "",
				general = "",
				dtl1  = { text = "入口 : Broken Commons", colour = AM_GREEN, coords = { {6, 58}  }, symbol = { "X1" },
						tooltiptxt = "", toMap = "厄運之槌"..AM_EXTERIOR },
				dtl2  = { text = "入口 : Eldereth Row", colour = AM_GREEN, coords = { {12, 92} }, symbol = { "X2" },
						tooltiptxt = "", toMap = "厄運之槌"..AM_EXTERIOR },
				dtl3  = { text = "入口 : Pavillion", colour = AM_GREEN, coords = { {98, 64} }, symbol = { "X3" },
						tooltiptxt = "" },
				dtl4  = { text = AM_INSTANCE_EXITS, colour = AM_RED, coords = { {8, 40} }, symbol = { AM_EXIT_SYMBOL },
						tooltiptxt = "Drop to Broken Commons\nside Chamber" },
				dtl5  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {41, 85}, {61, 93} }, symbol = { "L1" },
						tooltiptxt = "" },
				dtl6  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {75, 92}, {55, 82} }, symbol = { "L2" },
						tooltiptxt = "" },
				dtl7  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {67, 63}, {83, 73} }, symbol = { "L3" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "開始追捕普希林", colour = AM_GREEN, coords = { {10, 50} }, symbol = { "P" },
						tooltiptxt = "追捕以取得厄運之槌鑰匙(月牙鑰匙)", lootid = "DMEPusillin"  },
				dtl9  = { text = "結束追捕普希林", colour = AM_RED, coords = { {79, 61} }, symbol = { "P" },
						tooltiptxt = "喔, 你這小惡魔!", lootid = "DMEPusillin"  },
				dtl10 = { text = "瑟雷姆·刺蹄", colour = AM_RED, coords = { {83, 88} }, symbol = { "1" },
						tooltiptxt = "Lvl57 菁英惡魔", lootid = "DMEZevrimThornhoof"  },
				dtl11 = { text = "海多斯博恩", colour = AM_RED, coords = { {64, 77} }, symbol = { "2" },
						tooltiptxt = "Lvl57 菁英元素怪", lootid = "DMEHydro"  },
				dtl12 = { text = "蕾瑟塔蒂絲", colour = AM_RED, coords = { {46, 66} }, symbol = { "3" },
						tooltiptxt = "Lvl57 菁英人形怪", lootid = "DMELethtendris"  },
				dtl13 = { text = "埃隆巴克", colour = AM_RED, coords = { {21, 69} }, symbol = { "4" },
						tooltiptxt = "打開門"  },
				dtl14 = { text = "奧茲恩", colour = AM_RED, coords = { {42, 23} }, symbol = { "5" },
						tooltiptxt = "Lvl58 菁英惡魔", lootid = "DMEAlzzin"  },
				dtl15 = { text = "依薩利恩", colour = AM_RED, coords = { {42, 23} }, symbol = { " " },
						tooltiptxt = "需要召喚火盆\n任務從黑石山的布德利取得", lootid = "DMEIsalien", leaveGap = 2 },
				dtl16 = { text = "書籍", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 },
				dtl17 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMETrash", leaveGap = 1 }
			},

			{	name = "厄運之槌 (北)",		-- Dire Maul North
				type = AM_TYP_INSTANCE,
				displayname = "厄運之槌 (北)",
				displayshort = "DM",
				filename = "DMNorth",		-- DMNorth
				location = "菲拉斯 (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "需要從東厄普希林拿到的月牙鑰匙",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {74, 74} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "厄運之槌"..AM_EXTERIOR },
				dtl2  = { text = "厄運之槌 (西)", colour = AM_GREEN, coords = { {9, 98} }, symbol = { "W" },
						tooltiptxt = "", toMap = "厄運之槌 (西)" },
				dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {49.2, 59.4} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "衛兵摩爾達", colour = AM_RED, coords = { {76.4, 55.5} }, symbol = { "1" },
						tooltiptxt = "Lvl59 菁英人形怪", lootid = "DMNGuardMoldar"  },
				dtl5  = { text = "踐踏者克雷格", colour = AM_RED, coords = { {67, 49} }, symbol = { "2" },
						tooltiptxt = "Lvl57 菁英惡魔", lootid = "DMNStomperKreeg"  },
				dtl6  = { text = "衛兵芬古斯", colour = AM_RED, coords = { {49.2, 56.1} }, symbol = { "3" },
						tooltiptxt = "Lvl59 菁英人形怪", lootid = "DMNGuardFengus"  },
				dtl7  = { text = "衛兵斯里基克", colour = AM_RED, coords = { {17, 41} }, symbol = { "4" },
						tooltiptxt = "Lvl59 菁英人形怪", lootid = "DMNGuardSlipkik"  },
				dtl8  = { text = "諾特‧希姆加克", colour = AM_RED, coords = { {19, 37} }, symbol = { "5" },
						tooltiptxt = "", lootid = "DMNThimblejack"  },
				dtl9  = { text = "克羅卡斯", colour = AM_RED, coords = { {24.6, 34.8} }, symbol = { "6" },
						tooltiptxt = "", lootid = "DMNCaptainKromcrush"  },
				dtl10 = { text = "戈多克大王", colour = AM_RED, coords = { {24.2, 11.2} }, symbol = { "7" },
						tooltiptxt = "", lootid = "DMNKingGordok"  },
				dtl11 = { text = "圖書館", colour = AM_BLUE, coords = { {20, 89} }, symbol = { "8" },
						tooltiptxt = "", leaveGap = 2  },
				dtl12 = { text = "貢品進貢", colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "DMNTRIBUTERUN" },
				dtl13 = { text = "書籍", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 }
			},

			{	name = "厄運之槌 (西)",		-- Dire Maul West
				type = AM_TYP_INSTANCE,
				displayname = "厄運之槌 (西)",
				displayshort = "DM",
				filename = "DMWest",		-- DMWest
				location = "菲拉斯 (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "需要從東厄普希林拿到的月牙鑰匙",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {97, 78} }, symbol = { "X1" },
						tooltiptxt = "", toMap = "厄運之槌"..AM_EXTERIOR },
				dtl2  = { text = "厄運之槌 (北)", colour = AM_GREEN, coords = { {66, 9} }, symbol = { "N" },
						tooltiptxt = "", toMap = "厄運之槌 (北)", leaveGap = 1 },
				dtl3  = { text = "階梯", colour = AM_BLUE, coords = { {49.2, 25}, {52, 60} }, symbol = { AM_STAIRS_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "水晶塔", colour = AM_GREEN, coords = { {83, 80}, {64, 61}, {64, 87}, {27, 62}, {27, 37} }, symbol = { "P" },
						tooltiptxt = "將這些都摧毀", leaveGap = 1 },
				dtl5  = { text = "辛德拉古靈", colour = AM_ORANGE, coords = { {68, 74} }, symbol = { "1" },
						tooltiptxt = "任務接到'挑戰托塞德林王子'" },
				dtl6  = { text = "特迪斯‧扭木", colour = AM_RED, coords = { {58, 74} }, symbol = { "2" },
						tooltiptxt = "Lvl60 菁英元素怪", lootid = "DMWTendrisWarpwood" },
				dtl7  = { text = "伊琳娜‧暗木", colour = AM_RED, coords = { {49, 87} }, symbol = { "3" },
						tooltiptxt = "Lvl60 菁英不死族", lootid = "DMWIllyannaRavenoak" },
				dtl8  = { text = "蘇斯", colour = AM_RED, coords = { {48, 60} }, symbol = { "4" },
						tooltiptxt = "Lvl59 菁英不死族", special = AM_RARE, lootid = "DMWTsuzee" },
				dtl9  = { text = "卡雷迪斯鎮長", colour = AM_RED, coords = { {53, 51} }, symbol = { "5" },
						tooltiptxt = "Lvl60 菁英不死族", lootid = "DMWMagisterKalendris" },
				dtl10 = { text = "伊莫塔爾", colour = AM_RED, coords = { {19, 49} }, symbol = { "6" },
						tooltiptxt = "Lvl61 菁英惡魔", lootid = "DMWImmolthar" },
				dtl11 = { text = "赫爾努拉斯", colour = AM_RED, coords = { { 19, 49} }, symbol = { " " },
						tooltiptxt = "Lvl62 菁英惡魔", lootid = "DMWHelnurath" },
				dtl12 = { text = "托塞德林王子", colour = AM_RED, coords = { {41, 26} }, symbol = { "7" },
						tooltiptxt = "Lvl61 菁英人形怪", lootid = "DMWPrinceTortheldrin", leaveGap = 1  },
				dtl13 = { text = "圖書館", colour = AM_BLUE, coords = { {51, 20} }, symbol = { "8" },
						tooltiptxt = "", leaveGap = 1 },
				dtl14 = { text = "書籍", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMWTrash", leaveGap = 1 }
			},

			{	name = "諾姆瑞根",			-- Gnomeregan
				type = AM_TYP_INSTANCE,
				displayname = "諾姆瑞根",
				filename = "Gnomeregan",
				location = "丹莫洛 (25, 41)",
				levels = "26-33",
				players = "10",
				prereq = "",
				general = "部落可由藏寶海灣傳送過來.\n起始任務來自奧格瑪工程師.",
				dtl1  = { text = "正門入口 (Clockwerk Run)", colour = AM_GREEN, coords = { {70.5, 16} }, symbol = { "X1" },
						tooltiptxt = "", toMap = "諾姆瑞根"..AM_EXTERIOR },
				dtl2  = { text = "後門入口 (車庫)", colour = AM_GREEN, coords = { {87, 59} }, symbol = { "X2" },
						tooltiptxt = "需要車間鑰匙", toMap = "Gnomeregan"..AM_EXTERIOR },
				dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {75, 38}, {79, 56} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "粘性輻射塵", colour = AM_RED, coords = { {71.5, 33.5} }, symbol = { "1" },
						tooltiptxt = "Lvl30 菁英元素怪\n下層", lootid = "GnViscousFallout" },
				dtl5  = { text = "格魯比斯", colour = AM_RED, coords = { {95, 46} }, symbol = { "2" },
						tooltiptxt = "Lvl32 菁英人形怪\n觸發後出現\n在同一個地方和爆破專家艾米·短線講話", lootid = "GnGrubbis"  },
				dtl6  = { text = "克努比 (宿舍區)", colour = AM_BLUE, coords = { {76, 54} }, symbol = { "3" },
						tooltiptxt = ""  },
				dtl7  = { text = "矩陣式打孔電腦 3005-B", colour = AM_GREEN, coords = { {70, 50} }, symbol = { "B" },
						tooltiptxt = "卡片升級"  },
				dtl8  = { text = "清洗區", colour = AM_GREEN, coords = { {64, 46} }, symbol = { "4" },
						tooltiptxt = ""  },
				dtl9  = { text = "電刑器 6000 型", colour = AM_RED, coords = { {30, 49} }, symbol = { "5" },
						tooltiptxt = "Lvl32 菁英機器人\n會掉落車間鑰匙", lootid = "GnElectrocutioner6000"  },
				dtl10 = { text = "矩陣式打孔電腦 3005-C", colour = AM_GREEN, coords = { {33.2, 49.6} }, symbol = { "C" },
						tooltiptxt = "卡片升級"  },
				dtl11 = { text = "群體打擊者 9-60", colour = AM_RED, coords = { {47.6, 77.3} }, symbol = { "6" },
						tooltiptxt = "Lvl32 菁英機器人", lootid = "GnCrowdPummeler960"  },
				dtl12 = { text = "矩陣式打孔電腦 3005-D", colour = AM_GREEN, coords = { {48.9, 75.7} }, symbol = { "D" },
						tooltiptxt = "卡片升級"  },
				dtl13 = { text = "黑鐵大師", colour = AM_RED, coords = { {9, 52} }, symbol = { "5" },
						tooltiptxt = "Lvl33 菁英人形怪", special = AM_RARE, lootid = "GnDIAmbassador"  },
				dtl14 = { text = "麥克尼爾‧瑟瑪普拉格", colour = AM_RED, coords = { {11.8, 42.2} }, symbol = { "8" },
						tooltiptxt = "Lvl35 菁英惡魔", lootid = "GnMekgineerThermaplugg", leaveGap = 1  },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "GnTrash", leaveGap = 1 }
			},

			{	name = "諾姆瑞根"..AM_EXTERIOR,			-- Gnomeregan
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 諾姆瑞根",
				filename = "GnomereganExt",
				location = "丹莫洛 (25, 41)",
				levels = "",
				players = "",
				prereq = "",
				general = "部落可由藏寶海灣傳送過來.\n起始任務來自奧格瑪工程師.",
				wmData = { minX = 0.42812, maxX = 0.43726, minY =  0.52503, maxY = 0.53932 },
				amData = { minX = 0.198, maxX = 0.905, minY = 0.21, maxY = 0.940 },
				dtl1  = { text = "外部", colour = AM_GREEN, coords = { {91.0, 92.5} }, symbol = { "O" },
						tooltiptxt = "" },
				dtl2  = { text = "升降梯", colour = AM_GREEN, coords = { {81.59, 87.65} }, symbol = { "L" },
						tooltiptxt = "" },
				dtl3  = { text = "傳送器", colour = AM_GREEN, coords = { {60.95, 72.95} }, symbol = { "P" },
						tooltiptxt = "從藏寶海灣" },
				dtl4  = { text = "斯普洛克", colour = AM_BLUE, coords = { {60.95, 72.95} }, symbol = { " " },
						tooltiptxt = "Away Team", leaveGap = 1 },
				dtl5  = { text = "矩陣式打孔電腦 3005-A", colour = AM_PURPLE, coords = { {67.29, 42.22}, {61.43, 41.78}, {64.00, 26.52}, {69.46, 26.75} }, symbol = { "A" },
						tooltiptxt = "卡片升級" },
				dtl6  = { text = "尖端機器人", colour = AM_RED, coords = { {44.0, 36.53} }, symbol = { "1" },
						tooltiptxt = "Lvl26 菁英機器人", leaveGap = 1 },
				dtl7  = { text = "主要副本入口", colour = AM_ORANGE, coords = { {18.89, 88.0} }, symbol = { "I" },
						tooltiptxt = "", toMap = "諾姆瑞根" },
				dtl8  = { text = "車間入口", colour = AM_ORANGE, coords = { {62.46, 22.75} }, symbol = { "W" },
						tooltiptxt = "需要車間鑰匙", toMap = "Gnomeregan", leaveGap = 1  }
			},

			{	name = "卡札克",			-- Lord Kazzak
				type = AM_TYP_RAID,
				displayname = "卡札克",
				filename = "AM_Kazzak_Map",
				location = "詛咒之地 : 腐爛之痕 (32, 44)",
				minimapZoom = 1.42,
				minimapXOffset = 95,
				minimapYOffset = 0,
				area = "BlastedLands",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "",
				wmData = { minX = 0.33, maxX = 0.49, minY = 0.47, maxY = 0.79 },
				amData = { minX = 0.25, maxX = 0.99, minY = 0.01, maxY = 0.98 },
				dtl1 = { text = "逼近", colour = AM_GREEN, coords = { {79, 30} }, symbol = { AM_ENTRANCE },
						tooltiptxt = "", leaveGap = 1 },
				dtl2 = { text = "卡札克", colour = AM_RED, coords = { {42, 84} }, symbol = { "1" },
						tooltiptxt = "首領", lootid = "KKazzak", leaveGap = 1 },
				dtl3 = { text = "Daio the Decrepit", colour = AM_GREEN, coords = { {29.5, 8.5} }, symbol = { "2" },
						tooltiptxt = "", leaveGap = 1 }
			},

			{	name = "艾索雷葛斯",				-- Azuregos
				type = AM_TYP_RAID,
				displayname = "艾索雷葛斯",
				filename = "AM_Azuregos_Map",
				location = "艾薩拉 (大約位置 56, 81)",
				minimapZoom = 1.5385,
				minimapXOffset = 0,
				minimapYOffset = 0,
				area = "Aszhara",				-- Deliberately spelt Aszhara !
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "",
				wmData = { minX = 0.485, maxX = 0.62743, minY = 0.71498, maxY = 0.917 },
				amData = { minX = 0.005, maxX = 0.995, minY = 0.005, maxY = 0.995 },
				dtl1 = { text = "艾索雷葛斯", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "對話後啟動戰鬥", lootid = "AAzuregos", leaveGap = 1 }
			},

			{	name = "四巨龍: 暮色森林",		-- Four Dragons
				type = AM_TYP_RAID,
				displayname = "四巨龍: 暮色森林",
				filename = "AM_Dragon_Duskwood_Map",
				location = "暮色森林 : 黎明森林 (46, 36)",
				minimapZoom = 2.11,
				minimapXOffset = 54,
				minimapYOffset = 0,
				area = "Duskwood",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "",
				wmData = { minX = 0.421, maxX = .526, minY = 0.292, maxY = 0.54 },
				amData = { minX = 0.29, maxX = .85, minY = 0.115, maxY = 0.97 },
				dtl1 = { text = "逼近", colour = AM_GREEN, coords = { {48, 96} }, symbol = { AM_ENTRANCE },
						tooltiptxt = "", leaveGap = 1 },
				dtl2 = { text = "翡翠傳送門", colour = AM_GREEN, coords = { {54, 47} }, symbol = { "1" },
						tooltiptxt = "首領\n伊索德雷", special = AM_WANDERS, leaveGap = 1 },
				dtl3 = { text = "艾莫莉絲", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DEmeriss" },
				dtl4 = { text = "雷索", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DLethon" },
				dtl5 = { text = "泰拉爾", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DTaerar" },
				dtl6 = { text = "伊索德雷", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DYsondre" },
			},

			{	name = "四巨龍: 辛特蘭",			-- Four Dragons
				type = AM_TYP_RAID,
				displayname = "四巨龍: 辛特蘭",
				filename = "AM_Dragon_Hinterlands_Map",
				location = "辛特蘭 : 瑟拉丹 (46, 36)",
				minimapZoom = 2,
				minimapXOffset = 0,
				minimapYOffset = 0,
				area = "Hinterlands",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "三人一組徘徊的 62 & 61 級菁英",
				wmData = { minX = 0.561, maxX = .697, minY = 0.159, maxY = 0.362 },
				amData = { minX = 0.005, maxX = .995, minY = 0.005, maxY = 0.995 },
				dtl1 = { text = "逼近", colour = AM_GREEN, coords = { {37, 98} }, symbol = { AM_ENTRANCE },
						tooltiptxt = "", leaveGap = 1 },
				dtl2 = { text = "雷索", colour = AM_RED, coords = { {52.5, 59} }, symbol = { "1" },
						tooltiptxt = "Lvl62 菁英龍族", special = AM_WANDERS },
				dtl3 = { text = "尋夢者", colour = AM_RED, coords = { {51, 49} }, symbol = { "2" },
						tooltiptxt = "Lvl62 菁英龍族" },
				dtl4 = { text = "翡翠傳送門", colour = AM_GREEN, coords = { {46, 39} }, symbol = { "3" },
						tooltiptxt = "首領\n泰拉爾", leaveGap = 1 },
				dtl5 = { text = "艾莫莉絲", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DEmeriss" },
				dtl6 = { text = "雷索", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DLethon" },
				dtl7 = { text = "泰拉爾", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DTaerar" },
				dtl8 = { text = "伊索德雷", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DYsondre" },
			},

			{	name = "四巨龍: 菲拉斯",			-- Four Dragons
				type = AM_TYP_RAID,
				displayname = "四巨龍: 菲拉斯",
				filename = "AM_Dragon_Feralas_Map",
				location = "菲拉斯 : 夢境之樹 (51, 9)",	-- Jademir Lake
				minimapZoom = 2,
				minimapXOffset = 0,
				minimapYOffset = 0,
				area = "Feralas",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "三人一組徘徊的 62 & 61 級菁英",
				wmData = { minX = 0.47695, maxX = .55113, minY = 0.04585, maxY = 0.15963 },
				amData = { minX = 0.005, maxX = .995, minY = 0.005, maxY = 0.995 },
				dtl1 = { text = "睡夢咆哮者", colour = AM_RED, coords = { {36, 63} }, symbol = { "1" },
						tooltiptxt = "Lvl62 菁英龍族\n在島上巡邏", special = AM_WANDERS },
				dtl2 = { text = "萊薩拉斯", colour = AM_RED, coords = { {46, 68} }, symbol = { "2" },
						tooltiptxt = "Lvl62 菁英龍族\nP在島上巡邏", special = AM_WANDERS },
				dtl3 = { text = "翡翠傳送門", colour = AM_GREEN, coords = { {45, 57} }, symbol = { "3" },
						tooltiptxt = "首領\n艾莫莉絲", leaveGap = 1 },
				dtl4 = { text = "艾莫莉絲", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DEmeriss" },
				dtl5 = { text = "雷索", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DLethon" },
				dtl6 = { text = "泰拉爾", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DTaerar" },
				dtl7 = { text = "伊索德雷", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DYsondre" },
			},

			{	name = "四巨龍: 梣谷",		-- Four Dragons
				type = AM_TYP_RAID,
				displayname = "四巨龍: 梣谷",
				filename = "AM_Dragon_Ashenvale_Map",
				location = "梣谷 : 大樹蔭 (93, 36)",
				minimapZoom = 2,
				minimapXOffset = 0,
				minimapYOffset = 0,
				area = "Ashenvale",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "三人一組徘徊的 62 & 61 級菁英",
				wmData = { minX = 0.895, maxX = .984, minY = 0.299, maxY = 0.4286 },
				amData = { minX = 0.005, maxX = .995, minY = 0.005, maxY = 0.995 },
				dtl1 = { text = "范迪姆", colour = AM_RED, coords = { {57, 75} }, symbol = { "1" },
						tooltiptxt = "Lvl62 菁英龍族", special = AM_WANDERS },
				dtl2 = { text = "巡夢者", colour = AM_RED, coords = { {50.4, 57} }, symbol = { "2" },
						tooltiptxt = "Lvl62 菁英龍族" },
				dtl3 = { text = "翡翠傳送門", colour = AM_GREEN, coords = { {50.8, 48} }, symbol = { "3" },
						tooltiptxt = "首領\n雷索", leaveGap = 1 },
				dtl4 = { text = "艾莫莉絲", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DEmeriss" },
				dtl5 = { text = "雷索", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DLethon" },
				dtl6 = { text = "泰拉爾", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DTaerar" },
				dtl7 = { text = "伊索德雷", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DYsondre" },
			},

			{	name = "瑪拉頓",			-- Maraudon
				type = AM_TYP_INSTANCE,
				displayname = "瑪拉頓",
				filename = "Maraudon",
				location = "淒涼之地 (29, 62)",
				levels = "40-49",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = "入口 (橙區)", colour = AM_ORANGE, coords = { {71, 12} }, symbol = { "X1" },
						tooltiptxt = "", toMap = "瑪拉頓"..AM_EXTERIOR },
				dtl2  = { text = "入口 (紫區)", colour = AM_PURPLE, coords = { {85, 31} }, symbol = { "X2" },
						tooltiptxt = "", toMap = "瑪拉頓"..AM_EXTERIOR },
				dtl3  = { text = "入口 (傳送)", colour = AM_GREEN, coords = { {36, 55} }, symbol = { "P" },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {64, 44}, {39, 31} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl5  = { text = "溫格 (第五可汗)", colour = AM_RED, coords = { {59, 6} }, symbol = { "1" },
						tooltiptxt = "", special = AM_WANDERS  },
				dtl6  = { text = "諾克賽恩", colour = AM_RED, coords = { {51, 3} }, symbol = { "2" },
						tooltiptxt = "Lvl48 菁英元素怪", lootid = "MaraNoxxion"  },
				dtl7  = { text = "銳刺鞭笞者", colour = AM_RED, coords = { {36, 14} }, symbol = { "3" },
						tooltiptxt = "Lvl47 菁英野獸", lootid = "MaraRazorlash"  },
				dtl8  = { text = "瑪勞杜斯 (第四可汗)", colour = AM_RED, coords = { {64, 27} }, symbol = { "4" },
						tooltiptxt = ""  },
				dtl9  = { text = "維利塔恩", colour = AM_RED, coords = { {53.3, 32} }, symbol = { "5" },
						tooltiptxt = "Lvl47 菁英人形怪", lootid = "MaraLordVyletongue"  },
				dtl10 = { text = "收割者麥什洛克", colour = AM_RED, coords = { {43, 30} }, symbol = { "6" },
						tooltiptxt = "", special = AM_RARE, lootid = "MaraMeshlok"  },
				dtl11 = { text = "被詛咒的塞雷布拉斯", colour = AM_RED, coords = { {31, 35} }, symbol = { "7" },
						tooltiptxt = "Lvl49 菁英人形怪", lootid = "MaraCelebras"  },
				dtl12 = { text = "蘭斯利德", colour = AM_RED, coords = { {51.3, 60} }, symbol = { "8" },
						tooltiptxt = "Lvl50 菁英元素怪", lootid = "MaraLandslide"  },
				dtl13 = { text = "工匠吉茲洛克", colour = AM_RED, coords = { {61, 74} }, symbol = { "9" },
						tooltiptxt = "Lvl50 菁英人形怪", lootid = "MaraTinkererGizlock"  },
				dtl14 = { text = "洛特格里普", colour = AM_RED, coords = { {45, 82} }, symbol = { "10" },
						tooltiptxt = "Lvl50 菁英野獸", lootid = "MaraRotgrip"  },
				dtl15 = { text = "瑟萊德絲公主", colour = AM_RED, coords = { {32, 85} }, symbol = { "11" },
						tooltiptxt = "Lvl51 菁英元素怪", lootid = "MaraPrincessTheradras" },
				dtl16 = { text = "札爾塔的靈魂", colour = AM_RED, coords = { {32, 85} }, symbol = { " " },
						tooltiptxt = "", leaveGap = 1 }
			},

			{	name = "瑪拉頓"..AM_EXTERIOR,		-- Maraudon Exterior
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 瑪拉頓",
				displayshort = "",
				filename = "MaraudonExt",
				location = "淒涼之地 (29, 62)",
				levels = "40-49",
				players = "",
				prereq = "",
				general = "",
				area = "Kalimdor",
				wmData = { minX = 0.3807325, maxX = 0.393785, minY =  0.5679875, maxY = 0.58772 },
				amData = { minX = 0.02, maxX = 0.92, minY = 0.01, maxY = 0.98 },
				dtl1  = { text = "入口", colour = AM_GREEN, coords = { {23, 59}  }, symbol = { "X" },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "第一可汗", colour = AM_RED, coords = { {31, 45} }, symbol = { "1" },
						tooltiptxt = "" },
				dtl3  = { text = "S第二可汗", colour = AM_RED, coords = { {24, 29} }, symbol = { "2" },
						tooltiptxt = "在中間層的水池間" },
				dtl4  = { text = "第三可汗", colour = AM_RED, coords = { {80, 46} }, symbol = { "3" },
						tooltiptxt = "" },
				dtl5  = { text = "凱雯德拉", colour = AM_GREEN, coords = { {48, 64} }, symbol = { "4" },
						tooltiptxt = "任務提供者", leaveGap = 1 },
				dtl6  = { text = "瑪拉頓傳送點", colour = AM_BLUE, coords = { {24, 47} }, symbol = { "P" },
						tooltiptxt = "需要塞雷布拉斯節杖" },
				dtl7  = { text = "瑪拉頓 (橙區)", colour = AM_ORANGE, coords = { {84, 71} }, symbol = { "X1" },
						tooltiptxt = "按下以開啟瑪拉頓副本地圖", toMap = "瑪拉頓" },
				dtl8  = { text = "瑪拉頓 (紫區)", colour = AM_PURPLE, coords = { {39, 12.4} }, symbol = { "X2" },
						tooltiptxt = "按下以開啟瑪拉頓副本地圖", toMap = "瑪拉頓" }
			},


			{	name = "熔火之心",			-- Molten Core
				type = AM_TYP_INSTANCE,
				displayname = "熔火之心",
				displayshort = "MC",
				filename = "MoltenCore",
				location = "黑石深淵",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {3, 20} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "黑石深淵", leaveGap = 1 },
				dtl2  = { text = "魯西弗隆", colour = AM_RED, coords = { {62, 35} }, symbol = { "1" },
						tooltiptxt = "首領 人形", lootid = "MCLucifron" },
				dtl3  = { text = "瑪格曼達", colour = AM_RED, coords = { {70, 16} }, symbol = { "2" },
						tooltiptxt = "首領 野獸", lootid = "MCMagmadar" },
				dtl4  = { text = "基赫納斯", colour = AM_RED, coords = { {13, 46} }, symbol = { "3" },
						tooltiptxt = "首領 人形", lootid = "MCGehennas" },
				dtl5  = { text = "加爾", colour = AM_RED, coords = { {8, 71} }, symbol = { "4" },
						tooltiptxt = "首領 元素怪", lootid = "MCGarr"  },
				dtl6  = { text = "沙斯拉爾", colour = AM_RED, coords = { {44, 80} }, symbol = { "5" },
						tooltiptxt = "首領 人形", lootid = "MCShazzrah"  },
				dtl7  = { text = "迦頓男爵", colour = AM_RED, coords = { {53, 68} }, symbol = { "6" },
						tooltiptxt = "首領 元素怪", lootid = "MCGeddon"  },
				dtl8  = { text = "焚化者古雷曼格", colour = AM_RED, coords = { {66, 57} }, symbol = { "7" },
						tooltiptxt = "首領 巨人", lootid = "MCGolemagg"  },
				dtl9  = { text = "薩弗隆先驅者", colour = AM_RED, coords = { {87, 80} }, symbol = { "8" },
						tooltiptxt = "首領 人形", lootid = "MCSulfuron"  },
				dtl10 = { text = "管理者埃克索圖斯", colour = AM_RED, coords = { {89, 62} }, symbol = { "9" },
						tooltiptxt = "首領 人形", lootid = "MCMajordomo"  },
				dtl11 = { text = "拉格納羅斯", colour = AM_RED, coords = { {47, 52} }, symbol = { "10" },
						tooltiptxt = "首領 元素怪", lootid = "MCRagnaros", leaveGap = 2  },
				dtl12 = { text = AM_MOB_LOOT, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "MCTrashMobs", lootlink = true },
				dtl13 = { text = AM_RBOSS_DROP, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "MCRANDOMBOSSDROPPS", leaveGap = 1 },
				dtl14 = { text = AM_TIER1_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T1SET", leaveGap = 1 }
			},

			{	name = "納克薩瑪斯",			-- Naxxramas
				type = AM_TYP_INSTANCE,
				displayname = "納克薩瑪斯",
				filename = "Naxxramas",
				location = "斯坦索姆",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text ="憎惡區" , colour = AM_BLUE, coords = { {2, 15} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "縫補者", colour = AM_RED, coords = { {22, 36} }, symbol = { "1" },
						tooltiptxt = "憎惡區", lootid = "NAXPatchwerk" },
				dtl3  = { text = "葛羅巴斯", colour = AM_RED, coords = { {32, 29} }, symbol = { "2" },
						tooltiptxt = "憎惡區", lootid = "NAXGrobbulus" },
				dtl4  = { text = "古魯斯", colour = AM_RED, coords = { {20, 20} }, symbol = { "3" },
						tooltiptxt = "憎惡區", lootid = "NAXGluth" },
				dtl5  = { text = "泰迪斯", colour = AM_RED, coords = { {5, 4} }, symbol = { "4" },
						tooltiptxt = "憎惡區", lootid = "NAXThaddius", leaveGap = 1  },
				dtl6  = { text = "蜘蛛區", colour = AM_BLUE, coords = { {67, 3} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = ""  },
				dtl7  = { text = "阿努比瑞克漢", colour = AM_RED, coords = { {45.2, 20} }, symbol = { "1" },
						tooltiptxt = "蜘蛛區", lootid = "NAXAnubRekhan"  },
				dtl8  = { text = "大寡婦費琳娜", colour = AM_RED, coords = { {55, 16} }, symbol = { "2" },
						tooltiptxt = "蜘蛛區", lootid = "NAXGrandWidowFaerlina"  },
				dtl9  = { text = "梅克絲娜", colour = AM_RED, coords = { {74, 5} }, symbol = { "3" },
						tooltiptxt = "蜘蛛區", lootid = "NAXMaexxna", leaveGap = 1  },
				dtl10 = { text = "瘟疫區", colour = AM_BLUE, coords = { {79, 56} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = ""  },
				dtl11 = { text = "瘟疫者諾斯", colour = AM_RED, coords = { {47, 64} }, symbol = { "1" },
						tooltiptxt = "瘟疫區", lootid = "NAXNothderPlaguebringer"  },
				dtl12 = { text = "骯髒者海根", colour = AM_RED, coords = { {60, 58} }, symbol = { "2" },
						tooltiptxt = "瘟疫區", lootid = "NAXHeiganderUnclean"  },
				dtl13 = { text = "洛斯伯", colour = AM_RED, coords = { {82, 47} }, symbol = { "3" },
						tooltiptxt = "瘟疫區", lootid = "NAXLoatheb", leaveGap = 1  },
				dtl14 = { text = "死亡騎士區", colour = AM_BLUE, coords = { {15, 79} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = ""  },
				dtl15 = { text = "講師拉祖維斯", colour = AM_RED, coords = { {18, 58} }, symbol = { "1" },
						tooltiptxt = "死亡騎士區", lootid = "NAXInstructorRazuvious"  },
				dtl16 = { text = "收割者高希", colour = AM_RED, coords = { {37, 64} }, symbol = { "2" },
						tooltiptxt = "死亡騎士區", lootid = "NAXGothikderHarvester" },
				dtl17 = { text = "四騎士", colour = AM_RED, coords = { {8, 75} }, symbol = { "3" },
						tooltiptxt = "死亡騎士區", lootid = "NAXTheFourHorsemen" },
				dtl18 = { text = "庫爾塔茲領主", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "" },
				dtl19 = { text = "瑟裡耶克爵士", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "" },
				dtl20 = { text = "莫格萊尼公爵", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "" },
				dtl21 = { text = "女公爵布勞繆克絲", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "", leaveGap = 1 },
				dtl22 = { text = "冰霜巨龍的巢穴", colour = AM_BLUE, coords = { {74, 93} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "冰霜巨龍的巢穴"  },
				dtl23 = { text = "薩菲隆", colour = AM_RED, coords = { {87, 91} }, symbol = { "1" },
						tooltiptxt = "冰霜巨龍的巢穴", lootid = "NAXSapphiron"  },
				dtl24 = { text = "科爾蘇加德", colour = AM_RED, coords = { {75, 79} }, symbol = { "2" },
						tooltiptxt = "冰霜巨龍的巢穴", lootid = "NAXKelThuzard", leaveGap = 2  },
				dtl25 = { text = AM_TIER3_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T3SET", leaveGap = 1 },
				dtl26 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "NAXTrash", leaveGap = 1 }
			},

			{	name = "奧妮克希亞的巢穴",				-- Onyxia's Lair
				type = AM_TYP_INSTANCE,
				displayname = "奧妮克希亞的巢穴",
				filename = "OnyxiasLair",
				location = "塵泥沼澤 (52, 76)",
				levels = "60+",
				players = "40",
				prereq = "需要龍火護符\n(完整的任務是在黑石塔上層殺死達基薩斯將軍)",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {9, 12} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "奧妮克希亞守衛", colour = AM_RED, coords = { {26, 41}, {29, 56}, {39, 68}, {50, 80} }, symbol = { "1" },
						tooltiptxt = "Lvl62 菁英龍族" },
				dtl3  = { text = "雛龍蛋", colour = AM_RED, coords = { {45, 40}, {51, 54}, {84, 41}, {79, 54} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl4  = { text = "奧妮克希亞", colour = AM_RED, coords = { {66, 27} }, symbol = { "3" },
						tooltiptxt = "首領 龍族", lootid = "Onyxia", leaveGap = 1 }
			},

			{	name = "怒焰裂谷",			-- Ragefire Chasm
				type = AM_TYP_INSTANCE,
				displayname = "怒焰裂谷",
				displayshort = "RFC",
				filename = "RagefireChasm",			-- RagefireChasm
				location = "奧格瑪",
				levels = "13-18",
				players = "10",
				general = "",
				dtl1  = { text = "入口", colour = AM_GREEN, coords = { {72, 4} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "瑪爾·恐怖圖騰", colour = AM_GOLD, coords = { {71, 53} }, symbol = { "1" },
						tooltiptxt = "'歸還背包'任務"  },
				dtl3  = { text = "饑餓者塔拉加曼", colour = AM_RED, coords = { {34, 59} }, symbol = { "2" },
						tooltiptxt = "Lvl16 菁英惡魔", lootid = "RFCTaragaman" },
				dtl4  = { text = "祈求者耶戈什", colour = AM_RED, coords = { {24, 86} }, symbol = { "3" },
						tooltiptxt = "Lvl16 菁英人形怪", lootid = "RFCJergosh" },
				dtl5  = { text = "巴紮蘭", colour = AM_RED, coords = { {36, 91} }, symbol = { "4" },
						tooltiptxt = "Lvl16 菁英惡魔", leaveGap = 1  }

			},

			{	name = "剃刀高地",			-- Razorfen Downs
				type = AM_TYP_INSTANCE,
				displayname = "剃刀高地",
				displayshort = "RFD",
				filename = "RazorfenDowns",
				location = "南貧瘠之地 (48, 88)",
				levels = "38-43",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {4, 23} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {77, 45} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "圖特卡什", colour = AM_RED, coords = { {52, 36} }, symbol = { "1" },
						tooltiptxt = "Lvl40 菁英不死族", lootid = "RFDTutenkash" },
				dtl4  = { text = "銅鑼以叫出圖特卡什", colour = AM_GREEN, coords = { {54, 30} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl5  = { text = "亨利‧斯特恩,\n貝尼斯特拉茲", colour = AM_BLUE, coords = { {76, 27} }, symbol = { "3" },
						tooltiptxt = "學會如何製造 :\n金棘茶, \n超強食人妖之血藥水"  },
				dtl6  = { text = "火眼莫德雷斯", colour = AM_RED, coords = { {87, 47} }, symbol = { "4" },
						tooltiptxt = "Lvl39 菁英不死族", lootid = "RFDMordreshFireEye"  },
				dtl7  = { text = "暴食者", colour = AM_RED, coords = { {19, 65} }, symbol = { "5" },
						tooltiptxt = "Lvl40 菁英人形怪", lootid = "RFDGlutton"  },
				dtl8  = { text = "拉戈斯諾特", colour = AM_RED, coords = { {41, 67} }, symbol = { "6" },
						tooltiptxt = "Lvl40 菁英人形怪", special = AM_RARE, lootid = "RFDRagglesnout"  },
				dtl9  = { text = "寒冰之王亞門納爾", colour = AM_RED, coords = { {33, 59} }, symbol = { "0" },
						tooltiptxt = "Lvl41 菁英不死族", lootid = "RFDAmnennar", leaveGap = 1 },
				dtl10 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "RFDTrash", leaveGap = 1 }
			},

			{	name = "剃刀沼澤",			-- Razorfen Kraul
				type = AM_TYP_INSTANCE,
				displayname = "剃刀沼澤",
				displayshort = "RFK",
				filename = "RazorfenKraul",
				location = "貧瘠之地 (42, 86)",
				levels = "28-33",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {75, 71} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "魯古格", colour = AM_RED, coords = { {73, 44} }, symbol = { "1" },
						tooltiptxt = "Lvl28 菁英人形怪" },
				dtl3  = { text = "阿格姆", colour = AM_RED, coords = { {88, 48} }, symbol = { "2" },
						tooltiptxt = "Lvl30 菁英人形怪" },
				dtl4  = { text = "亡語者賈格巴", colour = AM_RED, coords = { {93, 38} }, symbol = { "3" },
						tooltiptxt = "Lvl30 菁英人形怪", lootid = "RFKDeathSpeakerJargba" },
				dtl5  = { text = "主宰拉姆塔斯", colour = AM_RED, coords = { {60, 29} }, symbol = { "4" },
						tooltiptxt = "Lvl32 菁英人形怪", lootid = "RFKOverlordRamtusk"  },
				dtl6 = { text = "喚地者哈穆加", colour = AM_RED, coords = { {49, 37} }, symbol = { "5" },
						tooltiptxt = "Lvl32 菁英人形怪", special = AM_RARE, lootid = "RFKEarthcallerHalmgar"  },
				dtl7 = { text = "進口商威利克斯,\n赫爾拉斯‧靜水", colour = AM_BLUE, coords = { {35, 33} }, symbol = { "6" },
						tooltiptxt = ""  },
				dtl8  = { text = "卡爾加‧刺肋", colour = AM_RED, coords = { {21, 33} }, symbol = { "7" },
						tooltiptxt = "Lvl33 菁英人形怪", lootid = "RFKCharlgaRazorflank"  },
				dtl9  = { text = "盲眼獵手", colour = AM_RED, coords = { {6, 32} }, symbol = { "8" },
						tooltiptxt = "Lvl32 菁英野獸\n& Chest", special = AM_RARE, lootid = "RFKBlindHunter"  },
				dtl10  = { text = "Ward Sealing Agathelos", colour = AM_GREEN, coords = { {4, 54} }, symbol = { "9" },
						tooltiptxt = ""  },
				dtl11  = { text = "暴怒的阿迦賽羅斯", colour = AM_RED, coords = { {11, 65} }, symbol = { "10" },
						tooltiptxt = "Lvl33 菁英野獸", lootid = "RFKAgathelos", leaveGap = 1  },
				dtl12 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "RFKTrash", leaveGap = 1 }
			},

			{	name = "安其拉廢墟",		-- Ruins of Ahn'Qiraj
				type = AM_TYP_INSTANCE,
				displayname = "安其拉廢墟",
				displayshort = "AQ20",
				filename = "RuinsofAhnQiraj",		-- RuinsofAhnQiraj
				location = "希利蘇斯 (29, 96)",
				levels = "60+",
				players = "20",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {64, 2} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "庫林納克斯", colour = AM_RED, coords = { {55, 29} }, symbol = { "1" },
						tooltiptxt = "首領 & 菁英", lootid = "AQ20Kurinnaxx" },
				dtl3  = { text ="安多洛夫中將,\n四個卡多雷精英", colour = AM_RED, coords = { {55, 29} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ20Andorov" },
				dtl4  = { text = "奎茲上尉", colour = AM_RED, coords = { {52.1, 46.9} }, symbol = { "2" },
						tooltiptxt = "Lvl63 菁英", lootid = "AQ20CAPTIAN" },
				dtl5  = { text = "圖畢德上尉", colour = AM_RED, coords = { {55.4, 46.9} }, symbol = { "3" },
						tooltiptxt = "Lvl63 菁英", lootid = "AQ20CAPTIAN" },
				dtl6  = { text = "德蘭上尉", colour = AM_RED, coords = { {57.2, 47.9} }, symbol = { "4" },
						tooltiptxt = "Lvl63 菁英", lootid = "AQ20CAPTIAN"  },
				dtl7  = { text = "瑟瑞姆上尉", colour = AM_RED, coords = { {59.2, 49.2} }, symbol = { "5" },
						tooltiptxt = "Lvl63 菁英", lootid = "AQ20CAPTIAN"  },
				dtl8  = { text = "葉吉斯少校", colour = AM_RED, coords = { {61.3, 50.3} }, symbol = { "6" },
						tooltiptxt = "Lvl63 菁英", lootid = "AQ20CAPTIAN"  },
				dtl9  = { text = "帕康少校", colour = AM_RED, coords = { {60, 53.4} }, symbol = { "7" },
						tooltiptxt = "Lvl63 菁英", lootid = "AQ20CAPTIAN"  },
				dtl10  = { text = "澤朗上校", colour = AM_RED, coords = { {56, 51.2} }, symbol = { "8" },
						tooltiptxt = "Lvl63 菁英", lootid = "AQ20CAPTIAN"  },
				dtl11 = { text = "拉賈克斯將軍", colour = AM_RED, coords = { {52.2, 49.5} }, symbol = { "9" },
						tooltiptxt = "首領", lootid = "AQ20Rajaxx"  },
				dtl12 = { text = "莫阿姆", colour = AM_RED, coords = { {13, 31} }, symbol = { "10" },
						tooltiptxt = "首領", lootid = "AQ20Moam"  },
				dtl13 = { text = "吞咽者布魯", colour = AM_RED, coords = { {83, 55} }, symbol = { "11" },
						tooltiptxt = "首領", lootid = "AQ20Buru"  },
				dtl14 = { text = "安全的房間", colour = AM_GREEN, coords = { {65, 70} }, symbol = { "12" },
						tooltiptxt = ""  },
				dtl15 = { text = "狩獵者阿亞米斯", colour = AM_RED, coords = { {67, 91} }, symbol = { "13" },
						tooltiptxt = "首領", lootid = "AQ20Ayamiss"  },
				dtl16 = { text = "無疤者奧斯里安", colour = AM_RED, coords = { {29, 73} }, symbol = { "14" },
						tooltiptxt = "首領", lootid = "AQ20Ossirian", leaveGap = 2  },
				dtl17 = { text = "職業書籍", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ20ClassBooks" },
				dtl18 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQEnchants" },
				dtl19 = { text = "AQ20"..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ20SET", leaveGap = 1 }
			},

			{	name = "血色修道院",			-- Scarlet Monastery
				type = AM_TYP_INSTANCE,
				displayname = "血色修道院",
				displayshort = "SM",
				filename = "ScarletMonastery",
				location = "提里斯法林地 (83.6, 34)",
				levels = "30-40",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = "墓地入口", colour = AM_GREEN, coords = { {61, 97} }, symbol = { "G" },
						tooltiptxt = "" },
				dtl2  = { text = "鐵脊死靈", colour = AM_RED, coords = { {21, 88} }, symbol = { "1" },
						tooltiptxt = "Lvl33 菁英不死族\n墓地", special = AM_RARE, lootid = "SMIronspine"  },
				dtl3  = { text = "永醒的艾希爾", colour = AM_RED, coords = { {5, 88} }, symbol = { "2" },
						tooltiptxt = "Lvl33 菁英不死族\n墓地", special = AM_RARE, lootid = "SMAzshir"  },
				dtl4  = { text = "死靈勇士", colour = AM_RED, coords = { {8, 80} }, symbol = { "3" },
						tooltiptxt = "Lvl33 菁英不死族\n墓地", special = AM_RARE, lootid = "SMFallenChampion" },
				dtl5  = { text = "血法師薩爾諾斯", colour = AM_RED, coords = { {5, 77} }, symbol = { "4" },
						tooltiptxt = "Lvl34 菁英不死族\n墓地", lootid = "SMBloodmageThalnos" },
				dtl6  = { text = "圖書館入口", colour = AM_GREEN, coords = { {56, 74} }, symbol = { "L" },
						tooltiptxt = "" },
				dtl7  = { text = "馴犬者洛克希", colour = AM_RED, coords = { {66.1, 95} }, symbol = { "5" },
						tooltiptxt = "Lvl34 菁英人形怪\n圖書館", lootid = "SMHoundmasterLoksey"  },
				dtl8  = { text = "奧法師杜安", colour = AM_RED, coords = { {95.1, 92} }, symbol = { "6" },
						tooltiptxt = "Lvl37 菁英人形怪\n圖書館", lootid = "SMDoan", leaveGap = 1  },
				dtl9  = { text = "軍械庫入口", colour = AM_GREEN, coords = { {54, 65} }, symbol = { "A" },
						tooltiptxt = "" },
				dtl10 = { text = "赫洛德", colour = AM_RED, coords = { {74.8, 6.2} }, symbol = { "7" },
						tooltiptxt = "Lvl40 菁英人形怪\n軍械庫", lootid = "SMHerod", leaveGap = 1  },
				dtl11 = { text = "大教堂入口", colour = AM_GREEN, coords = { {37, 65} }, symbol = { "C" },
						tooltiptxt = "" },
				dtl12 = { text = "大檢察官法爾班克斯", colour = AM_RED, coords = { {31, 11} }, symbol = { "8" },
						tooltiptxt = "Lvl40 菁英人形怪\n大教堂", lootid = "SMFairbanks"  },
				dtl13 = { text = "血色十字軍指揮官莫格萊尼", colour = AM_RED, coords = { {23.4, 12} }, symbol = { "9" },
						tooltiptxt = "Lvl42 菁英人形怪\n大教堂", lootid = "SMMograine"  },
				dtl14 = { text = "大檢察官懷特邁恩", colour = AM_RED, coords = { {23.4, 4.4} }, symbol = { "10" },
						tooltiptxt = "Lvl42 菁英人形怪\n大教堂", lootid = "SMWhitemane", leaveGap = 2  },
				dtl15 = { text = "套裝 : 血色十字軍系列", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "6 件", lootid = "SMScarletSET", leaveGap = 1 },
				dtl16 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "SMTrash", leaveGap = 1 }
			},

			{	name = "安其拉",			-- Ahn'Qiraj
				type = AM_TYP_INSTANCE,
				displayname = "安其拉神廟",
				displayshort = "AQ40",
				filename = "TempleofAhnQiraj",		-- TempleofAhnQiraj
				location = "希利蘇斯 (29, 96)",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {16, 37} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "亞雷戈斯\n凱雷斯特拉茲\n夢境之龍麥琳瑟拉", colour = AM_BLUE, coords = { {21, 56} }, symbol = { "A" },
						tooltiptxt = ""  },
				dtl3  = { text = "安多葛斯\n溫瑟拉\n坎多斯特拉茲", colour = AM_BLUE, coords = { {27, 43} }, symbol = { "B" },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "預言者斯克拉姆", colour = AM_RED, coords = { {19, 41} }, symbol = { "1" },
						tooltiptxt = "首領\n戶外", lootid = "AQ40Skeram" },
				dtl5  = { text = "維姆/克里勳爵/亞爾基公主", colour = AM_RED, coords = { {15, 52} }, symbol = { "2" },
						tooltiptxt = "首領", special = AM_OPTIONAL, lootid = "AQ40Vem" },
				dtl6  = { text = "沙爾圖拉", colour = AM_RED, coords = { {40, 30} }, symbol = { "3" },
						tooltiptxt = "首領", lootid = "AQ40Sartura" },
				dtl7  = { text = "頑強的范克里斯", colour = AM_RED, coords = { {67, 14} }, symbol = { "4" },
						tooltiptxt = "首領", lootid = "AQ40Fankriss"  },
				dtl8  = { text = "維希度斯", colour = AM_RED, coords = { {82, 7} }, symbol = { "5" },
						tooltiptxt = "首領", special = AM_OPTIONAL, lootid = "AQ40Viscidus"  },
				dtl9  = { text = "哈霍蘭公主", colour = AM_RED, coords = { {41, 49} }, symbol = { "6" },
						tooltiptxt = "首領", lootid = "AQ40Huhuran"  },
				dtl10 = { text = "雙子帝王", colour = AM_RED, coords = { {72, 67} }, symbol = { "7" },
						tooltiptxt = "首領\n維克尼拉斯大帝\n維克洛爾大帝", lootid = "AQ40Emperors"  },
				dtl11 = { text = "奧羅", colour = AM_RED, coords = { { 22, 87 } }, symbol = { "8" },
						tooltiptxt = "首領", special = AM_OPTIONAL, lootid = "AQ40Ouro" },
				dtl12 = { text = "克蘇恩之眼", colour = AM_RED, coords = { {25, 50} }, symbol = { "9" },
						tooltiptxt = "", lootid = "AQ40CThun" },
				dtl13 = { text = "克蘇恩", colour = AM_RED, coords = { {25, 50} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ40CThun", leaveGap = 2 },
				dtl14 = { text = AM_MOB_LOOT, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ40Trash", leaveGap = 1 },
				dtl15 = { text = "AQ40 "..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ40SET", leaveGap = 1 },
				dtl16 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AQEnchants", leaveGap = 1 },
				dtl17 = { text = "AQ Brood Rings", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQBroodRings", leaveGap = 1 },
				dtl18 = { text = AM_OPENING, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQOpening", leaveGap = 1 }
			},

			{	name = "死亡礦井",			-- The Deadmines
				type = AM_TYP_INSTANCE,
				displayname = "死亡礦井",
				filename = "TheDeadmines",
				location = "西部荒野 (42, 72)",
				levels = "16-26",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {12, 23} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_EXITS, colour = AM_RED, coords = { {99, 42} }, symbol = { AM_EXIT_SYMBOL },
						tooltiptxt = "" },
				dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {80, 40} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "拉克佐", colour = AM_RED, coords = { {21, 58} }, symbol = { "1" },
						tooltiptxt = "Lvl19 菁英人形怪", lootid = "VCRhahkZor" },
				dtl5  = { text = "礦工約翰森", colour = AM_RED, coords = { {41, 50} }, symbol = { "2" },
						tooltiptxt = "Lvl19 菁英人形怪", lootid = "VCMinerJohnson", special = AM_RARE  },
				dtl6  = { text = "斯尼德", colour = AM_RED, coords = { {37, 77} }, symbol = { "3" },
						tooltiptxt = "Lvl20 菁英機器人 (伐木機上)", lootid = "VCSneed"  },
				dtl7  = { text = "基爾尼格", colour = AM_RED, coords = { {48.8, 60.2} }, symbol = { "4" },
						tooltiptxt = "Lvl20 菁英人形怪", lootid = "VCGilnid"  },
				dtl8  = { text = "迪菲亞火藥", colour = AM_GREEN, coords = { {55.6, 39} }, symbol = { "5" },
						tooltiptxt = "...火藥用於炸開大門"  },
				dtl9  = { text = "重拳先生", colour = AM_RED, coords = { {76, 31} }, symbol = { "6" },
						tooltiptxt = "Lvl20 菁英人形怪", lootid = "VCMrSmite"  },
				dtl10 = { text = "曲奇", colour = AM_RED, coords = { {81, 36} }, symbol = { "7" },
						tooltiptxt = "", lootid = "VCCookie"  },
				dtl11 = { text = "綠皮隊長", colour = AM_RED, coords = { {76, 37} }, symbol = { "8" },
						tooltiptxt = "Lvl21 菁英人形怪", lootid = "VCCaptainGreenskin"  },
				dtl12 = { text = "艾德溫‧范克里夫", colour = AM_RED, coords = { {79, 37} }, symbol = { "9" },
						tooltiptxt = "Lvl21 菁英人形怪", lootid = "VCVanCleef", leaveGap = 2 },
				dtl13 = { text = "套裝 : 迪菲亞皮甲", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "5 件", lootid = "VCDefiasSET", leaveGap = 1 }
			},

			{	name = "監獄",			-- The Stockade
				type = AM_TYP_INSTANCE,
				displayname = "監獄",
				filename = "TheStockade",
				location = "暴風城",
				levels = "24-32",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {50, 74} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {69, 60}, {75, 40}, {26, 57}, {31, 36}, {18, 29} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "可怕的塔高爾", colour = AM_RED, coords = { {58, 63}, {41, 55}, {50, 37}, {27, 50} }, symbol = { "1" },
						tooltiptxt = "Lvl24 菁英人形怪", special = AM_VARIES },
				dtl4  = { text = "卡姆‧深怒", colour = AM_RED, coords = { {73, 43} }, symbol = { "2" },
						tooltiptxt = "Lvl27 菁英人形怪", lootid = "SWStKamDeepfury" },
				dtl5  = { text = "哈姆霍克", colour = AM_RED, coords = { {85, 56} }, symbol = { "3" },
						tooltiptxt = "Lvl28 菁英人形怪"  },
				dtl6  = { text = "巴基爾‧斯瑞德", colour = AM_RED, coords = { {95, 62} }, symbol = { "4" },
						tooltiptxt = ""  },
				dtl7  = { text = "迪克斯特‧瓦德", colour = AM_RED, coords = { {15, 40} }, symbol = { "5" },
						tooltiptxt = "Lvl26 菁英人形怪"  },
				dtl8  = { text = "布魯戈‧艾爾克納寇", colour = AM_RED, coords = { {22, 54} }, symbol = { "6" },
						tooltiptxt = "Lvl26 菁英人形怪", special = AM_RARE, lootid = "SWStBruegalIronknuckle", leaveGap = 1 }
			},

			{	name = "阿塔哈卡神廟",			-- The Sunken Temple
				type = AM_TYP_INSTANCE,
				displayname = "沈沒的神廟",
				displayshort = "ST",
				filename = "TheSunkenTemple",
				location = "悲傷沼澤 (70, 53)",
				levels = "45-60",
				players = "10",
				prereq = "",
				general = "也被稱呼為阿塔哈卡神廟",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {62, 7} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "入口處通往高層的階梯", colour = AM_GREEN, coords = { {54, 11.3}, {13.9, 47} }, symbol = { "SL" },
						tooltiptxt = "" },
				dtl3  = { text = "入口處通往中層的階梯", colour = AM_GREEN, coords = { {69, 11.3} }, symbol = { "SM" },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "通往上層的階梯", colour = AM_BLUE, coords = { {52, 18}, {69, 18}, {52, 48}, {69, 48} }, symbol = { AM_STAIRS_SYMBOL },
						tooltiptxt = "" },
				dtl5  = { text = "食人妖小首領 (上層)", colour = AM_RED, coords = { {55, 23}, {66, 23}, {72, 33}, {49, 33}, {54, 43}, {66, 43} }, symbol = { "T1", "T2", "T3", "T4", "T5", "T6" },
						tooltiptxt = "全部殺死後,然後是迦瑪蘭\n接著是伊蘭尼庫斯", lootid = "STTrollMinibosses", leaveGap = 1 },
				dtl6  = { text = "雕像 (下層)", colour = AM_ORANGE, coords = { {22, 82}, {22, 64}, {13, 77}, {30, 77}, {13, 68}, {30, 68} }, symbol = { "S1", "S2", "S3", "S4", "S5", "S6" },
						tooltiptxt = "依標示的順序啟動雕像\n以召喚阿塔拉利恩" },
				dtl7  = { text = "哈卡祭壇", colour = AM_ORANGE, coords = { {22, 74} }, symbol = { "1" },
						tooltiptxt = ""  },
				dtl8  = { text = "阿塔拉利恩", colour = AM_RED, coords = { {22, 71} }, symbol = { "2" },
						tooltiptxt = "Lvl50 菁英人形怪", lootid = "STAtalalarion", leaveGap = 1  },
				dtl9  = { text = "德姆塞卡爾", colour = AM_RED, coords = { {58, 33} }, symbol = { "3" },
						tooltiptxt = "Lvl53 菁英龍族", lootid = "STDreamscythe"  },
				dtl10 = { text = "德拉維沃爾", colour = AM_RED, coords = { {62, 33} }, symbol = { "4" },
						tooltiptxt = "Lvl51 菁英龍族", lootid = "STWeaver"  },
				dtl11 = { text = "哈卡的化身", colour = AM_RED, coords = { {32, 33} }, symbol = { "5" },
						tooltiptxt = "Lvl50 菁英龍", lootid = "STAvatarofHakkar"  },
				dtl12 = { text = "預言者迦瑪蘭", colour = AM_RED, coords = { {88, 27} }, symbol = { "6" },
						tooltiptxt = "Lvl54 菁英人形怪", lootid = "STJammalan"  },
				dtl13 = { text = "可悲的奧戈姆", colour = AM_RED, coords = { {88, 31} }, symbol = { "7" },
						tooltiptxt = "Lvl53 菁英不死族", lootid = "STOgom"  },
				dtl14 = { text = "摩弗拉斯", colour = AM_RED, coords = { {59, 62} }, symbol = { "8" },
						tooltiptxt = "Lvl52 菁英龍", lootid = "STMorphaz"  },
				dtl15 = { text = "哈札斯", colour = AM_RED, coords = { {62, 62} }, symbol = { "9" },
						tooltiptxt = "Lvl53 菁英龍", lootid = "STHazzas"  },
				dtl16 = { text = "伊蘭尼庫斯的陰影", colour = AM_RED, coords = { {80, 62} }, symbol = { "10" },
						tooltiptxt = "Lvl55 菁英龍", lootid = "STEranikus"  },
				dtl17 = { text = "精華之泉", colour = AM_ORANGE, coords = { {85, 57} }, symbol = { "11" },
						tooltiptxt = "把伊蘭尼庫斯精華放在精華之泉裡", leaveGap = 1 },
				dtl18 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "STTrash", leaveGap = 1 }
			},

			{	name = "奧達曼",			-- Uldaman
				type = AM_TYP_INSTANCE,
				displayname = "奧達曼",
				filename = "Uldaman",
				location = "荒蕪之地 (44, 12)",
				levels = "35-50",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = "正門入口", colour = AM_GREEN, coords = { {89, 73.1} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "奧達曼"..AM_EXTERIOR },
				dtl2  = { text = "後門入口", colour = AM_GREEN, coords = { {21, 71} }, symbol = { "XR" },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "巴爾洛戈", colour = AM_RED, coords = { {73, 93} }, symbol = { "1" },
						tooltiptxt = "Lvl41 Elite" },
				dtl4  = { text = "聖騎士的遺體", colour = AM_ORANGE, coords = { {62.8, 63.2} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl5  = { text = "魯維羅什", colour = AM_RED, coords = { {64, 73.3} }, symbol = { "3" },
						tooltiptxt = "Lvl40 菁英人形怪", lootid = "UldRevelosh"  },
				dtl6  = { text = "艾隆納亞", colour = AM_RED, coords = { {38, 75} }, symbol = { "4" },
						tooltiptxt = "首領 Giant", lootid = "UldIronaya"  },
				dtl7  = { text = "安諾拉 (大師級附魔師)", colour = AM_BLUE, coords = { {56, 61} }, symbol = { "5" },
						tooltiptxt = ""  },
				dtl8  = { text = "黑曜石哨兵", colour = AM_RED, coords = { {24.4, 62} }, symbol = { "6" },
						tooltiptxt = "Lvl42 菁英機器人"  },
				dtl9  = { text = "古代的石頭看守者", colour = AM_RED, coords = { {54.7, 43} }, symbol = { "7" },
						tooltiptxt = "Lvl44 菁英元素怪", lootid = "UldAncientStoneKeeper"  },
				dtl10 = { text = "加加恩‧火錘", colour = AM_RED, coords = { {21, 31} }, symbol = { "8" },
						tooltiptxt = "首領 人形怪", lootid = "UldGalgannFirehammer"  },
				dtl11 = { text = "格瑞姆洛克", colour = AM_RED, coords = { {17, 19} }, symbol = { "9" },
						tooltiptxt = "Lvl45 菁英人形怪", lootid = "UldGrimlok"  },
				dtl12 = { text = "阿札達斯", colour = AM_RED, coords = { {45.2, 14.4} }, symbol = { "10" },
						tooltiptxt = "首領 巨人\n下層", lootid = "UldArchaedas"  },
				dtl13 = { text = "諾甘農圓盤", colour = AM_ORANGE, coords = { {39.7, 6.2} }, symbol = { "11" },
						tooltiptxt = "上層"  },
				dtl14 = { text = "古代寶藏", colour = AM_ORANGE, coords = { {42.3, 4.9} }, symbol = { "12" },
						tooltiptxt = "下層", leaveGap = 1 },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "UldTrash", leaveGap = 1 }
			},

			{	name = "奧達曼"..AM_EXTERIOR,		-- Uldaman Exterior
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 奧達曼",
				filename = "UldamanExt",
				location = "荒蕪之地 (44, 12)",
				levels = "",
				players = "",
				prereq = "",
				general = "",
				area = "Azeroth",
				wmData = { minX = 0.536226, maxX = 0.544795, minY =  0.57594, maxY = 0.586616 },
				amData = { minX = 0.075, maxX = 0.95, minY = 0.20, maxY = 0.935 },
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {95, 33}  }, symbol = { "X" },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_BLUE, coords = { {23, 64}, {33, 88} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "Quests", leaveGap = 1 },
				dtl3  = { text = "奧達曼", colour = AM_GREEN, coords = { {30.5, 23} }, symbol = { "U" },
						tooltiptxt = "", toMap = "奧達曼", leaveGap = 1 }
			},

			{ 	name = "哀嚎洞穴",			-- Wailing Caverns
				type = AM_TYP_INSTANCE,
				displayname = "哀嚎洞穴",
				displayshort = "WC",
				filename = "WailingCaverns",
				location = "貧瘠之地 (46, 36)",
				levels = "16-25",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {44, 58} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "哀嚎洞穴"..AM_EXTERIOR },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {62, 47}, {94, 49} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "納拉雷克斯的信徒", colour = AM_BLUE, coords = { {45, 53} }, symbol = { "1" },
						tooltiptxt = "" },
				dtl4  = { text = "考布萊恩", colour = AM_RED, coords = { {14, 55} }, symbol = { "2" },
						tooltiptxt = "Lvl20 菁英人形怪", lootid = "WCLordCobrahn" },
				dtl5  = { text = "安娜科德拉", colour = AM_RED, coords = { {39, 35} }, symbol = { "3" },
						tooltiptxt = "Lvl20 菁英人形怪", lootid = "WCLadyAnacondra" },
				dtl6  = { text = "克雷什", colour = AM_RED, coords = { {45, 42} }, symbol = { "4" },
						tooltiptxt = "Lvl20 菁英人形怪", lootid = "WCKresh"  },
				dtl7  = { text = "變異精靈龍", colour = AM_RED, coords = { {63, 43} }, symbol = { "5" },
						tooltiptxt = "Lvl20 菁英龍族", lootid = "WCDeviateFaerieDragon", special = AM_RARE },
				dtl8  = { text = "皮薩斯", colour = AM_RED, coords = { {86, 34} }, symbol = { "6" },
						tooltiptxt = "Lvl22 菁英人形怪", lootid = "WCLordPythas"  },
				dtl9  = { text = "斯卡姆", colour = AM_RED, coords = { {93, 69} }, symbol = { "7" },
						tooltiptxt = "Lvl21 菁英人形怪", lootid = "WCSkum"  },
				dtl10  = { text = "瑟芬迪斯", colour = AM_RED, coords = { {60, 52} }, symbol = { "8" },
						tooltiptxt = "Lvl22 菁英人形怪\nUpper level", lootid = "WCLordSerpentis"  },
				dtl11 = { text = "永生者沃爾丹", colour = AM_RED, coords = { {56, 48} }, symbol = { "9" },
						tooltiptxt = "Lvl24 菁英元素怪\nUpper level", lootid = "WCVerdan"  },
				dtl12 = { text = "吞噬者穆坦努斯", colour = AM_RED, coords = { {29.9, 23.9} }, symbol = { "10" },
						tooltiptxt = "Lvl22 菁英人形怪\nTriggered Spawn", lootid = "WCMutanus"  },
				dtl13 = { text = "納拉雷克斯", colour = AM_RED, coords = { {32.4, 25.4} }, symbol = { "11" },
						tooltiptxt = "Lvl25 菁英人形怪", leaveGap = 2  },
				dtl14 = { text = "套裝 : 毒蛇的擁抱", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "5 件", lootid = "WCViperSET", leaveGap = 1 }
			},

			{	name = "哀嚎洞穴"..AM_EXTERIOR,		-- Wailing Caverns Exterior
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 哀嚎洞穴",
				filename = "WailingCavernsExt",
				location = "貧瘠之地 (46, 36)",
				levels = "",
				players = "",
				prereq = "",
				general = "",
				area = "Kalimdor",
				wmData = { minX = 0.5178145, maxX = 0.529001, minY =  0.543372, maxY = 0.555871 },
				amData = { minX = 0.05, maxX = 0.97, minY = 0.15, maxY = 0.80 },
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {14.2, 81.5}  }, symbol = { "X" },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "哀嚎洞穴", colour = AM_GREEN, coords = { {55.1, 62.2} }, symbol = { "W" },
						tooltiptxt = "", toMap = "哀嚎洞穴", leaveGap = 1 }
			},

			{	name = "祖爾法拉克",			-- Zul'Farrak
				type = AM_TYP_INSTANCE,
				displayname = "祖爾法拉克",
				displayshort = "ZF",
				filename = "ZulFarrak",
				location = "塔納利斯 (37, 15)",
				levels = "43-47",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {69, 89} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "澤雷利斯", colour = AM_RED, coords = { {63, 47} }, symbol = { "1" },
						tooltiptxt = "Lvl45 菁英人形怪", special = AM_RARE.." "..AM_WANDERS, lootid = "ZFZerillis" },
				dtl3  = { text = "杉達爾‧沙掠者", colour = AM_RED, coords = { {55, 59} }, symbol = { "2" },
						tooltiptxt = "Lvl45 菁英人形怪", special = AM_RARE },
				dtl4  = { text = "水占師維蕾薩", colour = AM_RED, coords = { {34, 43} }, symbol = { "3" },
						tooltiptxt = "Lvl46 菁英人形怪" },
				dtl5  = { text = "加茲瑞拉", colour = AM_RED, coords = { {37, 46} }, symbol = { "4" },
						tooltiptxt = "Lvl46 菁英野獸", lootid = "ZFGahzrilla"  },
				dtl6  = { text = "灰塵怨靈", colour = AM_RED, coords = { {32, 46} }, symbol = { "5" },
						tooltiptxt = "Lvl45 菁英人形怪", special = AM_RARE, lootid = "ZFDustwraith"  },
				dtl7  = { text = "安圖蘇爾", colour = AM_RED, coords = { {80, 35} }, symbol = { "6" },
						tooltiptxt = "Lvl48 菁英人形怪", lootid = "ZFAntusul"  },
				dtl8  = { text = "殉教者塞卡", colour = AM_RED, coords = { {67, 33} }, symbol = { "7" },
						tooltiptxt = "Lvl46 菁英人形怪"  },
				dtl9  = { text = "巫醫祖穆拉恩", colour = AM_RED, coords = { {53, 23} }, symbol = { "8" },
						tooltiptxt = "Lvl46 菁英人形怪", lootid = "ZFWitchDoctorZumrah"  },
				dtl10 = { text = "祖爾法拉克陣亡英雄", colour = AM_RED, coords = { {51, 27} }, symbol = { "9" },
						tooltiptxt = "Lvl46 菁英人形怪"  },
				dtl11 = { text = "暗影祭司塞瑟斯", colour = AM_RED, coords = { {36, 26} }, symbol = { "10" },
						tooltiptxt = "Lvl47 菁英人形怪", lootid = "ZFSezzziz" },
				dtl12 = { text = "耐克魯姆", colour = AM_RED, coords = { {36, 26} }, symbol = { " " },
						tooltiptxt = "Lvl46 菁英不死族"  },
				dtl13 = { text = "布萊中士", colour = AM_ORANGE, coords = { {26, 26} }, symbol = { "11" },
						tooltiptxt = "探水棒任務\n敵對/友善依陣營與採取的動作而定" },
				dtl14 = { text = "Ruuzlu", colour = AM_RED, coords = { {51, 39} }, symbol = { "12" },
						tooltiptxt = "Lvl46 菁英人形怪"  },
				dtl15 = { text = "烏克茲‧沙頂", colour = AM_RED, coords = { {55, 42} }, symbol = { "13" },
						tooltiptxt = "Lvl48 菁英人形怪", lootid = "ZFChiefUkorzSandscalp", leaveGap = 1 },
				dtl16 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZFTrash", leaveGap = 1 }
			},

			{	name = "祖爾格拉布",			-- Zul'Gurub
				type = AM_TYP_INSTANCE,
				displayname = "祖爾格拉布",
				displayshort = "ZG",
				filename = "ZulGurub",
				location = "荊棘谷 (54, 17)",
				levels = "60+",
				players = "20",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {12, 50} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "混濁的水", colour = AM_BLUE, coords = { {33, 41}, {47, 48}, {57, 47}, {60, 32}, {47, 30} }, symbol = { "W" },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "高階祭司 耶克里克", colour = AM_RED, coords = { {34, 78} }, symbol = { "1" },
						tooltiptxt = "首領 人形怪", special = "(蝙蝠王)", lootid = "ZGJeklik" },
				dtl4  = { text = "高階祭司 溫諾希斯", colour = AM_RED, coords = { {56, 57} }, symbol = { "2" },
						tooltiptxt = "首領 人形怪", special = "(蛇王)", lootid = "ZGVenoxis" },
				dtl5  = { text = "高階祭司 瑪爾羅", colour = AM_RED, coords = { {48, 85} }, symbol = { "3" },
						tooltiptxt = "首領 人形怪", special = "(蜘蛛王)", lootid = "ZGMarli"  },
				dtl6  = { text = "血領主 曼多基爾", colour = AM_RED, coords = { {76, 73} }, symbol = { "4" },
						tooltiptxt = "首領 人形怪", special = "(恐龍王)"..AM_OPTIONAL, lootid = "ZGMandokir"  },
				dtl7  = { text = "瘋狂之源", colour = AM_RED, coords = { {72, 47} }, symbol = { "5" },
						tooltiptxt = "", special = AM_OPTIONAL  },
				dtl8  = { text = "格里雷克‧鋼鐵之血", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "首領 不死族", lootid = "ZGGrilek"  },
				dtl9  = { text = "哈札拉爾‧織夢者", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "首領 不死族", lootid = "ZGHazzarah"  },
				dtl10 = { text = "雷納塔基‧千刃之王", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "首領 不死族", lootid = "ZGRenataki"  },
				dtl11 = { text = "烏蘇雷‧雷巫", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "首領 不死族", lootid = "ZGWushoolay"  },
				dtl12 = { text = "加茲蘭卡", colour = AM_RED, coords = { {66, 33} }, symbol = { "6" },
						tooltiptxt = "首領 人形怪", special = AM_OPTIONAL, lootid = "ZGGahzranka"  },
				dtl13 = { text = "高階祭司 塞卡爾", colour = AM_RED, coords = { {80, 32} }, symbol = { "7" },
						tooltiptxt = "首領 人形怪", special = "(虎王)", lootid = "ZGThekal" },
				dtl14 = { text = "高階祭司 婭爾羅", colour = AM_RED, coords = { {49, 16} }, symbol = { "8" },
						tooltiptxt = "首領 人形怪", special = "(豹王)", lootid = "ZGArlokk"  },
				dtl15 = { text = "妖術師 金度", colour = AM_RED, coords = { {20, 18} }, symbol = { "9" },
						tooltiptxt = "首領 人形怪", special = "(瘟疫之神)"..AM_OPTIONAL, lootid = "ZGJindo" },
				dtl16 = { text = "哈卡", colour = AM_RED, coords = { {54, 40} }, symbol = { "10" },
						tooltiptxt = "首領 龍", lootid = "ZGHakkar", leaveGap = 2 },
				dtl17 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZGTrash", leaveGap = 1 },
				dtl18 = { text = "ZG"..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZGSET", leaveGap = 1 },
				dtl19 = { text = AM_RBOSS_DROP, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZGShared", leaveGap = 1 },
				dtl20 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZGEnchants", leaveGap = 1 }
			},

			{	name = "通靈學院",			-- Scholomance
				type = AM_TYP_INSTANCE,
				displayname = "通靈學院",
				filename = "Scholomance",		-- Scholomance*
				location = "西瘟疫之地 (69, 73)",
				levels = "56-60",
				players = "5",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {24, 30} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {28, 38} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "" },
				dtl3  = { text = AM_INSTANCE_STAIRS, colour = AM_GREEN, coords = { {6.5, 22}, {62, 22} }, symbol = { "S1" },
						tooltiptxt = "" },
				dtl4  = {text = AM_INSTANCE_STAIRS, colour = AM_GREEN, coords = { {41, 41}, {34, 80} }, symbol = { "S2" },
						tooltiptxt = "", leaveGap = 1 },
				dtl5  = { text = "基爾圖諾斯的衛士", colour = AM_RED, coords = { {54, 32} }, symbol = { "1" },
						tooltiptxt = "Lvl61 菁英惡魔", lootid = "SCHOLOBloodSteward"  },
				dtl6  = { text = "傳令官基爾圖諾斯", colour = AM_RED, coords = { {30, 5} }, symbol = { "2" },
						tooltiptxt = "", lootid = "SCHOLOKirtonostheHerald" },
				dtl7  = { text = "詹迪斯‧巴羅夫", colour = AM_RED, coords = { {96, 8.5} }, symbol = { "3" },
						tooltiptxt = "Lvl61 菁英不死族", lootid = "SCHOLOJandiceBarov"  },
				dtl8  = { text = "血骨傀儡", colour = AM_RED, coords = { {10, 41} }, symbol = { "4" },
						tooltiptxt = "Lvl61 菁英不死族\n下層\n會掉落觀察室鑰匙", lootid = "SCHOLORattlegore"  },
				dtl9  = { text = "死亡騎士達克雷爾", colour = AM_RED, coords = { {10, 41} }, symbol = { " " },
						tooltiptxt = "Lvl62 菁英不死族", lootid = "SCHOLODeathKnight" },
				dtl10  = { text = "馬杜克‧布萊克波爾", colour = AM_BLUE, coords = { {23.7, 42} }, symbol = { "5" },
						tooltiptxt = "Lvl58 菁英\n在觀察室放下黎明先鋒的箱子後\n會轉為敵對", lootid = "SCHOLOMarduk"  },
				dtl11 = { text = "維克圖斯", colour = AM_BLUE, coords = { {27.2, 42} }, symbol = { "6" },
						tooltiptxt = "Lvl60 菁英不死族\n在觀察室放下黎明先鋒的箱子後\n會轉為敵對", lootid = "SCHOLOVectus"  },
				dtl12 = { text = "萊斯‧霜語", colour = AM_RED, coords = { {18, 87} }, symbol = { "8" },
						tooltiptxt = "Lvl62 菁英不死族", lootid = "SCHOLORasFrostwhisper"  },
				dtl13 = { text = "科爾莫克", colour = AM_RED, coords = { {18, 80} }, symbol = { "9" },
						tooltiptxt = "Lvl60 菁英", lootid = "SCHOLOKormok" },
				dtl14 = { text = "講師瑪麗希亞", colour = AM_RED, coords = { {44.5, 94} }, symbol = { "10" },
						tooltiptxt = "Lvl60 菁英人形怪", lootid = "SCHOLOInstructorMalicia"  },
				dtl15 = { text = "瑟爾林‧卡斯迪諾夫教授", colour = AM_RED, coords = { {64, 74.2} }, symbol = { "11" },
						tooltiptxt = "Lvl60 菁英人形怪", lootid = "SCHOLODoctorTheolenKrastinov"  },
				dtl16 = { text = "博學者普克爾特", colour = AM_RED, coords = { {44.8, 55.2} }, symbol = { "12" },
						tooltiptxt = "Lvl60 菁英不死族", lootid = "SCHOLOLorekeeperPolkelt"  },
				dtl17 = { text = "拉文尼亞", colour = AM_RED, coords = { {75.8, 92} }, symbol = { "13" },
						tooltiptxt = "Lvl60 菁英不死族", lootid = "SCHOLOTheRavenian"  },
				dtl18 = { text = "阿萊克斯‧巴羅夫", colour = AM_RED, coords = { {96.2, 74.5} }, symbol = { "14" },
						tooltiptxt = "Lvl60 菁英不死族", lootid = "SCHOLOLordAlexeiBarov"  },
				dtl19 = { text = "伊露希亞‧巴羅夫", colour = AM_RED, coords = { {75.6, 54} }, symbol = { "15" },
						tooltiptxt = "Lvl60 菁英不死族", lootid = "SCHOLOLadyIlluciaBarov" },
				dtl20 = { text = "黑暗院長加丁", colour = AM_RED, coords = { {76.2, 74.4} }, symbol = { "16" },
						tooltiptxt = "Lvl61 菁英人形怪", lootid = "SCHOLODarkmasterGandling", leaveGap = 1 },
				dtl21 = { text = "火炬", colour = AM_GREEN, coords = { {89, 19} }, symbol = { "T" },
						tooltiptxt = "" },
				dtl22 = { text = "煉金實驗室", colour = AM_GREEN, coords = { {14, 70} }, symbol = { "AL" },
						tooltiptxt = "", leaveGap = 1 },
				dtl23 = { text = "南海鎮地契", colour = AM_ORANGE, coords = { {56, 25} }, symbol = { "D" },
						tooltiptxt = ""  },
				dtl24 = { text = "塔倫米爾地契", colour = AM_ORANGE, coords = { {11, 36} }, symbol = { "D" },
						tooltiptxt = ""  },
				dtl25 = { text = "布瑞爾地契", colour = AM_ORANGE, coords = { {15, 77} }, symbol = { "D" },
						tooltiptxt = ""  },
				dtl26 = { text = "凱爾達隆地契", colour = AM_ORANGE, coords = { {94, 72} }, symbol = { "D" },
						tooltiptxt = "", leaveGap = 1},
			},

			{	name = "斯坦索姆",			-- Stratholme
				type = AM_TYP_INSTANCE,
				displayname = "斯坦索姆",
				filename = "Stratholme",
				location = "東瘟疫之地 (30, 12)",
				levels = "55-60",
				players = "5",
				prereq = "",
				general = "側門入口在 (47, 24)",
				dtl1  = { text = "正門入口", colour = AM_GREEN, coords = { {50, 91} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "側門入口", colour = AM_GREEN, coords = { {83, 72} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "弗拉斯‧希亞比的郵箱", colour = AM_ORANGE, coords = { {37, 86} }, symbol = { "P1" },
						tooltiptxt = "" },
				dtl4  = { text = "國王廣場郵箱", colour = AM_ORANGE, coords = { {47, 74} }, symbol = { "P2" },
						tooltiptxt = "" },
				dtl5  = { text = "十字軍廣場郵箱", colour = AM_ORANGE, coords = { {24, 66} }, symbol = { "P3" },
						tooltiptxt = "" },
				dtl6  = { text = "市場郵箱", colour = AM_ORANGE, coords = { {50, 62} }, symbol = { "P4" },
						tooltiptxt = ""  },
				dtl7  = { text = "節日小道的郵箱", colour = AM_ORANGE, coords = { {61, 62} }, symbol = { "P5" },
						tooltiptxt = ""  },
				dtl8  = { text = "長者廣場郵箱", colour = AM_ORANGE, coords = { {80, 68} }, symbol = { "P6" },
						tooltiptxt = "" },
				dtl9 = { text = "郵差瑪羅恩", colour = AM_RED, coords = { {37, 86}, {47, 74}, {24, 66}, {50, 62}, {61, 62}, {80, 68} }, symbol = { " " },
						tooltiptxt = "Lvl60 菁英不死族\n在打開第三個郵箱時出現\n郵箱鑰匙從信差身上拾取", leaveGap = 1 },
				dtl10 = { text = "斯庫爾", colour = AM_RED, coords = { {42, 83} }, symbol = { "1" },
						tooltiptxt = "Lvl58 菁英不死族", special = AM_RARE.." "..AM_WANDERS, lootid = "STRATSkull" },
				dtl11 = { text = "斯坦索姆信差", colour = AM_RED, coords = { {43, 78} }, symbol = { "2" },
						tooltiptxt = "Lvl57 菁英不死族", lootid = "STRATStratholmeCourier"  },
				dtl12 = { text = "弗拉斯‧希亞比", colour = AM_RED, coords = { {39, 83} }, symbol = { "3" },
						tooltiptxt = "Lvl61 菁英不死族", lootid = "STRATFrasSiabi"  },
				dtl13 = { text = "弗雷斯特恩", colour = AM_RED, coords = { {45, 62}, {65, 58}, {66, 66} }, symbol = { "4" },
						tooltiptxt = "Lvl57 菁英不死族", special = AM_VARIES, lootid = "STRATHearthsingerForresten" },
				dtl14 = { text = "不可寬恕者", colour = AM_RED, coords = { {56, 57} }, symbol = { "5" },
						tooltiptxt = "Lvl57 菁英不死族", lootid = "STRATTheUnforgiven"  },
				dtl15 = { text = "悲慘的提米", colour = AM_RED, coords = { {26, 61.5} }, symbol = { "6" },
						tooltiptxt = "Lvl58 菁英不死族", lootid = "STRATTimmytheCruel"  },
				dtl16 = { text = "炮手威利", colour = AM_RED, coords = { {1, 74} }, symbol = { "7" },
						tooltiptxt = "Lvl60 菁英人形怪", lootid = "STRATCannonMasterWilley"  },
				dtl17 = { text = "檔案管理員加爾福特", colour = AM_RED, coords = { {24, 92} }, symbol = { "8" },
						tooltiptxt = "Lvl60 菁英人形怪", lootid = "STRATArchivistGalford"  },
				dtl18 = { text = "巴納札爾", colour = AM_RED, coords = { {17, 97} }, symbol = { "9" },
						tooltiptxt = "Lvl62 菁英惡魔", lootid = "STRATBalnazzar"  },
				dtl19 = { text = "索索斯", colour = AM_RED, coords = { {17, 97} }, symbol = { " " },
						tooltiptxt = "需要召喚火盆", lootid = "STRATSothosJarien" },
				dtl20 = { text = "賈琳", colour = AM_RED, coords = { {17, 97} }, symbol = { " " },
						tooltiptxt = "需要召喚火盆", lootid = "STRATSothosJarien" },
				dtl21 = { text = "奧裏克斯", colour = AM_BLUE, coords = { {81, 61} }, symbol = { "10" },
						tooltiptxt = ""  },
				dtl22 = { text = "石脊", colour = AM_RED, coords = { {78, 42} }, symbol = { "11" },
						tooltiptxt = "Lvl60 菁英人形怪", special = AM_RARE, lootid = "STRATStonespine"  },
				dtl23 = { text = "安娜絲塔麗男爵夫人", colour = AM_RED, coords = { {90, 39} }, symbol = { "12" },
						tooltiptxt = "Lvl59 菁英人形怪", lootid = "STRATBaronessAnastari"  },
				dtl24 = { text = "奈魯布恩坎", colour = AM_RED, coords = { {64, 39} }, symbol = { "13" },
						tooltiptxt = "Lvl60 菁英人形怪", lootid = "STRATNerubenkan"  },
				dtl25 = { text = "蒼白的瑪勒基", colour = AM_RED, coords = { {81, 14} }, symbol = { "14" },
						tooltiptxt = "Lvl61 菁英人形怪", lootid = "STRATMalekithePallid"  },
				dtl26 = { text = "巴瑟拉斯鎮長", colour = AM_RED, coords = { {66, 10}, {74, 60} }, symbol = { "15" },
						tooltiptxt = "Lvl58 菁英人形怪", special = AM_VARIES, lootid = "STRATMagistrateBarthilas" },
				dtl27 = { text = "吞咽者拉姆斯登", colour = AM_RED, coords = { {56, 15} }, symbol = { "16" },
						tooltiptxt = "Lvl61 菁英人形怪", lootid = "STRATRamsteintheGorger"  },
				dtl28 = { text = "瑞文戴爾男爵", colour = AM_RED, coords = { {42, 15} }, symbol = { "17" },
						tooltiptxt = "Lvl62 菁英人形怪", lootid = "STRATBaronRivendare", leaveGap = 1 }
			},

			{	name = "影牙城堡",			-- Shadowfang Keep
				type = AM_TYP_INSTANCE,
				displayname = "影牙城堡",
				displayshort = "SFK",
				filename = "ShadowfangKeep",
				location = "銀松森林 (45, 67)",
				levels = "20-30",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {75, 69} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {57, 57}, {36, 55}, {29, 12} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "" },
				dtl3  = { text = "城垛", colour = AM_BLUE, coords = { {38, 71}, {54, 93} }, symbol = { "B1" },
						tooltiptxt = "" },
				dtl4  = {text = "城垛", colour = AM_BLUE, coords = { {69, 85}, {35, 37} }, symbol = { "B2" },
						tooltiptxt = "" },
				dtl5  = { text = "死亡之誓", colour = AM_RED, coords = { {69, 85}, {35, 37} }, symbol = { " " },
						tooltiptxt = "Lvl25 菁英不死族", special = AM_RARE  },
				dtl6  = { text = "階梯", colour = AM_GREEN, coords = { {29.8, 34.8}, {50, 46.8} }, symbol = { "S1" },
						tooltiptxt = "" },
				dtl7  = { text = "階梯", colour = AM_GREEN, coords = { {42, 32}, {67, 33} }, symbol = { "S2" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "雷希戈爾", colour = AM_RED, coords = { {70, 78} }, symbol = { "1" },
						tooltiptxt = "Lvl20 菁英人形怪" },
				dtl9  = { text = "巫師阿克魯比", colour = AM_RED, coords = { {67, 73} }, symbol = { "2" },
						tooltiptxt = "Lvl18 菁英人形怪"  },
				dtl10 = { text = "亡靈哨兵阿達曼特", colour = AM_RED, coords = { {71, 74} }, symbol = { "3" },
						tooltiptxt = "Lvl18 菁英人形怪"  },
				dtl11 = { text = "屠夫拉佐克勞", colour = AM_RED, coords = { {25, 59} }, symbol = { "4" },
						tooltiptxt = "Lvl22 菁英人形怪", lootid = "BSFRazorclawtheButcher"  },
				dtl12 = { text = "席瓦萊恩男爵", colour = AM_RED, coords = { {13, 87} }, symbol = { "5" },
						tooltiptxt = "Lvl24 菁英不死族", lootid = "BSFSilverlaine" },
				dtl13 = { text = "指揮官斯普林瓦爾", colour = AM_RED, coords = { {26, 69} }, symbol = { "6" },
						tooltiptxt = "Lvl24 菁英不死族", lootid = "BSFSpringvale"  },
				dtl14 = { text = "盲眼守衛奧杜", colour = AM_RED, coords = { {61, 84} }, symbol = { "7" },
						tooltiptxt = "Lvl24 菁英人形怪", lootid = "BSFOdotheBlindwatcher"  },
				dtl15 = { text = "吞噬者芬魯斯", colour = AM_RED, coords = { {53.4, 33.4} }, symbol = { "8" },
						tooltiptxt = "Lvl25 菁英野獸", lootid = "BSFFenrustheDevourer"  },
				dtl16 = { text = "狼王南杜斯", colour = AM_RED, coords = { {80, 29} }, symbol = { "9" },
						tooltiptxt = "Lvl25 菁英人形怪", lootid = "BSFWolfMasterNandos"  },
				dtl17 = { text = "大法師阿魯高", colour = AM_RED, coords = { {84, 13} }, symbol = { "10" },
						tooltiptxt = "Lvl26 菁英人形怪", lootid = "BSFArchmageArugal", leaveGap = 1 },
				dtl18 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "BSFTrash", leaveGap = 1 }
			},

			{ 	name = "戰歌峽谷",			-- Warsong Gulch
				type = AM_TYP_BG,
				displayname = "戰歌峽谷",
				displayshort = "WSG",
				filename = "WarsongGulch",
				location = "梣谷 (62, 84) / 貧瘠之地 (47, 8)",
				levels = "10+ 帶狀",
				players = "10",
				prereq = "",
				general = "",
				wmData = { minX = 0.26, maxX = 0.74, minY =  0.05, maxY = 0.95 },
				amData = { minX = 0.33, maxX = 0.97, minY = 0.12, maxY = 0.88 },
				dtl1  = { text = "聯盟旗幟房", colour = AM_BLUE, coords = { {64.31, 14.15} }, symbol = { "F" },
						tooltiptxt = "聯盟玩家從這裡開始" },
				dtl2  = { text = "聯盟出口", colour = AM_BLUE, coords = { {45.93, 22.34} }, symbol = { AM_EXIT_SYMBOL },
						tooltiptxt = "使用或輸入 /afk", leaveGap = 1 },
				dtl3  = { text = "部落旗幟房", colour = AM_RED, coords = { {70.75, 85.31} }, symbol = { "F" },
						tooltiptxt = "部落玩家從這裡開始" },
				dtl4  = { text = "部落出口", colour = AM_RED, coords = { {87.75, 77.12} }, symbol = { AM_EXIT_SYMBOL },
						tooltiptxt = "使用或輸入 /afk", leaveGap = 1 },
				dtl5  = { text = "增益點", colour = AM_GREEN, coords = { {55.35, 60.26}, {76.26, 39.67} }, symbol = { "P" },
						tooltiptxt = "" },
				dtl6  = { text = "回春", colour = AM_GREEN, coords = { {81.09, 61.43}, {56.04, 39.20} }, symbol = { "R" },
						tooltiptxt = "回復生命和法力", leaveGap = 2 },
				dtl7  = { text = "聯盟旗幟搬運者", colour = AM_BLUE, coords = { {30, 15} }, symbol = { "FC" },
						tooltiptxt = "", bgFlag = "A" },
				dtl8  = { text = "部落旗幟搬運者", colour = AM_RED, coords = { {30, 85} }, symbol = { "FC" },
						tooltiptxt = "", bgFlag = "H", leaveGap = 2 },
				dtl9  = { text = AM_FRIENDLY, colour = AM_GREEN, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "WSGFriendly" },
				dtl10 = { text = AM_HONOURED, colour = AM_GREEN, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "WSGHonored" },
				dtl11 = { text = AM_REVERED, colour = AM_BLUE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "WSGRevered" },
				dtl12 = { text = AM_EXALTED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "WSGExalted", leaveGap = 1 },
				dtl13 = { text = AM_PVP_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "PVPSET", leaveGap = 1 }
			},

			{ 	name = "阿拉希盆地",			-- Arathi Basin
				type = AM_TYP_BG,
				displayname = "阿拉希盆地",
				displayshort = "AB",
				filename = "ArathiBasin",
				location = "阿拉希高地 (73, 28)",
				levels = "20+ 帶狀",
				players = "15",
				prereq = "",
				general = "",
				wmData = { minX = 0.23, maxX = 0.71, minY =  0.09, maxY = 0.76 },
				amData = { minX = 0.15, maxX = 0.93, minY = 0.05, maxY = 0.87 },
				dtl1  = { text = "聯盟起始點", colour = AM_BLUE, coords = { {21.8, 12.98} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "聯盟玩家從此處開始", bgBase = "A" },
				dtl2  = { text = "部落起始點", colour = AM_RED, coords = { {91.89, 80.63} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "部落玩家從此處開始", bgBase = "H", leaveGap = 1 },
				dtl3  = { text = "獸欄", colour = AM_GREEN, coords = { {34.67, 29.6}, {9, 28.0} }, symbol = { "S" },
						tooltiptxt = "佔領", bgPOI = true },
				dtl4  = { text = "金礦", colour = AM_GREEN, coords = { {72.81, 30.54}, {9, 34.0} }, symbol = { "M" },
						tooltiptxt = "佔領", bgPOI = true },
				dtl5  = { text = "鐵匠舖", colour = AM_GREEN, coords = { {51.9, 50.2}, {9, 50.2} }, symbol = { "B" },
						tooltiptxt = "佔領", bgPOI = true },
				dtl6  = { text = "伐木廠", colour = AM_GREEN, coords = { {41.10, 62.37}, {9, 62.0} }, symbol = { "L" },
						tooltiptxt = "佔領", bgPOI = true },
				dtl7  = { text = "農場", colour = AM_GREEN, coords = { {70.52, 67.75}, {9, 68.0} }, symbol = { "F" },
						tooltiptxt = "佔領", bgPOI = true, leaveGap = 1 },
				dtl8  = { text = AM_FRIENDLY, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "ABFriendly" },
				dtl9  = { text = AM_HONOURED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "ABHonored" },
				dtl10 = { text = AM_REVERED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "ABRevered" },
				dtl11 = { text = AM_EXALTED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "ABExalted", leaveGap = 1 },
				dtl12 = { text = AM_PVP_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "PVPSET", leaveGap = 1 }
			},

			{ 	name = "奧特蘭克山谷",			-- Alterac Valley
				type = AM_TYP_BG,
				displayname = "奧特蘭克山谷",
				displayshort = "AV",
				filename = "AlteracValley",
				location = "奧特蘭克山脈 (63, 58)",
				levels = "51-60",
				players = "40",
				prereq = "",
				general = "",
				notescale = 0.7,
				wmData = { minX = 0.395, maxX = 0.586, minY =  0.106, maxY = 0.9187 },
				amData = { minX = 0.65, maxX = 0.95, minY = 0.036, maxY = 0.98 },
				dtl1  = { text = "聯盟入口", colour = AM_BLUE, coords = { {87.98, 2.69} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "部落入口", colour = AM_RED, coords = { {91.01, 71.03} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "丹巴達爾", colour = AM_BLUE, coords = { {67.38, 6.47} }, symbol = { "!" },
						tooltiptxt = "殺死首領來贏得這場戰役" },
				dtl4  = { text = "霜狼要塞", colour = AM_RED, coords = { {75.38, 92.42} }, symbol = { "!" },
						tooltiptxt = "殺死首領來贏得這場戰役", leaveGap = 1 },
				dtl5  = { text = "墓地", colour = AM_GREEN, coords = { {68.26, 9.55}, {79.29, 8.36}, {83.68, 32.53}, {70.89, 44.37}, {83.49, 60.99}, {80.66, 80.18}, {80.27, 94.31} }, symbol = { " " },
						tooltiptxt = "佔領後可讓你的友方可以在此復活", bgPOI = true },
				dtl6  = { text = "雷矛急救站", colour = AM_GREEN, coords = { {68.26, 9.55}, {57, 9.55} }, symbol = { "1" },
						tooltiptxt = "", bgPOI = true },
				dtl7  = { text = "雷矛墓地", colour = AM_GREEN, coords = { {79.29, 8.36}, {57, 12} }, symbol = { "2" },
						tooltiptxt = "", bgPOI = true },
				dtl8  = { text = "石爐墓地", colour = AM_GREEN, coords = { {83.68, 32.53}, {57, 32.53} }, symbol = { "3" },
						tooltiptxt = "", bgPOI = true },
				dtl9  = { text = "落雪墓地", colour = AM_GREEN, coords = { {72.2, 44.8}, {57, 44.37} }, symbol = { "4" },
						tooltiptxt = "", bgPOI = true },
				dtl10 = { text = "冰血墓地", colour = AM_GREEN, coords = { {83.49, 60.99}, {57, 60.99} }, symbol = { "5" },
						tooltiptxt = "", bgPOI = true },
				dtl11 = { text = "霜狼墓地", colour = AM_GREEN, coords = { {82.0, 80.18}, {57, 80.18} }, symbol = { "6" },
						tooltiptxt = "", bgPOI = true },
				dtl12 = { text = "霜狼急救站", colour = AM_GREEN, coords = { {80.27, 94.31}, {57, 94.31} }, symbol = { "7" },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl13 = { text = "石爐哨站", bgPOI = true, colour = AM_BLUE, coords = { {79, 36.71} }, symbol = { "C" },
						tooltiptxt = "" },
				dtl14 = { text = "巴林達上尉", colour = AM_BLUE, coords = { {79, 36.71} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl15 = { text = "冰血要塞", colour = AM_RED, coords = { {73.82, 57.7} }, symbol = { "C" },
						tooltiptxt = "", bgPOI = true },
				dtl16 = { text = "加爾范上尉", colour = AM_RED, coords = { {73.82, 57.7} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl17 = { text = "聯盟碉堡", colour = AM_BLUE, coords = { {85.54, 41.98}, {82.02, 27.16}, {70.50, 13.53}, {73.04, 7.37} }, symbol = { " " },
						tooltiptxt = "部落可以摧毀以取得榮譽\n摧毀後守衛將不會在重生", bgPOI = true },
				dtl18 = { text = "石爐碉堡", colour = AM_BLUE, coords = { {85.54, 41.98}, {60, 41.98} }, symbol = { "8" },
						tooltiptxt = "", bgPOI = true },
				dtl19 = { text = "冰翼碉堡", colour = AM_BLUE, coords = { {82.02, 27.16}, {60, 27.16} }, symbol = { "9" },
						tooltiptxt = "聯盟指揮官卡爾菲利普\n部落空軍指揮官古斯", bgPOI = true },
				dtl20 = { text = "丹巴達爾南部碉堡", colour = AM_BLUE, coords = { {71.00, 13.00}, {60, 13.53} }, symbol = { "10" },
						tooltiptxt = "", bgPOI = true },
				dtl21 = { text = "丹巴達爾北部碉堡", colour = AM_BLUE, coords = { {73.04, 7.37}, {60, 7.37} }, symbol = { "11" },
						tooltiptxt = "部落空軍指揮官穆維里克", bgPOI = true, leaveGap = 1 },
				dtl22 = { text = "部落碉堡", colour = AM_RED, coords = { {78.31, 59.29}, {81.83, 67.25}, {80.4, 89.04}, {77, 88.5}  }, symbol = { " " },
						tooltiptxt = "聯盟可以摧毀以取得榮譽\n摧毀後守衛將不會在重生", bgPOI = true },
				dtl23 = { text = "冰血哨塔", colour = AM_RED, coords = { {78.31, 59.29}, {60, 59.29} }, symbol = { "12" },
						tooltiptxt = "", bgPOI = true },
				dtl24 = { text = "哨塔高地", colour = AM_RED, coords = { {81.83, 67.25}, {60, 67.25} }, symbol = { "13" },
						tooltiptxt = "部落指揮官路易斯菲利普\n聯盟空軍指揮官斯里多爾", bgPOI = true },
				dtl25 = { text = "東部霜狼哨塔", colour = AM_RED, coords = { {80.6, 89.04}, {63, 89.05} }, symbol = { "14" },
						tooltiptxt = "", bgPOI = true },
				dtl26 = { text = "西部霜狼哨塔", colour = AM_RED, coords = { {78.5, 88.8}, {60.5, 88.5} }, symbol = { "15" },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl27 = { text = "礦坑", colour = AM_ORANGE, coords = { {81.15, 1.69}, {73.33, 74.61} }, symbol = { " " },
						tooltiptxt = "佔領以獲取資源", bgPOI = true },
				dtl28 = { text = "深鐵礦坑", colour = AM_GREEN, coords = { {81.15, 1.69}, {63, 1.69} }, symbol = { "IM" },
						tooltiptxt = "", bgPOI = true },
				dtl29 = { text = "金牙礦坑", colour = AM_GREEN, coords = { {73.33, 74.61}, {63, 74.61} }, symbol = {"CM" },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
	-- Pad to dtl32 to control the page break
				dtl30 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "" },
				dtl31 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "" },
				dtl32 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "" },
	-- Pad to dtl32 to control the page break
				dtl33 = { text = "Summoning Zone", colour = AM_GREEN, coords = { {80.76, 44.27}, {73.14, 48.05} }, symbol = { " " },
						tooltiptxt = "Summon a Factions Avatar at these points" },
				dtl34 = { text = "Ivus the Forest Lord", colour = AM_BLUE, coords = { {80.76, 44.27} }, symbol = { "IF" },
						tooltiptxt = "Escort summoning NPCs to this point\nfrom Dun Baldar" },
				dtl35 = { text = "Lokholar the Ice Lord", colour = AM_RED, coords = { {73.14, 48.05} }, symbol = { "LI" },
						tooltiptxt = "Escort summoning NPCs to this point\nfrom Frostwolf Keep", leaveGap = 1 },
				dtl36 = { text = "Alliance Wing Commanders", colour = AM_BLUE, coords = { {82.02, 27.16}, {81.05, 85.46}, {81.83, 67.25}, {80.4, 89.04} }, symbol = { " " },
						tooltiptxt = "Rescue and escort back to base to get Air support", bgPOI = true },
				dtl37 = { text = "Karl Philips (9 Icewing Bunker)", colour = AM_BLUE, coords = { {82.02, 27.16} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl38 = { text = "Slidore (13 Tower Point)", colour = AM_BLUE, coords = { {81.83, 67.25} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl39 = { text = "Vipore", colour = AM_BLUE, coords = { {81.05, 85.46} }, symbol = { "W" },
						tooltiptxt = "" },
				dtl40 = { text = "Ichman (14 East Frostwolf Tower)", colour = AM_BLUE, coords = { {80.4, 89.04} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl41 = { text = "Horde Wing Commanders", colour = AM_RED, coords = { {81.83, 67.25}, {82.02, 27.16}, {88.96, 23.38}, {73.04, 7.37} }, symbol = { " " },
						tooltiptxt = "Rescue and escort back to base to get Air support", bgPOI = true },
				dtl42 = { text = "Louis Philips (13 Tower Point)", colour = AM_RED, coords = { {81.83, 67.25} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl43 = { text = "Guse (9 Icewing Bunker)", colour = AM_RED, coords = { {82.02, 27.16} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl44 = { text = "Jeztore", colour = AM_RED, coords = { {88.96, 23.38} }, symbol = { "W" },
						tooltiptxt = "" },
				dtl45 = { text = "Mulverick (11 Dun Baldar North Bunker)", colour = AM_RED, coords = { {73.04, 7.37} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl46 = { text = "Steamsaw Locations", colour = AM_PURPLE, coords = { {83, 54.72}, {88.57, 15.42} }, symbol = { " " },
						tooltiptxt = "" },
				dtl47 = { text = "Alliance Steamsaw", colour = AM_BLUE, coords = { {83, 54.72} }, symbol = { "S" },
						tooltiptxt = "Required for Reaper quest" },
				dtl48 = { text = "Horde Steamsaw", colour = AM_RED, coords = { {88.57, 15.42} }, symbol = { "S" },
						tooltiptxt = "Required for Reaper quest", leaveGap = 1 },
				dtl49 = { text = "Caverns", colour = AM_GREEN, coords = { {64.54, 24.08}, {85.93, 94.71} }, symbol = { " " },
						tooltiptxt = "" },
				dtl50 = { text = "Icewing", colour = AM_GREEN, coords = { {64.54, 24.08} }, symbol = { "IC" },
						tooltiptxt = "" },
				dtl51 = { text = "Wildpaw", colour = AM_GREEN, coords = { {85.93, 94.71} }, symbol = { "WC" },
						tooltiptxt = "", leaveGap = 1 },
				dtl52 = { text = "Wolf Rider Commander", colour = AM_RED, coords = { {91.2, 86.55} }, symbol = { "WR" },
						tooltiptxt = "Tame Wolves and hand in Ram hides to summon Cavalry\nAlliance counterpart in Dun Baldar, just south of Aid Station GY", leaveGap = 2 },
				dtl53 = { text = AM_FRIENDLY, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AVFriendly" },
				dtl54 = { text = AM_HONOURED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AVHonored" },
				dtl55 = { text = AM_REVERED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AVRevered" },
				dtl56 = { text = AM_EXALTED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AVExalted", leaveGap = 1 },
				dtl57 = { text = AM_PVP_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "PVPSET", leaveGap = 1 }
			}
	};

end