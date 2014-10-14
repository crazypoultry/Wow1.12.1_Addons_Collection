------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- Traditional Chinese  VERSION TEXTS  -- Nightly@布蘭卡德
------------------------------------------------

function Serenity_Localization_Dialog_Tw()

	function SerenityLocalization()
		Serenity_Localization_Speech_Tw();
	end

	SERENITY_COOLDOWN = {
		["Potion"] = "藥水冷卻"
	};

	SerenityTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFSerenity|r",
			["HealingPotion"] = "治療藥水：",
			["ManaPotion"] = "法力藥水：",
			["Drink"] = "飲料：",
			["HolyCandle"] = "聖潔蠟燭：",
			["SacredCandle"] = "神聖蠟燭：",
			["LightFeather"] = "輕羽毛：",
  		},
		["Alt"] = {
			Left = "右鍵施放：",
			Right = "",
		},
		["Potion"] = {
			Label = "|c00FFFFFF藥水|r",
			Text = {"恢復 ", " 持續 ", " 對 "}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFF法術持續時間|r",
			Text = "冷卻時間及法術對目標的持續時間",
			Right = "右鍵使用爐石傳送到"
		},
		
		["Fortitude"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[38].Name.."|r"
		},
		["DivineSpirit"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[8].Name.."|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[51].Name.."|r"
		},
		["InnerFire"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[20].Name.."|r"
		},
		["Levitate"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[23].Name.."|r"
		},
		["FearWard"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[11].Name.."|r"
		},
		["ElunesGrace"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[9].Name.."|r"
		},
		["Shadowguard"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[54].Name.."|r"
		},
		["TouchOfWeakness"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[59].Name.."|r"
		},
		["Feedback"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[12].Name.."|r"
		},
		["InnerFocus"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[19].Name.."|r"
		},
		["PowerInfusion"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[37].Name.."|r"
		},
		["Shadowform"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[53].Name.."|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[23].Name.."|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[25].Name.."|r"
		},
		["Fade"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[10].Name.."|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFF坐騎："
		},
		["Buff"] = {
			Label = "|c00FFFFFF增益魔法清單|r\n中間鍵保持清單開啟狀態"
		},
		["Spell"] = {
			Label = "|c00FFFFFF法術清單|r\n中間鍵保持清單開啟狀態"
		},
		["Lightwell"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[24].Name.."|r"
		},
		["Resurrection"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[48].Name.."|r"
		},
		["Scream"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[45].Name.."|r"
		},
		["MindControl"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[33].Name.."|r"
		},
		["MindSoothe"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[35].Name.."|r"
		},
		["MindVision"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[36].Name.."|r"
		},
		["ShackleUndead"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[49].Name.."|r"
		},
		["Dispel"] = {
			Label = "|c00FFFFFF驅散魔法|r"
		},
		["LastSpell"] = {
			Left = "右鍵重新施放",      
			Right = "",
		},
		["Drink"] = {
			Label = "|c00FFFFFF飲料|r",
		},
	};


	SERENITY_SOUND = {
		["ShackleWarn"] = "Interface\\AddOns\\Serenity\\sounds\\Shackle01.mp3",
		["ShackleBreak"] = "Interface\\AddOns\\Serenity\\sounds\\Shackle02.mp3",
		["Shackle"] = "Interface\\AddOns\\Serenity\\sounds\\Shackle03.mp3",
	};


