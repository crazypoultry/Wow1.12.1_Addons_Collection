-- File containing localized strings
-- Translation : zhCN - AndyAska.com (20060626)

if GetLocale() == "zhCN" then
	-- Chinese Simplified localized variables

	GroupCalendar_cTitle = "团体行事历 v%s";

	GroupCalendar_cSun = "日";
	GroupCalendar_cMon = "一";
	GroupCalendar_cTue = "二";
	GroupCalendar_cWed = "三";
	GroupCalendar_cThu = "四";
	GroupCalendar_cFri = "五";
	GroupCalendar_cSat = "六";

	GroupCalendar_cSunday = "星期日";
	GroupCalendar_cMonday = "星期一";
	GroupCalendar_cTuesday = "星期二";
	GroupCalendar_cWednesday = "星期三";
	GroupCalendar_cThursday = "星期四";
	GroupCalendar_cFriday = "星期五";
	GroupCalendar_cSaturday = "星期六";

	GroupCalendar_cSelfWillAttend = "%s会出席";

	GroupCalendar_cMonthNames = {"1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"};
	GroupCalendar_cDayOfWeekNames = {GroupCalendar_cSunday, GroupCalendar_cMonday, GroupCalendar_cTuesday, GroupCalendar_cWednesday, GroupCalendar_cThursday, GroupCalendar_cFriday, GroupCalendar_cSaturday};

	GroupCalendar_cLoadMessage = "团体行事历已载入。使用 /calendar 来浏览行事历";
	GroupCalendar_cInitializingGuilded = "团体行事历: 替已有公会的玩家进行初始化设定";
	GroupCalendar_cInitializingUnguilded = "团体行事历: 指没有公会的玩家进行初始化设定";
	GroupCalendar_cLocalTimeNote = "(%s 本地)";

	GroupCalendar_cOptions = "设定...";

	GroupCalendar_cCalendar = "行事历";
	GroupCalendar_cChannel = "频道";
	GroupCalendar_cTrust = "信任";
	GroupCalendar_cAbout = "关于";

	GroupCalendar_cUseServerDateTime = "使用伺服器日期与时间";
	GroupCalendar_cUseServerDateTimeDescription = "启动此功能将会以伺服器的日期与时间来显示活动资讯，若关闭此功能则会以您的电脑日期及时间来显示。";

	GroupCalendar_cChannelConfigTitle = "资料频道设定";
	GroupCalendar_cChannelConfigDescription = "行事历频道用来传送及接收玩家之间的活动，所有在频道的人都能浏灠您的活动。若想替您的行事历保密就必须设定密码。";
	GroupCalendar_cAutoChannelConfig = "自动频道设定";
	GroupCalendar_cManualChannelConfig = "手动频道设定";
	GroupCalendar_cStoreAutoConfig = "自动储存设定到玩家讯息";
	GroupCalendar_cAutoConfigPlayer = "玩家名称:";
	GroupCalendar_cApplyChannelChanges = "套用";
	GroupCalendar_cAutoConfigTipTitle = "自动频道设定";
	GroupCalendar_cAutoConfigTipDescription = "自动从公会资讯中取得频道资讯。您必须是公会成员，此功能必须在公会干部设定后方可使用。";
	GroupCalendar_cManualConfigTipDescription = "允许您手动输入频道及密码资料。";
	GroupCalendar_cStoreAutoConfigTipDescription = "允许公会干部将频道设置资讯存到指定成员的玩家资讯中。";
	GroupCalendar_cAutoConfigPlayerTipDescription = "玩家在公会资讯中包含频道设置资料。";
	GroupCalendar_cChannelNameTipTitle = "频道名称";
	GroupCalendar_cChannelNameTipDescription = "频道名称用来传送及接收其他玩家的活动资料。";
	GroupCalendar_cConnectChannel = "连线";
	GroupCalendar_cDisconnectChannel = "中断连线";
	GroupCalendar_cChannelStatus =
	{
		Starting = {mText = "状态: 启动中...", mColor = {r = 1, g = 1, b = 0.3}},
		Synching = {mText = "状态: 与网络同步中", mColor = {r = 0.3, g = 1, b = 0.3}},
		Connected = {mText = "状态: 资料频道已连接", mColor = {r = 0.3, g = 1, b = 0.3}},
		Disconnected = {mText = "状态: 资料频道尚未连接", mColor = {r = 1, g = 0.5, b = 0.2}},
		Initializing = {mText = "状态: 初始化资料频道", mColor = {r = 1, g = 1, b = 0.3}},
		Error = {mText = "错误: %s", mColor = {r = 1, g = 0.2, b = 0.4}},
	};

	GroupCalendar_cConnected = "已连线";
	GroupCalendar_cDisconnected = "已中断连线";
	GroupCalendar_cTooManyChannels = "您已经到达频道的加入上限";
	GroupCalendar_cJoinChannelFailed = "不明原因引致无法加入频道";
	GroupCalendar_cWrongPassword = "密码错误";
	GroupCalendar_cAutoConfigNotFound = "找不到公会设置资料";
	GroupCalendar_cErrorAccessingNote = "无法接收设置资料";

	GroupCalendar_cTrustConfigTitle = "信任设定";
	GroupCalendar_cTrustConfigDescription = "允许您控制能够检视活动的人。行事历本身并无限制谁能够检视活动，设定密码就能有效限制能够检视行事历的人。";
	GroupCalendar_cTrustGroupLabel = "信任:";
	GroupCalendar_cEvent = "活动";
	GroupCalendar_cAttendance = "出席";

	GroupCalendar_cAboutTitle = "关于团体行事历";
	GroupCalendar_cTitleVersion = "团体行事历 v"..gGroupCalendar_VersionString;
	GroupCalendar_cAuthor = "由 Thunderlord 的 Baylord 设计及编写";
	GroupCalendar_cTestersTitle = "测试人员";

	GroupCalendar_cSpecialThanksTitle = "特别鸣谢";

	GroupCalendar_cGuildURL = "http://www.andyaska.com";
	GroupCalendar_cRebuildDatabase = "重新建立资料库";
	GroupCalendar_cRebuildDatabaseDescription = "重新建立活动资料库给您的角色。有助解决无法观看所有活动的问题，但是此举动可能有机会会遗失出席回覆的资讯。";

	GroupCalendar_cTrustGroups =
	{
		"所有存取资料频道的玩家",
		"公会成员",
		"仅限下列名单列出的玩家"
	};

	GroupCalendar_cTrustAnyone = "信任所有存取资料频道的玩家";
	GroupCalendar_cTrustGuildies = "信任我的公会成员";
	GroupCalendar_cTrustMinRank = "最低阶级需求:";
	GroupCalendar_cTrustNobody = "只信任下列名单中列出的玩家";
	GroupCalendar_cTrustedPlayers = "信任的玩家";
	GroupCalendar_cExcludedPlayers = "例外的玩家"
	GroupCalendar_cPlayerName = "玩家名称:";
	GroupCalendar_cAddTrusted = "信任";
	GroupCalendar_cRemoveTrusted = "移除";
	GroupCalendar_cAddExcluded = "例外";

	CalendarEventViewer_cTitle = "检示活动";
	CalendarEventViewer_cDone = "完成";

	CalendarEventViewer_cLevelRangeFormat = "等级 %i 至 %i";
	CalendarEventViewer_cMinLevelFormat = "等级 %i 或以上";
	CalendarEventViewer_cMaxLevelFormat = "等级 %i 或以下";
	CalendarEventViewer_cAllLevels = "所有等级";
	CalendarEventViewer_cSingleLevel = "只限等级 %i";

	CalendarEventViewer_cYes = "嗯! 我会出席此活动";
	CalendarEventViewer_cNo = "不. 我不会出席此活动";

	CalendarEventViewer_cResponseMessage =
	{
		"状态: 没有回应",
		"状态: 等候确认",
		"状态: 已确认 - 已接受",
		"状态: 已确认 - 等候中",
		"状态: 已确认 - 不出席",
		"状态: 被禁止",
	};

	CalendarEventEditorFrame_cTitle = "新增/修改活动";
	CalendarEventEditor_cDone = "完成";
	CalendarEventEditor_cDelete = "删除";
	CalendarEventEditor_cGroupTabTitle = "队伍";

	CalendarEventEditor_cConfirmDeleteMsg = "删除 \"%s\"?";

	-- Event names

	GroupCalendar_cGeneralEventGroup = "综合";
	GroupCalendar_cRaidEventGroup = "团队";
	GroupCalendar_cDungeonEventGroup = "地下城";
	GroupCalendar_cBattlegroundEventGroup = "战场";

	GroupCalendar_cMeetingEventName = "聚会";
	GroupCalendar_cBirthdayEventName = "生日";
	GroupCalendar_cRoleplayEventName = "角色扮演";

	GroupCalendar_cAQREventName = "安其拉废墟";
	GroupCalendar_cAQTEventName = "安其拉神庙";
	GroupCalendar_cBFDEventName = "黑暗深渊";
	GroupCalendar_cBRDEventName = "黑石深渊";
	GroupCalendar_cUBRSEventName = "黑石塔上层";
	GroupCalendar_cLBRSEventName = "黑石塔";
	GroupCalendar_cBWLEventName = "黑翼之巢";
	GroupCalendar_cDeadminesEventName = "死亡矿坑";
	GroupCalendar_cDMEventName = "厄运之槌";
	GroupCalendar_cGnomerEventName = "诺姆瑞根";
	GroupCalendar_cMaraEventName = "玛拉顿";
	GroupCalendar_cMCEventName = "熔火之心";
	GroupCalendar_cOnyxiaEventName = "奥尼西亚洞穴";
	GroupCalendar_cRFCEventName = "怒焰裂谷";
	GroupCalendar_cRFDEventName = "剃刀高地";
	GroupCalendar_cRFKEventName = "剃刀沼泽";
	GroupCalendar_cSMEventName = "血色修道院";
	GroupCalendar_cScholoEventName = "通灵学院";
	GroupCalendar_cSFKEventName = "影牙城堡";
	GroupCalendar_cStockadesEventName = "监狱";
	GroupCalendar_cStrathEventName = "斯坦索姆";
	GroupCalendar_cSTEventName = "阿塔哈卡神庙";
	GroupCalendar_cUldEventName = "奥达曼";
	GroupCalendar_cWCEventName = "哀嚎洞穴";
	GroupCalendar_cZFEventName = "祖尔法拉克";
	GroupCalendar_cZGEventName = "祖尔格拉布";
	GroupCalendar_cNaxxEventName = "纳克萨玛斯";

	GroupCalendar_cPvPEventName = "综合 PvP";
	GroupCalendar_cABEventName = "阿拉希盆地";
	GroupCalendar_cAVEventName = "奥特蔺克山谷";
	GroupCalendar_cWSGEventName = "战歌峡谷";

	GroupCalendar_cZGResetEventName = "祖尔格拉布 重置";
	GroupCalendar_cMCResetEventName = "熔火之心 重置";
	GroupCalendar_cOnyxiaResetEventName = "奥妮克希亚 重置";
	GroupCalendar_cBWLResetEventName = "黑翼之巢 重置";
	GroupCalendar_cAQRResetEventName = "安其拉废墟 重置";
	GroupCalendar_cAQTResetEventName = "安其拉神庙 重置";
	GroupCalendar_cNaxxResetEventName = "纳克萨玛斯 重置";

	GroupCalendar_cTransmuteCooldownEventName = "转换 就绪";
	GroupCalendar_cSaltShakerCooldownEventName = "Salt Shaker 就绪";
	GroupCalendar_cMoonclothCooldownEventName = "月布 就绪";
	GroupCalendar_cSnowmasterCooldownEventName = "SnowMaster 9000 就绪";

	GroupCalendar_cPersonalEventOwner = "私人";

	GroupCalendar_cRaidInfoMCName = GroupCalendar_cMCEventName;
	GroupCalendar_cRaidInfoOnyxiaName = GroupCalendar_cOnyxiaEventName;
	GroupCalendar_cRaidInfoZGName = GroupCalendar_cZGEventName;
	GroupCalendar_cRaidInfoBWLName = GroupCalendar_cBWLEventName;
	GroupCalendar_cRaidInfoAQRName = GroupCalendar_cAQREventName;
	GroupCalendar_cRaidInfoAQTName = GroupCalendar_cAQTEventName;

	-- Race names

	GroupCalendar_cDwarfRaceName = "矮人";
	GroupCalendar_cGnomeRaceName = "地精";
	GroupCalendar_cHumanRaceName = "人类";
	GroupCalendar_cNightElfRaceName = "夜精灵";
	GroupCalendar_cOrcRaceName = "兽人";
	GroupCalendar_cTaurenRaceName = "牛头人";
	GroupCalendar_cTrollRaceName = "食人妖";
	GroupCalendar_cUndeadRaceName = "不死族";
	GroupCalendar_cBloodElfRaceName = "血精灵";
	GroupCalendar_cDraeneiRaceName = "不死族";

	-- Class names

	GroupCalendar_cDruidClassName = "德鲁伊";
	GroupCalendar_cHunterClassName = "猎人";
	GroupCalendar_cMageClassName = "法师";
	GroupCalendar_cPaladinClassName = "圣骑士";
	GroupCalendar_cPriestClassName = "牧师";
	GroupCalendar_cRogueClassName = "盗贼";
	GroupCalendar_cShamanClassName = "萨满";
	GroupCalendar_cWarlockClassName = "术士";
	GroupCalendar_cWarriorClassName = "战士";

	-- Plural forms of class names

	GroupCalendar_cDruidsClassName = "德鲁伊";
	GroupCalendar_cHuntersClassName = "猎人";
	GroupCalendar_cMagesClassName = "法师";
	GroupCalendar_cPaladinsClassName = "圣骑士";
	GroupCalendar_cPriestsClassName = "牧师";
	GroupCalendar_cRoguesClassName = "盗贼";
	GroupCalendar_cShamansClassName = "萨满";
	GroupCalendar_cWarlocksClassName = "术士";
	GroupCalendar_cWarriorsClassName = "战士";

