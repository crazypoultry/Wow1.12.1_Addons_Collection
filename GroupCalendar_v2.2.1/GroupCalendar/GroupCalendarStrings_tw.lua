-- File containing localized strings
-- Translation : zhTW - AndyAska.com (20060626)

if GetLocale() == "zhTW" then
	-- Chinese Traditional localized variables

	GroupCalendar_cTitle = "團體行事曆 v%s";

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

	GroupCalendar_cSelfWillAttend = "%s會出席";

	GroupCalendar_cMonthNames = {"1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"};
	GroupCalendar_cDayOfWeekNames = {GroupCalendar_cSunday, GroupCalendar_cMonday, GroupCalendar_cTuesday, GroupCalendar_cWednesday, GroupCalendar_cThursday, GroupCalendar_cFriday, GroupCalendar_cSaturday};

	GroupCalendar_cLoadMessage = "團體行事曆已載入。使用 /calendar 來瀏覽行事曆";
	GroupCalendar_cInitializingGuilded = "團體行事曆: 替已有公會的玩家進行初始化設定";
	GroupCalendar_cInitializingUnguilded = "團體行事曆: 指沒有公會的玩家進行初始化設定";
	GroupCalendar_cLocalTimeNote = "(%s 本地)";

	GroupCalendar_cOptions = "設定...";

	GroupCalendar_cCalendar = "行事曆";
	GroupCalendar_cChannel = "頻道";
	GroupCalendar_cTrust = "信任";
	GroupCalendar_cAbout = "關於";

	GroupCalendar_cUseServerDateTime = "使用伺服器日期與時間";
	GroupCalendar_cUseServerDateTimeDescription = "啟動此功能將會以伺服器的日期與時間來顯示活動資訊，若關閉此功能則會以您的電腦日期及時間來顯示。";

	GroupCalendar_cChannelConfigTitle = "資料頻道設定";
	GroupCalendar_cChannelConfigDescription = "行事曆頻道用來傳送及接收玩家之間的活動，所有在頻道的人都能瀏灠您的活動。若想替您的行事曆保密就必須設定密碼。";
	GroupCalendar_cAutoChannelConfig = "自動頻道設定";
	GroupCalendar_cManualChannelConfig = "手動頻道設定";
	GroupCalendar_cStoreAutoConfig = "自動儲存設定到玩家訊息";
	GroupCalendar_cAutoConfigPlayer = "玩家名稱:";
	GroupCalendar_cApplyChannelChanges = "套用";
	GroupCalendar_cAutoConfigTipTitle = "自動頻道設定";
	GroupCalendar_cAutoConfigTipDescription = "自動從公會資訊中取得頻道資訊。您必須是公會成員，此功能必須在公會幹部設定後方可使用。";
	GroupCalendar_cManualConfigTipDescription = "允許您手動輸入頻道及密碼資料。";
	GroupCalendar_cStoreAutoConfigTipDescription = "允許公會幹部將頻道設置資訊存到指定成員的玩家資訊中。";
	GroupCalendar_cAutoConfigPlayerTipDescription = "玩家在公會資訊中包含頻道設置資料。";
	GroupCalendar_cChannelNameTipTitle = "頻道名稱";
	GroupCalendar_cChannelNameTipDescription = "頻道名稱用來傳送及接收其他玩家的活動資料。";
	GroupCalendar_cConnectChannel = "連線";
	GroupCalendar_cDisconnectChannel = "中斷連線";
	GroupCalendar_cChannelStatus =
	{
		Starting = {mText = "狀態: 啟動中...", mColor = {r = 1, g = 1, b = 0.3}},
		Synching = {mText = "狀態: 與網絡同步中", mColor = {r = 0.3, g = 1, b = 0.3}},
		Connected = {mText = "狀態: 資料頻道已連接", mColor = {r = 0.3, g = 1, b = 0.3}},
		Disconnected = {mText = "狀態: 資料頻道尚未連接", mColor = {r = 1, g = 0.5, b = 0.2}},
		Initializing = {mText = "狀態: 初始化資料頻道", mColor = {r = 1, g = 1, b = 0.3}},
		Error = {mText = "錯誤: %s", mColor = {r = 1, g = 0.2, b = 0.4}},
	};

	GroupCalendar_cConnected = "已連線";
	GroupCalendar_cDisconnected = "已中斷連線";
	GroupCalendar_cTooManyChannels = "您已經到達頻道的加入上限";
	GroupCalendar_cJoinChannelFailed = "不明原因引致無法加入頻道";
	GroupCalendar_cWrongPassword = "密碼錯誤";
	GroupCalendar_cAutoConfigNotFound = "找不到公會設置資料";
	GroupCalendar_cErrorAccessingNote = "無法接收設置資料";

	GroupCalendar_cTrustConfigTitle = "信任設定";
	GroupCalendar_cTrustConfigDescription = "允許您控制能夠檢視活動的人。行事曆本身並無限制誰能夠檢視活動，設定密碼就能有效限制能夠檢視行事曆的人。";
	GroupCalendar_cTrustGroupLabel = "信任:";
	GroupCalendar_cEvent = "活動";
	GroupCalendar_cAttendance = "出席";

	GroupCalendar_cAboutTitle = "關於團體行事曆";
	GroupCalendar_cTitleVersion = "團體行事曆 v"..gGroupCalendar_VersionString;
	GroupCalendar_cAuthor = "由 Thunderlord 的 Baylord 設計及編寫";
	GroupCalendar_cTestersTitle = "測試人員";

	GroupCalendar_cSpecialThanksTitle = "特別鳴謝";

	GroupCalendar_cGuildURL = "http://www.andyaska.com";
	GroupCalendar_cRebuildDatabase = "重新建立資料庫";
	GroupCalendar_cRebuildDatabaseDescription = "重新建立活動資料庫給您的角色。有助解決無法觀看所有活動的問題，但是此舉動可能有機會會遺失出席回覆的資訊。";

	GroupCalendar_cTrustGroups =
	{
		"所有存取資料頻道的玩家",
		"公會成員",
		"僅限下列名單列出的玩家"
	};

	GroupCalendar_cTrustAnyone = "信任所有存取資料頻道的玩家";
	GroupCalendar_cTrustGuildies = "信任我的公會成員";
	GroupCalendar_cTrustMinRank = "最低階級需求:";
	GroupCalendar_cTrustNobody = "只信任下列名單中列出的玩家";
	GroupCalendar_cTrustedPlayers = "信任的玩家";
	GroupCalendar_cExcludedPlayers = "例外的玩家"
	GroupCalendar_cPlayerName = "玩家名稱:";
	GroupCalendar_cAddTrusted = "信任";
	GroupCalendar_cRemoveTrusted = "移除";
	GroupCalendar_cAddExcluded = "例外";

	CalendarEventViewer_cTitle = "檢示活動";
	CalendarEventViewer_cDone = "完成";

	CalendarEventViewer_cLevelRangeFormat = "等級 %i 至 %i";
	CalendarEventViewer_cMinLevelFormat = "等級 %i 或以上";
	CalendarEventViewer_cMaxLevelFormat = "等級 %i 或以下";
	CalendarEventViewer_cAllLevels = "所有等級";
	CalendarEventViewer_cSingleLevel = "只限等級 %i";

	CalendarEventViewer_cYes = "嗯! 我會出席此活動";
	CalendarEventViewer_cNo = "不. 我不會出席此活動";

	CalendarEventViewer_cResponseMessage =
	{
		"狀態: 沒有回應",
		"狀態: 等候確認",
		"狀態: 已確認 - 已接受",
		"狀態: 已確認 - 等候中",
		"狀態: 已確認 - 不出席",
		"狀態: 被禁止",
	};

	CalendarEventEditorFrame_cTitle = "新增/修改活動";
	CalendarEventEditor_cDone = "完成";
	CalendarEventEditor_cDelete = "刪除";
	CalendarEventEditor_cGroupTabTitle = "隊伍";

	CalendarEventEditor_cConfirmDeleteMsg = "刪除 \"%s\"?";

	-- Event names

	GroupCalendar_cGeneralEventGroup = "綜合";
	GroupCalendar_cRaidEventGroup = "團隊";
	GroupCalendar_cDungeonEventGroup = "地下城";
	GroupCalendar_cBattlegroundEventGroup = "戰場";

	GroupCalendar_cMeetingEventName = "聚會";
	GroupCalendar_cBirthdayEventName = "生日";
	GroupCalendar_cRoleplayEventName = "角色扮演";

	GroupCalendar_cAQREventName = "安其拉廢墟";
	GroupCalendar_cAQTEventName = "安其拉神廟";
	GroupCalendar_cBFDEventName = "黑暗深淵";
	GroupCalendar_cBRDEventName = "黑石深淵";
	GroupCalendar_cUBRSEventName = "黑石塔上層";
	GroupCalendar_cLBRSEventName = "黑石塔";
	GroupCalendar_cBWLEventName = "黑翼之巢";
	GroupCalendar_cDeadminesEventName = "死亡礦坑";
	GroupCalendar_cDMEventName = "厄運之槌";
	GroupCalendar_cGnomerEventName = "諾姆瑞根";
	GroupCalendar_cMaraEventName = "瑪拉頓";
	GroupCalendar_cMCEventName = "熔火之心";
	GroupCalendar_cOnyxiaEventName = "奧尼西亞洞穴";
	GroupCalendar_cRFCEventName = "怒焰裂谷";
	GroupCalendar_cRFDEventName = "剃刀高地";
	GroupCalendar_cRFKEventName = "剃刀沼澤";
	GroupCalendar_cSMEventName = "血色修道院";
	GroupCalendar_cScholoEventName = "通靈學院";
	GroupCalendar_cSFKEventName = "影牙城堡";
	GroupCalendar_cStockadesEventName = "監獄";
	GroupCalendar_cStrathEventName = "斯坦索姆";
	GroupCalendar_cSTEventName = "阿塔哈卡神廟";
	GroupCalendar_cUldEventName = "奧達曼";
	GroupCalendar_cWCEventName = "哀嚎洞穴";
	GroupCalendar_cZFEventName = "祖爾法拉克";
	GroupCalendar_cZGEventName = "祖爾格拉布";
	GroupCalendar_cNaxxEventName = "納克薩瑪斯";

	GroupCalendar_cPvPEventName = "綜合 PvP";
	GroupCalendar_cABEventName = "阿拉希盆地";
	GroupCalendar_cAVEventName = "奧特藺克山谷";
	GroupCalendar_cWSGEventName = "戰歌峽谷";

	GroupCalendar_cZGResetEventName = "祖爾格拉布 重置";
	GroupCalendar_cMCResetEventName = "熔火之心 重置";
	GroupCalendar_cOnyxiaResetEventName = "奧妮克希亞 重置";
	GroupCalendar_cBWLResetEventName = "黑翼之巢 重置";
	GroupCalendar_cAQRResetEventName = "安其拉廢墟 重置";
	GroupCalendar_cAQTResetEventName = "安其拉神廟 重置";
	GroupCalendar_cNaxxResetEventName = "納克薩瑪斯 重置";

	GroupCalendar_cTransmuteCooldownEventName = "轉換 就緒";
	GroupCalendar_cSaltShakerCooldownEventName = "Salt Shaker 就緒";
	GroupCalendar_cMoonclothCooldownEventName = "月布 就緒";
	GroupCalendar_cSnowmasterCooldownEventName = "SnowMaster 9000 就緒";

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
	GroupCalendar_cHumanRaceName = "人類";
	GroupCalendar_cNightElfRaceName = "夜精靈";
	GroupCalendar_cOrcRaceName = "獸人";
	GroupCalendar_cTaurenRaceName = "牛頭人";
	GroupCalendar_cTrollRaceName = "食人妖";
	GroupCalendar_cUndeadRaceName = "不死族";
	GroupCalendar_cBloodElfRaceName = "血精靈";
	GroupCalendar_cDraeneiRaceName = "不死族";

	-- Class names

	GroupCalendar_cDruidClassName = "德魯伊";
	GroupCalendar_cHunterClassName = "獵人";
	GroupCalendar_cMageClassName = "法師";
	GroupCalendar_cPaladinClassName = "聖騎士";
	GroupCalendar_cPriestClassName = "牧師";
	GroupCalendar_cRogueClassName = "盜賊";
	GroupCalendar_cShamanClassName = "薩滿";
	GroupCalendar_cWarlockClassName = "術士";
	GroupCalendar_cWarriorClassName = "戰士";

	-- Plural forms of class names

	GroupCalendar_cDruidsClassName = "德魯伊";
	GroupCalendar_cHuntersClassName = "獵人";
	GroupCalendar_cMagesClassName = "法師";
	GroupCalendar_cPaladinsClassName = "聖騎士";
	GroupCalendar_cPriestsClassName = "牧師";
	GroupCalendar_cRoguesClassName = "盜賊";
	GroupCalendar_cShamansClassName = "薩滿";
	GroupCalendar_cWarlocksClassName = "術士";
	GroupCalendar_cWarriorsClassName = "戰士";

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

	GroupCalendar_cTimeLabel = "時間:";
	GroupCalendar_cDurationLabel = "需時:";
	GroupCalendar_cEventLabel = "活動:";
	GroupCalendar_cTitleLabel = "標題:";
	GroupCalendar_cLevelsLabel = "等級:";
	GroupCalendar_cLevelRangeSeparator = "至";
	GroupCalendar_cDescriptionLabel = "內容:";
	GroupCalendar_cCommentLabel = "備註:";

	CalendarEditor_cNewEvent = "新活動...";
	CalendarEditor_cEventsTitle = "活動";

	GroupCalendar_cGermanTranslation = "德文翻譯由 Silver Hand 的 Palyr 提供";
	GroupCalendar_cFrenchTranslation = "法文翻譯由 Dalaran (EU) 的 Kisanth 提供";
	GroupCalendar_cChineseTranslation = "中文翻譯由 Royaltia (HK) 的 Aska 提供";

	CalendarEventEditor_cNotAttending = "不出席";
	CalendarEventEditor_cConfirmed = "已確定";
	CalendarEventEditor_cDeclined = "已拒絕";
	CalendarEventEditor_cStandby = "在等候名單";
	CalendarEventEditor_cPending = "懸而未決";
	CalendarEventEditor_cUnknownStatus = "不明 %s";

	GroupCalendar_cChannelNameLabel = "頻道名稱:";
	GroupCalendar_cPasswordLabel = "密碼:";

	GroupCalendar_cTimeRangeFormat = "%s至%s";

	GroupCalendar_cPluralMinutesFormat = "%d分鐘";
	GroupCalendar_cSingularHourFormat = "%d小時";
	GroupCalendar_cPluralHourFormat = "%d小時";
	GroupCalendar_cSingularHourPluralMinutes = "%d小時%d分鐘";
	GroupCalendar_cPluralHourPluralMinutes = "%d小時%d分鐘";

	GroupCalendar_cLongDateFormat = "$year".."年".."$month".."$day".."日";
	GroupCalendar_cShortDateFormat = "$day/$monthNum";
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $year".."年".."$month".."$day".."日";

	GroupCalendar_cNotAttending = "不出席";
	GroupCalendar_cAttending = "出席";
	GroupCalendar_cPendingApproval = "等待審核";
	GroupCalendar_cStandby = "等候中";
	GroupCalendar_Queued = "排隊中";
	GroupCalendar_cWhispers = "最近的密語者";

	GroupCalendar_cQuestAttendanceNameFormat = "$name ($level $race)";
	GroupCalendar_cMeetingAttendanceNameFormat = "$name ($level $class)";
	GroupCalendar_cGroupAttendanceNameFormat = "$name ($status)";

	GroupCalendar_cNumAttendeesFormat = "%d 位出席";
	GroupCalendar_cNumPlayersFormat = "%d 位玩家";

	BINDING_HEADER_GROUPCALENDAR_TITLE = "團體行事曆";
	BINDING_NAME_GROUPCALENDAR_TOGGLE = "打開/關閉團體行事曆";

