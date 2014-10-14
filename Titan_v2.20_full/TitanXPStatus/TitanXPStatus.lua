local TitanXPStatus_Value=nil
TITAN_XPSTATUS_FREQUENCY=1.0;

-- Version information
local TitanXPStatusName = "TitanXPStatus";
local TitanXPStatusVersion = "2.9.2";
-- Version notes
-- toggle instead of display restedXP in options

local restedraw;
local restedpercent;

local totalkills = 0;
local avgxp = 0;
local totalxpgained = 0;
local xpgained = 0;
local neededkills = 0;

function TitanPanelXPStatusButton_OnLoad()
	this.registry={
		id="XPStatus",
		menuText=TITAN_XPSTATUS_MENU_TEXT,
		buttonTextFunction="TitanPanelXPStatusButton_GetButtonText",
		tooltipTitle = TITAN_XPSTATUS_TOOLTIP, 
		tooltipTextFunction = "TitanPanelXPStatusButton_GetTooltipText",
		frequency=TITAN_XPSTATUS_FREQUENCY,
		icon = TITAN_XPSTATUS_ICON,
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	}

	this.timer = 0;	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("UPDATE_EXHAUSTION");
	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
end

function TitanPanelXPStatusButton_OnShow()
	TitanPanelXPStatusButton_SetIcon();
end

function TitanPanelXPStatusButton_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") then		
		this.initXP = UnitXP("player");
		this.accumXP = 0;
		this.sessionXP = 0;

	elseif (event == "PLAYER_XP_UPDATE") then
		if (not this.initXP) then
			this.initXP = UnitXP("player");
			this.accumXP = 0;
			this.sessionXP = 0;
		end
		this.sessionXP = UnitXP("player") - this.initXP + this.accumXP;
	elseif (event == "PLAYER_LEVEL_UP") then
		this.accumXP = this.accumXP + UnitXPMax("player") - this.initXP;
		this.initXP = 0;
	end

	if(event=="CHAT_MSG_COMBAT_XP_GAIN") then
--		for mobile_name, xp in string.gfind(arg1, "(.+) dies, you gain (%d+) experience.") do						-- for Korean localization by techys
		for mobile_name, xp in string.gfind(arg1, "(.+)|1이;가; 죽었습니다. (%d+)의 경험치를 획득했습니다.") do	-- by techys

			xpgained = tonumber(xp)
			totalkills = totalkills + 1
			totalxpgained = totalxpgained + xpgained
		end
	end	
	if( (totalkills > 0) and (totalkills~=nil) ) then
			avgxp = floor(totalxpgained / totalkills * 100) / 100;
	end
	if( (avgxp > 0) and (avgxp~=nil) ) then
			neededkills = ( UnitXPMax("player") - UnitXP("player") ) / avgxp;
			neededkills = ceil(neededkills);
	end

	TitanPanelXPStatusButton_StatusBarBGUpdate();
	TitanPanelXPStatusButton_StatusBarUpdate();

	TitanPanelButton_UpdateButton("XPStatus");
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelXPStatusButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);
	local totalXP = UnitXPMax("player");
	local currentXP = UnitXP("player");
	local currentXPPercent = currentXP / totalXP * 100;
	local toLevelXP = totalXP - currentXP;
	local toLevelXPPercent = toLevelXP / totalXP * 100;	
	local sessionXP = button.sessionXP;
	local xpPerHour, xpPerHourText, timeToLevel, timeToLevelText;	
	local sessionTime = TitanUtils_GetSessionTime();
	local levelTime = TitanUtils_GetLevelTime();
	local buttontext = "";
	local restedbuttontext = "";

	if not StatusBar then
		XPStatus:Hide()
	else
		XPStatus:Show()
	end

	local raw=GetXPExhaustion()
	local percent
	if raw then
		percent=floor((raw*100)/UnitXPMax("player"))
	else
		raw=0
		percent=0
	end

	if not Type then
		TitanXPStatus_Value=raw
	else
		TitanXPStatus_Value=percent.."%"
	end

		restedraw = raw;
		restedpercent = percent;

		if (ShowXP == 1) then
			toLevelXPText = toLevelXP;
			toLevelXPPercentText = toLevelXPPercent;

			buttontext = format(TITAN_XPSTATUS_TOLEVEL_XP_BUTTON, toLevelXPText)..
			format(TITAN_XPSTATUS_TOLEVELPERC_XP_BUTTON, toLevelXPPercentText)..
			" ";
			if (ShowRested == 1) then
				restedbuttontext = format(TITAN_XPSTATUS_BUTTON_TEXT_RESTED,TitanUtils_GetHighlightText(TitanXPStatus_Value));
			end

			-- supports turning off labels
			if (ShowRested == 1) then
				return TITAN_XPSTATUS_TOLEVEL_XP_LABEL, buttontext, TITAN_XPSTATUS_BUTTON_TEXT_LABEL, restedbuttontext;
			else
				return TITAN_XPSTATUS_TOLEVEL_XP_LABEL, buttontext;
			end
		else	
			currentXPText = currentXP;
			currentXPPercentText = currentXPPercent;
			totalXPText = totalXP;
		
			buttontext = format(TITAN_XPSTATUS_CURRENT_XP_BUTTON, currentXPText)..
			format(TITAN_XPSTATUS_MAX_XP_BUTTON, totalXPText)..
			format(TITAN_XPSTATUS_CURRENTPERC_XP_BUTTON, currentXPPercentText)..
			" ";
			if (ShowRested == 1) then
				restedbuttontext = format(TITAN_XPSTATUS_BUTTON_TEXT_RESTED,TitanUtils_GetHighlightText(TitanXPStatus_Value));
			end

			-- supports turning off labels
			if (ShowRested == 1) then
				return TITAN_XPSTATUS_CURRENT_XP_LABEL, buttontext, TITAN_XPSTATUS_BUTTON_TEXT_LABEL, restedbuttontext;
			else
				return TITAN_XPSTATUS_CURRENT_XP_LABEL, buttontext;
			end
		end