--	SERENITY_NIGHTFALL_TEXT = {
--		["NoBoltSpell"] = "You do not seem to have any Shadow Bolt Spell.",
--		["Message"] = "<white>S<lightPurple1>h<lightPurple2>a<purple>d<darkPurple1>o<darkPurple2>w T<darkPurple1>r<purple>a<lightPurple2>n<lightPurple1>c<white>e"
--	};


	SERENITY_MESSAGE = {
		["Error"] = {
			["HolyCandleNotPresent"] = "需要施法材料：聖潔蠟燭",
			["SacredCandle"] = "需要施法材料：神聖蠟燭",
			["LightFeatherNotPresent"] = "需要施法材料：輕羽毛",
			["NoRiding"] = "沒有坐騎可供騎乘！",
			["FullMana"] = "現在不需要使用法力藥水（法力已滿）",
			["FullHealth"] = "現在不需要使用治療藥水（生命值已滿）",
			["NoHearthStone"] = "錯誤：背包裡沒有爐石！",
			["NoPotion"] = "錯誤：背包內沒有藥水",
			["NoDrink"] = "錯誤：背包內沒有飲料",
			["PotionCooldown"] = "錯誤：藥水還在冷卻中...",
			["NoSpell"] = "錯誤：你無法那樣做....",
		},
		["Interface"] = {
			["Welcome"] = "<white>/serenity 或 /seren 顯示設定視窗！",
			["TooltipOn"] = "開啟提示訊息" ,
			["TooltipOff"] = "關閉提示訊息",
			["MessageOn"] = "開啟對話訊息",
			["MessageOff"] = "關閉對話訊息",
			["MessagePosition"] = "<- Serenity 的系統訊息將會顯示在這裡 ->",
			["DefaultConfig"] = "<lightYellow> 已載入預設設定值！",
			["UserConfig"] = "<lightYellow> 已載入使用者設定值！"
		},
		["Personality"] = {
			["Greeting"] = "哈囉，"..UnitName("player").."，很高興看到你。",
			["Welcome"] = "歡迎回來，"..UnitName("player"),
			["Signal"] = "你無法關閉訊息。",
		},
		["Help"] = {
			"/seren recall -- Serenity 和所有按鈕置於螢幕中央",
			"/seren sm -- 置換為簡短訊息（raid-ready）版本",
			"/seren reset -- 恢復並重新載入 Serenity 預設組態",
			"/serenity toggle -- 隱藏/顯示 Serenity 主按鈕",
			"可經由按鈕選單中調整施法按鈕排列順序",	
		},
		["Information"] = {
			["ShackleWarn"] = "束縛不死生物的效果即將結束！",
			["ShackleBreak"] = "你的束縛已經結束...",
			["Restocked"] = "購買 ",
			["Restock"] = "要購買蠟燭嗎？",
			["Yes"] = "要",
			["No"] = "不要",
		},
	};


	-- Gestion XML - Menu de configuration

	SERENITY_COLOR_TOOLTIP = {
		["Purple"] = "紫色",
		["Blue"] = "藍色",
		["Pink"] = "粉紅色",
		["Orange"] = "橙色",
		["Turquoise"] = "藍綠色",
		["X"] = "X"
	};
	
	SERENITY_CONFIGURATION = {
		["Menu1"] = "一般設定",
		["Menu2"] = "訊息設定",
		["Menu3"] = "按鈕設定",
		["Menu4"] = "計時器設定",
		["Menu5"] = "圖樣設定",
		["MainRotation"] = "按鈕顯示位置",
		["InventoryMenu"] = "|CFFB700B7背|CFFB700B7包 :",
		["InventoryMenu2"] = "|CFFB700B7食|CFFB700B7物 :",
		["ProvisionMove"] = "放置藥水和飲料在指定背包中。",
--		["ProvisionDestroy"] = "Destroy all new food and drink if the bag is full.", --應該不用翻譯（法師）
		["SpellMenu1"] = "|CFFB700B7法|CFFFFC4FFl術 :",
		["SpellMenu2"] = "|CFFB700B7玩|CFFFF99FF家 :",
		["TimerMenu"] = "|CFFB700B7圖|CFFFF99FF形|CFFFF00FF計|CFFFFC4FF時 :",
		["TimerColor"] = "顯示文字計時器（白色字取代黃色字）",
		["TimerDirection"] = "計時器向上新增",
		["TranseWarning"] = "進入昏睡狀態發出警告",
		["SpellTime"] = "打開施法時間計時器",
		["AntiFearWarning"] = "如果目標無法被恐懼，提示我", --術士 恐懼
		["GraphicalTimer"] = "顯示圖形計時器（取代文字計時器）",	
		["TranceButtonView"] = "拖曳時顯示隱藏按鈕。",
		["ButtonLock"] = "鎖定 Serenity 週邊按鈕位置。",
		["MainLock"] = "鎖定 Serenity 位置。",
		["BagSelect"] = "選擇藥水和飲料放置位置",
		["BuffMenu"] = "增益魔法清單放置在左邊",
		["SpellMenu"] = "法術清單放置在左邊",
		["STimerLeft"] = "計時器顯示在按鈕左邊",
		["ShowCount"] = "在 Serenity 顯示物品數量",
		["CountType"] = "球面顯示事件（文字）",
		["Potion"] = "藥水下限",
		["Sound"] = "使用音效",
		["ShowMessage"] = "隨機說話訊息",
		["ShowResMessage"] = "使用隨機說話訊息 (復活)",
		["ShowSteedMessage"] = "使用隨機說話訊息 (坐騎)",
		["ShowShackleMessage"] = "使用隨機說話訊息 (束縛不死生物)",
		["ChatType"] = "將 Serenity 訊息視為系統訊息",
		["SerenitySize"] = "Serenity 主按鈕大小",
		["StoneScale"] = "其它按鈕大小",
		["ShackleUndeadSize"] = "束縛不死生物按鈕大小",
		["TranseSize"] = "睡眠跟反恐懼按鈕大小", --應該是術士的功能
		["Skin"] = "飲料下限",
		["PotionOrder"] = "優先使用這種藥水",
		["Show"] = {
			["Text"] = "顯示按鈕：",
			["Potion"] = "藥水按鈕",
			["Drink"] = "飲料按鈕",
			["Dispel"] = "驅魔按鈕",
			["LeftSpell"] = "左鍵施法",
			["MiddleSpell"] = "中間鍵施法",
			["RightSpell"] = "右鍵施法",
			["Steed"] = "坐騎",
			["Buff"] = "增益魔法清單",
			["Spell"] = "法術清單",
			["Tooltips"] = "顯示提示訊息",
			["Spelltimer"] = "顯示施法時間按鈕",
		},
		["Text"] = {
			["Text"] = "按鈕上顯示：",
			["Potion"] = "藥水數量",
			["Drink"] = "飲料數量",
			["Potion"] = "藥水冷卻",
--			["Evocation"] = "Evocation Cooldown",  --法師
			["HolyCandles"] = "聖潔蠟燭",
			["Feather"] = "輕羽毛",
			["SacredCandles"] = "神聖蠟燭",
		},
		["QuickBuff"] = "滑鼠經過時自動開啟/關閉增益魔法清單",
		["Count"] = {
			["None"] = "無",
			["Drink"] = "飲料數量",
			["PotionCount"] = "法力/治療藥水數量",
			["Health"] = "生命值",
			["HealthPercent"] = "生命值百分比",
			["Mana"] = "法力值",
			["ManaPercent"] = "法力值百分比",
			["PotionCooldown"] = "藥水冷卻",
			["Candles"] = "蠟燭",
		},
		["Circle"] = {
			["Text"] = "球面顯示事件（圖形）",
			["None"] = "無",
			["HP"] = "生命值",
			["Mana"] = "法力值",
            ["Potion"] = "藥水冷卻",
			["Candles"] = "蠟燭",
		},
		["Button"] = {
			["None"] = "無",
			["Text"] = "主按鈕功能",
			["Drink"] = "使用飲料恢復",
			["ManaPotion"] = "使用法力藥水",
			["HealingPotion"] = "使用治療藥水",
		},
		["Restock"] = {
			["Restock"] = "自動補充施法材料",
			["Confirm"] = "購買前出現確認視窗",			
		},
		["ShackleUndead"] = {
			["Warn"] = "束縛不死生物效果被移除前發出警告",
			["Break"] = "束縛不死生物效果被移除時顯示提示",
		},
		["ButtonText"] = "在按鈕上顯示施法材料數量",
		["Anchor"] = {
			["Text"] = "選單錨點（鎖定）",
			["Above"] = "向上",
			["Center"] = "中間",
			["Below"] = "向下",
		},
	};
end     