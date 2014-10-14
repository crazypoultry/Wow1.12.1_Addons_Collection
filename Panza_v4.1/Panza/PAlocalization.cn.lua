----------------------------------------------------------------------------------------------
--
--		Chinese localization for Panza Version 4.1
--
----------------------------------------------------------------------------------------------

if ( GetLocale() == "zhCN" ) then

BINDING_HEADER_PANZA		= 'Panza 按键绑定';
BINDING_NAME_PANZA_OPTIONS	= 'Panza 选项';
BINDING_NAME_PANZA_SAVE		= '使用CTRL+宏保存Buff';
BINDING_NAME_PANZA_SELF		= '使用ALT+宏对自己Buff或者治疗';
BINDING_NAME_PANZA_LALL		= '列表显示已保存的Buff';
BINDING_NAME_PANZA_LPARTY	= '列表显示为你的小队成员保存的Buff';
BINDING_NAME_PANZA_LRAID	= '列表显示为你的团队成员保存的Buff';

PANZA_DESC			= '帮助圣骑士在单练，组队或者组团时自动Buff，治疗和清洁。';
PANZA_CHATLANGUAGE		= "通用语";

PANZA_DISEASE			= "疾病";
PANZA_MAGIC			= "魔法";
PANZA_POISON			= "中毒";
PANZA_CURSE			= "诅咒";

PANZA_OPTS_TITLE		= 'Panza';
PANZA_OPTS_BUTPOS		= '小地图按钮位置';
PANZA_OPTS_BUTPICT		= "小地图按键图标";
PANZA_OPTS_CBX_SELF		= '打开使用alt+宏进行自我Buff和治疗的功能。';
PANZA_OPTS_CBX_SAVE		= '打开使用ctrl+宏进行保存Buff的功能。';
PANZA_OPTS_CBX_BUTT		= '显示小地图按钮。';
PANZA_OPTS_CBX_OUT		= '打开治疗/Buff/清洁小队/团队之外对象的功能。';
PANZA_OPTS_CBX_RGS		= '打开筛选团队小组的功能';
PANZA_OPTS_CBX_PVP		= '跳过标记PVP的玩家。';
PANZA_OPTS_TRANS		= '透明度';
PANZA_OPTS_CBX_MLS		= 'MapLibrary 支持';
PANZA_OPTS_CBX_ACTION		= '使用动作栏进行距离检查';

PANZA_PAM_TITLE			= 'Panza 消息 (PAM)'
PANZA_PAM_HEAL			= '治疗消息';
PANZA_PAM_BLESS			= 'Buff消息';
PANZA_PAM_CURE			= '清洁消息';
PANZA_PAM_REZ			= '复活信息';
PANZA_PAM_CORE			= '内核消息';
PANZA_PAM_UI			= '用户界面消息';
PANZA_PAM_CBX_PROGRESS		= '显示/发送治疗法术进度报告。';
PANZA_PAM_CBX_NOTIFYFAIL	= '通报法术失败。';
PANZA_PAM_SHOWRANKS		= '在施法信息中显示法术等级';
PANZA_PAM_COOP			= '协同治疗信息';
PANZA_PAM_OFFEN			= '攻击法术信息';

PANZA_PAMCUSTOM_TITLE		= 'PA定制(PAM)'
PANZA_PAMCUSTOM_RESURRECT	= "复活";
PANZA_PAMCUSTOM_DAMAGE		= "伤害法术信息";

PANZA_PHM_TITLE			= '圣骑士治疗模块 (PHM)';
PANZA_PHM_MINTH			= '最小允许治疗的生命值阈值';
PANZA_PHM_OVERHEAL		= '超量治疗阈值';
PANZA_PHM_FOLTH			= '开始专用圣光闪现的法力值阈值';
PANZA_PHM_FLASH			= '开始专用圣光闪现的生命值阈值';
PANZA_PHM_LOWFLASH		= '使用圣光闪现的最低生命值阈值';
PANZA_PHM_MID			= "中等生命值阈值";
PANZA_PHM_PETTH			= '开始自动宠物治疗的生命值阈值';
PANZA_PHM_SENSE			= '调整治疗的敏感度';
PANZA_PHM_GROUPLIMIT		= "小队治疗下限";
PANZA_PHM_ABORT			= '打断过量治疗';
PANZA_PHM_RANGE			= '根据情况忽略治疗距离检查';
PANZA_PHM_USEDFALL		= '在可用时为治疗法术使用神恩';
PANZA_PHM_USEDF			= '在可用时使用神恩术和圣光术';
PANZA_PHM_USEDFALL_PRIEST	= '为治疗法术使用心灵专注';
PANZA_PHM_USEDF_PRIEST		= '使用心灵专注和治疗法术';
PANZA_PHM_USEDFALL_SHAMAN	= '为治疗法术使用自然迅捷';
PANZA_PHM_USEDF_SHAMAN		= '使用自然迅捷和治疗法术';
PANZA_PHM_USEDFALL_DRUIDOMEN	= '检查ClearCasting并修改治疗法术等级。';
PANZA_PHM_USEDF_DRUIDOMEN	= 'Only with Healing Touch';
PANZA_PHM_USEDFALL_DRUIDSWIFT	= '使用自然迅捷和治疗法术';
PANZA_PHM_USEDF_DRUIDSWIFT	= 'Only with Healing Touch';
PANZA_PHM_PARTYBIAS		= '治疗偏向于小队成员';
PANZA_PHM_MAINTANKBIAS		= '偏向MT(依赖团队助手)';
PANZA_PHM_MTTTBIAS		= "偏向MT的目标的目标";
PANZA_PHM_SELFBIAS		= '治疗偏向于自己';
PANZA_PHM_MANABUFF		= '法力缓冲';
PANZA_PHM_CRITRANK		= '使用DF的最低等级';
PANZA_PHM_CRITRANK_PRIEST	= '使用心灵专注的最低等级';
PANZA_PHM_CRITRANK_SHAMAN	= '使用自然迅捷的最低等级';
PANZA_PHM_CRITRANK_DRUIDOMEN 	= '使用节能施法的最低等级';
PANZA_PHM_CRITRANK_DRUIDSWIFT	= '使用自然迅捷的最低等级';
PANZA_OOCH_SWITCH		= "组合技之外使用简单治疗";
PANZA_PHM_HOTS			= "Use Heal Over Time";
PANZA_PHMBIAS_TITLE		= "Panza治疗/清洁偏好";
PANZA_ALLRANKS			= "所有等级";
PANZA_THEN			= "然后";
PANZA_PHM_OOC			= "组合技";

PANZA_PBM_TITLE			= 'PANZA Buff模块 (PBM)';
PANZA_PBM_NPCS			= '近邻循环中跳过的NPC人数';
PANZA_PBM_REBLESS		= '循环Buff重新开始的阈值';
PANZA_PBM_NOTBLESSED		= '循环Buff未被Buff者记数';
PANZA_PBM_NEAR_RESTART		= '近邻循环列表刷新阈值';
PANZA_PBM_BOSAF			= "被标记为PVP时保持牺牲祝福";
PANZA_PBM_PETS			= "Buff宠物";
PANZA_PBM_PARTYINRAID		= "在团队中忽略小队";

PANZA_PBM_CBX_NPC		= '打开近邻循环中对NPC进行Buff的功能';
PANZA_PBM_CBX_CYCLE		= '打开自动选择Buff模式下的循环Buff功能';
PANZA_PBM_CBX_BOWLOWMANA	= '对法力值过低的目标施放智慧Buff';
PANZA_PBM_CBX_PVPUSEBG		= 'PVP状态时使用为战场设定的Buff';
PANZA_PBM_CBX_WARN		= '打开Buff失效警告系统 (BEWS).';
PANZA_PBM_CBX_BLESSINGPROGRESS	= '每次Buff施放后显示Buff进度';

PANZA_PBM_CBX_GBME		= "自己";
PANZA_PBM_CBX_GBPARTY		= "小队";
PANZA_PBM_CBX_GBRAID		= "团队";
PANZA_PBM_CBX_GBBG		= "战场";

PANZA_PBM_HEAD_SOLO		= "单练";
PANZA_PBM_HEAD_PARTY		= "小队";
PANZA_PBM_HEAD_RAID		= "团队";
PANZA_PBM_HEAD_BG		= "战场";

PANZA_PBM_BEWS_GREATER		= "强效";
PANZA_PBM_BEWS_ALL		= "所有的";
PANZA_PBM_BEWS_SOUNDS		= "播放声音";
PANZA_PBM_GB 			= "强效祝福";
PANZA_PBM_GREATER		= "强效祝福阈值";
PANZA_PBM_GREATERFLAGS		= "启用强效祝福于:"

PANZA_TYPE			= {};
PANZA_TYPE["Heal"]		= "治疗";
PANZA_TYPE["Cure"]		= "清洁";
PANZA_TYPE["Bless"]		= "Buff";
PANZA_TYPE["Free"]		= "自由";
PANZA_TYPE["Panic"]		= "紧急";
PANZA_TYPE["Offense"]		= "攻击";

PANZA_BUFF_DISPLAY = {}
PANZA_BUFF_DISPLAY["bol"]	= {Abbr="光明",		Short="光明祝福"};
PANZA_BUFF_DISPLAY["bom"]	= {Abbr="力量",		Short="力量祝福"};
PANZA_BUFF_DISPLAY["bow"]	= {Abbr="智慧",		Short="智慧祝福"};
PANZA_BUFF_DISPLAY["bosal"]	= {Abbr="拯救",		Short="拯救祝福"};
PANZA_BUFF_DISPLAY["bosan"]	= {Abbr="庇护",		Short="庇护祝福"};
PANZA_BUFF_DISPLAY["bok"]	= {Abbr="王者",		Short="王者祝福"};
PANZA_BUFF_DISPLAY["bop"]	= {Abbr="保护",		Short="保护祝福"};
PANZA_BUFF_DISPLAY["fury"]	= {Abbr="Fury",		Short="Fury"};
PANZA_BUFF_DISPLAY["bosaf"]	= {Abbr="牺牲",		Short="牺牲祝福"};
PANZA_BUFF_DISPLAY["bof"]	= {Abbr="自由",		Short="自由祝福"};
PANZA_BUFF_DISPLAY["fort"]	= {Abbr="圣言术：韧",	Short="圣言术：韧"};
PANZA_BUFF_DISPLAY["pws"]	= {Abbr="圣言术：盾",	Short="圣言术：盾"};
PANZA_BUFF_DISPLAY["fward"]	= {Abbr="反恐",		Short="防护恐惧结界"};
PANZA_BUFF_DISPLAY["ifire"]	= {Abbr="Ifire",	Short="InnerFire"};
PANZA_BUFF_DISPLAY["sprt"]	= {Abbr="DSpr",		Short="神圣之灵"};
PANZA_BUFF_DISPLAY["sprot"]	= {Abbr="Sprot",	Short="防护暗影"};
PANZA_BUFF_DISPLAY["motw"]	= {Abbr="MotW",		Short="野性印记"};
PANZA_BUFF_DISPLAY["thorns"] 	= {Abbr="Thorns",	Short="荆棘术"};
PANZA_BUFF_DISPLAY["ai"]	= {Abbr="AI",		Short="ArcaneInt"};
PANZA_BUFF_DISPLAY["farm"]	= {Abbr="FArm",		Short="FrostArmor"};
PANZA_BUFF_DISPLAY["iarm"]	= {Abbr="IArm",		Short="IceArmor"};
PANZA_BUFF_DISPLAY["marm"]	= {Abbr="MArm",		Short="MageArmor"};
PANZA_BUFF_DISPLAY["amagic"]	= {Abbr="AMagic",	Short="AmplifyMagic"};
PANZA_BUFF_DISPLAY["dmagic"]	= {Abbr="DMagic",	Short="DampenMagic"};
PANZA_BUFF_DISPLAY["lshld"]	= {Abbr="Lshld",	Short="LightningShield"};
PANZA_BUFF_DISPLAY["rbiter"]	= {Abbr="RBiter",	Short="RockBiter"};
PANZA_BUFF_DISPLAY["ftwep"]	= {Abbr="ftwep",	Short="FlameTongueWep"};
PANZA_BUFF_DISPLAY["fbwep"]	= {Abbr="fbwep",	Short="FrostbandWep"};
PANZA_BUFF_DISPLAY["wfwep"]	= {Abbr="wfwep",	Short="WindfuryWep"};
PANZA_BUFF_DISPLAY["wbreath"]	= {Abbr="wbrth",	Short="WaterBreathing"};
PANZA_BUFF_DISPLAY["wwalk"]	= {Abbr="wwalk",	Short="WaterWalking"};

