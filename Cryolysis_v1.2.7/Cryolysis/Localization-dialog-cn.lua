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
-- SIMPLIFIED CHINESE VERSION TEXTS --
------------------------------------------------

function Cryolysis_Localization_Dialog_Cn()

	function CryolysisLocalization()
		Cryolysis_Localization_Speech_Cn();
	end

	CRYOLYSIS_COOLDOWN = {
		["Evocation"] = "唤醒冷却",
		["Manastone"] = "魔法水晶冷却"
	};

	CryolysisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFCryolysis|r",
			Stone = {
				[true] = "是";
				[false] = "否";
			},
			Hellspawn = {
				[true] = "开";
				[false] = "关";
			},
			["Food"] = "魔法食物：",
			["Drink"] = "魔法水：",
			["RuneOfTeleportation"] = "传送符文：",
			["RuneOfPortals"] = "传送门符文：",
			["ArcanePowder"] = "魔粉：",
			["LightFeather"] = "轻羽毛：",
			["Manastone"] = "魔法水晶：",
  		},
		["Alt"] = {
			Left = "右键点击：",
			Right = "",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSoulstone|r",
			Text = {"制造","使用","已使用","等待"}			
		},
		["Manastone"] = {
			Label = "|c00FFFFFF魔法宝石|r",
			Text = {"：制造 - ","：回复 ", "：等待", "：不可用"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFF法术持续时间|r",
			Text = "启用对目标的法术计时",
			Right = "右键使用炉石到"
		},
		["Armor"] = {
			Label = "|c00FFFFFF冰甲术|r"
		},
		["MageArmor"] = {
			Label = "|c00FFFFFF魔甲术|r"
		},
		["ArcaneInt"] = {
			Label = "|c00FFFFFF奥术智慧|r"
		},
		["ArcaneBrilliance"] = {
			Label = "|c00FFFFFF奥术光辉|r"
		},
		["DampenMagic"] = {
			Label = "|c00FFFFFF魔法抑制|r"
		},
		["AmplifyMagic"] = {
			Label = "|c00FFFFFF魔法增效|r"
		},
		["SlowFall"] = {
			Label = "|c00FFFFFF缓落术|r"
		},
		["FireWard"] = {
			Label = "|c00FFFFFF防护火焰结界|r"
		},
		["FrostWard"] = {
			Label = "|c00FFFFFF防护冰霜结界|r"
		},
		["ConjureFood"] = {
			Label = "|c00FFFFFF造食术|r"
		},
		["ConjureDrink"] = {
			Label = "|c00FFFFFF造水术|r"
		},
		["Evocation"] = {
			Label = "|c00FFFFFF唤醒|r",
			Text = "Use"
		},
		["ColdSnap"] = {
			Label = "|c00FFFFFF急速冷却|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[23].Name.."|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[25].Name.."|r"
		},
		["DetectMagic"] = {
			Label = "|c00FFFFFF侦测魔法|r"
		},
		["RemoveCurse"] = {
			Label = "|c00FFFFFF解除次级诅咒|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFF座骑："
		},
		["Buff"] = {
			Label = "|c00FFFFFF法术菜单|r\n中键保持菜单打开状态"
		},
		["Portal"] = {
			Label = "|c00FFFFFF传送门菜单|r\n中键保持菜单打开状态"
		},
		["T:Org"] = {
		    Label = "|c00FFFFFF传送：奥格瑞玛|r"
		},
		["T:UC"] = {
		    Label = "|c00FFFFFF传送：幽暗城|r"
		},
		["T:TB"] = {
		    Label = "|c00FFFFFF传送：雷霆崖|r"
		},
		["T:IF"] = {
		    Label = "|c00FFFFFF传送：铁炉堡|r"
		},
		["T:SW"] = {
		    Label = "|c00FFFFFF传送：暴风城|r"
		},
		["T:Darn"] = {
		    Label = "|c00FFFFFF传送：达纳苏斯|r"
		},
		["P:Org"] = {
		    Label = "|c00FFFFFF传送门：奥格瑞玛|r"
		},
		["P:UC"] = {
		    Label = "|c00FFFFFF传送门：幽暗城|r"
		},
		["P:TB"] = {
		    Label = "|c00FFFFFF传送门：雷霆崖|r"
		},
		["P:IF"] = {
		    Label = "|c00FFFFFF传送门：铁炉堡|r"
		},
		["P:SW"] = {
		    Label = "|c00FFFFFF传送门：暴风城|r"
		},
		["P:Darn"] = {
		    Label = "|c00FFFFFF传送门：达纳苏斯|r"
		},
		["EvocationCooldown"] = "右键快速召唤",
		["LastSpell"] = {
			Left = "右键重新施放 ",      -- <--
			Right = "",
		},
		["Food"] = {
			Label = "|c00FFFFFF食物|r",
			Right = "右键制造",
			Middle = "中键交易",
		},
		["Drink"] = {
			Label = "|c00FFFFFF饮水|r",
			Right = "右键制造 ",
			Middle = "中键交易",
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
			["RuneOfTeleportationNotPresent"] = "需要传送符文。",
			["RuneOfPortals"] = "需要传送门符文。",
			["LightFeatherNotPresent"] = "需要轻羽毛。",
			["ArcanePowderNotPresent"] = "需要魔粉。",
			["NoRiding"] = "你没有坐骑。",
			["NoFoodSpell"] = "你没有学习制造食物的法术。",
			["NoDrinkSpell"] = "你没有学习制造饮水的法术。",
			["NoManaStoneSpell"] = "你没有学习制造魔法宝石的法术。",
			["NoEvocationSpell"] = "你没有学习唤醒法术。",
			["FullMana"] = "你的法力值已满，现在不需要使用魔法宝石。",
			["BagAlreadySelect"] = "错误：此背包已被选择。",
			["WrongBag"] = "错误：数值必须介于0到4。",
			["BagIsNumber"] = "错误：请输入一个数值。",
			["NoHearthStone"] = "错误：你的物品中没有炉石。",
			["NoFood"] = "错误：你的物品中没有最高等级的魔法食物。",
			["NoDrink"] = "错误：你的物品中没有最高等级的魔法饮水。",
			["ManaStoneCooldown"] = "错误：魔法宝石处于冷却状态。",
			["NoSpell"] = "错误：你还没有学习那个法术。",
		},
		["Bag"] = {
			["FullPrefix"] = "你的",
			["FullSuffix"] = " 已满！",
			["FullDestroySuffix"] = " 已满。接下来的食物/饮水将被摧毁。",
			["SelectedPrefix"] = "你选择了",
			["SelectedSuffix"] = "来存放食物和饮水。"
		},
		["Interface"] = {
			["Welcome"] = "<white>/cryo显示设置菜单",
			["TooltipOn"] = "浮动提示已开启" ,
			["TooltipOff"] = "浮动提示已关闭",
			["MessageOn"] = "聊天消息已开启",
			["MessageOff"] = "聊天消息已关闭",
			["MessagePosition"] = "<- Cryolysis提示的系统消息会在这儿显示 ->",
			["DefaultConfig"] = "<lightYellow>缺省配置信息已载入。",
			["UserConfig"] = "<lightYellow>配置信息已载入。"
		},
		["Help"] = {
			"/cryo recall -- 使Cryolysis和所有按钮居中显示",
			"/cryo sm -- 将消息替换为简短的团队支持(raid-ready)版本",
			"/cryo decurse -- 施放解除次级诅咒(调用Decursive的功能)",
			"/cryo poly -- 随即选择可用的变形术",
			"/cryo coldblock -- 使用寒冰屏障或者急速冷却",
			"/cryo reset -- 恢复并重新载入 Cryolysis 缺省配置信息",
			"/serenity toggle -- hide/show the main serenity sphere",
			"可经由按钮选单中调整施法按钮排列顺序",			
		},
		["EquipMessage"] = "装备 ",
		["SwitchMessage"] = " 来替换 ",
		["Information"] = {
			["PolyWarn"] = "变形术将要被移除",
			["PolyBreak"] = "变形术已被移除",
			["Restock"] = "购买了",
		},
	};


	-- Gestion XML - Menu de configuration

	CRYOLYSIS_COLOR_TOOLTIP = {
		["Purple"] = "紫色",
		["Blue"] = "蓝色",
		["Pink"] = "粉红色",
		["Orange"] = "橙色",
		["Turquoise"] = "青绿色",
		["X"] = "X"
	};
	
	CRYOLYSIS_CONFIGURATION = {
		["Menu1"] = "物品设置",
		["Menu2"] = "消息设置",
		["Menu3"] = "按钮设置",
		["Menu4"] = "计时器设置",
		["Menu5"] = "图像设置",
		["MainRotation"] = "Cryolysis角度选择",
		["ProvisionMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["ProvisionMenu2"] = "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7n :",
		["ProvisionMove"] = "将食物和饮水放到选定的背包里",
		["ProvisionDestroy"] = "如果背包已满，摧毁新制造的食物和饮水",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7P|CFFFF00FFl|CFFFF50FFa|CFFFF99FFy|CFFFFC4FFe|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFc|CFFFF00FFa|CFFB700B7l T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs :",
		["TimerColor"] = "计时器显示白色文本",
		["TimerDirection"] = "计时器向上增长",
		["TranseWarning"] = "当我进入发呆状态时提醒我",
		["SpellTime"] = "开启法术时间进度条",
		["AntiFearWarning"] = "当目标不能被恐惧时警告",
		["GraphicalTimer"] = "显示图形化计时器",	
		["TranceButtonView"] = "显示隐藏按钮以便拖动",
		["ButtonLock"] = "锁定Cryolysis球形周围的按钮",
		["MainLock"] = "锁定Cryolysis球形界面",
		["BagSelect"] = "选择食物和饮水的容器",
		["BuffMenu"] = "将BUFF菜单置于左边",
		["PortalMenu"] = "将传送门按钮置于左边",
		["STimerLeft"] = "在按钮的左边显示计时器",
		["ShowCount"] = "在Cryolysis中显示物品数量",
		["CountType"] = "球面显示事件(文字)",
		["Food"] = "食物下限",
		["Sound"] = "启用音效",
		["ShowMessage"] = "随机讲话",
		["ShowPortalMessage"] = "启用随机讲话(传送门)",
		["ShowSteedMessage"] = "启用随机讲话(坐骑)",
		["ShowPolyMessage"] = "启用随机讲话(变形术)",
		["ChatType"] = "将Cryolysis消息发布为系统消息",
		["CryolysisSize"] = "Cryolysis主按钮大小",
		["StoneScale"] = "其它按钮大小",
		["PolymorphSize"] = "变形术按钮大小",
		["TranseSize"] = "传送和反恐按钮大小",
		["Skin"] = "饮水下限",
		["ManaStoneOrder"] = "优先使用魔法宝石",
		["Show"] = {
			["Text"] = "显示按钮：",
			["Food"] = "食物按钮",
			["Drink"] = "饮水按钮",
			["Manastone"] = "魔法宝石按钮",
			["LeftSpell"] = "左法术按钮",
			["Evocation"] = "唤醒",
			["RightSpell"] = "右法术按钮",
			["Steed"] = "坐骑",
			["Buff"] = "法术菜单",
			["Portal"] = "传送门菜单",
			["Tooltips"] = "显示浮动提示",
			["Spelltimer"] = "显示法术持续时间按钮"
		},
		["Text"] = {
			["Text"] = "在按钮上显示：",
			["Food"] = "食物数量",
			["Drink"] = "饮水数量",
			["Manastone"] = "魔法宝石冷却时间",
			["Evocation"] = "唤醒冷却时间",
			["Powder"] = "魔粉",
			["Feather"] = "轻羽毛",
			["Rune"] = "传送门符文",
		},
		["QuickBuff"] = "鼠标滑过时自动开/关法术菜单",
		["Count"] = {
			["None"] = "无",
			["Provision"] = "食物和饮水",
			["Provision2"] = "食物和饮水",
			["Health"] = "当前生命值",
			["HealthPercent"] = "生命值百分比",
			["Mana"] = "当前法力值",
			["ManaPercent"] = "法力值百分比",
			["Manastone"] = "法力宝石冷却时间",
			["Evocation"] = "唤醒冷却时间",
		},
		["Circle"] = {
			["Text"] = "球面显示事件(图形)",
			["None"] = "无",
			["HP"] = "命中点数",
			["Mana"] = "法力",
			["Manastone"] = "魔法宝石冷却时间",
			["Evocation"] = "唤醒冷却时间",

		},
		["Button"] = {
			["Text"] = "主按钮功能",
			["Consume"] = "吃/喝",
			["Evocation"] = "使用唤醒",
			["Polymorph"] = "施放变形术",
			["Manastone"] = "魔法宝石",
		},
		["Restock"] = {
			["Restock"] = "自动购买施法材料",
			["Confirm"] = "购买前确认",			
		},
		["Polymorph"] = {
			["Warn"] = "在变形术效果被移除前警告我",
			["Break"] = "在变形术效果被移除时通知我",
		},
		["ButtonText"] = "在按钮上显示施法材料数量",
		["Anchor"] = {
			["Text"] = "菜单定位点",
			["Above"] = "上方",
			["Center"] = "居中",
			["Below"] = "下方"
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