end

function TitanPanelXPStatusButton_GetTooltipText()

	local xp = { 0, 400, 1300, 2700, 4800, 7600, 11200, 15700, 21100, 27600,
                35200, 44000, 54100, 65500, 78400, 92800, 108800, 126500,
		145900, 167200, 190400, 215600, 242900, 272300, 304000,
		338000, 374400, 413300, 454700, 499000, 546400, 597200,
		651900, 710500, 773300, 840300, 911900, 988000, 1068800,
		1154500, 1245200, 1341000, 1442000, 1548300, 1660100,
		1777500, 1900700, 2029800, 2164900, 2306100, 2453600,
		2607500, 2767900, 2935000, 3108900, 3289700, 3477600,
		3672600, 3874900, 4084700 }

	local totalTime = TitanUtils_GetTotalTime();
	local totalXP = UnitXPMax("player");
	local sessionTime = TitanUtils_GetSessionTime();
	local levelTime = TitanUtils_GetLevelTime();
	local CurrentLevel = UnitLevel("player");
	local XPToCurrentLevel = xp[CurrentLevel];
	local currentXP = UnitXP("player");
	local totallvlXP = currentXP + XPToCurrentLevel;
	local toLevelXP = totalXP - currentXP;
	local currentXPPercent = currentXP / totalXP * 100;
	local toLevelXPPercent = toLevelXP / totalXP * 100;
	local xpPerHourThisLevel = currentXP / levelTime * 3600;
	local xpPerHourThisSession = this.sessionXP / sessionTime * 3600;
	local estTimeToLevelThisLevel = TitanUtils_Ternary((currentXP == 0), -1, toLevelXP / currentXP * levelTime);
	local estTimeToLevelThisSession = TitanUtils_Ternary((this.sessionXP == 0), -1, toLevelXP / this.sessionXP * sessionTime);
	local lvl60XP = 4084700;
	local lvl60XPneeded = lvl60XP - totallvlXP;
	local lvl60XPneededPercent = lvl60XPneeded / lvl60XP * 100;

	
	return ""..
		format(TITAN_XPSTATUS_TOOLTIP_SHIFTCLICK).."\n".."\n"..
		format(TITAN_XPSTATUS_TOTAL_XP, totalXP).."\n".. 
		format(TITAN_XPSTATUS_LEVEL_XP_VALUEPERCENT, currentXP, currentXPPercent).."\n".. 
		format(TITAN_XPSTATUS_TOLEVEL_XP_VALUEPERCENT, toLevelXP, toLevelXPPercent).."\n"..
		format(TITAN_XPSTATUS_SESSION_XP, this.sessionXP).."\n"..
		"\n"..
		format(TITAN_XPSTATUS_LVL60XP, lvl60XPneeded, lvl60XPneededPercent).."\n"..
		"\n"..
		format(TITAN_XPSTATUS_TOOLTIP_RESTED, restedraw, restedpercent).."\n"..
		"\n"..
		format(TITAN_XPSTATUS_AVGXP,avgxp).."\n"..
		format(TITAN_XPSTATUS_TOTALKILLS,totalkills).."\n"..
		format(TITAN_XPSTATUS_NEEDEDKILLS,neededkills).."\n"..
		"\n"..
		format(TITAN_XPSTATUS_TOTAL_TIME_PLAYED, TitanUtils_GetAbbrTimeText(totalTime)).."\n"..
		format(TITAN_XPSTATUS_LEVEL_TIME_PLAYED, TitanUtils_GetAbbrTimeText(levelTime)).."\n"..
		format(TITAN_XPSTATUS_SESSION_TIME_PLAYED, TitanUtils_GetAbbrTimeText(sessionTime)).."\n"..
		"\n"..
		format(TITAN_XPSTATUS_PER_HOUR_LEVEL, xpPerHourThisLevel).."\n"..
		format(TITAN_XPSTATUS_PER_HOUR_SESSION, xpPerHourThisSession).."\n"..
		format(TITAN_XPSTATUS_EST_TIME_TO_LEVEL_LEVEL_RATE, TitanUtils_GetAbbrTimeText(estTimeToLevelThisLevel)).."\n"..
		format(TITAN_XPSTATUS_EST_TIME_TO_LEVEL_SESSION_RATE, TitanUtils_GetAbbrTimeText(estTimeToLevelThisSession));
