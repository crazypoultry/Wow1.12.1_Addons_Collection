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
-- SIMPLIFIED CHINESE VERSION TEXTS --
------------------------------------------------

function Serenity_Localization_Dialog_Cn()

	function SerenityLocalization()
		Serenity_Localization_Speech_Cn();
	end

	SERENITY_COOLDOWN = {
		["Potion"] = "药水冷却"
	};

	SerenityTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFSerenity|r",
			["HealingPotion"] = "治疗药水：",
			["ManaPotion"] = "法力药水：",
			["Drink"] = "饮料：",
			["HolyCandle"] = "圣洁蜡烛：",
			["SacredCandle"] = "神圣蜡烛：",
			["LightFeather"] = "轻羽毛：",
  		},
		["Alt"] = {
			Left = "右键施放：",
			Right = "",
		},
		["Potion"] = {
			Label = "|c00FFFFFF药水|r",
			Text = {"Restores ", " over ", " to "}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFF法术持续时间|r",
			Text = "启用对目标的法术计时",
			Right = "右键使用炉石到"
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
			Label = "|c00FFFFFF坐骑："
		},
		["Buff"] = {
			Label = "|c00FFFFFF增益魔法菜单|r\n中间键保持清单开启状态"
		},
		["Spell"] = {
			Label = "|c00FFFFFF法术菜单|r\n中间键保持清单开启状态"
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
			Label = "|c00FFFFFF驱散魔法|r"
		},
		["LastSpell"] = {
			Left = "右键重新施放",      
			Right = "",
		},
		["Drink"] = {
			Label = "|c00FFFFFF饮料|r",
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
			["HolyCandleNotPresent"] = "需要施法材料：圣洁蜡烛",
			["SacredCandle"] = "需要施法材料：神圣蜡烛",
			["LightFeatherNotPresent"] = "需要施法材料：轻羽毛",
			["NoRiding"] = "没有坐骑可供骑乘！",
			["FullMana"] = "你的法力值已满，现在不需要使用法力药水",
			["FullHealth"] = "你的生命值已满，现在不需要使用治疗药水",
			["NoHearthStone"] = "错误：你的物品中没有炉石。",
			["NoPotion"] = "错误：你的物品中没有药水",
			["NoDrink"] = "错误：你的物品中没有饮料",
			["PotionCooldown"] = "错误：药水处于冷却状态。",
			["NoSpell"] = "错误：你还没有学习那个法术。",
		},
		["Interface"] = {
			["Welcome"] = "<white>/serenity 或 /seren 显示设置菜单！",
			["TooltipOn"] = "浮动提示已开启" ,
			["TooltipOff"] = "浮动提示已关闭",
			["MessageOn"] = "聊天消息已开启",
			["MessageOff"] = "聊天消息已关闭",
			["MessagePosition"] = "<- Serenity 提示的系统消息会在这儿显示 ->",
			["DefaultConfig"] = "<lightYellow> 缺省配置信息已载入。",
			["UserConfig"] = "<lightYellow> 配置信息已载入。"
		},
		["Personality"] = {
			["Greeting"] = "哈啰, "..UnitName("player")..", 很高兴看到你",
			["Welcome"] = "欢迎回来, "..UnitName("player"),
			["Signal"] = "你无法关闭讯息。",
		},
		["Help"] = {
			"/seren recall -- 使 Serenity 和所有按钮居中显示",
			"/seren sm -- 将消息替换为简短的团队支持(raid-ready)版本",
			"/seren reset -- 恢复并重新载入 Serenity 缺省配置信息",
			"/serenity toggle -- 隐藏/显示 Serenity 主按钮",
			"可经由按钮选单中调整施法按钮排列顺序",				
		},
		["Information"] = {
			["ShackleWarn"] = "束缚亡灵将要被移除！",
			["ShackleBreak"] = "束缚亡灵已被移除...",
			["Restocked"] = "购买了 ",
			["Restock"] = "要购买蜡烛吗？",
			["Yes"] = "是",
			["No"] = "否",
		},
	};


	-- Gestion XML - Menu de configuration

	SERENITY_COLOR_TOOLTIP = {
		["Purple"] = "紫色",
		["Blue"] = "蓝色",
		["Pink"] = "粉红色",
		["Orange"] = "橙色",
		["Turquoise"] = "青绿色",
		["X"] = "X"
	};
	
	SERENITY_CONFIGURATION = {
		["Menu1"] = "物品设置",
		["Menu2"] = "消息设置",
		["Menu3"] = "按钮设置",
		["Menu4"] = "计时器设置",
		["Menu5"] = "图像设置",
		["MainRotation"] = "Serenity 角度选择",
		["InventoryMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["InventoryMenu2"] = "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7n :",
		["ProvisionMove"] = "将药水和饮料放到选定指定背包中。",
		["ProvisionDestroy"] = "Destroy all new food and drink if the bag is full.", --应该不用翻译（法师）
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7P|CFFFF00FFl|CFFFF50FFa|CFFFF99FFy|CFFFFC4FFe|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFc|CFFFF00FFa|CFFB700B7l T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs :",
		["TimerColor"] = "计时器显示白色文本",
		["TimerDirection"] = "计时器向上增长",
		["TranseWarning"] = "当我进入发呆状态时提醒我",
		["SpellTime"] = "开启法术时间进度条",
		["AntiFearWarning"] = "当目标不能被恐惧时警告", --术士 恐惧
		["GraphicalTimer"] = "显示图形化计时器",	
		["TranceButtonView"] = "显示隐藏按钮以便拖动",
		["ButtonLock"] = "锁定 Serenity 球形周围的按钮。",
		["MainLock"] = "锁定 Serenity 球形界面。",
		["BagSelect"] = "选择药水和饮料的容器",
		["BuffMenu"] = "将增益魔法菜单置于左边",
		["SpellMenu"] = "法术菜单置于左边",
		["STimerLeft"] = "在按钮的左边显示计时器",
		["ShowCount"] = "在 Serenity 中显示物品数量",
		["CountType"] = "球面显示事件（文字）",
		["Potion"] = "药水下限",
		["Sound"] = "启用音效",
		["ShowMessage"] = "随机讲话",
		["ShowResMessage"] = "启用随机讲话 (复活)",
		["ShowSteedMessage"] = "启用随机讲话 (坐骑)",
		["ShowShackleMessage"] = "启用随机讲话 (束缚亡灵)",
		["ChatType"] = "将 Serenity 消息发布为系统消息",
		["SerenitySize"] = "Serenity 主按钮大小",
		["StoneScale"] = "其它按钮大小",
		["ShackleUndeadSize"] = "束缚不死生物按钮大小",
		["TranseSize"] = "Size of Transe and Anti-fear buttons", --应该是术士的功能
		["Skin"] = "饮水下限",
		["PotionOrder"] = "优先使用药水",
		["Show"] = {
			["Text"] = "显示按钮：",
			["Potion"] = "药水按钮",
			["Drink"] = "饮料按钮",
			["Dispel"] = "驱散按钮",
			["LeftSpell"] = "左法术按钮",
			["MiddleSpell"] = "中间法术按钮",
			["RightSpell"] = "右法术按钮",
			["Steed"] = "坐骑",
			["Buff"] = "增益魔法菜单",
			["Spell"] = "法术菜单",
			["Tooltips"] = "显示浮动提示",
			["Spelltimer"] = "显示法术持续时间按钮"
		},
		["Text"] = {
			["Text"] = "在按钮上显示：",
			["Potion"] = "药水数量",
			["Drink"] = "饮料数量",
			["Potion"] = "药水冷却",
			--["Evocation"] = "Evocation Cooldown",  --法师
			["HolyCandles"] = "圣洁蜡烛",
			["Feather"] = "轻羽毛",
			["SacredCandles"] = "神圣蜡烛",
		},
		["QuickBuff"] = "鼠标滑过时自动开/关法术菜单",
		["Count"] = {
			["None"] = "无",
			["Drink"] = "饮水数量",
			["PotionCount"] = "法力/治疗药水数量",
			["Health"] = "当前生命值",
			["HealthPercent"] = "生命值百分比",
			["Mana"] = "当前法力值",
			["ManaPercent"] = "法力值百分比",
			["PotionCooldown"] = "药水冷却时间",
			["Candles"] = "蜡烛",
		},
		["Circle"] = {
			["Text"] = "球面显示事件（图形）",
			["None"] = "无",
			["HP"] = "命中点数",
			["Mana"] = "法力",
            ["Potion"] = "药水冷却时间",
			["Candles"] = "蜡烛",
		},
		["Button"] = {
			["None"] = "无",
			["Text"] = "主按钮功能",
			["Drink"] = "使用饮水恢复",
			["ManaPotion"] = "使用法力药水",
			["HealingPotion"] = "使用治疗药水",
		},
		["Restock"] = {
			["Restock"] = "自动购买施法材料",
			["Confirm"] = "购买前确认",			
		},
		["ShackleUndead"] = {
			["Warn"] = "在束缚不死生物效果被移除前发出警告",
			["Break"] = "在束缚不死生物效果被移除时显示提示",
		},
		["ButtonText"] = "在按钮上显示施法材料数量",
		["Anchor"] = {
			["Text"] = "菜单定位点",
			["Above"] = "上方",
			["Center"] = "居中",
			["Below"] = "下方"
		},
	};
end     