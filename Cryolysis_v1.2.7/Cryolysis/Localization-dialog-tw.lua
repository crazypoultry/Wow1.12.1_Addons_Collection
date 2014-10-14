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
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- Traditional Chinese  VERSION TEXTS  -- Nightly@布蘭卡德
------------------------------------------------

function Cryolysis_Localization_Dialog_Tw()

	function CryolysisLocalization()
		Cryolysis_Localization_Speech_Tw();
	end

	CRYOLYSIS_COOLDOWN = {
		["Evocation"] = "喚醒冷卻",
		["Manastone"] = "魔法寶石冷卻"
	};

	CryolysisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFCryolysis|r",
			Stone = {
				[true] = "確定";
				[false] = "取消";
			},
			Hellspawn = {
				[true] = "開啟";
				[false] = "關閉";
			},
			["Food"] = "魔法食物：",
			["Drink"] = "魔法飲料：",
			["RuneOfTeleportation"] = "傳送符文：",
			["RuneOfPortals"] = "傳送門符文：",
			["ArcanePowder"] = "魔粉：",
			["LightFeather"] = "輕羽毛：",
			["Manastone"] = "魔法寶石:",
  		},
		["Alt"] = {
			Left = "右鍵施放：|c00FF99FF ",
			Right = "",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSoulstone|r",
			Text = {"Create","Use","Used","Waiting"}			
		},  --靈魂石 應該是術士使用的！ 暫時不翻譯
		["Manastone"] = {
			Label = "|c00FFFFFF魔法寶石|r",
			Text = {"：製造 - ","：恢復 ", "：等待", "：無法使用"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFF施法時間|r",
			Text = "冷卻時間及法術對目標的持續時間",
			Right = "右鍵使用爐石傳送到"
		},
		["Armor"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[22].Name.."|r"
		},
		["MageArmor"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[24].Name.."|r"
		},
		["ArcaneInt"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[4].Name.."|r"
		},
		["ArcaneBrilliance"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[2].Name.."|r"
		},
		["DampenMagic"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[13].Name.."|r"
		},
		["AmplifyMagic"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[1].Name.."|r"
		},
		["SlowFall"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[35].Name.."|r"
		},
		["FireWard"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[15].Name.."|r"
		},
		["FrostWard"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[20].Name.."|r"
		},
		["ConjureFood"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[10].Name.."|r"
		},
		["ConjureDrink"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[11].Name.."|r"
		},
		["Evocation"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[49].Name.."|r",
			Text = "使用"
		},
		["ColdSnap"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[42].Name.."|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[23].Name.."|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[25].Name.."|r"
		},
		["DetectMagic"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[50].Name.."|r"
		},
		["RemoveCurse"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[33].Name.."|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFF坐騎：|r"
		},
		["Buff"] = {
			Label = "|c00FFFFFF增益魔法清單|r\n中間鍵保持清單開啟狀態"
		},
		["Portal"] = {
			Label = "|c00FFFFFF傳送門清單|r\n中間鍵保持清單開啟狀態"
		},
		["T:Org"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[38].Name.."|r"
		},
		["T:UC"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[40].Name.."|r"
		},
		["T:TB"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[39].Name.."|r"
		},
		["T:IF"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[37].Name.."|r"
		},
		["T:SW"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[51].Name.."|r"
		},
		["T:Darn"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[46].Name.."|r"  -- Question For 46 OR 36(The Same)
		},
		["P:Org"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[47].Name.."|r"
		},
		["P:UC"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[31].Name.."|r"
		},
		["P:TB"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[30].Name.."|r"
		},
		["P:IF"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[28].Name.."|r"
		},
		["P:SW"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[29].Name.."|r"
		},
		["P:Darn"] = {
		    Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[27].Name.."|r"
		},
		["EvocationCooldown"] = "右鍵使用喚醒",
		["LastSpell"] = {
			Left = "右鍵重新施放 ",      -- <--
			Right = "",
		},
		["Food"] = {
			Label = "|c00FFFFFF食物|r",
			Right = "右鍵施放造食術 ",
			Middle = "中間鍵進行交易",
		},
		["Drink"] = {
			Label = "|c00FFFFFF飲料|r",
			Right = "右鍵施放造水術 ",
			Middle = "中間鍵進行交易",
		},
	};


	CRYOLYSIS_SOUND = {
		["SheepWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep01.mp3",
		["SheepBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep02.mp3",
		["PigWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig01.mp3",
		["PigBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig02.mp3",
	};


--	CRYOLYSIS_NIGHTFALL_TEXT = {
--		["NoBoltSpell"] = "You do not seem to have any Shadow Bolt Spell.",
--		["Message"] = "<white>S<lightPurple1>h<lightPurple2>a<purple>d<darkPurple1>o<darkPurple2>w T<darkPurple1>r<purple>a<lightPurple2>n<lightPurple1>c<white>e"
--	};


	CRYOLYSIS_MESSAGE = {
		["Error"] = {
			["RuneOfTeleportationNotPresent"] = "需要傳送符文！",
			["RuneOfPortals"] = "需要傳送門符文！",
			["LightFeatherNotPresent"] = "需要輕羽毛！",
			["ArcanePowderNotPresent"] = "需要魔粉！",
			["NoRiding"] = "沒有坐騎可供騎乘！",
			["NoFoodSpell"] = "沒有製作任何食物的法術",
			["NoDrinkSpell"] = "沒有製作任何飲料的法術",
			["NoManaStoneSpell"] = "沒有製作任何法力寶石的法術",
			["NoEvocationSpell"] = "沒有施放喚醒",
			["FullMana"] = "現在不需要使用魔法寶石（法力已滿）",
			["BagAlreadySelect"] = "錯誤：已選擇這個背包。",
			["WrongBag"] = "錯誤：數字必須介於 0 到 4 ！",
			["BagIsNumber"] = "錯誤：請輸入數字。",
			["NoHearthStone"] = "錯誤：背包裡沒有爐石！",
			["NoFood"] = "錯誤：背包內沒發現你製造的食物",
			["NoDrink"] = "錯誤：背包內沒發現你製造的飲料",
			["ManaStoneCooldown"] = "錯誤：法力寶石處於冷卻狀態",
			["NoSpell"] = "錯誤：你無法那樣做....",
		},
		["Bag"] = {
			["FullPrefix"] = "你的 ",
			["FullSuffix"] = " 已滿！",
			["FullDestroySuffix"] = " 已滿；下一組製造的食物或飲料將被摧毀！",
			["SelectedPrefix"] = "已選擇 ",
			["SelectedSuffix"] = "來存放食物與飲料。"
		},
		["Interface"] = {
			["Welcome"] = "<white>/cryo 顯示設定視窗！",
			["TooltipOn"] = "開啟提示訊息" ,
			["TooltipOff"] = "關閉提示訊息",
			["MessageOn"] = "開啟對話訊息",
			["MessageOff"] = "關閉對話訊息",
			["MessagePosition"] = "<- Cryolysis 的系統訊息將會顯示在這裡 ->",
			["DefaultConfig"] = "<lightYellow> 已載入預設設定值！",
			["UserConfig"] = "<lightYellow> 已載入使用者設定值！"
		},
		["Help"] = {
			"/cryo recall -- Cryolysis 和所有按鈕置於螢幕中央",
			"/cryo sm -- 置換為簡短訊息（raid-ready）版本",
			"/cryo decurse -- 施放解除次級詛咒（使用 Decursive 的功能）",
			"/cryo poly -- 隨機施放可用的變形術（羊、豬、海龜）",
			"/cryo coldblock -- 使用寒冰護體或急速冷卻",
			"/cryo reset -- 恢復並重新載入 Cryolysis 預設組態",
			"/serenity toggle -- hide/show the main serenity sphere",
			"可經由按鈕選單中調整施法按鈕排列順序",			
		},
		["EquipMessage"] = "裝備 ",
		["SwitchMessage"] = " 替代為 ",
		["Information"] = {
			["PolyWarn"] = "變形術即將消失！",
			["PolyBreak"] = "變形術已消失...",
			["Restock"] = "購買 ",
		},
	};


	-- Gestion XML - Menu de configuration

	CRYOLYSIS_COLOR_TOOLTIP = {
		["Purple"] = "紫色",
		["Blue"] = "藍色",
		["Pink"] = "粉紅色",
		["Orange"] = "橙色",
		["Turquoise"] = "藍綠色",
		["X"] = "X"
	};
	
	CRYOLYSIS_CONFIGURATION = {
		["Menu1"] = "背包設定",
		["Menu2"] = "訊息設定",
		["Menu3"] = "按鈕設定",
		["Menu4"] = "計時器設定",
		["Menu5"] = "圖樣設定",
		["MainRotation"] = "按鈕顯示位置",
		["ProvisionMenu"] = "|CFFB700B7背|CFFFF00FF包|CFFFF50FF：",
		["ProvisionMenu2"] = "|CFFB700B7糧|CFFFF00FF食|CFFFF50FF：",
		["ProvisionMove"] = "放置食物和飲料到指定背包。",
		["ProvisionDestroy"] = "所有新的食物與飲料將被摧毀（背包已滿）。",
		["SpellMenu1"] = "|CFFB700B7施|CFFFF00FF放|CFFFF50FF法|CFFFF99FF術|CFFFFC4FF：",
		["SpellMenu2"] = "|CFFB700B7玩|CFFFF00FF家|CFFFF50FF：",
		["TimerMenu"] = "|CFFB700B7圖|CFFFF00FF形|CFFFF50FF計|CFFFF99FF時|CFFFFC4FF器|CFFFF99FF：",
		["TimerColor"] = "顯示文字計時器（白色字取代黃色字）",
		["TimerDirection"] = "計時器向上新增",
		["TranseWarning"] = "進入昏睡狀態發出警告",
		["SpellTime"] = "啟動施法時間計時器",
		["AntiFearWarning"] = "Warn me when my target cannot be feared.", --術士 恐懼
		["GraphicalTimer"] = "顯示圖形計時器（取代文字計時器）",	
		["TranceButtonView"] = "拖曳時顯示隱藏按鈕。",
		["ButtonLock"] = "鎖定 Cryolysis 週邊按鈕位置。",
		["MainLock"] = "鎖定 Cryolysis 位置。",
		["BagSelect"] = "選擇食物和飲料放置位置",
		["BuffMenu"] = "增益魔法清單放置在左邊",
		["PortalMenu"] = "傳送門清單放置在左邊",
		["STimerLeft"] = "計時器顯示在按鈕左邊",
		["ShowCount"] = "在 Cryolysis 顯示物品數量",
		["CountType"] = "球面顯示事件（文字）",
		["Food"] = "食物下限",
		["Sound"] = "使用音效",
		["ShowMessage"] = "隨機訊息",
		["ShowPortalMessage"] = "使用隨機訊息（傳送門）",
		["ShowSteedMessage"] = "使用隨機訊息（坐騎）",
		["ShowPolyMessage"] = "使用隨機訊息（變形術）",
		["ChatType"] = "將 Cryolysis 訊息視為系統訊息",
		["CryolysisSize"] = "Cryolysis 主按鈕大小",
		["StoneScale"] = "其它按鈕大小",
		["PolymorphSize"] = "變形術按鈕大小",
		["TranseSize"] = "Size of Transe and Anti-fear buttons", --應該是術士的功能
		["Skin"] = "飲料下限",
		["ManaStoneOrder"] = "優先使用這個魔法寶石",
		["Show"] = {
			["Text"] = "顯示按鈕：",
			["Food"] = "食物",
			["Drink"] = "飲料",
			["Manastone"] = "魔法寶石",
			["LeftSpell"] = "左鍵施法",
			["Evocation"] = "喚醒",
			["RightSpell"] = "右鍵施法",
			["Steed"] = "坐騎",
			["Buff"] = "增益魔法清單",
			["Portal"] = "傳送門清單",
			["Tooltips"] = "顯示提示訊息",
			["Spelltimer"] = "顯示施法時間按鈕",
		},
		["Text"] = {
			["Text"] = "按鈕上顯示：",
			["Food"] = "食物數量",
			["Drink"] = "飲料數量",
			["Manastone"] = "魔法寶石冷卻時間",
			["Evocation"] = "喚醒冷卻時間",
			["Powder"] = "魔粉",
			["Feather"] = "輕羽毛",
			["Rune"] = "傳送門符文",
		},
		["QuickBuff"] = "滑鼠經過時自動開啟/關閉增益魔法清單",
		["Count"] = {
			["None"] = "無",
			["Provision"] = "食物和飲料",
			["Provision2"] = "飲料和食物",
			["Health"] = "生命值",
			["HealthPercent"] = "生命值百分比",
			["Mana"] = "法力值",
			["ManaPercent"] = "法力值百分比",
			["Manastone"] = "魔法寶石冷卻時間",
			["Evocation"] = "喚醒冷卻時間",
		},
		["Circle"] = {
			["Text"] = "球面顯示事件（圖形）",
			["None"] = "無",
			["HP"] = "生命值",
			["Mana"] = "法力值",
			["Manastone"] = "魔法寶石冷卻時間",
			["Evocation"] = "喚醒冷卻時間",
			
		},
		["Button"] = {
			["Text"] = "主按鈕功能",
			["Consume"] = "進食/喝水",
			["Evocation"] = "使用喚醒",
			["Polymorph"] = "施放變形術",
			["Manastone"] = "魔法寶石",
		},
		["Restock"] = {
			["Restock"] = "自動補充施法材料",
			["Confirm"] = "購買前出現確認視窗",			
		},
		["Polymorph"] = {
			["Warn"] = "變形術效果被移除前發出警告",
			["Break"] = "變形術效果被移除時顯示提示",
		},
		["ButtonText"] = "在按鈕上顯示施法材料數量",
		["Anchor"] = {
			["Text"] = "選單錨點（鎖定）",
			["Above"] = "向上",
			["Center"] = "中間",
			["Below"] = "向下",
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