end

function TitanPanelRightClickMenu_PrepareXPStatusMenu()
	local id="XPStatus"
	local info
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText)

	info={}
	info.text=TITAN_XPSTATUS_MENU_SHOW_RAW
	info.func=function()
		Type=nil
		TitanPanelButton_UpdateButton("XPStatus")
	end
	info.checked=TitanUtils_Toggle(Type)
	UIDropDownMenu_AddButton(info)

	info={}
	info.text=TITAN_XPSTATUS_MENU_SHOW_PERCENT
	info.func=function()
		Type=1
		TitanPanelButton_UpdateButton("XPStatus")
	end
	info.checked=Type
	UIDropDownMenu_AddButton(info)

	info = {};
	info.text = TITAN_XPSTATUS_MENU_SHOWRESTED;
	info.func = TitanPanelXPStatusButton_ShowRested;
	info.checked = TitanUtils_Toggle(ShowRested);
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();

	info = {};
	info.text = TITAN_XPSTATUS_MENU_SHOW_XPHR_THIS_SESSION;
	info.func = TitanPanelXPStatusButton_ShowXP;
	info.checked = ShowXP;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_XPSTATUS_MENU_SHOW_XPHR_THIS_LEVEL;
	info.func = TitanPanelXPStatusButton_ShowXPLevel;
	info.checked = TitanUtils_Toggle(ShowXP);
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();

	info = {};
	info.text = TITAN_XPSTATUS_MENU_SHOW_STATUSBAR;
	info.func = TitanPanelXPStatusButton_ShowStatus;
	info.checked = StatusBar;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_XPSTATUS_MENU_HIDE_STATUSBAR;
	info.func = TitanPanelXPStatusButton_HideStatus;
	info.checked = TitanUtils_Toggle(StatusBar);
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleLabelText("XPStatus");

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_CUSTOMIZE..TITAN_PANEL_MENU_POPUP_IND,id,TITAN_PANEL_MENU_FUNC_CUSTOMIZE)
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,id,TITAN_PANEL_MENU_FUNC_HIDE)
end

function TitanPanelXPStatusButton_ShowXP()
	ShowXP = 1;
	TitanPanelButton_UpdateButton("XPStatus");
end

function TitanPanelXPStatusButton_ShowXPLevel()
	ShowXP = nil;
	TitanPanelButton_UpdateButton("XPStatus");