-- ClassColorNames are the indices for the RAID_CLASS_COLORS array found in FrameXML\Fonts.xml
-- in the English version of WoW these are simply the class names in caps, I don't know if that's
-- true of other languages so I'm putting them here in case they need to be localized

	GroupCalendar_cDruidClassColorName = "DRUID";
	GroupCalendar_cHunterClassColorName = "HUNTER";
	GroupCalendar_cMageClassColorName = "MAGE";
	GroupCalendar_cPaladinClassColorName = "PALADIN";
	GroupCalendar_cPriestClassColorName = "PRIEST";
	GroupCalendar_cRogueClassColorName = "ROGUE";
	GroupCalendar_cShamanClassColorName = "SHAMAN";
	GroupCalendar_cWarlockClassColorName = "WARLOCK";
	GroupCalendar_cWarriorClassColorName = "WARRIOR";

-- Label forms of the class names for the attendance panel.  Usually just the plural
-- form of the name followed by a colon

	GroupCalendar_cDruidsLabel = GroupCalendar_cDruidsClassName..":";
	GroupCalendar_cHuntersLabel = GroupCalendar_cHuntersClassName..":";
	GroupCalendar_cMagesLabel = GroupCalendar_cMagesClassName..":";
	GroupCalendar_cPaladinsLabel = GroupCalendar_cPaladinsClassName..":";
	GroupCalendar_cPriestsLabel = GroupCalendar_cPriestsClassName..":";
	GroupCalendar_cRoguesLabel = GroupCalendar_cRoguesClassName..":";
	GroupCalendar_cShamansLabel = GroupCalendar_cShamansClassName..":";
	GroupCalendar_cWarlocksLabel = GroupCalendar_cWarlocksClassName..":";
	GroupCalendar_cWarriorsLabel = GroupCalendar_cWarriorsClassName..":";

	GroupCalendar_cTimeLabel = "时间:";
	GroupCalendar_cDurationLabel = "需时:";
	GroupCalendar_cEventLabel = "活动:";
	GroupCalendar_cTitleLabel = "标题:";
	GroupCalendar_cLevelsLabel = "等级:";
	GroupCalendar_cLevelRangeSeparator = "至";
	GroupCalendar_cDescriptionLabel = "内容:";
	GroupCalendar_cCommentLabel = "备注:";

	CalendarEditor_cNewEvent = "新活动...";
	CalendarEditor_cEventsTitle = "活动";

	GroupCalendar_cGermanTranslation = "德文翻译由 Silver Hand 的 Palyr 提供";
	GroupCalendar_cFrenchTranslation = "法文翻译由 Dalaran (EU) 的 Kisanth 提供";
	GroupCalendar_cChineseTranslation = "中文翻译由 Royaltia (HK) 的 Aska 提供";

	CalendarEventEditor_cNotAttending = "不出席";
	CalendarEventEditor_cConfirmed = "已确定";
	CalendarEventEditor_cDeclined = "已拒绝";
	CalendarEventEditor_cStandby = "在等候名单";
	CalendarEventEditor_cPending = "悬而未决";
	CalendarEventEditor_cUnknownStatus = "不明 %s";

	GroupCalendar_cChannelNameLabel = "频道名称:";
	GroupCalendar_cPasswordLabel = "密码:";

	GroupCalendar_cTimeRangeFormat = "%s至%s";

	GroupCalendar_cPluralMinutesFormat = "%d分钟";
	GroupCalendar_cSingularHourFormat = "%d小时";
	GroupCalendar_cPluralHourFormat = "%d小时";
	GroupCalendar_cSingularHourPluralMinutes = "%d小时%d分钟";
	GroupCalendar_cPluralHourPluralMinutes = "%d小时%d分钟";

	GroupCalendar_cLongDateFormat = "$year".."年".."$month".."$day".."日";
	GroupCalendar_cShortDateFormat = "$day/$monthNum";
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $year".."年".."$month".."$day".."日";

	GroupCalendar_cNotAttending = "不出席";
	GroupCalendar_cAttending = "出席";
	GroupCalendar_cPendingApproval = "等待审核";
	GroupCalendar_cStandby = "等候中";
	GroupCalendar_Queued = "排队中";
	GroupCalendar_cWhispers = "最近的密语者";

	GroupCalendar_cQuestAttendanceNameFormat = "$name ($level $race)";
	GroupCalendar_cMeetingAttendanceNameFormat = "$name ($level $class)";
	GroupCalendar_cGroupAttendanceNameFormat = "$name ($status)";

	GroupCalendar_cNumAttendeesFormat = "%d 位出席";
	GroupCalendar_cNumPlayersFormat = "%d 位玩家";

	BINDING_HEADER_GROUPCALENDAR_TITLE = "团体行事历";
	BINDING_NAME_GROUPCALENDAR_TOGGLE = "打开/关闭团体行事历";

