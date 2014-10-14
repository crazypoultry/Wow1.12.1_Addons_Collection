--[[
-- Traditional  Chinese localization file copyright
-- This file free for everyone who want use this AddOn with zhCN WoW,.
-- Please just keep my name on it is ok. flukeMS
--
-- 简体中文版本
-- 本简体中文版授权所有人使用.
-- 請留著我的小名就好. CWDG-衰衰的MS
--
-- KLHThreatMeter mandarin Chinese localization file
-- Maintained by: flukeMS
-- Last updated: 08/09/2006
-- Revision History:
--    10/16/2006   * Update to R17 Test20.
--    08/02/2006  * Update to R17 Test 7.
--    08/01/2006  * Update to R17 Test 7.
--]]

klhtm.string.data["zhCN"] =
{
	["binding"] = 
	{
		hideshow = "隐藏 / 显示主窗口",
		stop = "停止",
		mastertarget = "设置 / 清除主目标",
		resetraid = "重置Raid仇恨列表",
	},
	["spell"] = 
	{
		-- 17.20
		["execute"] = "斩杀",
		
		["heroicstrike"] = "英勇打击",
		["maul"] = "槌击",
		["swipe"] = "挥击",
		["shieldslam"] = "盾牌猛击",
		["revenge"] = "复仇",
		["shieldbash"] = "盾击",
		["sunder"] = "破甲攻击",
		["feint"] = "佯攻",
		["cower"] = "畏缩",
		["taunt"] = "嘲讽",
		["growl"] = "低吼",
		["vanish"] = "消失",
		["frostbolt"] = "寒冰箭",
		["fireball"] = "火球术",
		["arcanemissiles"] = "奥术飞弹",
		["scorch"] = "灼烧",
        ["cleave"] = "顺劈斩",
		
		hemorrhage = "出血",
		backstab = "背刺",
		sinisterstrike = "邪恶攻击",
		eviscerate = "剔骨",
		
		-- Items / Buffs:
		["arcaneshroud"] = "奥术环绕",
		["reducethreat"] = "Reduce Threat",
		
		-- Leeches: no threat from heal
		["holynova"] = "神圣新星", -- no heal or damage threat
		["siphonlife"] = "汲取生命", -- no heal threat
		["drainlife"] = "生命吸取", -- no heal threat		
		["deathcoil"] = "死亡缠绕",
		
		-- no threat for fel stamina. energy unknown.		
		--["felstamina"] = "恶魔耐力", 
        --["felenergy"] = "恶魔能量",
		
        ["bloodsiphon"] = "生命虹吸", -- poisoned blood vs Hakkar		

		["lifetap"] = "生命分流", -- no heal threat
		["holyshield"] = "神圣之盾", -- multiplier
		["tranquility"] = "宁静",
		["distractingshot"] = "扰乱射击",
		["earthshock"] = "地震术",
		["rockbiter"] = "石化武器",
		["fade"] = "渐隐术",
		["thunderfury"] = "雷霆之怒",
			
		-- Spell Sets
		-- warlock descruction
		["shadowbolt"] = "暗影箭",
		["immolate"] = "献祭",
		["conflagrate"] = "燃烧",
		["searingpain"] = "灼热之痛",
		["rainoffire"] = "火焰之雨",
		["soulfire"] = "灵魂之火",
		["shadowburn"] = "暗影灼烧",
		["hellfire"] = "地狱烈焰",
		
		-- mage offensive arcane
		["arcaneexplosion"] = "魔爆术",
		["counterspell"] = "法术反制",
		
		-- priest shadow. No longer used (R17).		
		["mindblast"] = "心灵震爆",-- 2 threat per damage
		--[[
		["mindflay"] = "精神鞭笞",
		["devouringplague"] = "吸血鬼的拥抱",
		["shadowwordpain"] = "暗言术：痛",
                     ,
		["manaburn"] = "法力燃烧",
		]]
	},
	["power"] = 
	{
		["mana"] = "法力",
		["rage"] = "怒气",
		["energy"] = "能量",
	},
	["threatsource"] = -- these values are for user printout only
	{
		["powergain"] = "获得能力",
		["total"] = "总共",
		["special"] = "其它技能",
		["healing"] = "治疗",
		["dot"] = "DOTS",
		["threatwipe"] = "仇恨清除",
		["damageshield"] = "伤害护盾",
		["whitedamage"] = "普通攻击",
	},
	["talent"] = -- these values are for user printout only
	{
		["defiance"] = "挑衅",
		["impale"] = "穿刺",
		["silentresolve"] = "无声消退",
		["frostchanneling"] = "冰霜导能",
		["burningsoul"] = "燃烧之魂",
		["healinggrace"] = "治疗之赐",
		["shadowaffinity"] = "暗影亲和",
		["druidsubtlety"] = "微妙",
		["feralinstinct"] = "野性本能",
		["ferocity"] = "凶暴",
		["savagefury"] = "野蛮暴怒",
		["tranquility"] = "强化宁静",
		["masterdemonologist"] = "恶魔学识大师",
		["arcanesubtlety"] = "奥术精妙",
		["righteousfury"] = "强化愤怒圣印",
		["sleightofhand"] = "Sleight of Hand",
	},
	["threatmod"] = -- these values are for user printout only
	{
		["tranquilair"] = "宁静之风图腾",
		["salvation"] = "拯救祝福",
		["battlestance"] = "战斗姿态",
		["defensivestance"] = "防御姿态",
		["berserkerstance"] = "狂暴姿态",
		["defiance"] = "挑衅",
		["basevalue"] = "基础值",
		["bearform"] = "熊形态",	
		["glovethreatenchant"] = "附魔手套-威胁",
		["backthreatenchant"] = "附魔披风-狡诈",
	},

	["sets"] = 
	{
		["bloodfang"] = "血牙",
		["nemesis"] = "复仇",
		["netherwind"] = "灵风",
		["might"] = "力量",
		["arcanist"] = "奥术师",
	},
	["boss"] = 
	{
		["speech"] = 
		{
		    onyxiaphase2 = "这无味的战斗让我心烦，我要飞上天空把你们全都烧成灰烬",
			["razorphase2"] = "在宝珠的控制力消失之前逃走",
			["onyxiaphase3"] = "看起来需要再给你一次教训",
			["thekalphase2"] = "让我感受你的怒气",
			["rajaxxfinal"] = "无礼的蠢货！我会亲自要了你们的命！",
			["azuregosport"] = "来吧，小子。面对我！",		
		    ["nefphase2"] = "燃烧吧! 你这不幸的人! 燃烧吧!",
		},
		-- Some of these are unused. Also, if none is defined in your localisation, they won't be used,
		-- so don't worry if you don't implement it.
		["name"] = 
		{
			["rajaxx"] = "拉贾克斯",
			["onyxia"] = "奥妮克希亚",
			["ebonroc"] = "埃博诺克",
			["razorgore"] = "狂野的拉佐格尔",
			["thekal"] = "高阶祭司塞卡尔",
			["shazzrah"] = "沙斯拉尔",
			["twinempcaster"] = "维克洛尔大帝",
			["twinempmelee"] = "维克尼拉斯大帝",
		    ["noth"] = "瘟疫使者诺斯",
		},
		["spell"] = 
		{
			["shazzrahgate"] = "沙斯拉尔之门", -- "Shazzrah casts Gate of Shazzrah."
			["wrathofragnaros"] = "拉格纳罗斯之怒", -- "Ragnaros's Wrath of Ragnaros hits you for 100 Fire damage."
			["timelapse"] = "时间流逝", -- "You are afflicted by Time Lapse."
			["knockaway"] = "击飞",
			["wingbuffet"] = "龙翼打击",
            ["burningadrenaline"] = "燃烧刺激",
			["twinteleport"] = "双子换位",
			["nothblink"] = "闪现术",
			["sandblast"] = "沙尘爆裂",
			["fungalbloom"] = "蘑菇花",
			["hatefulstrike"] = "仇恨打击",
			
			-- 4 horsemen marks
			mark1 = "布劳缪克丝印记",
			mark2 = "库尔塔兹印记",
			mark3 = "莫格莱尼印记",
			mark4 = "瑟里耶克印记",
			
			-- Onyxia fireball (presumably same as mage)
			fireball = "火球术",
		},

	},
	["misc"] = 
	{
		["imp"] = "小鬼", -- UnitCreatureFamily("pet")
		["spellrank"] = "等级 (%d+)", -- second value of GetSpellName(x, "spell")
		["aggrogain"] = "OT临界值",
	},

	
	["gui"] = { 
		["raid"] = {
			["head"] = {
				-- column headers for the raid view
				["name"] = "团队信息",
				["threat"] = "仇恨值",
				["pc"] = "最大值%",
			},
			["stringshort"] = {
				-- tooltip titles for the bottom bar strings
				["tdef"] = "仇恨余额",
				["targ"] = "主要目标",
			},
			["stringlong"] = {
				-- tooltip descriptions for the bottom bar strings
				["tdef"] = "",
				["targ"] = "只有在指定 %s 为插件仇恨记录目标后,才能正确统计仇恨值."
			},
		},
		["self"] = {
			["head"] = {
				-- column headers for the self view
				["name"] = "技能",
				["hits"] = "击中",
				["rage"] = "怒气",
				["dam"] = "伤害",
				["threat"] = "仇恨",
				["pc"] = "%",
			},
			-- text on the self threat reset button
			["reset"] = "重置",
		},
		["title"] = {
			["text"] = {
				-- the window titles
				["long"] = "CWDG-KTM %d.%d",
				["short"] = "CWDG-KTM",
				
			},
			["buttonshort"] = {
				-- the tooltip titles for command buttons
				["close"] = "关闭",
				["min"] = "最小化",
				["max"] = "最大化",
				["self"] = "个人仇恨",
				["raid"] = "团队仇恨",
				["pin"] = "锁定",
				["unpin"] = "解锁",
				["opt"] = "配置",
				["targ"] = "设定主要目标",
				["clear"] = "重置",
			},
			["buttonlong"] = {
				-- the tooltip descriptions for command buttons
				["close"] = "如果你还在队伍或团队里,仇恨值将继续同步.",
				["min"] = "",
				["max"] = "",
				["self"] = "显示个人仇恨详细资料.",
				["raid"] = "显示团队仇恨列表.",
				["pin"] = "锁定以防止仇恨列表窗体移动.",
				["unpin"] = "解锁以允许仇恨列表窗体移动.",
				["opt"] = "配置仇恨插件相关信息.",
				["targ"] = "设置你当前选定目标为首要目标,如果你未选择任何目标,该值将会清零.必须是团长或团队副手才能使用.",
				["clear"] = "重置所有人的仇恨为零,只有团长或团队副手才能使用.",
			},
			["stringshort"] = {
				-- the tooltip titles for titlebar strings
				["threat"] = "仇恨值",
				["tdef"] = "仇恨差值",
				["rank"] = "仇恨排名",
				["pc"] = "% 百分比",
			},
			["stringlong"] = {
				-- the tooltip descriptions for titlebar strings
				["threat"] = "从你重置仇恨值那刻开始统计的累计仇恨值",
				["tdef"] = "你和你的目标之间产生仇恨值的差异",
				["rank"] = "你的仇恨值在仇恨列表的排名",
				["pc"] = "你的仇恨值占目标仇恨值的百分比"
			},
		},
	},
	-- labels and tooltips for the options gui
	["optionsgui"] = {
		["buttons"] = {
			-- the options gui command button labels
			["gen"] = "常规",
			["raid"] = "团队",
			["self"] = "个人",
			["close"] = "关闭",	
		},
		-- the labels for option checkboxes and headers
		["labels"] = {
			-- the title description for each option page
			["titlebar"] = {
				["gen"] = "常规选项",
				["raid"] = "团队选项",
				["self"] = "个人选项",
			},
			["buttons"] = {
				-- the names of title bar command buttons
				["pin"] = "锁定",
				["opt"] = "选项",
				["view"] = "列表切换",
				["targ"] = "定义目标",
				["clear"] = "重置",
			},
			["columns"] = {
				-- names of columns on the self and raid views
				["hits"] = "击中",
				["rage"] = "怒气",
				["dam"] = "伤害",
				["threat"] = "仇恨",
				["pc"] = "百分比",
			},
			["options"] = {
				-- miscelaneous option names
				["hide"] = "隐藏仇恨为0的行",
				["abbreviate"] = "单位值简写",
				["resize"] = "调整框体",
				["aggro"] = "显示仇恨",
				["rows"] = "仇恨列表最大人数",
				["scale"] = "窗体缩放",
				["bottom"] = "隐藏底部信息条",
			},
			["minvis"] = {
				-- the names of minimised strings
				["threat"] = "最小仇恨", -- dodge...
				["rank"] = "仇恨值排名",
				["pc"] = "% 百分比",
				["tdef"] = "仇恨值差异",
			},
			["headers"] = {
				-- headers in the options gui
				["columns"] = "显示增量条",
				["strings"] = "最小化显示字串",
				["other"] = "其他选项",
				["minvis"] = "最小化显示按钮",
				["maxvis"] = "最大化显示按钮",
			},
		},
		-- the tooltips for some of the options
		["tooltips"] = {
			-- miscelaneous option descriptions
			["raidhide"] = "如果选择,仇恨为0的玩家将不会在仇恨列表中显示.",
			["selfhide"] = "不选中此项可以显示所有仇恨值.",
			["abbreviate"] = "如果选择如果选中, 超过1万的数值将被采用缩写模式显示. 例如 '15400' 会显示为 '15.4k'.",
			["resize"] = "如果选择,将自动以当前统计的信息数量来调整窗体大小.",
			["aggro"] = "如果选择,一个特殊的行将会显示玩家OT的仇恨预测值,通常在选择主要目标后统计比较准确.",
			["rows"] = "团队窗口中显示玩家的最大数量.",
			["bottom"] = "如果选择,用于显示当前主要目标和仇恨对比的底框将被隐藏.",
		},
	},
	["print"] = 
	{
		["main"] = 
		{
			["startupmessage"] = "KLHThreatMeter Release [CWDG汉化版]|cff33ff33%s|r Revision |cff33ff33%s|r 已经加载。 输入 |cffffff00/ktm|r 取得更多帮助。",
		},
		["data"] = 
		{
			["abilityrank"] = "你的 %s 技能等级是 %s。",
			["globalthreat"] = "你的总体仇恨修正值是 %s。",
			["globalthreatmod"] = "%s 给予你 %s。",
			["multiplier"] = "作为一个%s，你的%s仇恨修正值是 %s。",
			["damage"] = "伤害",
			["shadowspell"] = "暗影术",
			["arcanespell"] = "奥术",
			["holyspell"] = "神圣法术",
			["setactive"] = "是否穿着 %s 套装 %d 件? ... %s。",
			["true"] = "是",
			["false"] = "否",
			["healing"] = "你的治疗造成了 %s 仇恨（被总体修正值修正前）。",
			["talentpoint"] = "你有 %d 点天赋值在 %s。",
			["talent"] = "发现 %d 点 %s 天赋。",
			["rockbiter"] = "你的石化攻击(等级%d)同时增加了%d点威胁值。 ",
		},
		
		-- new in R17.7
		["boss"] = 
		{
			["automt"] = "主要目标已经自动设置为 %s.",
			["spellsetmob"] = "%s 为 %s'的 %s设置了从%s到 %s的 %s参数.", -- "Kenco sets the multiplier parameter of Onyxia's Knock Away ability to 0.7"
			["spellsetall"] = "%s 为 %s设置了%s参数从 %s 到 %s.",
			["reportmiss"] = "%s 报告 他闪避了%s的 %s.",
			["reporttick"] = "%s 报告 %s'的 %s 击中了他. 他遭受了 %s 打击, 并将遭受更多的 %s 打击.",
			["reportproc"] = "%s 报告 %s'的 %s他的威胁值从%s改变到%s.",
			["bosstargetchange"] = "%s 的目标已经从 %s (%s 仇恨) 改变为 %s (%s 仇恨).",
			["autotargetstart"] = "当你下个目标为BOSS时,你之前的BOSS仇恨数据将会自动清除.",
			["autotargetabort"] = "当前主要目标已经设置为当前BOSS: %s.",
		},
		
		["network"] = 
		{
			["newmttargetnil"] = "无法确认主要目标 %s, 因为 %s 没有目标。",
			["newmttargetmismatch"] = "%s 设定主要目标为 %s，但是他的主要目标是 %s， 将会使用他的主要目标替代，请注意。",
			["threatreset"] = "团队仇恨列表已经被 %s 清除。",
			["newmt"] = "主要目标已经被更改为'%s'，被 %s 改变。",
			["mtclear"] = "主要目标已经被 %s 清除。",
			["knockbackstart"] = "击飞侦测已经被 %s 启用。",
			["knockbackstop"] = "击飞侦测已经被 %s 停用。",
			["aggrogain"] = "%s 报告，在产生了 %d 仇恨后获得Aggro。",
			["aggroloss"] = "%s 报告，%d 仇恨失去了Aggro。",
			["knockback"] = "%s 报告被击飞，他的仇恨值下降到 %d 。",
			["knockbackstring"] = "%s 报告了这个击飞的文字：'%s'。",
			["upgraderequest"] = "%s 请你升级KLHThreatMeter到 %s 版本。你目前使用的是 %s。",
			["remoteoldversion"] = "%s 正在使用KLHThreatMeter的 %s 版本。请告诉他升级到 %s。",
			["knockbackvaluechange"] = "|cffffff00%s|r 设定了 %s 的 |cffffff00%s|r 仇恨减少到 |cffffff00%d%%|r。",
			["raidpermission"] = "只有队长才能这样做。",
			["needmastertarget"] = "你必须设置一个主目标。",
			["knockbackinactive"] = "击飞侦测在团队中被关闭。",
			["versionrequest"] = "查询团队内的版本信息，将在3秒钟后报告。",
			["versionrecent"] = "这些人使用版本 %s: { ",
			["versionold"] = "这些人使用旧版本: { ",
			["versionnone"] = "这些人没有使用KLHThreatMeter，或者不在正确的CTRA频道: { ",	
			["channel"] = 
			{
				ctra = "CTRA 频道",
				ora = "oRA 频道",
				manual = "手工设置",
			},
			needtarget = "首先选择一个目标作为主目标来设置.",
			upgradenote = "已提醒升级本插件最新版本.",
			advertisestart = "你会随机的提示获得Aggro的人安装试用KTM插件.",
			advertisestop = "你已停止推荐KTM插件的提示.",
			advertisemessage = "建议尝试KLHThreatMeter插件, 这会帮助你更好的控制仇恨避免意外.",		
			},
		
		-- ok, so autohide isn't really a word, but just improvise
		table = 
		{
			autohideon = "窗体将会自动显示或隐藏",
			autohideoff = "自动隐藏关闭",
		}		
	}
}