PANZA_PPM_STAGE1		= '保护祝福'; 	-- Short form of Blesing of Protection保护祝福
PANZA_PPM_STAGE1_PRIEST		= '圣言术：盾'; -- Short form of Power Word: Shield圣言术：盾
PANZA_PPM_STAGE2		= '神圣震击'; 	-- Short form of Holy Shock神圣震击
PANZA_PPM_STAGE3		= '圣疗术'; 	-- Short form of Lay on Hands圣疗术
PANZA_PPM_STAGE4		= '清洁';
PANZA_PPM_STAGE5		= '神恩术'; 	-- Short form of Divine Favor神恩术
PANZA_PPM_STAGE5_PRIEST		= '心灵专注';	-- Replacement Text for DF (Priest Inner Focus)心灵专注
PANZA_PPM_STAGE5_DRUIDSWIFT 	= '自然迅捷';	-- Replacement Text for DF (Druid Nature's Swiftness)自然迅捷
PANZA_PPM_STAGE5_DRUIDOMEN 	= '节能施法';	-- Replacement Text for DF (Druid when ClearCasting)节能施法
PANZA_PPM_STAGE5_SHAMAN 	= '自然迅捷';	-- Replacement Text for DF (Shaman Nature's Swiftness)自然迅捷
PANZA_PPM_STAGE6		= '最佳治疗';

PANZA_PAW_TITLE			= "Panza 密语 (PAW)";
PANZA_PAW_CMDANNOUNCE		= "paw";
PANZA_PAW_HEADER		= "(PAW) PA 密语符号和词组";
PANZA_PAW_ANNCSPELLS		= "    %s = %s";
PANZA_PAW_TRAILER		= "Send a tell with one keyword listed to setup that spell.";
PANZA_PAW_WC_PASS		= "(PAW) is disabled but Whispercast is installed and queueing. Send WC commands.";
PANZA_PAW_DUP 			= "(PAW) %s is already set for you.";
PANZA_PAW_SAVED 		= "(PAW) %s is setup for you.";
PANZA_PAW_BLESSINGOK		= "(PAW) your Buff (%s) has %d seconds remaining.";
PANZA_PAW_BLESSINGEXPIRING	= "(PAW) your Buff (%s) is expiring in %d seconds. Cycle will refresh it.";
PANZA_PAW_BLESSINGFADING	= "(PAW) your Buff (%s) is fading in %d. Cycle will refresh it ASAP.";
PANZA_PAW_BLESSINGEXPIRED	= "(PAW) your Buff (%s) has expired. Cycle will cast it ASAP.";
PANZA_PAW_SPELLDISABLED		= "(PAW) %s is disabled for automatic setup.";
PANZA_PAW_REPORTDEFAULT		= "(PAW) %s will be cast on you and other %s\'s by default.";
PANZA_PAW_NOSPELL		= "(PAW) %s is unavailable.";
PANZA_PAW_GB			= "(PAW) %s(%s) is setup for your class.";
PANZA_PAW_NOSPELLS		= "(PAW) No spells are available.";
PANZA_PAW_DISABLED		= "(PAW) PA Whisper is disabled.";
PANZA_PAW_ENABLED		= "(PAW) PA Whisper is enabled.";
PANZA_PAW_RESP_ENABLED		= "(PAW) Responses Enabled.";
PANZA_PAW_RESP_DISABLED		= "(PAW) Responses Disabled.";
PANZA_PAW_LOCALNO		= "(PAW) is not supported by sending tells to yourself.";
PANZA_PAW_CBX_ENABLE		= "启用";
PANZA_PAW_CBX_RESPONSE		= "回应";

PANZA_PFM_TITLE			= "Panza 自由模块 (PFM)";

PANZA_PMM_TITLE			= "Panza 鼠标设置 (PMM)";
PANZA_PMM_CBX_ENABLE		= "启用 Panza 鼠标设置";
PANZA_PMM_FRAMESUP		= "Frame Support";
PANZA_PMM_CBX_CTRA		= "Enable CTRA Frames";
PANZA_PMM_CBX_PLAYER		= "Enable Blizzard Player Frames";
PANZA_PMM_CBX_TARGET		= "Enable Blizzard Target Frames";
PANZA_PMM_CBX_PARTY		= "Enable Blizzard Party Frames";
PANZA_PMM_CBX_PET		= "Enable Blizzard Pet Frames";
PANZA_PMM_CBX_DUF		= "Enable Discord Unit Frames";
PANZA_PMM_CBX_PERL		= "Enable Perl Classic Frames";

PANZA_POM_TITLE			= "Panza 攻击 (POM)";
PANZA_POM_HSONLYONDF		= "仅当神恩术可用时";
PANZA_POM_HSALWAYSONDF		= "Divine Favor used anytime with Holy Shock";
PANZA_POM_HS			= "使用神圣震击";
PANZA_POM_EXO			= "使用驱邪术";
PANZA_POM_HOW			= "使用愤怒之锤";
PANZA_POM_SOC			= "在可用时总是审判命令圣印";
PANZA_POM_STUNNED		= "仅在目标昏迷时";
PANZA_POM_SOR			= "在可用时总是审判正义圣印";
PANZA_POM_OFFALL		= "总是施放攻击法术";
PANZA_POM_SMSHOW		= "显示圣印菜单";
PANZA_POM_SMLOCK		= "锁住圣印菜单";
PANZA_POM_SMKEEPOPEN		= "保持选择菜单打开";
PANZA_POM_SMKEEPDOCKED		= "保持选择菜单停靠";
PANZA_POM_SMMENUONSHIFT		= "使用SHIFT打开选择菜单";
PANZA_POM_SMPVP			= "忽略PvP标记";
PANZA_POM_TOOLTIPS		= "圣印菜单提示"
PANZA_POM_TEXTTOP		= "Top";
PANZA_POM_TEXTBOTTOM		= "按钮";
PANZA_POM_TEXTOFF		= "Off";
PANZA_POM_SMTEXT		= "Prediction Text:"

PANZA_RGS_TITLE			= '团队小组筛选 (RGS)';
PANZA_RGS_ENABLED		= '团队小组筛选功能(RGS)已打开';
PANZA_RGS_DISABLED		= '团队小组筛选功能(RGS)已关闭';

PANZA_DCB_TITLE			= '默认职业Buff(DCB)';
PANZA_BLE_TITLE			= 'Buff列表编辑(BLE)';
PANZA_STA_TITLE			= '圣骑士助手';
PANZA_PPM_TITLE			= '紧急情形治疗';
PANZA_PCS_TITLE			= '职业选择 (PCS)';
PANZA_PCM_TITLE			= 'Panza 清洁模块 (PCM)';

PANZA_MSG_HEAL_NO		= '现在不需要治疗';
PANZA_MSG_HEAL_FULL		= '%s\'的生命值是或将是满的, 不需要治疗。'
PANZA_MSG_HEAL_MTH		= '%s\'s的生命值在或即将在阈值上, 不需要治疗。'
PANZA_MSG_CURE_NO		= '现在不需要清洁。';
PANZA_MSG_FREE_NO		= '没人需要自由祝福。';
PANZA_MSG_SAF_NO		= '没人可以被施放牺牲祝福。';
PANZA_MSG_SAL_NO		= '拯救只能施放给队友或你自己。';
PANZA_MSG_DI_NO			= "找不到施放神圣干涉的合适对象！"
PANZA_MSG_BOL_RCV		= '将获得bonus healing于';
PANZA_MSG_ADDUSER		= "Panza: 为%s创建个性设置";
PANZA_MSG_UPDATE		= "更新设置， 从版本%s到%s。";
PANZA_MSG_NEW			= "Panza: 创建默认设置";
PANZA_MSG_SETUP_INFORMCHANGED	= "检查消息设置。你需要重新设置消息，它已经被改变!";
PANZA_MSG_SETUP_VERBOSECHANGED	= "检查消息设置。你需要重新设置小组 (old Verbose)消息。它已经被改变!";
PANZA_MSG_SETUP_RAIDCHANGED	= "检查消息设置。你需要重新设置团队消息。它已经被改变!";
PANZA_MSG_MAPLIBRARY		= "MapLibrary 支持到%s, %s 已就绪.";
PANZA_MSG_ITEM_BONUS		= "Titan ItemBonus的支持 %s, %s 已就绪. +%.0f 治疗效果.";
PANZA_MSG_BONUSSCAN		= "BonusScanner的支持 %s, %s 已就绪. +%.0f 治疗效果.";
PANZA_MSG_INVENTORY_CHANGED	= "物品升级";
PANZA_MSG_RESURRECT_NO		= '没有人需要被复活。';
PANZA_MSG_RESURRECT_MISSING	= '你还没有学会救赎魔法';
PANZA_MSG_RESURRECT_COMBAT	= 'You cannot resurrect in combat.';
PANZA_MSG_RESURRECTING		= "Rezzing %1$s in %2$d 秒。";
PANZA_MSG_RESURRECT_YOU		= "你";
PANZA_MSG_RESURRECT_RELEASED    = "下一个玩家已释放，无法自动选中:";
PANZA_MSG_RESURRECT_OUTOFRANGE	= "下一个玩家已死亡但尸体超出范围。";
PANZA_MSG_RESURRECT_TARGETOOR	= "目标尸体超出范围";
PANZA_MSG_DI_MISSING		= '你还不会神圣干涉。';
PANZA_MSG_PANIC_NO		= "不必惊慌。";
PANZA_MSG_CUR_MISSING		= '你还没有学会解负面状态。';

PANZA_DELAY			= "延迟"; 		-- spell "delayed" 1 second
PANZA_COOLDOWN			= "还有 %.2f 秒冷却时间来施放 %s"; -- %.2f Time in seconds, %s : name of the spell
PANZA_UNIT_DOESNT_EXIST		= "目标 %s 不存在";
PANZA_TARGET_VANITYPET		= "目标是虚无的宠物。";
PANZA_NAME_TOO_FAR_AWAY		= "%s 超出距离。";
PANZA_TARGET_BURNING		= "%s 正在燃烧。";
PANZA_TARGET_NOT_VISABLE	= "目标超出可见范围。";
PANZA_TARGET_NOT_FRIEND		= "目标不是友好目标。";
PANZA_TARGET_ENEMY		= "目标是敌方单位。";
PANZA_TARGET_CAN_ATTACK		= "目标可以攻击。";
PANZA_TARGET_CAN_BE_ATTACKED	= "目标可被攻击。";
PANZA_TARGET_SELF		= "目标是你自己。";
PANZA_CANNOT_COOP_TARGET	= "不能配合目标。";
PANZA_TARGET_NOT_CONNECTED	= "目标不在线。";
PANZA_TARGET_DEAD		= "%s 死亡。";
PANZA_TARGET_NOTDEAD		= "%s 还活着。";
PANZA_TARGET_GHOST		= "%s 是灵魂。";
PANZA_TARGET_PHASE_SHIFT	= "目标处于时空转移状态。";
PANZA_TARGET_PROWL		= "目标正在潜行。";
PANZA_WELCOME			= "Panza: 版本 %s。使用 /panza 或 /pa 获得帮助。";
PANZA_INITIALIZING		= "Panza: 初始化中...";
PANZA_PARTY_MODIFIED		= "小队/团队发生改变。 在本次循环完成后，循环目标列表将会重置";
PANZA_UPDATE_BLESSING_LIST	= "更新已保存的Buff列表";
PANZA_UPDATE_CLASS_DB		= "Panza: 更新内部职业数据库...";
PANZA_UPDATE_SPELL_DB		= "Panza: 更新内部法术数据库...";
PANZA_DEF_BLESS			= "默认Buff改变为 %s ，基于列表。";
PANZA_MODIFIED_CLASS		= "改变的职业有";
PANZA_AND			= "和";
PANZA_INITIALIZATION_COMPLETE	= "Panza: 初始化完成。 %d 法术读入。";
PANZA_HASSPELL			= "%s 获得 %s %s"; -- Insert Name, Spell and DefClass

PANZA_TITLE_ASHEAL		= "自动选择治疗";
PANZA_TITLE_ASBLESS		= "自动选择Buff";
PANZA_TITLE_ASCURE		= "自动选择清洁";
PANZA_TITLE_ASFREE		= "自动选择自由祝福";
PANZA_TITLE_ASREZ		= "自动选择复活";
PANZA_TITLE_BESTHEAL		= "最适当治疗";
PANZA_TITLE_CYCLENEAR		= "Buff近邻";
PANZA_TITLE_CYCLEBLESS		= "Buff团队";
PANZA_TITLE_DI			= "自动神圣干涉";
PANZA_TITLE_PANIC		= "紧急！";

PANZA_HELP_ASHEAL		= " 自动选择治疗模式";
PANZA_HELP_ASBLESS		= " 自动选择Buff模式";
PANZA_HELP_ASCURE		= " 自动选择清洁模式";
PANZA_HELP_ASFREE		= " 对团队/小队/单练 中被限制行动的成员使用自由祝福";
PANZA_HELP_ASREZ		= " 复活 团队/小队 成员";
PANZA_HELP_PANIC		= " 紧急 保护祝福/圣疗术/最佳治疗";
PANZA_HELP_PANIC2		= " 紧急 PWS/清洁/最佳治疗";
PANZA_HELP_AUTOHEAL		= " 根据最低生命率治疗队伍或Solo人员。";
PANZA_HELP_AUTOCURE		= " 清洁中了毒、疾病或魔法的团队、小队或Solo人员in that order。";
PANZA_HELP_BESTHEAL		= " 用最有效率的法术治疗目标。";
PANZA_HELP_BESTCURE		= " 用最有效的法术清洁目标。";
PANZA_HELP_RAIDHEAL		= " 根据最低生命治疗团队、小队或Solo人员。";
PANZA_HELP_AUTOBLESS		= " 根据职业施放Buff。";
PANZA_HELP_CYCLENEAR		= " 自动Buff附近的玩家。";
PANZA_HELP_CYCLEBLESS		= " 自动Buff队友。循环遍历所有人员。";
PANZA_HELP_DI			= " 以最近且活着的治疗者为目标施放神圣干涉。";
PANZA_HELP_PAW			= " (PAW) 启用/禁用Panza密语";
PANZA_HELP_ANNC			= " (PAW) Announce solo, party, or raid paw help.";
PANZA_HELP_PAWRESP		= " (PAW) 启用/禁用对PAW的回应。";

PANZA_HELP_BOW			= " 施放基于目标等级选择的智慧祝福 ";
PANZA_HELP_BOM			= " 施放基于目标等级选择的力量祝福 ";
PANZA_HELP_BOL			= " 施放基于目标等级选择的光明祝福 ";
PANZA_HELP_BOSAF		= " 施放基于目标等级选择的牺牲祝福 ";
PANZA_HELP_BOSAN		= " 施放基于目标等级选择的庇护祝福 ";
PANZA_HELP_BOSAL		= " 施放拯救祝福 ";
PANZA_HELP_BOK			= " 施放王者祝福 ";
PANZA_HELP_BOP			= " 施放保护祝福 ";
PANZA_HELP_BOF			= " 施放自由祝福 ";

PANZA_HELP_RAIDSTATUS		= " 显示当前团队设置 ";
PANZA_HELP_WARNINGS		= " 切换 开/关 Buff到期预警";
PANZA_HELP_QUIET		= " 不向队员通告施法情况";
PANZA_HELP_SHOW			= " 显示当前设置 ";
PANZA_HELP_ENABLESELF		= " 开/关 使用alt+宏进行自我buff和治疗的功能。";
PANZA_HELP_ENABLESAVE		= " 开/关 使用ctrl+宏保存Buff的功能。";
PANZA_HELP_OPTIONS		= " 显示图形界面的Panza设置";
PANZA_HELP_ENABLESELF_TEXT	= " 使用这些宏时按住 alt 键将会对自己施放相应的法术。";
PANZA_HELP_ENABLESAVE_TEXT1	= " 使用这些buff宏时按住 ctrl 键将会为目标保存使用的Buff ";
PANZA_HELP_ENABLESAVE_TEXT2	= " ctrl 键Buff将会对目标玩家保存：";
PANZA_HELP_AUTOLIST		= " 切换当有成员离开队伍时是否自动刷新Buff列表。";
PANZA_HELP_LISTPARTY		= " 列表显示为当前小队成员选定的Buff ";
PANZA_HELP_LISTRAID		= " 列表显示为当前团队成员选定的Buff ";
PANZA_HELP_LISTALL		= " 列表显示已保存Buff的目标玩家 ";
PANZA_HELP_CLEARTARGET		= " 清除为当前选定玩家设置保存的Buff ";
PANZA_HELP_CLEARPARTY		= " 清除为当前小队中玩家设置保存的Buff ";
PANZA_HELP_CLEARRAID		= " 清除为当前团队中玩家设置保存的Buff ";
PANZA_HELP_CLEARALL		= " 清除所有保存Buff，并且用 \"players\" 默认的Buff重建列表 ";
PANZA_HELP_CLEARNAME		= " 清除列表中指定名字的玩家 ";
PANZA_HELP_RESET		= " 将已保存的信息重置到默认值 ";
PANZA_HELP_NOPVP		= " 跳过PVP的NPC和玩家 ";
PANZA_HELP_SHOWSPELLS		= " Show details on spells Panza knows about.";

PANZA_HELP_DESTGUILD		= " Switch to PanzaComm \"Guild\" Msg Destination.";
PANZA_HELP_DESTRAID		= " Switch to PanzaComm \"Raid\" Msg Destination.";
PANZA_SHOW_NOTINRAID		= "你不在一个团队中，这些设置目前没有效果";
PANZA_SHOW_QUIET		= "Panza 静默中. 小队/团队/玩家 通报关闭 ";

PANZA_CLEARNAME_USAGE		= "使用: /script PA:ClearName(\"名字\")";
PANZA_CLEARNAME_PLAYER		= "你无法移除 \"玩家\" 记录.";
PANZA_CLEARNAME_NAME		= "清除为 %s 保存的Buff设置";
PANZA_CLEARNAME_NOCLEAR		= "没有为 %s 保存Buff ";

PANZA_WINDOWSTATE_CHANGED	= "窗口状态已改变 ";
PANZA_BUFFEXPIREWARNINGS	= "Buff预警从到期前 %s 秒开始显示 ";
PANZA_BUFFEXPIRE		= "%s Buff将在 %d 秒内到期 ";
PANZA_NOBUFFEXPIRE		= "Buff没有施放或者已过期";
PANZA_WARNINGS			= "Buff预警将会显示 ";
PANZA_NOWARNINGS		= "Buff预警将不会显示 ";

PANZA_SELFBLESSING_ENABLED	= "当使用Alt+宏时，自我Buff将会被激活";
PANZA_SELFBLESSING_DISABLED	= "自我Buff功能已关闭 ";
PANZA_SAVEBLESSING_ENABLED	= "当使用Ctrl+宏时，施放的Buff将会为目标保存";
PANZA_SAVEBLESSING_DISABLED	= "保存Buff功能已关闭 ";

PANZA_OUTSIDE_DISABLED		= "自动选择 治疗/Buff/清洁 处于 小队/团队 之外的目标的功能已关闭 "
PANZA_OUTSIDE_ENABLED		= "自动选择 治疗/Buff/清洁 处于 小队/团队 之外的目标的功能已激活 "

PANZA_HEALREPORT_ENABLED	= "治疗进度报告已打开。";
PANZA_HEALREPORT_DISABLED	= "治疗进度报告已关闭。";
PANZA_HEAL_ABORT_DISABLE	= "取消治疗的检查功能已关闭 ";
PANZA_HEAL_ABORT_ENABLE		= "取消治疗的检查功能已打开 ";
PANZA_MINHEALTH_THRESHOLD	= "启动治疗的最小生命值阈值是 %s 或更少 ";
PANZA_PET_THRESHOLD		= "治疗宠物的生命值阈值是 %s 或更多 "
PANZA_FOL_HEALTH_THRESHOLD	= "当目标的生命值为 %s 或者更多时改用圣光闪现 ";
PANZA_FOL_MANA_THRESHOLD	= "当法力值为 %s 或更少时将只用圣光闪现 ";
PANZA_LOW_FOL_THRESHOLD  	= "当目标生命值为%s或在其下时使用圣光闪现。";
PANZA_AUTOLIST_ENABLED		= "有队友离队（团）时Buff列表将被更新。";
PANZA_AUTOLIST_DISABLED		= "有队友离队（团）时Buff列表不会被更新。";
PANZA_SAVELIST			= "保存的Buff列表有%d条。";
PANZA_CURRENTSETTINGS		= "Panza v%s 当前设置";
PANZA_KINGSCOUNT		= "%d %s 可用来施放强效祝福。";
PANZA_DIVINITYCOUNT		= "%d %s 可用来施放%s.";
PANZA_FEATHERCOUNT		= "%d %ss 可用来施放漂浮术。";
PANZA_CANDLECOUNT		= "%d %s 和 %d %s 蜡烛可用来施放祈祷法术。";

PANZA_BEWS_ACTIVATE		= "(BEWS) 对 %s 已激活。\nBuff预警在 %d 秒内启动";

PANZA_BLESS_DONE_LOW		= "%.2f秒内不需要重新施加Buff.";
PANZA_BLESS_DONE		= "%.0f秒内不需要重新施加Buff..";
PANZA_BLESS_DONE_HIGH		= "无需Buff在%d:%02d 分钟内。";
PANZA_BLESS_DONE_NONE		= "无需Buff。";
PANZA_BLESS_COUNT		= "已Buff %d，总共 %d (%s)"
PANZA_BLESS_DEAD		= "死亡 %d (%s)";
PANZA_BLESS_OUTOFRANGE		= "超出Buff距离 %d (%s)";
PANZA_BLESS_DISCONNECTED	= "离线 %d (%s)";
PANZA_BLESS_NOPVP		= "无PVP标记 %d (%s)";
PANZA_BLESS_SKIPPED		= "跳过 %d (%s)";
PANZA_BLESS_FAILED		= "失败 %d (%s)";	
PANZA_BLESS_BELOWTHRESHOLD 	= "下限 %d (%s)";

PANZA_NOTIFY			= "%s+%.0f on %s in %.1f second%s.";
PANZA_NOTIFY_HOT		= "(HoT) %s+%.0f on %s";
PANZA_NOTIFY_DELAY		= "%s+%.0f for %s 延迟 %.1f 秒%s.";
PANZA_NOTIFY_INTERRUPT_HEAL	= "%s+%.0f 预定施加于 %s 被打断。";
PANZA_NOTIFY_INTERRUPT		= "%s 预定施加于 %s 被打断 ";
PANZA_NOTIFY_BLESS_STOP		= "%s %s 施加于 %s";  		-- [(Saved)] [Blessing of Crap] was cast on [Dummy]
PANZA_NOTIFY_CURE_STOP	    	= "%s 施加于 %s"; 			-- [Purify] was cast on [Dummy]
PANZA_NOTIFY_PANIC_STOP	  	= "%s情况紧急!%s %s 施加于 %s"; 	-- PANIC! [Blessing of Protection] was cast on [Dummy]
PANZA_NOTIFY_FAIL		= "%s 欲施加于 %s 失败了 ";
PANZA_NOTIFY_FAIL_UNKNOWN	= "法术失败，目标名未知，或者没有法术记录。";
PANZA_NOTIFY_PANIC_FAIL		= "情况紧急! %s 欲施加于 %s 失败了.";

PANZA_NO_PVP			= "%s 处于PVP状态， 在战场 %s 中。 跳过。";
PANZA_NO_PVP_ENABLED		= "打开了跳过PVP玩家的功能 "
PANZA_NO_PVP_DISABLED		= "关闭了跳过PVP玩家的功能，你将可能被标记为PVP玩家 "

PANZA_DRUID			= "德鲁伊";
PANZA_HUNTER			= "猎人";
PANZA_MAGE			= "法师";
PANZA_PRIEST			= "牧师";
PANZA_ROGUE			= "盗贼";
PANZA_WARRIOR			= "战士";
PANZA_WARLOCK			= "术士";
PANZA_PALADIN			= "圣骑士";
PANZA_SHAMAN			= "萨满";
PANZA_SELF			= "自己";

PANZA_SETALL			= "set all";
PANZA_SAVESETS			= "Set:";


PANZA_HELP_PAGE1		= "即将来临...";

PANZA_PAM_ENTERRESET		= "Entered PA:Reset_PAM().";
PANZA_PAM_DONERESET		= "所有的PAM设定重置到了默认值。";
PANZA_RGS_ENTERRESET		= "Entered PA:Reset_RGS()";
PANZA_RGS_RESET			= "重置团队小组选择设定。";

PANZA_EVENT_DELAYED		= "PA:SpellcastDelayed() handler entered."
PANZA_EVENT_INTERRUPTED		= "PA:SpellcastInterrupted() handler entered.";
PANZA_EVENT_STOP		= "PA:SpellcastStop() handler entered.";
PANZA_EVENT_FAIL		= "PA:SpellcastFail() handler entered";

PANZA_WARN_EXPIRE		= "[ %s %s 将在 %.0f 秒内失效。 ]";
PANZA_WARN_EXPIRE_FINAL		= "[ %s %s 已失效! ]";

PANZA_CURRENT			= "常规";
PANZA_ADD_SAVESET_LABEL		= "输入新设置的名称：";
PANZA_DCBLEVEL			= "等级:"

PANZA_TRINKET			= "饰品:";
PANZA_TRINKETEMPTY		= "把饰品放到这里以设为治疗用饰品。";
PANZA_TRINKETEXTRA		= "在治疗时饰品将激活。";
PANZA_TRINKET_DF		= "有神恩时激活";
PANZA_TRINKET_DF_PRIEST 	= "有心灵专注时激活";
PANZA_TRINKET_DF_SHAMAN 	= "有自然迅捷时激活";
PANZA_TRINKET_DF_DRUIDSWIFT 	= "有自然迅捷时激活";
PANZA_TRINKET_DF_DRUIDOMEN  	= "有清晰预兆时激活";
PANZA_TRINKET_FLASH		= "在快速治疗前激活。";
PANZA_TRINKET_HEAL		= "在普通治疗前激活。";

PANZA_OWN_BARS			= "当前治疗状态条"
PANZA_OTHER_BARS		= "其它治疗状态条"
PANZA_COOP_SWITCH		= "启用CoOp治疗"

PANZA_GOODDEBUFF		= "Benificial debuff %s detected";
---------------------------------------------
-- Tooltip used for the Button on the MiniMap
---------------------------------------------
PanzaButton_Tooltip = { PanzaButton = { tooltip1 = PANZA_TITLE..' v'..PANZA_VERSION, tooltip2 = PANZA_DESC.." 拖动以移动图标。" } };

-----------------------
-- Tooltips used in PAM
-----------------------
PA.PAM_Tooltips["cbxPanzaPAMHealParty"]	= {
	tooltip1	= "小队治疗",
	tooltip2	= "通过小队频道发送治疗信息。仅仅当治疗对象存在于你的小队中时，才会发送该信息。"
};

PA.PAM_Tooltips["cbxPanzaPAMHealRaid"]	= {
	tooltip1	= "团队治疗",
	tooltip2	= "通过团队频道发送治疗信息。仅仅当团队中的治疗对象不存在于你的小队中时，才会发送该信息。"
};

PA.PAM_Tooltips["cbxPanzaPAMHealWhis"]	= {
	tooltip1	= "密语治疗",
	tooltip2	= "通过私聊频道发送治疗信息。如果私聊信息打开，那么说话信息和表情信息将会关闭。这三种类型的信息只能同时选择一个，另外两个都将关闭。私聊信息仅仅当治疗对象不在团队中时，或者在团队中但是说话和表情信息都被关闭时，才会发送。"
};

PA.PAM_Tooltips["cbxPanzaPAMHealSay"]	= {
	tooltip1	= "说话治疗",
	tooltip2	= "通过说话频道发送治疗信息。如果说话信息打开，那么私聊信息和表情信息将会关闭。这三种类型的信息只能同时选择一个，另外两个都将关闭。说话信息仅仅当治疗对象不在团队中时，或者在团队中但是私聊和表情信息都被关闭时，才会发送。"
};

PA.PAM_Tooltips["cbxPanzaPAMHealEM"]	= {
	tooltip1	= "表情治疗",
	tooltip2	= "通过表情频道发送治疗信息。如果表情信息打开，它会代替其它的信息模式，其它所有信息模式都将被关闭。"
};

PA.PAM_Tooltips["cbxPanzaPAMBlessParty"]	= {
	tooltip1	= "小队Buff",
	tooltip2	= "通过小队频道发送Buff信息，仅仅当治疗对象存在于你的小队中时，才会发送该信息。"
};

PA.PAM_Tooltips["cbxPanzaPAMBlessRaid"]	= {
	tooltip1	= "团队Buff",
	tooltip2	= "通过团队频道发送Buff信息。仅仅当团队中的治疗对象不存在于你的小队中时，才会发送该信息。"
};

PA.PAM_Tooltips["cbxPanzaPAMBlessWhis"]	= {
	tooltip1	= "密语Buff",
	tooltip2	= "通过私聊频道发送Buff信息。如果私聊信息打开，那么说话信息和表情信息将会关闭。这三种类型的信息只能同时选择一个，另外两个都将关闭。私聊信息仅仅当治疗对象不在团队中时，或者在团队中但是说话和表情信息都被关闭时，才会发送。"
};

PA.PAM_Tooltips["cbxPanzaPAMBlessSay"]	= {
	tooltip1	= "说话Buff",
	tooltip2	= "通过说话频道发送Buff信息。如果说话信息打开，那么私聊信息和表情信息将会关闭。这三种类型的信息只能同时选择一个，另外两个都将关闭。说话信息仅仅当治疗对象不在团队中时，或者在团队中但是私聊和表情信息都被关闭时，才会发送。"
};

PA.PAM_Tooltips["cbxPanzaPAMBlessEM"]	= {
	tooltip1	= "表情Buff",
	tooltip2	= "通过表情频道发送Buff信息。如果表情信息打开，它会代替其它的信息模式，其它所有信息模式都将被关闭。"
};

PA.PAM_Tooltips["cbxPanzaPAMCureParty"]	= {
	tooltip1	= "小队清洁",
	tooltip2	= "通过小队频道发送清除状态信息。仅仅当清洁对象存在于你的小队中时，才会发送该信息。"
};

PA.PAM_Tooltips["cbxPanzaPAMCureRaid"]	= {
	tooltip1	= "团队清洁",
	tooltip2	= "通过团队频道发送清除状态信息。仅仅当团队中的清洁对象不存在于你的小队中时，才会发送该信息。"
};

PA.PAM_Tooltips["cbxPanzaPAMCureWhis"]	= {
	tooltip1	= "密语清洁",
	tooltip2	= "通过私聊频道发送清除状态信息。如果私聊信息打开，那么说话信息和表情信息将会关闭。这三种类型的信息只能同时选择一个，另外两个都将关闭。私聊信息仅仅当治疗对象不在团队中时，或者在团队中但是说话和表情信息都被关闭时，才会发送。"
};

PA.PAM_Tooltips["cbxPanzaPAMCureSay"]	= {
	tooltip1	= "说话清洁",
	tooltip2	= "通过说话频道发送清除状态信息。如果说话信息打开，那么私聊信息和表情信息将会关闭。这三种类型的信息只能同时选择一个，另外两个都将关闭。说话信息仅仅当治疗对象不在团队中时，或者在团队中但是私聊和表情信息都被关闭时，才会发送。"
};

PA.PAM_Tooltips["cbxPanzaPAMCureEM"]	= {
	tooltip1	= "表情清洁",
	tooltip2	= "通过表情频道发送清除状态信息。如果表情信息打开，它会代替其它的信息模式，其它所有信息模式都将被关闭。"
};

PA.PAM_Tooltips["cbxPanzaPAMRezParty"]	= {
	tooltip1	= "小队复活",
	tooltip2	= "通过小队频道发送复活信息。仅仅当复活对象存在于你的小队中时，才会发送该信息。"
};

PA.PAM_Tooltips["cbxPanzaPAMRezRaid"]	= {
	tooltip1	= "团队复活",
	tooltip2	= "通过团队频道发送复活态信息。仅仅当团队中的复活对象不存在于你的小队中时，才会发送该信息。"
};

PA.PAM_Tooltips["cbxPanzaPAMRezWhis"]	= {
	tooltip1	= "密语复活",
	tooltip2	= "通过私聊频道发送复活信息。如果私聊信息打开，那么说话信息和表情信息将会关闭。这三种类型的信息只能同时选择一个，另外两个都将关闭。私聊信息仅仅当复活对象不在团队中时，或者在团队中但是说话和表情信息都被关闭时，才会发送。"
};

PA.PAM_Tooltips["cbxPanzaPAMRezSay"]	= {
	tooltip1	= "说话复活",
	tooltip2	= "通过说话频道发送复活信息。如果说话信息打开，那么私聊信息和表情信息将会关闭。这三种类型的信息只能同时选择一个，另外两个都将关闭。说话信息仅仅当复活对象不在团队中时，或者在团队中但是私聊和表情信息都被关闭时，才会发送。"
};

PA.PAM_Tooltips["cbxPanzaPAMRezEM"]	= {
	tooltip1	= "表情复活",
	tooltip2	= "通过表情频道发送复活信息。如果表情信息打开，它会代替其它的信息模式，其它所有信息模式都将被关闭。"
};

PA.PAM_Tooltips["cbxPanzaPAMSendProgress"]	= {
	tooltip1	= "显示/发送治疗报告",
	tooltip2	= "治疗进度报告，同时也显示特殊的延迟报告，通过已勾选的Pary/Raid/Whisper/Say等频道以及发送信息详细度等级来发送消息。只有当信息详细度等级设置为中等或者更高，并且本功能已被勾选时才会发送信息。延迟报告将会在自己的聊天窗口显示，并且只有当信息详细度等级设置为中等或者更高，并且本功能已被勾选时才会发送出去。 这个选项在小队和团队活动上不推荐使用，因为如果所需要的治疗很多，它会产生大量的信息。"
};

PA.PAM_Tooltips["cbxPanzaPAMNotifyFail"]	= {
	tooltip1	= "通告法术失败",
	tooltip2	= "勾选后，如果法术施放失败，PA会根据上面所选择的通报方式发送信息。如果没有选择，那么PA只会在自己的本地窗口显示法术失败信息。不论信息详细度等级如何设置，所有的错误施法都会在本地窗口显示。这个设置对所有的治疗，Buff和清洁法术有效。"
};

PA.PAM_Tooltips["cbxPanzaPAMShowRanks"]	= {
	tooltip1	= "显示法术等级",
	tooltip2	= "勾选后，施法报告中将显示法术等级。"
};

PA.PAM_Tooltips["SliderPanzaPAMHeal"]	= {
	tooltip1	= "治疗信息",
	tooltip2	= "治疗法术的信息详细度等级"
};

PA.PAM_Tooltips["SliderPanzaPAMBless"]	= {
	tooltip1	= "Buff信息",
	tooltip2	= "Buff法术的信息详细度等级"
};

PA.PAM_Tooltips["SliderPanzaPAMCure"]	= {
	tooltip1	= "清洁信息",
	tooltip2	= "清洁法术的信息详细度等级"
};

PA.PAM_Tooltips["SliderPanzaPAMRez"]	= {
	tooltip1	= "复活信息",
	tooltip2	= "复活法术的信息详细度等级"
};

PA.PAM_Tooltips["SliderPanzaPAMCore"]	= {
	tooltip1	= "内核",
	tooltip2	= "Panza内部信息等级 "
};

PA.PAM_Tooltips["SliderPanzaPAMUI"]	= {
	tooltip1	= "用户界面信息",
	tooltip2	= "Panza用户界面显示的信息详细度等级"
};

PA.PAM_Tooltips["SliderPanzaPAMCoop"]	= {
	tooltip1	= "Coorporative治疗信息",
	tooltip2	= "CoOp治疗系统的信息等级"
};

PA.PAM_Tooltips["SliderPanzaPAMOffen"]	= {
	tooltip1	= "攻击法术信息",
	tooltip2	= "攻击法术的信息等级"
};

PA.PAM_Tooltips["btnPanzaPAMQuiet"]	= {
	tooltip1	= "PA Quiet Please!",
	tooltip2	= "这个选项让Panza信息等级设置为出错等级,只有发生错误时才显示信息，同时关闭所有的信息发送频道。这个模式并不推荐，除非你不关心你施放的什么法术以及施法对象是谁。"
};

PA.PAM_Tooltips["btnPanzaPAMCustom"]	= {
	tooltip1	= "定制信息",
	tooltip2	= "打开一个对话框来输入定制信息。"
};

PA.PAM_Tooltips["btnPanzaPAMDefault"]	= {
	tooltip1	= "信息默认值",
	tooltip2	= "这会重置Panza的信息设置到默认值。"
};

-------------------------------------
-- PAM Healing Tooltips for MsgLevel
-------------------------------------
PA.PAM_Tooltips["txtPanzaPAMHealError"]	= {
	tooltip1	= "Healing Meassages Error Level",
	tooltip2	= "只发送出错信息。在这个信息等级上，你只能在发生错误时，看到出错信息。这个模式并不推荐，因为你将不知道自己施放的是何种法术。"
};

PA.PAM_Tooltips["txtPanzaPAMHealNormal"]	= {
	tooltip1	= "Healing Meassages Normal Level",
	tooltip2	= "普通信息等级。在这个等级上，只有施放圣光术时，才会向别人通过你设定的频道发送信息。圣光闪现的施法信息只会在本地窗口显示。"
};

PA.PAM_Tooltips["txtPanzaPAMHealLow"]	= {
	tooltip1	= "Healing Meassages Low Level",
	tooltip2	= "低细节信息等级。在这个等级，施放圣光术和圣光闪现均会通过你设定的频道发送信息。注意：所有的施法情况都会在本地窗口显示，除非你选定了出错信息等级。"
};

PA.PAM_Tooltips["txtPanzaPAMHealMedium"]	= {
	tooltip1	= "Healing Meassages Medium Level",
	tooltip2	= "中等细节信息等级。在这个等级，施放圣光术和圣光闪现均会通过你设定的频道发送信息。此外，法术因被攻击而打断延迟的信息也会显示并根据你的选择来发送 (看下方)."
};

PA.PAM_Tooltips["txtPanzaPAMHealHigh"]	= {
	tooltip1	= "Healing Meassages High Detail Level",
	tooltip2	= "高等细节信息等级。在这个等级，施放圣光术，圣光闪现，以及法术打断延迟都会发送(需要选择一些选项)，此外，目标的生命值也会显示。注意：只有法术施放和延迟信息(可选)才会被发送给其他玩家。其它信息都只在本地窗口显示。 "
};

PA.PAM_Tooltips["txtPanzaPAMHealAll"]	= {
	tooltip1	= "Healing Meassages Debug Level",
	tooltip2	= "全部信息(调试等级)。在这个等级，任何跟治疗模块相关的琐碎的信息都会在本地窗口显示。其它选择发送的信息仍然会被发送。这个模式不推荐。"
};

-------------------------------------
-- PAM Buff Tooltips for MsgLevel
-------------------------------------
PA.PAM_Tooltips["txtPanzaPAMBlessError"]	= {
	tooltip1	= "Buff Messages Error Level",
	tooltip2	= "只发送出错信息。在这个信息等级上，你只能在发生错误时，看到出错信息。这个模式并不推荐，因为你将不知道自己施放的是何种法术。"
};

PA.PAM_Tooltips["txtPanzaPAMBlessNormal"]	= {
	tooltip1	= "Buff Messages Normal Level",
	tooltip2	= "普通信息等级。在这个等级上，只有施放法术时，才会向别人通过你设定的频道发送信息。"
};

PA.PAM_Tooltips["txtPanzaPAMBlessLow"]	= {
	tooltip1	= "Buff Messages Low Level",
	tooltip2	= "低细节信息等级。在这个等级，法术施放，Buff到期预警，还有循环列表的刷新都会显示。注意：所有的施法情况都会在本地窗口显示，除非你选定了出错信息等级。"
};

PA.PAM_Tooltips["txtPanzaPAMBlessMedium"]	= {
	tooltip1	= "Buff Messages Medium Level",
	tooltip2	= "中等细节信息等级。在这个等级，所有的法术施放，Buff到期预警，循环列表的刷新，和循环目标的选择都会显示。法术施放的信息根据你的设定发送出去。"
};

PA.PAM_Tooltips["txtPanzaPAMBlessHigh"]	= {
	tooltip1	= "Buff Messages High Detail Level",
	tooltip2	= "高等细节信息等级。在这个等级，所有的法术施放，Buff到期预警，循环列表刷新，循环目标的选择还有团队小组选择的信息都会根据你的选择显示或者发送。"
};

PA.PAM_Tooltips["txtPanzaPAMBlessAll"]	= {
	tooltip1	= "Buff Meassages Debug Level",
	tooltip2	= "全部信息(调试等级)。在这个等级，任何跟Buff模块相关的琐碎的信息都会在本地窗口显示。其它选择发送的信息仍然会被发送。这个模式不推荐。"
};

-----------------------------------
-- PAM Curing Tooltips for MsgLevel
-----------------------------------
PA.PAM_Tooltips["txtPanzaPAMCureError"]	= {
	tooltip1	= "Cure Meassages Error Level",
	tooltip2	= "只发送出错信息。在这个信息等级上，你只能在发生错误时，看到出错信息。这个模式并不推荐，因为你将不知道自己施放的是何种法术。"
};

PA.PAM_Tooltips["txtPanzaPAMCureNormal"]	= {
	tooltip1	= "Cure Meassages Normal Level",
	tooltip2	= "普通信息等级。在这个等级上，只有施放法术时，才会向别人通过你设定的频道发送信息。"
};

PA.PAM_Tooltips["txtPanzaPAMCureLow"]	= {
	tooltip1	= "Cure Meassages Low Level",
	tooltip2	= "低细节信息等级。在这个等级，法术施放，还有循环列表的刷新都会显示。注意：所有的施法情况都会在本地窗口显示，除非你选定了出错信息等级。"
};

PA.PAM_Tooltips["txtPanzaPAMCureMedium"]	= {
	tooltip1	= "Cure Meassages Medium Level",
	tooltip2	= "中等细节信息等级。在这个等级，所有的循环刷新，清洁目标的选择都会显示，法术施放会根据你的选择来发送。"
};

PA.PAM_Tooltips["txtPanzaPAMCureHigh"]	= {
	tooltip1	= "Cure Meassages High Detail Level",
	tooltip2	= "高等细节信息等级。在这个等级，团队小组选择和施放清洁法术的信息会根据选项来发送。其它所有信息都在本地窗口显示"
};

PA.PAM_Tooltips["txtPanzaPAMCureAll"]	= {
	tooltip1	= "Cure Meassages Debug Level",
	tooltip2	= "全部信息(调试等级)。 在这个等级，任何跟清洁模块相关的琐碎的信息都会在本地窗口显示。其它选择发送的信息仍然会被发送。这个模式不推荐。"
};

--------------------------------
-- PAM Rez Tooltips for MsgLevel
--------------------------------
PA.PAM_Tooltips["txtPanzaPAMRezError"]	= {
	tooltip1	= "Rez Meassages Error Level",
	tooltip2	= "只发送出错信息。在这个信息等级上，你只能在发生错误时，看到出错信息。"
};

PA.PAM_Tooltips["txtPanzaPAMRezNormal"]	= {
	tooltip1	= "Rez Meassages Normal Level",
	tooltip2	= "普通信息等级。在这个等级上，只有施放法术时，才会向别人通过你设定的频道发送信息。"
};

PA.PAM_Tooltips["txtPanzaPAMRezLow"]	= {
	tooltip1	= "Rez Meassages Low Level",
	tooltip2	= "低细节信息等级。"
};

PA.PAM_Tooltips["txtPanzaPAMRezMedium"]	= {
	tooltip1	= "Rez Meassages Medium Level",
	tooltip2	= "中等细节信息等级。"
};

PA.PAM_Tooltips["txtPanzaPAMRezHigh"]	= {
	tooltip1	= "Rez Meassages High Detail Level",
	tooltip2	= "高等细节信息等级。"
};

PA.PAM_Tooltips["txtPanzaPAMRezAll"]	= {
	tooltip1	= "Rez Meassages Debug Level",
	tooltip2	= "全部信息(调试等级)。 在这个等级，任何跟清洁模块相关的琐碎的信息都会在本地窗口显示。其它选择发送的信息仍然会被发送。这个模式不推荐。"
};


------------------------------
-- Tooltips used in PAM Custom
------------------------------

PA.PAMCustom_Tooltips["PA_ResurrectEditBox"]	= {
	tooltip1	= "Message displayed when resurrecting",
	tooltip2	= "编辑你自己的复活信息, %s将会被目标的名字所替代，或者在私聊模式下显示“你”."
};

PA.PAMCustom_Tooltips["btnPanzaPAMXDefault"]	= {
	tooltip1	= "Extra Message Defaults",
	tooltip2	= "This will restore Panza Custom Messages to the default levels and settings."
};

PA.PAMCustom_Tooltips["cbxPanzaPAMXDamageEnable"]	= {
	tooltip1	= "Damage Messages",
	tooltip2	= "Enable Damage Messages. Messages will be sent according to the Party, Raid, Say, and Emote checkboxes."
};

PA.PAMCustom_Tooltips["cbxPanzaPAMXDamageParty"]	= {
	tooltip1	= "Party Damage Messages",
	tooltip2	= "Send Damage Messages to the Party."
};

PA.PAMCustom_Tooltips["cbxPanzaPAMXDamageRaid"]	= {
	tooltip1	= "Raid Damage Messages",
	tooltip2	= "Send Damage Messages to the Raid."
};

PA.PAMCustom_Tooltips["cbxPanzaPAMXDamageSay"]	= {
	tooltip1	= "Say Damage Messages",
	tooltip2	= "Send Damage Messages via Say. If Say is enabled and Emote are disabled. Only one of these modes may be used, and both may be disabled."
};

PA.PAMCustom_Tooltips["cbxPanzaPAMXDamageEM"]	= {
	tooltip1	= "Emote Damage Messages",
	tooltip2	= "Send Damage Messages via Emote. If Emote is enabled it will be used in place of all other Chat Modes, and all other modes will be disabled."
};

PA.PAMCustom_Tooltips["edtPanzaPAMXDamageHitMessage"]	= {
	tooltip1	= "Message displayed when %s hits",
	tooltip2	= "Change this to a message of your choice."
};

PA.PAMCustom_Tooltips["edtPanzaPAMXDamageHitEmote"]	= {
	tooltip1	= "Emote displayed when %s hits",
	tooltip2	= "Change this to a message of your choice."
};

PA.PAMCustom_Tooltips["edtPanzaPAMXDamageCritMessage"]	= {
	tooltip1	= "Message displayed when %s criticals",
	tooltip2	= "Change this to a message of your choice."
};

PA.PAMCustom_Tooltips["edtPanzaPAMXDamageCritEmote"]	= {
	tooltip1	= "Emote displayed when %s criticals",
	tooltip2	= "Change this to a message of your choice."
};

PA.PAMCustom_Tooltips["cbxPanzaPAMXDamageHitMessage"]	= {
	tooltip1	= "Switch for damage messages (normal hits)",
	tooltip2	= "When checked messages will be shown according to options above."
};

PA.PAMCustom_Tooltips["cbxPanzaPAMXDamageCritMessage"]	= {
	tooltip1	= "Switch for damage messages (critical hits)",
	tooltip2	= "When checked messages will be shown according to options above."
};

PA.PAMCustom_Tooltips["btnPanzaPAMXDamageHelp"]	= {
	tooltip1	= "Inserts available:",
	tooltip2	= "%1$s - Your Name (e.g. "..PA:UnitName("player")..")";
	tooltip3	= "%2$s - Spell Name (e.g. Hammer of Wrath)";
	tooltip4	= "%3$s - Target (e.g. Ragnaros)";
	tooltip5	= "%4$d - Damage (e.g. 1234)";
	tooltip6	= "%5$s - Magic School (e.g. Holy)";
};

PA.PAMCustom_Tooltips["btnPanzaPAMXRezHelp"]	= {
	tooltip1	= "Inserts available:",
	tooltip2	= "%1$s - Rez target (e.g. Lazarus)";
	tooltip3	= "%2$d - Time to rez (s) (e.g. 10)";
	tooltip4	= "%3$s - Your Name (e.g. "..PA:UnitName("player")..")";
};

---------------------------------------
-- Tooltips used in the settings dialog
---------------------------------------
PA.Opts_Tooltips["cbxPanzaEnableMLS"]	= {
	tooltip1	= "MapLibrary 支持",
	tooltip2	= "勾选时，Panza会使用MapLibrary (如果安装了)的功能来进行距离计算。MapLibrary并不是必须的，但是推荐安装的。如果MapLibrary没有安装，或者关闭，那么PA会使用自带的距离计算模块。这个选项仅仅是让PA使用MapLibrary的函数。"
};

PA.Opts_Tooltips["SliderPanzaAlpha"]	= {
	tooltip1	= "透明度",
	tooltip2	= "调整PA所使用的GUI的Alpha/透明度"
};

PA.Opts_Tooltips["cbxPanzaButton"]	= {
	tooltip1	= "小地图按钮",
	tooltip2	= "勾选时，Panza的GUI图形界面将可以从小地图旁边的图标进入。"
};

PA.Opts_Tooltips["cbxPanzaEnableSave"]	= {
	tooltip1	= "激活Buff保存功能",
	tooltip2	= "勾选时，如果你使用Buff宏的时候同时按下Ctrl键，那么你施加的这个Buff将会为你的Buff对象保存，优先级高于预设的职业Buff。"
};

PA.Opts_Tooltips["cbxPanzaEnableSelf"]	= {
	tooltip1	= "激活自我施法功能",
	tooltip2	= "勾选时，当你使用治疗或者Buff宏的时候同时按下Alt键，那么你治疗或者Buff的对象就是你自己。"
};

PA.Opts_Tooltips["cbxPanzaEnableOut"]	= {
	tooltip1	= "激活团外治疗/Buff/清洁",
	tooltip2	= "勾选时，如果你存在于小队或者团队中，PA除了选择团队内的目标还会查找并选择团队外的友方目标来进行Buff治疗和清洁，推荐关闭。" 
};

PA.Opts_Tooltips["cbxPanzaEnableRGS"]	= {
	tooltip1	= "激活团队小组筛选",
	tooltip2	= "勾选时，Panza只针对筛选出来的团队小组进行Buff，治疗和清洁。" 
};

PA.Opts_Tooltips["cbxPanzaNoPVP"]	= {
	tooltip1	= "Skip PVP Flagged Players",
	tooltip2	= "When checked, Panza will skip any Player that is flagged PVP during Buffing, Healing, or Curing. Automatically disabled in Battlefields and when you are PVP flagged."
};

PA.Opts_Tooltips["cbxPanzaUseActionHeal"]	= {
	tooltip1	= "Use Action Bars for Range (Heal)",
	tooltip2	= "When checked, Panza will scan the action bars and use relvant spells for range checks when healing."
};

PA.Opts_Tooltips["cbxPanzaUseActionCure"]	= {
	tooltip1	= "Use Action Bars for Range (Cure)",
	tooltip2	= "When checked, Panza will scan the action bars and use relvant spells for range checks when curing."
};

PA.Opts_Tooltips["cbxPanzaUseActionBless"]	= {
	tooltip1	= "Use Action Bars for Range (Buff)",
	tooltip2	= "When checked, Panza will scan the action bars and use relvant spells for range checks when buffing."
};

PA.Opts_Tooltips["cbxPanzaUseActionFree"]	= {
	tooltip1	= "Use Action Bars for Range (Free)",
	tooltip2	= "勾选时, Panza 将会扫描你的快捷动作条，并且根据相应的法术来判断距离范围." 
};

PA.Opts_Tooltips["cbxPanzaUseActionOffense"]	= {
	tooltip1	= "Use Action Bars for Range (Offense)",
	tooltip2	= "When checked, Panza will scan the action bars and use relvant spells for range checks when casting offense spells."
};

PA.Opts_Tooltips["SliderPanzaButtonPos"]	= {
	tooltip1	= "Minimap Button Position",
	tooltip2	= "Adjusts the position of Panza's Button on the MiniMap."
};

PA.Opts_Tooltips["SliderPanzaButton"]	= {
	tooltip1	= "Minimap Button Picture",
	tooltip2	= "Changes the graphic used for Panza's Button on the MiniMap."
};

PA.Opts_Tooltips["btnPanzaOptsDefault"]	= {
	tooltip1	= "重置到默认设置",
	tooltip2	= "重置当前用户的设置和Buff配置到默认值。其他已保存的用户设置不受影响。"
};
PA.Opts_Tooltips["btnPanzaOptMacros"]	= {
	tooltip1	= "创建宏",
	tooltip2	= "自动创建使用PA的命令宏"
};

PA.Opts_Tooltips["btnPanzaOptsPAM"]	= {
	tooltip1	= "PA 信息 (PAM)",
	tooltip2	= "显示 PA 信息选项框"
};

PA.Opts_Tooltips["btnPanzaOptsRGS"] 	= {
	tooltip1	= "PA 团队小组筛选 (RGS)",
	tooltip2	= "显示 PA 团队小组筛选框。挑选出循环Buff，治疗或者清洁时需要包括的小组。"
};

PA.Opts_Tooltips["btnPanzaOptsDCB"]	= {
	tooltip1	= "PA 默认职业Buff (DCB)",
	tooltip2	= "显示 PA 的默认职业Buff表格。可以更改在单练/小队/团队或者战场中每个职业需要的Buff "
};

PA.Opts_Tooltips["btnPanzaOptsPBM"]	= {
	tooltip1	= "Panza Buff Module (PBM)",
	tooltip2	= "Configure Parameters used with AsBuff, CycleBuff, and CycleNear functions."
};

PA.Opts_Tooltips["btnPanzaOptsPHM"]	= {
	tooltip1	= "Panza Healing Module (PHM)",
	tooltip2	= "设定治疗相关参数。"
};

PA.Opts_Tooltips["btnPanzaOptsBLE"]	= {
	tooltip1	= "Panza Buff List Editor (BLE)",
	tooltip2	= "Modify and Maintain the Buff List."
};

PA.Opts_Tooltips["btnPanzaOptsPAW"]	= {
	tooltip1	= "Panza Whisper (PAW)",
	tooltip2	= "Options for Saved Buff List functions via whisper commands."
};

PA.Opts_Tooltips["btnPanzaOptsPFM"]	= {
	tooltip1	= "Panza Free Module (PFM)",
	tooltip2	= "Options for asfree."
};

PA.Opts_Tooltips["btnPanzaOptsPCS"]	= {
	tooltip1	= "Panza Class Selection (PCS)",
	tooltip2	= "Class Selection Options."
};

PA.Opts_Tooltips["btnPanzaOptsPOM"]	= {
	tooltip1	= "Panza Offense Module (POM)",
	tooltip2	= "Offensive Spell Options."
};

PA.Opts_Tooltips["btnPanzaOptsPMM"]	= {
	tooltip1	= "Panza Mouse Module (PMM)",
	tooltip2	= "Mouse Options."
};

PA.Opts_Tooltips["btnPanzaOptsPCM"]	= {
	tooltip1	= "Panza Cure Module (PCM)",
	tooltip2	= "Options for removing debuffs."
};

------------------------------
-- Tooltips used in PHM Dialog
------------------------------
PA.PHM_Tooltips["SliderPanzaMinTH"]	= {
	tooltip1	= "Minimum Health Threshold",
	tooltip2	= "调整最小允许治疗的生命值阈值。只有当生命值低于这个值的时候才允许施放治疗法术。" 
};

PA.PHM_Tooltips["SliderPanzaOverHeal"]	= {
	tooltip1	= "Overheal Warning Threshold",
	tooltip2	= "Adjusts the threshold for overheal warnings. If the abort healing check is enabled, warnings will appear when healing applied would virtually heal to this percent."
};

PA.PHM_Tooltips["SliderPanzaFlash"]	= {
	tooltip1	= "Flash Threshold",
	tooltip2	= "调整开始专用圣光闪现的生命值阈值。当目标的生命值高于这个值的时候，将只使用圣光闪现进行治疗，直到最小允许治疗的生命值阈值。" 
};

PA.PHM_Tooltips["SliderPanzaMid"]	= {
	tooltip1	= "Mid Health Threshold",
	tooltip2	= "Adjusts the health threshold for casting Rejuvenation. Target must be above this limit."
};

PA.PHM_Tooltips["SliderPanzaLowFlash"]	= {
	tooltip1	= "Low Health Flash Threshold",
	tooltip2	= "Adjusts the health threshold for forcing \"Flash\" Healing spells. Target health at or below this threshold will receive \"Flash\" healing to gain quick health."
};

PA.PHM_Tooltips["SliderPanzaPetTH"]	= {
	tooltip1	= "Pet Healing Threshold",
	tooltip2	= "When all Party health is above this setting, Panza will automatically check Party Pet health, and heal pets with the lowest health ratio. Setting this threshold to 100% will disable automatic pet healing, while setting it to 0% will turn you into a primary pet healer."
};

PA.PHM_Tooltips["PanzaPHMFramePanel1BarNone"]	= {
	tooltip1	= "Minimum Health Threshold",
	tooltip2	= "Healing only occurs at or below this health threshold.",
};

PA.PHM_Tooltips["PanzaPHMFramePanel1BarMid"]	= {
	tooltip1	= "Normal Health Threshold",
	tooltip2	= "Target health in this range will receive normal healing.",
};

PA.PHM_Tooltips["PanzaPHMFramePanel1BarHigh"]	= {
	tooltip1	= "High Health Flash Threshold",
	tooltip2	= "Target health in this range will receive \"Flash\" healing to \"top-off\" health.",
};

PA.PHM_Tooltips["PanzaPHMFramePanel1BarLow"]	= {
	tooltip1	= "Low Health Flash Threshold",
	tooltip2	= "Target health at or below this threshold will receive \"Flash\" healing to gain quick health.",
};

PA.PHM_Tooltips["PanzaPHMFramePanel1BarPets"]	= {
	tooltip1	= "Pet Healing Threshold",
	tooltip2	= "当所有团队人员的生命值高于这个值的时候。PA会开始自动检查宠物的血量，并且治疗血量百分比最低的宠物。如果将这个值设为100%将不会治疗宠物，如果设为0%，你就会变成一个私人兽医..." 
};

PA.PHM_Tooltips["SliderPanzaFolTH"]	= {
	tooltip1	= "Low Mana Flash Threshold",
	tooltip2	= "Adjusts the low mana threshold for exclusive use of \"Flash\" Spells. When mana falls below this threshold, only \"Flash\" Spells will be used when healing."
};
PA.PHM_Tooltips["SliderPanzaSense"]	= {
	tooltip1	= "Healing Sensitivity",
	tooltip2	= "这个选项调整PA治疗的宏观程度。Underhealing 会自动选择比普通情况下的等级稍微低一点的技能来治疗。 Standard (默认) 会自动选择最高的不会过量治疗的法术来进行治疗。Overhealing 会使用比普通情况下的等级较高的法术来治疗。(技能等级相差 +-2)." 
--	tooltip3	= "Range +- 5",
};

PA.PHM_Tooltips["SliderPanzaPHMGroupLimit"]	= {
	tooltip1	= "Group Healing Limit",
	tooltip2	= "Minumum number of in-range party members that require healing for party healing to fire.",
--	tooltip3	= "Range 0-5, 0 is off",
};
PA.PHM_Tooltips["cbxPanzaHealAbort"]	= {
	tooltip1	= "Healing Abort.",
	tooltip2	= "PA 会在你施放法术的期间监视目标的血量，一旦对方生命值高于允许治疗的生命值阈值，PA就会自动打断施法。"
};

PA.PHM_Tooltips["cbxPanzaHealUseHoTs"]	= {
	tooltip1	= "Healing over Time Spells",
	tooltip2	= "When checked Panza will generally cast HoTs before other heals"
};
PA.PHM_Tooltips["btnPanzaPHMDefault"]	= {
	tooltip1	= "Reset Healing Settings",
	tooltip2	= "重置治疗设置到默认设置"
};

PA.PHM_Tooltips["cbxPanzaIgnoreRange"]	= {
	tooltip1	= "Ignore Healing Range Check in Instances",
	tooltip2	= "设置这一项时，在某些情况下施放治疗法术时将不会使用距离检查."
};

PA.PHM_Tooltips["SliderPanzaManaBuff"] = {
	tooltip1	= "Mana Buffer (Non-Paladin Classes)",
	tooltip2	= "Specify the minimum number of spells you must be able to cast of the selected family of spells before switching to lower mana spells. Flash and Heal will switch to Lesser Heal, Greater Heal will switch to Heal. The check is run twice. This check is performed on Rank 1 spells of the family. If set to 0, this feature is disabled."
};

PA.PHM_Tooltips["cbxPanzaUseDFAll"] = {
	tooltip1	= "Divine Favor Switch",
	tooltip2	= "When checked PA will auto cast Divine Favor before all heals (if available)."
};

PA.PHM_Tooltips["cbxPanzaUseDF"] = {
	tooltip1	= "Divine Favor Holy Light Switch",
	tooltip2	= "When checked PA will auto cast Divine Favor before Holy Light spells (if available)."
};

PA.PHM_Tooltips["cbxPanzaOnDF"] = {
	tooltip1	= "Activate on Divine Favor",
	tooltip2	= "When checked PA will auto activate the selected trinket if DF is active."
};

PA.PHM_Tooltips["cbxPanzaOnFlash"] = {
	tooltip1	= "Activate on small heal",
	tooltip2	= "When checked PA will auto activate the selected trinket just before a small heal"
};

PA.PHM_Tooltips["cbxPanzaOnHeal"] = {
	tooltip1	= "Activate on large heal",
	tooltip2	= "When checked PA will auto activate the selected trinket just before a large heal"
};

PA.PHM_Tooltips["cbxPanzaOwnBars"] = {
	tooltip1	= "Current Healing Spell Status Bars",
	tooltip2	= "When checked PA will will display status bars for your own healing spells. Only regular healing spells are shown. All HOT spells are shown in the \"Other Healing Status Bars\"."
};

PA.PHM_Tooltips["cbxPanzaOtherBars"] = {
	tooltip1	= "Other Healing Status Bars",
	tooltip2	= "When checked PA will display status bars for healing spells cast by other Panza users. 20 spells may be shown at once. This must be enabled to display your own HOT spells."
};

PA.PHM_Tooltips["cbxPanzaCoop"] = {
	tooltip1	= "Panza Cooperative Healing",
	tooltip2	= "When checked Panza will transmit and process received healing messages using PanzaComm. The data gathered is used in target selection and rank selection for healing spells. This data is real-time. Transmissions occur when spellcasting starts, or stops in case of HoT spells. Spell Failures, Aborts, Delays, and Interruptions are accounted for. Panza will throttle messages to prevent message spam on PanzaComm\'s channel."
};

PA.PHM_Tooltips["cbxPanzaOOCHealing"] = {
	tooltip1	= "Simple Out of Combat Healing",
	tooltip2	= "When checked Panza will peform simple (mana efficient) heals when out of combat."
};
PA.PHM_Tooltips["btnPanzaPHMSetPos"] = {
	tooltip1	= "Set Healing Bars Position",
	tooltip2	= "PA will display simulated Healing Spells. Drag the bars to set their Position. Only bars selected will be shown. Pressing this button will unlock the bar postions if they are currently locked. When the simulation is complete, the bars will be locked into position. The status next to this button indicates Locked, Unlocked, or Disabled. This button will become disabled if neither of the bar options are set. You can also use this feature to reset any bars that may become stuck on-screen."
};

PA.PHM_Tooltips["SliderPanzaPHMCritRank"] = {
	tooltip1	= "Divine Favor Minimum Rank",
	tooltip2	= "(Paladin Only) Use this control to set the minimum healing spell rank needed to activate DF. 0 will disable this feature and use any rank if use DF is selected. This control is enabled if Divine Favor is in your SpellBook."
};

PA.PHM_Tooltips["cbxPanzaUseDFAll.Priest"] = {
	tooltip1	= "Inner Focus Switch",
	tooltip2	= "When checked Panza will auto cast Inner Focus before Heal spells (if available)."
};

PA.PHM_Tooltips["cbxPanzaUseDF.Priest"] = {
	tooltip1	= "Inner Focus Heal/GreaterHeal Switch",
	tooltip2	= "When checked Panza will auto cast Inner Focus before Heal/GreaterHeal spells (if available)."
};

PA.PHM_Tooltips["cbxPanzaOnDF.Priest"] = {
	tooltip1	= "Activate on Inner Focus",
	tooltip2	= "When checked Panza will auto activate the selected trinket if Inner Focus is active."
};

PA.PHM_Tooltips["SliderPanzaPHMCritRank.Priest"] = {
	tooltip1	= "Inner Focus Minimum Rank",
	tooltip2	= "(Priest Only) Use this control to set the minimum healing spell rank needed to activate Inner Focus. 0 will disable this feature and use any rank if use Inner Focus is selected. This control is enabled if Inner Focus is in your SpellBook."
};

PA.PHM_Tooltips["cbxPanzaUseDFAll.Shaman"] = {
	tooltip1	= "Natures Swiftness Switch",
	tooltip2	= "When checked Panza will auto cast Natures Swiftness before Heal spells (if available)."
};

PA.PHM_Tooltips["cbxPanzaUseDF.Shaman"] = {
	tooltip1	= "Natures Swiftness Healing Way Switch",
	tooltip2	= "When checked Panza will auto cast Natures Swiftness before Healing Way spells (if available)."
};
PA.PHM_Tooltips["cbxPanzaOnDF.Shaman"] = {
	tooltip1	= "Activate on Natures Swiftness",
	tooltip2	= "When checked Panza will auto activate the selected trinket if Natures Swiftness is active."
};

PA.PHM_Tooltips["SliderPanzaPHMCritRank.Shaman"] = {
	tooltip1	= "Nature's Swiftness Minimum Rank",
	tooltip2	= "(Shaman Only) Use this control to set the minimum healing spell rank needed to activate Nature's Swiftness. 0 will disable this feature and use any rank if use Natures Swiftness is selected. This control is enabled if Natures Swiftness is in your SpellBook."
};

PA.PHM_Tooltips["cbxPanzaUseDFAll.DruidOMEN"] = {
	tooltip1	= "ClearCasting Switch",
	tooltip2	= "When checked Panza will check if ClearCasting is on."
};

PA.PHM_Tooltips["cbxPanzaUseDF.DruidOMEN"] = {
	tooltip1	= "ClearCasting Switch",
	tooltip2	= "When checked Panza will check if ClearCasting is on."
};

PA.PHM_Tooltips["cbxPanzaOnDF.DruidOMEN"] = {
	tooltip1	= "Activate when ClearCasting",
	tooltip2	= "When checked Panza will auto activate the selected trinket if ClearCasting is active."
};

PA.PHM_Tooltips["SliderPanzaPHMCritRank.DruidOMEN"] = {
	tooltip1	= "ClearCasting Minimum Rank",
	tooltip2	= "(Druid Only) Use this control to set the minimum healing spell rank used when ClearCasting is on. 0 will disable this feature and use any rank if ClearCasing is on. This control is enabled if Omen of Clarity is in your SpellBook."
};

PA.PHM_Tooltips["cbxPanzaUseDFAll.DruidSWIFT"] = {
	tooltip1	= "Natures Swiftness Switch",
	tooltip2	= "When checked Panza will auto cast Natures Swiftness before Heal spells (if available)."
};

PA.PHM_Tooltips["cbxPanzaUseDF.DruidSWIFT"] = {
	tooltip1	= "Natures Swiftness Healing Touch Switch",
	tooltip2	= "When checked Panza will auto cast Natures Swiftness before Healing Touch spells (if available)."
};

PA.PHM_Tooltips["cbxPanzaOnDF.DruidSWIFT"] = {
	tooltip1	= "Activate on Natures Swiftness",
	tooltip2	= "When checked Panza will auto activate the selected trinket if Natures Swiftness is active."
};

PA.PHM_Tooltips["SliderPanzaPHMCritRank.DruidSWIFT"] = {
	tooltip1	= "Natures Swiftness Minimum Rank",
	tooltip2	= "(Druid Only) Use this control to set the minimum healing spell rank needed to activate Natures Swiftness. 0 will disable this feature and use any rank if \"Use Natures Swiftness\" is selected. This control is enabled if Natures Swiftness is in your SpellBook."
};
PA.PHM_Tooltips["PanzaPHMFramePanel1BarOOC"] = {
	tooltip1	= "Combat Switch",
	tooltip2	= "Switches the Healing Indicator between Combat and Out of Combat modes."
};

------------------------------
-- Tooltips used in PBM Dialog
------------------------------
PA.PBM_Tooltips["cbxPanzaEnableNPC"]	= {
	tooltip1	= "CycleNear NPC Buffs",
	tooltip2	= "When checked, Panza will buff nearby NPCs (this includes Pets) along with players. Usefull for escort missions. To buff nearby pets this must be enabled. Default is disabled."
};

PA.PBM_Tooltips["cbxPanzaEnableCycle"]	= {
	tooltip1	= "CycleBuff from AutoSelect Buff Mode",
	tooltip2	= "When checked, Panza will buff the entire party, and raid from the asbuff command if your are grouped and have no target, or a group member is targeted. Default is Enabled."
};

PA.PBM_Tooltips["SliderPanzaPBMRebless"]	= {
	tooltip1	= "CycleBuff Rebless Threshold",
	tooltip2	= "Adjusts the amount of remaining time, in seconds, below which an existing buff will be refreshed This may be bypassed by using the Alt+CycleBuff keys to reset CycleBuff."
};

PA.PBM_Tooltips["SliderPanzaPBMNotBlessed"]	= {
	tooltip1	= "CycleBuff Not Buffed Count",
	tooltip2	= "Adjusts the number of players output who do not have a buff."
};

PA.PBM_Tooltips["SliderPanzaPBMNearRestart"]	= {
	tooltip1	= "CycleNear List Timeout ",
	tooltip2	= "Adjusts the amount of time, in seconds, that must expire before the by-name list expires for CycleNear, You can reset this list at any time by using the Alt+CycleNear keys."
};

PA.PBM_Tooltips["SliderPanzaPBMNPC"]	= {
	tooltip1	= "NPC Skipping",
	tooltip2	= "Adjusts the number of NPCs that will be skipped, limiting the number prevents endless loops. This setting only takes effect if Buff NPCs is disabled."
};

PA.PBM_Tooltips["btnPanzaPBMDCB"]	= {
	tooltip1	= "Default Class Buff",
	tooltip2	= "Display the DCB Dialog. DCB will allow buff selection by Class and specific buffs for Solo, Party, Raid, and Battleground. DCB also has a special selection of buffs for \"Player\"."
};

PA.PBM_Tooltips["btnPanzaPBMDefault"]	= {
	tooltip1	= "Buff Parameter Defaults",
	tooltip2	= "This will reset all CycleNear, CycleBuff, and AsBuff parameters to the default values."
};

PA.PBM_Tooltips["cbxPanzaBowOnLowMana"]	= {
	tooltip1	= "Enable Blessing of Wisdom (Paladin Only) override on low mana",
	tooltip2	= "When checked, Panza will override the current blessing with Blessing of Wisdom if the target's mana is low." ;
};

PA.PBM_Tooltips["cbxPanzaPVPUseBG"]	= {
	tooltip1	= "Use BG buffs when PVP flag set",
	tooltip2	= "When checked, Panza will use the default buffs from the BattleGround column." ;
};

PA.PBM_Tooltips["cbxPanzaShowProgress"]	= {
	tooltip1	= "Buffing Progress",
	tooltip2	= "When checked, Panza will output a progress message after each CycleBuff." ;
};

PA.PBM_Tooltips["cbxPanzaGBMe"]	= {
	tooltip1	= "Group Buffs (Self)",
	tooltip2	= "When checked, Panza will always use Group Buffs on You (even if you are solo)." ;
};

PA.PBM_Tooltips["cbxPanzaGBParty"]	= {
	tooltip1	= "Group Buffs (Party)",
	tooltip2	= "When checked, Panza will use Group Buffs on your Party." ;
};

PA.PBM_Tooltips["cbxPanzaGBRaid"]	= {
	tooltip1	= "Group Buffs (Raid)",
	tooltip2	= "When checked, Panza will use Group Buffs on your Raid." ;
};

PA.PBM_Tooltips["cbxPanzaGBBG"]	= {
	tooltip1	= "Group Buffs (BG)",
	tooltip2	= "When checked, Panza will use Group Buffs in Battlegrounds." ;
};

PA.PBM_Tooltips["SliderPanzaPBMGreater"]	= {
	tooltip1	= "Group Buffs Threshold",
	tooltip2	= "Will not bless a class if less than this percentage of that class are within range. CycleBuff checks each class with this percentage." ;
};

PA.PBM_Tooltips["cbxPanzaIgnoreParty"]	= {
	tooltip1	= "Ignore party DCB buffs in raid",
	tooltip2	= "勾选后，在团队中时，PA会对自己小队中的成员使用团队情形的Buff设置，而不是小队情形的Buff设置。" 
};

PA.PBM_Tooltips["cbxPanzaPets"]	= {
	tooltip1	= "Allow pets to be blessed",
	tooltip2	= "勾选后，PA会Buff 小队/团队 中的宠物。" 
};

PA.PBM_Tooltips["cbxPanzaEnableWarn"]	= {
	tooltip1	= "Enable Buff Expiring Warning System (BEWS)",
	tooltip2	= "When checked, Assistant will issue a Warning 60 Seconds before your buff expires. It will then issue 2 further warnings at 10 second intervals. A final warning will be issued when the buff expires." ;
};

PA.PBM_Tooltips["cbxPanzaBEWSParty"]	= {
	tooltip1	= "Enable BEWS on Party",
	tooltip2	= "Panza will report party members who's buffs are about to expire."
};

PA.PBM_Tooltips["cbxPanzaBEWSRaid"]	= {
	tooltip1	= "Enable BEWS on Raid",
	tooltip2	= "Panza will report raid members who's buffs are about to expire."
};

PA.PBM_Tooltips["cbxPanzaBEWSAll"]	= {
	tooltip1	= "Enable BEWS on Everyone",
	tooltip2	= "Panza will report all buffs that are about to expire."
};

PA.PBM_Tooltips["cbxPanzaBEWSGreater"]	= {
	tooltip1	= "Enable BEWS on Group Buffs",
	tooltip2	= "Panza will report Group Buffs that are about to expire."
};

PA.PBM_Tooltips["cbxPanzaBEWSSounds"]	= {
	tooltip1	= "Enable BEWS sounds",
	tooltip2	= "Plays sounds as buffs are about to expire."
};

PA.PBM_Tooltips["cbxPanzaBoSaf"]	= {
	tooltip1	= "Keep Blessing of Sacrifice up during PVP",
	tooltip2	= "Using paComb, will attempt to keep Blessing of Sacrifice up on one group member whilst PVP on."
};

------------------------------
-- Tooltips used in PPM Dialog
------------------------------
PA.PPM_Tooltips["SliderPAPPM"]	= {
	tooltip1	= "Panic Healing Limit",
	tooltip2	= "设置生命值百分比阈值，低于这个值时，PA将启动紧急情形治疗。" 
};

PA.PPM_Tooltips["btnPanzaPPMDefault"]	= {
	tooltip1	= "Panic Defaults",
	tooltip2	= "这个键将紧急情形的参数设为默认值。" 
};

PA.PPM_Tooltips["cbxPanzaPPMStage1"]	= {
	tooltip1	= "Blessing of Protection Stage",
	tooltip2	= "Attempt to cast Blessing of Protection"
};

PA.PPM_Tooltips["cbxPanzaPPMStage1.Priest"]	= {
	tooltip1	= "Power Word: Shield Stage",
	tooltip2	= "Attempt to cast Power Word: Shield"
};

PA.PPM_Tooltips["cbxPanzaPPMStage2"]	= {
	tooltip1	= "Holy Shock Stage",
	tooltip2	= "Attempt to cast Holy Shock if Bop NOT up"
};

PA.PPM_Tooltips["cbxPanzaPPMStage3"]	= {
	tooltip1	= "Lay on Hands Stage",
	tooltip2	= "如果保护Buff失败，试图施放圣疗术" 
};

PA.PPM_Tooltips["cbxPanzaPPMStage4"]	= {
	tooltip1	= "Cure Stage",
	tooltip2	= "试图清洁目标。" 
};

PA.PPM_Tooltips["cbxPanzaPPMStage5"]	= {
	tooltip1	= "Divine Favor Stage",
	tooltip2	= "如果保护Buff成功，试图施放神恩" 
};

PA.PPM_Tooltips["cbxPanzaPPMStage5.Priest"]	= {
	tooltip1	= "Inner Focus Stage",
	tooltip2	= "Attempt to cast Inner Focus if PWS is up."
};

PA.PPM_Tooltips["cbxPanzaPPMStage5.DruidSWIFT"]	= {
	tooltip1	= "Nature\'s Swiftness Stage",
	tooltip2	= "Attempt to cast Nature\'s Swiftness."
};

PA.PPM_Tooltips["cbxPanzaPPMStage5.DruidOMEN"]	= {
	tooltip1	= "Force Highest Rank on ClearCasting",
	tooltip2	= "If ClearCasting is up, Force Highest Rank Heal."
};

PA.PPM_Tooltips["cbxPanzaPPMStage5.Shaman"]	= {
	tooltip1	= "Nature\'s Swiftness Stage",
	tooltip2	= "Attempt to cast Nature\'s Swiftness."
};

PA.PPM_Tooltips["cbxPanzaPPMStage6"]	= {
	tooltip1	= "BestHeal Stage",
	tooltip2	= "Attempt to cast BestHeal"
};


------------------------------
-- Tooltips used in PFM Dialog
------------------------------
PA.PFM_Tooltips["SliderPAPFM"]	= {
	tooltip1	= "PFM Free Weighting",
	tooltip2	= "Sets weighting for freeing. Classes with the highest weighting will be freed first."
};

PA.PFM_Tooltips["btnPanzaPFMDefault"]	= {
	tooltip1	= "PFM Defaults",
	tooltip2	= "This will reset all PFM parameters to the default values."
};

-----------------------------------
-- Tooltips used in PHM Bias Dialog
-----------------------------------
PA.PHMBias_Tooltips["SliderPAPHMBias"]	= {
	tooltip1	= "Healing/Curing Bias",
	tooltip2	= "Health/Cure bias applied to class (excludes Self). The higher it is the more you will heal/cure this class in preference to others. Centered on 0 (no bias)"
};

PA.PHMBias_Tooltips["btnPanzaPHMBiasDefault"]	= {
	tooltip1	= "Healing/Curing Bias Defaults",
	tooltip2	= "This will reset all Healing/Curing Bias parameters to the default values."
};

PA.PHMBias_Tooltips["SliderPanzaSelfBias"]	= {
	tooltip1	= "Self Healing/Curing Bias",
	tooltip2	= "Health/Cure bias applied to Self. The lower it is the more you will heal/cure others in preference to yourself. Centered on 0 (no bias)."
};

PA.PHMBias_Tooltips["SliderPanzaPartyBias"]	= {
	tooltip1	= "Party Healing/Curing Bias",
	tooltip2	= "Health/Cure bias applied to Party (including Self). The higher it is the more you will heal/cure your party in preference to the raid. Centered on 0 (no bias)."
};

PA.PHMBias_Tooltips["SliderPanzaMainTankBias"]	= {
	tooltip1	= "Main Tank Healing/Curing Bias",
	tooltip2	= "Health/Cure bias applied to Main Tanks (as defined in RaidAssist). The higher it is the more you will heal/cure the MTs in preference to the raid. Centered on 0 (no bias)."
};

PA.PHMBias_Tooltips["SliderPanzaMTTTBias"]	= {
	tooltip1	= "Main Tank Target's Target Healing/Curing Bias",
	tooltip2	= "Health/Cure bias applied to Main Tanks' (as defined in RaidAssist) Target's Target. The higher it is the more you will heal/cure the MTs Target's Target in preference to the raid. Centered on 0 (no bias)."
};


------------------------------
-- Tooltips used in PCM Dialog
------------------------------
PA.PCM_Tooltips["SliderPAPCM"]	= {
	tooltip1	= "PCM Cure Weighting Limit",
	tooltip2	= "Sets weighting below which cure will activate. Only if Use Weight is enabled."
};

PA.PCM_Tooltips["btnPanzaPCMDefault"]	= {
	tooltip1	= "PCM Defaults",
	tooltip2	= "This will reset all PCM parameters to the default values."
};

PA.PCM_Tooltips["SliderPCMType"]	= {
	tooltip1	= "PCM Cure Type Weighting",
	tooltip2	= "Sets weighting for this cure type"
};


------------------------------
-- Tooltips used in PAW Dialog
------------------------------
PA.PAW_Tooltips["cbxPanzaPAWEnable"] = {
	tooltip1	= "PAW Enable",
	tooltip2	= "With PAW enabled, other players can send you tells to change their default buff. If a player sends you a tell with the word paw, a list of blessings you have along with keywords for these blessings will be sent as a response. Players can send you tells with keywords like might, light, bom, bol, and PA will save that blessing for that player for the next time a cycle, or asbuff command is used."
};

PA.PAW_Tooltips["cbxPanzaPAWResponse"] = {
	tooltip1	= "PAW Responses",
	tooltip2	= "With Responses enabled, other players will receive notifications via whisper with the status of their command."
};

PA.PAW_Tooltips["btnPanzaPAWDefault"]	= {
	tooltip1	= "PAW Defaults",
	tooltip2	= "Reset PAW parameters to the default values."
};

------------------------------
-- Tooltips used in POM Dialog
------------------------------
PA.POM_Tooltips["cbxPanzaPOMHSOnlyOnDF"] = {
	tooltip1	= "Use Holy Shock only with Divine Favor",
	tooltip2	= "Only cast Holy Shock when Divine Favor is available."
};

PA.POM_Tooltips["cbxPanzaPOMHSAlwaysOnDF"] = {
	tooltip1	= "Use Divine Favor with Holy Shock",
	tooltip2	= "Cast Divine Favor anytime it\'s up with Holy Shock."
};

PA.POM_Tooltips["cbxPanzaPOMHS"] = {
	tooltip1	= "Holy Shock",
	tooltip2	= "Use Holy Shock as an offensive spell."
};

PA.POM_Tooltips["cbxPanzaPOMEXO"] = {
	tooltip1	= "Exorcism",
	tooltip2	= "Use Exorcism as an offensive spell on Undead and Demons."
};

PA.POM_Tooltips["cbxPanzaPOMHOW"] = {
	tooltip1	= "Hammer of Wrath",
	tooltip2	= "Use Hammer of Wrath as an offensive spell when target health is below 20%."
};

PA.POM_Tooltips["btnPanzaPOMDefault"]	= {
	tooltip1	= "POM Defaults",
	tooltip2	= "Reset POM parameters to the default values."
};

PA.POM_Tooltips["cbxPanzaPOMSoC"]	= {
	tooltip1	= "Always Judge Seal of Command",
	tooltip2	= "Judge Seal of Command when available."
};

PA.POM_Tooltips["cbxPanzaPOMStunned"]	= {
	tooltip1	= "Judge Seal of Command when stunned",
	tooltip2	= "Target must be stunned for Seal of Command to be Judged."
};

PA.POM_Tooltips["cbxPanzaPOMSoR"]	= {
	tooltip1	= "Always Judge Seal of Righteousness",
	tooltip2	= "Judge Seal of Righteousness when available."
};

PA.POM_Tooltips["cbxPanzaPOMOffAll"]	= {
	tooltip1	= "Cast offensive spells without seals",
	tooltip2	= "Will not wait until seals are up before casting offensive spells"
};

PA.POM_Tooltips["cbxPanzaSMShow"]	= {
	tooltip1	= "Show Seal Menu",
	tooltip2	= "Displays a small menu for selecting seals"
};

PA.POM_Tooltips["cbxPanzaSMLocked"]	= {
	tooltip1	= "Lock Seal Menu",
	tooltip2	= "Prevents Seal Menu from being moved or resized"
};

PA.POM_Tooltips["cbxPanzaSMKeepOpen"]	= {
	tooltip1	= "Keep Seal Menu Open",
	tooltip2	= "Keeps the Selection Menu Open"
};

PA.POM_Tooltips["cbxPanzaSMKeepDocked"]	= {
	tooltip1	= "Keep Seal Menu Docked",
	tooltip2	= "Keeps the Selection Menu Docked"
};

PA.POM_Tooltips["cbxPanzaSMMenuOnShift"]	= {
	tooltip1	= "Show Seal Menu on SHIFT",
	tooltip2	= "Only shows the Selection Menu when the SHIFT key is pressed"
};

PA.POM_Tooltips["cbxPanzaSMPvP"]	= {
	tooltip1	= "Ignore PvP seals",
	tooltip2	= "Do not use PvP seals when PvP flag set"
};

PA.POM_Tooltips["cbxPanzaSMTooltips"]	= {
	tooltip1	= "Display Seal Menu Tooltips",
	tooltip2	= "When enabled, Panza will display tooltips for the Seal Menu Combo"
};

PA.POM_Tooltips["cbxPanzaSMTextTop"]	= {
	tooltip1	= "Seal Menu Prediction, Top",
	tooltip2	= "When enabled, Panza will display prediction text above the Seal Menu"
};

PA.POM_Tooltips["cbxPanzaSMTextBottom"]	= {
	tooltip1	= "Seal Menu Prediction, Bottom",
	tooltip2	= "When enabled, Panza will display prediction text below the Seal Menu"
};

PA.POM_Tooltips["cbxPanzaSMTextOff"]	= {
	tooltip1	= "Disable Seal Menu Prediction",
	tooltip2	= "When enabled, Panza will turn off display prediction text"
};
PA.POM_Tooltips["SealMenu"]	= {
	tooltip1	= "Panza圣印菜单",
	tooltip2	= "施放定制的圣印,并在合适的时候审判它。",
	tooltip3	= "Offensive spells will also be cast if configured (via POM).",
	tooltip4	= "Mouse over the menu (or mouse over plus SHIFT) to bring up the Seal Selection Menu.",
	tooltip5	= "Left-click the menu to change Seal 1.",
	tooltip6	= "Right-click the menu to change Seal 2.",
	tooltip7	= "Clicking on the Seal Menu will activate the Seal 1-Judge-Seal 2 Process.",
};

PA.POM_Tooltips["SealMenu2"]	= {
	tooltip1	= "Panza 圣印菜单#2",
	tooltip2	= "施放定制的圣印,并在合适的时候审判它。",
	tooltip3	= "Offensive spells will also be cast if configured (via POM).",
	tooltip4	= "Mouse over the menu (or mouse over plus SHIFT) to bring up the Seal Selection Menu.",
	tooltip5	= "Right-click the menu to change this seal (#2).",
	tooltip6	= "Clicking on the Seal Menu will activate the Seal 1 -Judge-Seal 2 Process.",
};

--------------------------
-- Tooltips for PMM Dialog
--------------------------
PA.PMM_Tooltips["cbxPanzaPMMenable"] = {
	tooltip1	= "Enable PMM Functions",
	tooltip2	= "Enable or Disable Panza Mouse Functions. If PMM functions are enabled. Panza will use the functions listed below for each button listed. If Buttons are unassigned, no action will be taken. Standard keys (left, right, middle, etc buttons) will not be affected."
};

PA.PMM_Tooltips["btnPanzaPMMDefault"] = {
	tooltip1	= "PMM Deafult",
	tooltip2	= "Restore all Panza Mouse Settings to their default values."
};

PA.PMM_Tooltips["cbxPanzaPMM_CTRA"] = {
	tooltip1	= "CTRA Frame Support",
	tooltip2	= "When enabled Panza will register and use our functions on CTRA frames."
};

PA.PMM_Tooltips["cbxPanzaPMM_Bliz_Player"] = {
	tooltip1	= "Blizzard Player Frame Support",
	tooltip2	= "When enabled Panza will register use our functions on standard Player frame."
};

PA.PMM_Tooltips["cbxPanzaPMM_Bliz_Target"] = {
	tooltip1	= "Blizzard Target Frame Support",
	tooltip2	= "When enabled Panza will register use our functions on standard Target frame."
};

PA.PMM_Tooltips["cbxPanzaPMM_Bliz_Party"] = {
	tooltip1	= "Blizzard Party Frame Support",
	tooltip2	= "When enabled Panza will register and use our functions on standard Party Frames."
};

PA.PMM_Tooltips["cbxPanzaPMM_Bliz_Pet"] = {
	tooltip1	= "Blizzard Pet Frame Support",
	tooltip2	= "When enabled Panza will register and use our functions on standard Pet Frames."
};

PA.PMM_Tooltips["cbxPanzaPMM_DUF"] = {
	tooltip1	= "Discord Unit Frames Support",
	tooltip2	= "When enabled Panza will register and use our functions on Discord Unit Frames."
};

PA.PMM_Tooltips["cbxPanzaPMM_PERL"] = {
	tooltip1	= "Perl Classic Frames Support",
	tooltip2	= "When enabled Panza will register and use our functions on Perl Classic Frames."
};

------------------------------
-- Tooltips used in DCB Dialog
------------------------------
PA.DCB_Tooltips["PA_DCBSaveSetEditBox"] = {
	tooltip1	= "New Save Set",
	tooltip2	= "Name to create current DCB settings as"
};

PA.DCB_Tooltips["btnPanzaDCBNew"] = {
	tooltip1	= "Create new Save Set",
	tooltip2	= "Creates a new set of DCB settings using name in edit box"
};

PA.DCB_Tooltips["PA_DCBSelectSaveSet"] = {
	tooltip1	= "Select Save Set",
	tooltip2	= "Select saved Save Set from dropdown"
};

PA.DCB_Tooltips["btnPanzaDCBDelAll"] = {
	tooltip1	= "Delete all Save Sets",
	tooltip2	= "Deletes all currently saved Save Sets"
};

PA.DCB_Tooltips["btnPanzaDCBDelete"] = {
	tooltip1	= "Delete current Save Set",
	tooltip2	= "Deletes the currently selected Save Set"
};

PA.DCB_Tooltips["cbxPanzaBackup0"] = {
	tooltip1	= "Shows the primary buffs for the current set",
	tooltip2	= "PA will attempt to cast these buffs first"
};

PA.DCB_Tooltips["cbxPanzaBackup1"] = {
	tooltip1	= "Shows the no.1 buffs for the current set",
	tooltip2	= "PA will attempt to cast these buffs if the primary buff has been set by someone else. For Priests and Druids, this level will be used in addition to level 0 so each target will receive both spells."
};

PA.DCB_Tooltips["cbxPanzaBackup2"] = {
	tooltip1	= "Shows the no.2 buffs for the current set",
	tooltip2	= "PA will attempt to cast these buffs if the previous buffs have been set by someone else. For Priests and Druids, this level will be used in addition to level 0, and 1 so each target will receive all three spells."
};

PA.DCB_Tooltips["cbxPanzaBackup3"] = {
	tooltip1	= "Shows the no.3 buffs for the current set",
	tooltip2	= "PA will attempt to cast these buffs if the previous buffs have been set by someone else. For Priests and Druids, this level will be used in addition to levels 0, 1, and 2 so each target will receive all four spells."
};

---------------------------------------
-- Tooltip for Current Heal Status Bars
---------------------------------------
PA.Bars_Tooltips["PanzaFrame_HealCurrentSpell"] = {
	tooltip1	= "当前法术状态",
	tooltip2	= "The Top Bar shows the Healing Spell with the status bar counting down the time left in casting. The middle bar shows the target health in a current over max ratio. The bottom bar shows an estimate of target health after the spell lands. This takes into account all known healing directed at your target. The abort button will cancel this spell when pressed."
};

----------------------------------------------------
-- Values for Mouse Support pa_mouse.lua (Key Names)
----------------------------------------------------
PA_CLICK_UNASSIGNED		= "未分配";
PA_CLICK_HEAL			= "治疗";
PA_CLICK_BLESS			= "祝福";
PA_CLICK_CURE			= "清洁";
PA_CLICK_REZ			= "复活";
PA_CLICK_PWS			= "真言术：盾";
PA_CLICK_LAY_HANDS		= "圣疗术";

PA_SHIFTLEFTCLICK		= "Shift+左键:"
PA_SHIFTMIDDLECLICK		= "Shift+中键:"
PA_SHIFTRIGHTCLICK		= "Shift+右键:"
PA_CTRLLEFTCLICK		= "Ctrl+左键:"
PA_CTRLMIDDLECLICK		= "Ctrl+中键:"
PA_CTRLRIGHTCLICK		= "Ctrl+右键:"
PA_ALTLEFTCLICK			= "Alt+左键:"
PA_ALTMIDDLECLICK		= "Alt+中键:"
PA_ALTRIGHTCLICK		= "Alt+右键:"

--------------------------------------------
--            CRITICAL SECTION
--
-- Changing these values will break the code
--------------------------------------------

PANZA_KINGSCOUNT_ITEMNAME 	= "王者印记";
PANZA_DIVINITYCOUNT_ITEMNAME	= "神圣符印";
PANZA_KINGSCOUNT_SHORTNAME  	= "王者";
PANZA_DIVINITYCOUNT_SHORTNAME  	= "神圣";

PANZA_FEATHERCOUNT_ITEMNAME	= "轻羽毛";
PANZA_HOLYCANCOUNT_ITEMNAME	= "圣洁蜡烛";
PANZA_SACREDCANCOUNT_ITEMNAME 	= "神圣蜡烛";
PANZA_FEATHERCOUNT_SHORTNAME	= "羽毛";
PANZA_HOLYCANCOUNT_SHORTNAME	= "圣洁";
PANZA_SACREDCANCOUNT_SHORTNAME	= "神圣";

PANZA_BERRIESCOUNT_ITEMNAME	= "野生浆果";
PANZA_THORNROOTCOUNT_ITEMNAME	= "野生棘根草";
PANZA_MAPLECOUNT_ITEMNAME	= "枫树种子";
PANZA_THORNCOUNT_ITEMNAME	= "荆棘种子";
PANZA_ASHWOODCOUNT_ITEMNAME	= "灰木种子";
PANZA_HORNBEAMCOUNT_ITEMNAME	= "角树种子";
PANZA_IRONWOODCOUNT_ITEMNAME	= "铁木种子";
PANZA_BERRIESCOUNT_SHORTNAME	= "浆果";
PANZA_THORNROOTCOUNT_SHORTNAME	= "棘根草";
PANZA_MAPLECOUNT_SHORTNAME	= "枫树";
PANZA_THORNCOUNT_SHORTNAME	= "荆棘";
PANZA_ASHWOODCOUNT_SHORTNAME	= "灰木";
PANZA_HORNBEAMCOUNT_SHORTNAME	= "角树";
PANZA_IRONWOODCOUNT_SHORTNAME	= "铁木";

PANZA_IMMOBILIZED		= {"固定", "开发网页", "无法移动或施法"};

PANZA_STUNNED			= "昏迷";
PANZA_DISORIENTED		= "迷惑";
PANZA_INCAPACITATED		= "无法移动";

PANZA_UNDEAD			= "亡灵";
PANZA_DEMON			= "恶魔";

PANZA_FACTION_HORDE		= "部落";
PANZA_FACTION_ALLIANCE		= "联盟";

PANZA_WSG_CAPTURE_MATCH		= "(%w+) captured the (%w+) [fF]lag";
PANZA_WSG_DROPPED_MATCH		= "The (%w+) [fF]lag was dropped by (%w+)";
PANZA_WSG_PICKED_MATCH		= "The (%w+) [fF]lag was picked up by (%w+)";
PANZA_WSG_PLACED_MATCH		= "替换";

PANZA_RANK			= "等级";

PANZA_DREAMLESS			= "昏睡"; -- For Dreamless sleep detectiontraumlosen Schlafs

-- Gear bonuses are reduced by spell cast times and levels, Buff bonuses are not
PANZA_TRINKET_BONUS = {};
PANZA_TRINKET_BONUS["Zandalarian Hero Charm"] = {Gear=400, Buff=0};
-------------------------------------------------------------------------------
-- Match strings used to extract blessing durations from the spellbook tooltips
-------------------------------------------------------------------------------
PANZA_DURATION_SEC		= {" for (%d+) sec[%.,]", "Lasts (%d+) sec%.", "over (%d+) sec%."};
PANZA_DURATION_MIN		= {" for (%d+) min%.", "Lasts (%d+) min", "Lasts for (%d) minutes"};
PANZA_DURATION_HOUR		= {" for (%d+) hour%."};

------------------------------------------------------
-- Search positions used for buffs that affect healing
------------------------------------------------------
PA.HealBuffTip["bol"] 		= {Count={1,2}, Tip="Left2"};
PA.HealBuffTip["hway"]		= {Count=1, Tip="Left2"};
PA.HealBuffTip["amp"] 		= {Count=2, Tip="Left2"};
PA.HealBuffTip["usp"]		= {Count=1, Tip="Left3"};

-----------------------
-- CRITICAL SECTION END
-----------------------

end