-- Tradeskill cooldown items

	GroupCalendar_cHerbalismSkillName = "采药";
	GroupCalendar_cAlchemySkillName = "炼金";
	GroupCalendar_cEnchantingSkillName = "附魔";
	GroupCalendar_cLeatherworkingSkillName = "制革";
	GroupCalendar_cSkinningSkillName = "剥皮";
	GroupCalendar_cTailoringSkillName = "裁缝";
	GroupCalendar_cMiningSkillName = "采矿";
	GroupCalendar_cBlacksmithingSkillName = "锻造";
	GroupCalendar_cEngineeringSkillName = "工程学";

	GroupCalendar_cTransmuteMithrilToTruesilver = "转换: 点化秘银";
	GroupCalendar_cTransmuteIronToGold = "转换: 点铁成金";
	GroupCalendar_cTransmuteLifeToEarth = "转换: 生命归土";
	GroupCalendar_cTransmuteWaterToUndeath = "转换: 水转死灵";
	GroupCalendar_cTransmuteWaterToAir = "转换: 点水成气";
	GroupCalendar_cTransmuteUndeathToWater = "转换: 死灵化水";
	GroupCalendar_cTransmuteFireToEarth = "转换: 点火成土";
	GroupCalendar_cTransmuteEarthToLife = "转换: 土转生命";
	GroupCalendar_cTransmuteEarthToWater = "转换: 转土成水";
	GroupCalendar_cTransmuteAirToFire = "转换: 点气成火";
	GroupCalendar_cTransmuteArcanite = "转换: 合成奥金";
	GroupCalendar_cMooncloth = "月布";

	GroupCalendar_cCharactersLabel = "角色:";

	GroupCalendar_cConfirmed = "已接受";
	GroupCalendar_cStandby = "等候中";
	GroupCalendar_cDeclined = "已拒绝";
	GroupCalendar_cRemove = "移除";
	GroupCalendar_cEditPlayer = "修改玩家...";
	GroupCalendar_cInviteNow = "邀请到队伍";
	GroupCalendar_cStatus = "状态";
	GroupCalendar_cAddPlayerEllipses = "加入玩家...";

	GroupCalendar_cAddPlayer = "加入玩家";
	GroupCalendar_cPlayerLevel = "等级:";
	GroupCalendar_cPlayerClassLabel = "职业:";
	GroupCalendar_cPlayerRaceLabel = "种族:";
	GroupCalendar_cPlayerStatusLabel = "状态:";
	GroupCalendar_cRankLabel = "公会阶级:";
	GroupCalendar_cGuildLabel = "公会:";
	GroupCalendar_cSave = "储存";
	GroupCalendar_cLastWhisper = "最近密语者:";
	GroupCalendar_cReplyWhisper = "密语者回覆:";

	GroupCalendar_cUnknown = "未知";
	GroupCalendar_cAutoConfirmationTitle = "自动确认";
	GroupCalendar_cEnableAutoConfirm = "使用自动确认";
	GroupCalendar_cMinLabel = "最低";
	GroupCalendar_cMaxLabel = "最高";

	GroupCalendar_cAddPlayerTitle = "新增...";
	GroupCalendar_cAutoConfirmButtonTitle = "设定...";

	GroupCalendar_cClassLimitDescription = "设定下列每种职业的最低及最高人数。若该职业的人数尚未符合最低要求，您将被自动填补空缺。当人数到达上限时，将会有额外的提示。";

	GroupCalendar_cViewByDate = "检视日期";
	GroupCalendar_cViewByRank = "检视阶级";
	GroupCalendar_cViewByName = "检视名称";
	GroupCalendar_cViewByStatus = "检视状态";
	GroupCalendar_cViewByClassRank = "检视职业阶级";

	GroupCalendar_cMaxPartySizeLabel = "队伍人数上限:";
	GroupCalendar_cMinPartySizeLabel = "队伍人数下限:";
	GroupCalendar_cNoMinimum = "没有下限";
	GroupCalendar_cNoMaximum = "没有上限";
	GroupCalendar_cPartySizeFormat = "%d 位玩家";

	GroupCalendar_cInviteButtonTitle = "邀请已选取的玩家";
	GroupCalendar_cAutoSelectButtonTitle = "选取玩家...";
	GroupCalendar_cAutoSelectWindowTitle = "选取玩家";

	GroupCalendar_cNoSelection = "没有玩家选取";
	GroupCalendar_cSingleSelection = "选取了 1 位玩家";
	GroupCalendar_cMultiSelection = "选取了 %d 位玩家";

	GroupCalendar_cInviteNeedSelectionStatus = "选择准备邀请的玩家";
	GroupCalendar_cInviteReadyStatus = "准备邀请";
	GroupCalendar_cInviteInitialInvitesStatus = "传送首次的邀请";
	GroupCalendar_cInviteAwaitingAcceptanceStatus = "等待首次的邀请回应";
	GroupCalendar_cInviteConvertingToRaidStatus = "转换至团队";
	GroupCalendar_cInviteInvitingStatus = "传送邀请";
	GroupCalendar_cInviteCompleteStatus = "邀请完毕";
	GroupCalendar_cInviteReadyToRefillStatus = "准备填补空缺";
	GroupCalendar_cInviteNoMoreAvailableStatus = "已经没有玩家可以填补队伍";
	GroupCalendar_cRaidFull = "团队已满";

	GroupCalendar_cInviteWhisperFormat = "[团体行事历] 您已经被邀请加入 '%s' 活动。若阁下想加入此活动，请接受此邀请。";
	GroupCalendar_cAlreadyGroupedWhisper = "[团体行事历] 您已经加入了一个队伍。请阁下您在取消您的队伍后，使用 /w 回覆。";
	GroupCalendar_cAlreadyGroupedSysMsg = "(.+) 已经在队伍中";
	GroupCalendar_cInviteDeclinedSysMsg = "(.+) 拒绝了您的队伍邀请";
	GroupCalendar_cNoSuchPlayerSysMsg = "没有一位叫 '(.+)' 的玩家在游戏中";

	GroupCalendar_cJoinedGroupStatus = "已加入";
	GropuCalendar_cInvitedGroupStatus = "已邀请";
	GropuCalendar_cReadyGroupStatus = "就绪";
	GroupCalendar_cGroupedGroupStatus = "在其他队伍";
	GroupCalendar_cStandbyGroupStatus = "等候";
	GroupCalendar_cDeclinedGroupStatus = "拒绝邀请";
	GroupCalendar_cOfflineGroupStatus = "下线";
	GroupCalendar_cLeftGroupStatus = "离开队伍";

	GroupCalendar_cPriorityLabel = "优先权:";
	GroupCalendar_cPriorityDate = "时间";
	GroupCalendar_cPriorityRank = "阶级";

	GroupCalendar_cConfrimDeleteRSVP = "将 %s 从此活动中移除? 除非你手动把他们重新加入，否则他们将无法再参加。";

	GroupCalendar_cConfirmSelfUpdateMsg = "%s";
	GroupCalendar_cConfirmSelfUpdateParamFormat = "有一份关于 $mUserName 的活动新版本可以从 $mSender 取得。您想更新您的资料到这个新版本吗？当您更新任何与您有关的活动，在该活动的邀请及变动过的资讯将会被取消并更新至最新版本";
	GroupCalendar_cConfirmSelfRSVPUpdateParamFormat = "有一份关于 %mUserName 的新出席资讯可以从 $mSender 取得。您想更新您的出席邀请到最新版本吗？若您更新这个资讯，所有未确认的邀请将会被取消并更新至最新版本";
	GroupCalendar_cUpdate = "更新";

	GroupCalendar_cConfirmClearWhispers = "清除所有最近的悄悄话?";
	GroupCalendar_cClear = "清除";

	CalendarDatabases_cTitle = "团体行事历版本资讯";
	CalendarDatabases_cRefresh = "重新整理";
	CalendarDatabases_cRefreshDescription = "要求线上玩家报告他们的版本编号。重新整理版本资讯需时数分钟。即使您把新视窗关闭，更新程序仍然会继续进行。";

	GroupCalendar_cVersionFormat = "团体行事历 v%s";
	GroupCalendar_cShortVersionFormat = "v%s";
	GroupCalendar_cVersionUpdatedFormat = "资讯于 %s %s 更新 (本地时间)";
	GroupCalendar_cVersionUpdatedUnknown = "无法确认版本时间";

	GroupCalendar_cToggleVersionsTitle = "显示玩家版本";
	GroupCalendar_cToggleVersionsDescription = "显示其它玩家正在使用的版本";

	GroupCalendar_cChangesDelayedMessage = "团体行事历: 资料将于网络资讯同步化后变更。在资料同步化完成之前，资料不会传送，";

	GroupCalendar_cConfirmKillMsg = "您确定要将 %s 建立的活动从网络上强制删除?"; 
	GroupCalendar_cKill = "删除";

	GroupCalendar_cNotAnOfficerError = "团体行事历: 只有公会干部成员能执行此动作";
	GroupCalendar_cUserNameExpected = "团体行事历: 要求使用者名称";
	GroupCalendar_cDatabaseNotFoundError = "团体行事历: 找不到 %s 的资料库。";
	GroupCalendar_cCantKillGuildieError = "团体行事历: 无法删除一位在您公会内的玩家";

end