end

function TitanPanelXPStatusButton_ShowStatus()
	StatusBar = 1;
	TitanPanelButton_UpdateButton("XPStatus");
end

function TitanPanelXPStatusButton_HideStatus()
	StatusBar = nil;
	TitanPanelButton_UpdateButton("XPStatus");
end

function TitanPanelXPStatusButton_ShowRested()
    if ( ShowRested == 1) then
        ShowRested = 0;
    else
        ShowRested = 1;
    end
	TitanPanelButton_UpdateButton("XPStatus");
end

function TitanPanelXPStatusButton_OnClick()
	local totalXP = UnitXPMax("player");
	local currentXP = UnitXP("player");
	local toLevelXP = totalXP - currentXP;
	local currentXPPercent = currentXP / totalXP * 100;
	local toLevelXPPercent = toLevelXP / totalXP * 100;
	local currentpercent;
	local levelpercent;
	local level = UnitLevel("player");
	local nextlevel = level + 1;

	currentpercent=floor(currentXPPercent);
	levelpercent=floor(toLevelXPPercent);

	if (IsShiftKeyDown()) then
		if (not chatFrame) then
	   		chatFrame = DEFAULT_CHAT_FRAME;
		end
		chatType = chatFrame.editBox.chatType;

		if (ShowXP == 1) then
		      if (ChatFrameEditBox:IsVisible()) then
--	      		ChatFrameEditBox:Insert("XPtoLvl "..nextlevel..": "..toLevelXP.." ("..levelpercent.."%) RestedXP: "..restedraw.." ("..restedpercent.."%) AvgXP: "..avgxp);						-- for Korean localizing by techys
	      		ChatFrameEditBox:Insert(nextlevel.."레벨까지 필요한 경험치: "..toLevelXP.." ("..levelpercent.."%) 휴식 경험치: "..restedraw.." ("..restedpercent.."%) 평균 획득 경험치: "..avgxp);	-- for Korean localizing by techys
	      	else
--	        		SendChatMessage("XPtoLvl "..nextlevel..": "..toLevelXP.." ("..levelpercent.."%) RestedXP: "..restedraw.." ("..restedpercent.."%) AvgXP: "..avgxp, chatType);						-- for Korean localizing by techys
	        		SendChatMessage(nextlevel.."레벨까지 필요한 경험치: "..toLevelXP.." ("..levelpercent.."%) 휴식 경험치: "..restedraw.." ("..restedpercent.."%) 평균 획득 경험치: "..avgxp, chatType);	-- for Korean localizing by techys
		      end
		else
		      if (ChatFrameEditBox:IsVisible()) then
--	      		ChatFrameEditBox:Insert("XP/T: "..currentXP.."/"..totalXP.." ("..currentpercent.."%) RestedXP: "..restedraw.." ("..restedpercent.."%) AvgXP: "..avgxp);				-- for Korean localizing by techys
	      		ChatFrameEditBox:Insert("현재/총경험치: "..currentXP.."/"..totalXP.." ("..currentpercent.."%) 휴식 경험치: "..restedraw.." ("..restedpercent.."%) 평균 획득 경험치: "..avgxp);		-- for Korean localizing by techys
	      	else
--	        		SendChatMessage("XP/T: "..currentXP.."/"..totalXP.." ("..currentpercent.."%) RestedXP: "..restedraw.." ("..restedpercent.."%) AvgXP: "..avgxp, chatType);				-- for Korean localizing by techys
	        		SendChatMessage("현재/총경험치: "..currentXP.."/"..totalXP.." ("..currentpercent.."%) 휴식 경험치: "..restedraw.." ("..restedpercent.."%) 평균 획득 경험치: "..avgxp, chatType);		-- for Korean localizing by techys
		      end
		end
	end
end

function TitanPanelXPStatusButton_StatusBarBGUpdate()
	local maxValue = UnitXPMax("player");

	XPStatusBG:SetMinMaxValues(0, maxValue);
	XPStatusBG:SetValue(maxValue);
end

function TitanPanelXPStatusButton_StatusBarUpdate()
	local currentValue = UnitXP("player");
	local maxValue = UnitXPMax("player");

	XPStatus:SetMinMaxValues(0, maxValue);
	XPStatus:SetValue(currentValue);
end