-- Tradeskill cooldown items

	GroupCalendar_cHerbalismSkillName = "採藥";
	GroupCalendar_cAlchemySkillName = "煉金";
	GroupCalendar_cEnchantingSkillName = "附魔";
	GroupCalendar_cLeatherworkingSkillName = "製革";
	GroupCalendar_cSkinningSkillName = "剝皮";
	GroupCalendar_cTailoringSkillName = "裁縫";
	GroupCalendar_cMiningSkillName = "採礦";
	GroupCalendar_cBlacksmithingSkillName = "鍛造";
	GroupCalendar_cEngineeringSkillName = "工程學";

	GroupCalendar_cTransmuteMithrilToTruesilver = "轉換: 點化秘銀";
	GroupCalendar_cTransmuteIronToGold = "轉換: 點鐵成金";
	GroupCalendar_cTransmuteLifeToEarth = "轉換: 生命歸土";
	GroupCalendar_cTransmuteWaterToUndeath = "轉換: 水轉死靈";
	GroupCalendar_cTransmuteWaterToAir = "轉換: 點水成氣";
	GroupCalendar_cTransmuteUndeathToWater = "轉換: 死靈化水";
	GroupCalendar_cTransmuteFireToEarth = "轉換: 點火成土";
	GroupCalendar_cTransmuteEarthToLife = "轉換: 土轉生命";
	GroupCalendar_cTransmuteEarthToWater = "轉換: 轉土成水";
	GroupCalendar_cTransmuteAirToFire = "轉換: 點氣成火";
	GroupCalendar_cTransmuteArcanite = "轉換: 合成奧金";
	GroupCalendar_cMooncloth = "月布";

	GroupCalendar_cCharactersLabel = "角色:";

	GroupCalendar_cConfirmed = "已接受";
	GroupCalendar_cStandby = "等候中";
	GroupCalendar_cDeclined = "已拒絕";
	GroupCalendar_cRemove = "移除";
	GroupCalendar_cEditPlayer = "修改玩家...";
	GroupCalendar_cInviteNow = "邀請到隊伍";
	GroupCalendar_cStatus = "狀態";
	GroupCalendar_cAddPlayerEllipses = "加入玩家...";

	GroupCalendar_cAddPlayer = "加入玩家";
	GroupCalendar_cPlayerLevel = "等級:";
	GroupCalendar_cPlayerClassLabel = "職業:";
	GroupCalendar_cPlayerRaceLabel = "種族:";
	GroupCalendar_cPlayerStatusLabel = "狀態:";
	GroupCalendar_cRankLabel = "公會階級:";
	GroupCalendar_cGuildLabel = "公會:";
	GroupCalendar_cSave = "儲存";
	GroupCalendar_cLastWhisper = "最近密語者:";
	GroupCalendar_cReplyWhisper = "密語者回覆:";

	GroupCalendar_cUnknown = "未知";
	GroupCalendar_cAutoConfirmationTitle = "自動確認";
	GroupCalendar_cEnableAutoConfirm = "使用自動確認";
	GroupCalendar_cMinLabel = "最低";
	GroupCalendar_cMaxLabel = "最高";

	GroupCalendar_cAddPlayerTitle = "新增...";
	GroupCalendar_cAutoConfirmButtonTitle = "設定...";

	GroupCalendar_cClassLimitDescription = "設定下列每種職業的最低及最高人數。若該職業的人數尚未符合最低要求，您將被自動填補空缺。當人數到達上限時，將會有額外的提示。";

	GroupCalendar_cViewByDate = "檢視日期";
	GroupCalendar_cViewByRank = "檢視階級";
	GroupCalendar_cViewByName = "檢視名稱";
	GroupCalendar_cViewByStatus = "檢視狀態";
	GroupCalendar_cViewByClassRank = "檢視職業階級";

	GroupCalendar_cMaxPartySizeLabel = "隊伍人數上限:";
	GroupCalendar_cMinPartySizeLabel = "隊伍人數下限:";
	GroupCalendar_cNoMinimum = "沒有下限";
	GroupCalendar_cNoMaximum = "沒有上限";
	GroupCalendar_cPartySizeFormat = "%d 位玩家";

	GroupCalendar_cInviteButtonTitle = "邀請已選取的玩家";
	GroupCalendar_cAutoSelectButtonTitle = "選取玩家...";
	GroupCalendar_cAutoSelectWindowTitle = "選取玩家";

	GroupCalendar_cNoSelection = "沒有玩家選取";
	GroupCalendar_cSingleSelection = "選取了 1 位玩家";
	GroupCalendar_cMultiSelection = "選取了 %d 位玩家";

	GroupCalendar_cInviteNeedSelectionStatus = "選擇準備邀請的玩家";
	GroupCalendar_cInviteReadyStatus = "準備邀請";
	GroupCalendar_cInviteInitialInvitesStatus = "傳送首次的邀請";
	GroupCalendar_cInviteAwaitingAcceptanceStatus = "等待首次的邀請回應";
	GroupCalendar_cInviteConvertingToRaidStatus = "轉換至團隊";
	GroupCalendar_cInviteInvitingStatus = "傳送邀請";
	GroupCalendar_cInviteCompleteStatus = "邀請完畢";
	GroupCalendar_cInviteReadyToRefillStatus = "準備填補空缺";
	GroupCalendar_cInviteNoMoreAvailableStatus = "已經沒有玩家可以填補隊伍";
	GroupCalendar_cRaidFull = "團隊已滿";

	GroupCalendar_cInviteWhisperFormat = "[團體行事曆] 您已經被邀請加入 '%s' 活動。若閣下想加入此活動，請接受此邀請。";
	GroupCalendar_cAlreadyGroupedWhisper = "[團體行事曆] 您已經加入了一個隊伍。請閣下您在取消您的隊伍後，使用 /w 回覆。";
	GroupCalendar_cAlreadyGroupedSysMsg = "(.+) 已經在隊伍中";
	GroupCalendar_cInviteDeclinedSysMsg = "(.+) 拒絕了您的隊伍邀請";
	GroupCalendar_cNoSuchPlayerSysMsg = "沒有一位叫 '(.+)' 的玩家在遊戲中";

	GroupCalendar_cJoinedGroupStatus = "已加入";
	GropuCalendar_cInvitedGroupStatus = "已邀請";
	GropuCalendar_cReadyGroupStatus = "就緒";
	GroupCalendar_cGroupedGroupStatus = "在其他隊伍";
	GroupCalendar_cStandbyGroupStatus = "等候";
	GroupCalendar_cDeclinedGroupStatus = "拒絕邀請";
	GroupCalendar_cOfflineGroupStatus = "下線";
	GroupCalendar_cLeftGroupStatus = "離開隊伍";

	GroupCalendar_cPriorityLabel = "優先權:";
	GroupCalendar_cPriorityDate = "時間";
	GroupCalendar_cPriorityRank = "階級";

	GroupCalendar_cConfrimDeleteRSVP = "將 %s 從此活動中移除? 除非你手動把他們重新加入，否則他們將無法再參加。";

	GroupCalendar_cConfirmSelfUpdateMsg = "%s";
	GroupCalendar_cConfirmSelfUpdateParamFormat = "有一份關於 $mUserName 的活動新版本可以從 $mSender 取得。您想更新您的資料到這個新版本嗎？當您更新任何與您有關的活動，在該活動的邀請及變動過的資訊將會被取消並更新至最新版本";
	GroupCalendar_cConfirmSelfRSVPUpdateParamFormat = "有一份關於 %mUserName 的新出席資訊可以從 $mSender 取得。您想更新您的出席邀請到最新版本嗎？若您更新這個資訊，所有未確認的邀請將會被取消並更新至最新版本";
	GroupCalendar_cUpdate = "更新";

	GroupCalendar_cConfirmClearWhispers = "清除所有最近的悄悄話?";
	GroupCalendar_cClear = "清除";

	CalendarDatabases_cTitle = "團體行事曆版本資訊";
	CalendarDatabases_cRefresh = "重新整理";
	CalendarDatabases_cRefreshDescription = "要求線上玩家報告他們的版本編號。重新整理版本資訊需時數分鐘。即使您把新視窗關閉，更新程序仍然會繼續進行。";

	GroupCalendar_cVersionFormat = "團體行事曆 v%s";
	GroupCalendar_cShortVersionFormat = "v%s";
	GroupCalendar_cVersionUpdatedFormat = "資訊於 %s %s 更新 (本地時間)";
	GroupCalendar_cVersionUpdatedUnknown = "無法確認版本時間";

	GroupCalendar_cToggleVersionsTitle = "顯示玩家版本";
	GroupCalendar_cToggleVersionsDescription = "顯示其它玩家正在使用的版本";

	GroupCalendar_cChangesDelayedMessage = "團體行事曆: 資料將於網絡資訊同步化後變更。在資料同步化完成之前，資料不會傳送，";

	GroupCalendar_cConfirmKillMsg = "您確定要將 %s 建立的活動從網絡上強制刪除?"; 
	GroupCalendar_cKill = "刪除";

	GroupCalendar_cNotAnOfficerError = "團體行事曆: 只有公會幹部成員能執行此動作";
	GroupCalendar_cUserNameExpected = "團體行事曆: 要求使用者名稱";
	GroupCalendar_cDatabaseNotFoundError = "團體行事曆: 找不到 %s 的資料庫。";
	GroupCalendar_cCantKillGuildieError = "團體行事曆: 無法刪除一位在您公會內的玩家";

end
