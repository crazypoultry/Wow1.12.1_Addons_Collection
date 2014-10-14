--Created by Tehu of Garona
--Updated by joev@jarhedz.com for Titan Panel 1.24
--
--
--Credit goes out to the creators of AvgXP and AvgXPPlus for the AvgXP functions
--Credit goes out to the creator of TotalXP for the XP needed until 60 function

TITAN_XPBAR_ID="XPBar"
TITAN_XPBAR_FREQUENCY=1
local restxp=nil
PLAYER_ENTERING_WORLD=0
TITAN_XPBAR_BUTTON_TEXT_XP="XP: %s"
TITAN_XPBAR_BUTTON_TEXT_NIL="%s"
TITAN_XPBAR_BUTTON_TEXT_NEEDED="%s XP"
TITAN_XPBAR_BUTTON_TEXT_NPCT="%s"
TITAN_XPBAR_MENU_TEXT="XPBar"
TITAN_XPBAR_MENU_SHOW_STATUS="Show XP Statusbar"
TITAN_XPBAR_MENU_HIDE_STATUS="Hide XP Statusbar"
TITAN_XPBAR_TOOLTIP_XP="Current XP: %s"
TITAN_XPBAR_TOOLTIP_LEV="Level XP: %s"
TITAN_XPBAR_TOOLTIP_REST="Rested XP: %s"
TITAN_XPBAR_TOOLTIP_NEED="XP Until Next Level: %s"
TITAN_XPBAR_TOOLTIP_PERCENT="(%s)"
TITAN_XPBAR_TOOLTIP="Experience Tooltip"
TITAN_XPBAR_TOOLTIP_CURRLEV="Currently Level: %s"
TITAN_XPBAR_TOOLTIP_XPTO60="%s XP Remaining Until 60"
TITAN_XPBAR_TOOLTIP_XPSOFAR="%s XP Gained Since Level 1"
TITAN_XPBAR_TOOLTIP_XPTO60PCT="%s"
TITAN_XPBAR_TOOLTIP_XPSOFARPCT="%s"
TITAN_XPBAR_TOTAL_TIME_PLAYED = "Total Time Played: "..HIGHLIGHT_FONT_COLOR_CODE.."%s"..FONT_COLOR_CODE_CLOSE;
TITAN_XPBAR_LEVEL_TIME_PLAYED = "Time Played This Level: "..HIGHLIGHT_FONT_COLOR_CODE.."%s"..FONT_COLOR_CODE_CLOSE;
TITAN_XPBAR_SESSION_TIME_PLAYED = "Time Played This Session: "..HIGHLIGHT_FONT_COLOR_CODE.."%s"..FONT_COLOR_CODE_CLOSE;
TITAN_XPBAR_SESSION_XP = "XP Gained This Session: "..GREEN_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
TITAN_XPBAR_PER_HOUR_LEVEL = "XP Per Hour This Level: "..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
TITAN_XPBAR_PER_HOUR_SESSION = "XP Per Hour This Session: "..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
TITAN_XPBAR_EST_TIME_TO_LEVEL_LEVEL_RATE = "Time To Level At This Level's Rate: "..HIGHLIGHT_FONT_COLOR_CODE.."%s"..FONT_COLOR_CODE_CLOSE;
TITAN_XPBAR_EST_TIME_TO_LEVEL_SESSION_RATE = "Time To Level At This Session's Rate: "..HIGHLIGHT_FONT_COLOR_CODE.."%s"..FONT_COLOR_CODE_CLOSE;

TITAN_XPBAR_TOTAL_KILLS="Total Kills This Session: %s"
TITAN_XPBAR_TOTAL_NKILLS="Total Kills Needed To Level: %s"
TITAN_XPBAR_AVGXP="Average XP Gained Per Kill: %s"
TITAN_XPBAR_MENU_SHOW_TEXT="Show Average XP Text"

TITAN_XPBAR_NKILLS=" Needed Kills: %s"
TITAN_XPBAR_KILLS=" Kills: %s"
TITAN_XPBAR_AVGXPTEXT="AVG XP: %s"

TITAN_XPBAR_MENU_SHOWCURR="Display Current Level Info"
TITAN_XPBAR_MENU_SHOWNEXT="Display XP Needed Until Next Level"
TITAN_XPBAR_MENU_CHAT="Enable Chat Output"
TITAN_XPBAR_MENU_ENABLESHIFT="Enable Shift+Click Output"

LBLUE_FONT_COLOR="|cff55A9FF"


function TitanPanelXPBarButton_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("UPDATE_EXHAUSTION")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_LEVEL_UP")
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this.registry={
		id=TITAN_XPBAR_ID,
		menuText = TITAN_XPBAR_MENU_TEXT,
		buttonTextFunction="TitanPanelXPBarButton_GetButtonText",
		tooltipTitle = TITAN_XPBAR_TOOLTIP,
		tooltipTextFunction = "TitanPanelXPBarButton_GetTooltipText", 
        savedVariables = {
            ShowStatusBarText = 1,
            ShowChat = nil,
            XPFormat = 1,
            StatusBar = 1,
            EnableShift = nil,
        }
        
	}

	totalkilled=0
	avgxp=0
	totalxpgained=0
	lastxpgained=0
	numleft=0 
end

function TitanPanelXPBarButton_OnEvent(event)
	local rxp,curr,max,needed,currpcent,needpcent,currlev,nextlev=TitanPanelXPBarButton_GetXPBarInfo()
    TitanPanelButton_UpdateButton(TITAN_XPBAR_ID)
	Statusbar_Update()
	
    if (not TitanGetVar(TITAN_XPBAR_ID, "ShowChat")) then
		if (event == "PLAYER_XP_UPDATE") then
		DEFAULT_CHAT_FRAME:AddMessage(LBLUE_FONT_COLOR..curr.."/"..max.." XP ("..needpcent..") to go"..FONT_COLOR_CODE_CLOSE)
		DEFAULT_CHAT_FRAME:AddMessage(LBLUE_FONT_COLOR..needed.." XP Until Level "..nextlev..FONT_COLOR_CODE_CLOSE)
		end
	end
	
	if (event == "PLAYER_ENTERING_WORLD") then
		if (PLAYER_ENTERING_WORLD == 0) then		
		this.initXP = UnitXP("player");
		this.accumXP = 0;
		this.sessionXP = 0;
		PLAYER_ENTERING_WORLD = 1
		end
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
	for mobile_name, xp in string.gfind(arg1, "(.+) dies, you gain (%d+) experience.") do
		lastxpgained = tonumber(xp)
		totalkilled = totalkilled + 1
		totalxpgained = totalxpgained + lastxpgained
	end
	end
		
			


	if( (totalkilled > 0) and (totalkilled~=nil) ) then
			avgxp = floor(totalxpgained / totalkilled * 100) / 100;
	end


	if( (avgxp > 0) and (avgxp~=nil) ) then
			numleft = ( UnitXPMax("player") - UnitXP("player") ) / avgxp;
			numleft = ceil(numleft);
	end
end

function TitanPanelXPBarButton_GetButtonText(id)
	local rxp,curr,max,needed,currpcent,needpcent,currlev,nextlev=TitanPanelXPBarButton_GetXPBarInfo()
	local button, id = TitanUtils_GetButton(id, true);
	if (rxp == nil) then
		rxp=0
	else
		rxp=rxp
	end
	
	
    if (TitanGetVar(TITAN_XPBAR_ID, "StatusBar") == 1) then
			XPStatus:Hide()
    end
    
    if (TitanGetVar(TITAN_XPBAR_ID, "StatusBar") == nil) then
		    XPStatus:Show()
	end

	
    if (TitanGetVar(TITAN_XPBAR_ID, "ShowStatusBarText") == nil) then
		
	end

    if (TitanGetVar(TITAN_XPBAR_ID, "XPFormat") == 1) then
	
        if (TitanGetVar(TITAN_XPBAR_ID, "ShowStatusBarText") == nil) then
            if (TitanGetVar(TITAN_XPBAR_ID, "StatusBar") == nil) then
			

			return
			"\n".."\n".."\n"..
			format(TITAN_XPBAR_BUTTON_TEXT_XP,TitanUtils_GetHighlightText(curr)).."/"..
			format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(max)).." + ("..
			format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(rxp)).." Rested)"..
			"\n".."\n".."\n"..
			format(TITAN_XPBAR_AVGXPTEXT,TitanUtils_GetHighlightText(avgxp)).." "..
			format(TITAN_XPBAR_KILLS,TitanUtils_GetHighlightText(totalkilled)).." "..
			format(TITAN_XPBAR_NKILLS,TitanUtils_GetHighlightText(numleft))
			end
		return
		"\n".."\n"..
		format(TITAN_XPBAR_BUTTON_TEXT_XP,TitanUtils_GetHighlightText(curr)).."/"..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(max)).." + ("..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(rxp)).." Rested)"..
		"\n".."\n"..
		format(TITAN_XPBAR_AVGXPTEXT,TitanUtils_GetHighlightText(avgxp)).." "..
		format(TITAN_XPBAR_KILLS,TitanUtils_GetHighlightText(totalkilled)).." "..
		format(TITAN_XPBAR_NKILLS,TitanUtils_GetHighlightText(numleft))
		end

        if (TitanGetVar(TITAN_XPBAR_ID, "ShowStatusBarText") == 1) then
		return 
		format(TITAN_XPBAR_BUTTON_TEXT_XP,TitanUtils_GetHighlightText(curr)).."/"..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(max)).." + ("..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(rxp)).." Rested)"
		end
	end


    if (TitanGetVar(TITAN_XPBAR_ID, "XPFormat") == nil) then
        if (TitanGetVar(TITAN_XPBAR_ID, "ShowStatusBarText") == nil) then
            if (TitanGetVar(TITAN_XPBAR_ID, "StatusBar") == nil) then
			return 
			"\n".."\n".."\n"..
			format(TITAN_XPBAR_BUTTON_TEXT_NEEDED,TitanUtils_GetHighlightText(needed)).." ("..
			format(TITAN_XPBAR_BUTTON_TEXT_NPCT,TitanUtils_GetHighlightText(needpcent))..") til "..
			format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(nextlev)).." (R:"..
			format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(rxp))..")"..
			"\n".."\n".."\n"..
			format(TITAN_XPBAR_AVGXPTEXT,TitanUtils_GetHighlightText(avgxp)).." "..
			format(TITAN_XPBAR_KILLS,TitanUtils_GetHighlightText(totalkilled)).." "..
			format(TITAN_XPBAR_NKILLS,TitanUtils_GetHighlightText(numleft))
			end
		return 
		"\n".."\n"..
		format(TITAN_XPBAR_BUTTON_TEXT_NEEDED,TitanUtils_GetHighlightText(needed)).." ("..
		format(TITAN_XPBAR_BUTTON_TEXT_NPCT,TitanUtils_GetHighlightText(needpcent))..") til "..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(nextlev)).." (R:"..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(rxp))..")"..
		"\n".."\n"..
		format(TITAN_XPBAR_AVGXPTEXT,TitanUtils_GetHighlightText(avgxp)).." "..
		format(TITAN_XPBAR_KILLS,TitanUtils_GetHighlightText(totalkilled)).." "..
		format(TITAN_XPBAR_NKILLS,TitanUtils_GetHighlightText(numleft))
		end

        if (TitanGetVar(TITAN_XPBAR_ID, "ShowStatusBarText") == 1) then
	    return
		format(TITAN_XPBAR_BUTTON_TEXT_NEEDED,TitanUtils_GetHighlightText(needed)).." ("..
		format(TITAN_XPBAR_BUTTON_TEXT_NPCT,TitanUtils_GetHighlightText(needpcent))..") til "..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(nextlev)).." (R:"..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(rxp))..")"
		end
	end

end

function TitanPanelXPBarButton_GetXPBarInfo()
	local rxp=GetXPExhaustion("player")
	local max=UnitXPMax("player")
	local curr=UnitXP("player")
	local needed=max - curr
	local currpercent=floor(curr*100/max)
	local needpcent=floor(needed*100/max)
	local currlev=UnitLevel("player")
	local nextlev=currlev + 1
	return rxp,curr,max,needed,currpercent.."%",needpcent.."%",currlev,nextlev
end

function TitanPanelXPBarButton_GetTooltipText()
	local rxp,curr,max,needed,currpercent,needpcent,currlev=TitanPanelXPBarButton_GetXPBarInfo()
	local totalxp,totalMaxXP,totalxppct,needxp,needxppct,totalgpct,totalnpct=txp(level)
	local totalTime = TitanUtils_GetTotalTime();
	local sessionTime = TitanUtils_GetSessionTime();
	local levelTime = TitanUtils_GetLevelTime();	
	local xpPerHourThisLevel = curr / levelTime * 3600;
	local xpPerHourThisSession = this.sessionXP / sessionTime * 3600;
	local estTimeToLevelThisLevel = TitanUtils_Ternary((curr == 0), -1, needed / curr * levelTime);
	local estTimeToLevelThisSession = TitanUtils_Ternary((this.sessionXP == 0), -1, needed / this.sessionXP * sessionTime);	

	if (rxp == nil) then
		rxp=0 
		rxppcent=0 .."%"
	else
		rxppcent=floor(rxp*100/max) .."%"
	end

	return
		format(TITAN_XPBAR_TOOLTIP_CURRLEV,GetBlueText(currlev)).."\n"..
		"\n"..
		format(TITAN_XPBAR_TOOLTIP_XP,TitanUtils_GetHighlightText(curr)).." "..
		format(TITAN_XPBAR_TOOLTIP_PERCENT,TitanUtils_GetHighlightText(currpercent)).."\n"..
		format(TITAN_XPBAR_TOOLTIP_LEV,TitanUtils_GetHighlightText(max)).."\n"..
		format(TITAN_XPBAR_TOOLTIP_NEED,TitanUtils_GetHighlightText(needed)).." "..
		format(TITAN_XPBAR_TOOLTIP_PERCENT,TitanUtils_GetHighlightText(needpcent)).."\n"..
		format(TITAN_XPBAR_TOOLTIP_REST,TitanUtils_GetHighlightText(rxp)).." "..
		format(TITAN_XPBAR_TOOLTIP_PERCENT,TitanUtils_GetHighlightText(rxppcent)).."\n".."\n"..
		format(TITAN_XPBAR_TOOLTIP_XPSOFAR,GetBlueText(totalxp)).." ("..
		format(TITAN_XPBAR_TOOLTIP_XPSOFARPCT,GetBlueText(totalgpct))..")".."\n"..
		format(TITAN_XPBAR_TOOLTIP_XPTO60,GetBlueText(needxp)).." ("..
		format(TITAN_XPBAR_TOOLTIP_XPTO60PCT,GetBlueText(totalnpct))..")".."\n".."\n"..
		format(TITAN_XPBAR_SESSION_XP,this.sessionXP).."\n"..
		format(TITAN_XPBAR_AVGXP,TitanUtils_GetGreenText(avgxp)).."\n".."\n"..
		format(TITAN_XPBAR_TOTAL_KILLS,GetBlueText(totalkilled)).."\n"..
		format(TITAN_XPBAR_TOTAL_NKILLS,GetBlueText(numleft)).."\n".."\n"..		
		format(TITAN_XPBAR_PER_HOUR_LEVEL, xpPerHourThisLevel).."\n"..
		format(TITAN_XPBAR_PER_HOUR_SESSION, xpPerHourThisSession).."\n".."\n"..
		format(TITAN_XPBAR_TOTAL_TIME_PLAYED, TitanUtils_GetAbbrTimeText(totalTime)).."\n"..
		format(TITAN_XPBAR_EST_TIME_TO_LEVEL_LEVEL_RATE, TitanUtils_GetAbbrTimeText(estTimeToLevelThisLevel)).."\n"..
		format(TITAN_XPBAR_EST_TIME_TO_LEVEL_SESSION_RATE, TitanUtils_GetAbbrTimeText(estTimeToLevelThisSession))
		

end

function GetBlueText(text)
	if (text) then
		return LBLUE_FONT_COLOR..text..FONT_COLOR_CODE_CLOSE;
	end
end

function Statusbar_Update()
	local currValue = UnitXP("player");
	local maxValue = UnitXPMax("player");

	XPStatus:SetMinMaxValues(0, maxValue);
	XPStatus:SetValue(currValue);

	XPBG:SetMinMaxValues(0, maxValue);
	XPBG:SetValue(maxValue)
end

function TitanPanelRightClickMenu_PrepareXPBarMenu()
	local id = TITAN_XPBAR_ID;
	local info;

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);

	info = {};
	info.text = TITAN_XPBAR_MENU_SHOWCURR
	info.func = TitanPanelXPBarButton_ShowCurr
    info.checked=TitanGetVar(TITAN_XPBAR_ID, "XPFormat")
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_XPBAR_MENU_SHOWNEXT
	info.func = TitanPanelXPBarButton_ShowNext
    info.checked=TitanUtils_Toggle(TitanGetVar(TITAN_XPBAR_ID, "XPFormat"))
	UIDropDownMenu_AddButton(info)
	TitanPanelRightClickMenu_AddSpacer()

	info = {};
	info.text = TITAN_XPBAR_MENU_SHOW_STATUS;
	info.func = TitanPanelXPBarButton_ShowStatus;
    info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_XPBAR_ID, "StatusBar"))
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_XPBAR_MENU_SHOW_TEXT
	info.func = TitanPanelXPBarButton_ShowText
    info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_XPBAR_ID, "ShowStatusBarText"))
	UIDropDownMenu_AddButton(info)
	
	info = {};
	info.text = TITAN_XPBAR_MENU_CHAT
	info.func = TitanPanelXPBarButton_Chat
    info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_XPBAR_ID, "ShowChat"))
	UIDropDownMenu_AddButton(info)

	info = {}
    info.text = TITAN_XPBAR_MENU_ENABLESHIFT
	info.func = TitanPanelXPBarButton_Shift
    info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_XPBAR_ID, "EnableShift"))
	UIDropDownMenu_AddButton(info)
	

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
end

function txp(level)
	myLevel	= UnitLevel("player");
	myCurrXP = UnitXP("player");
	myMaxXP = UnitXPMax("player");
	myTNLXP = myMaxXP - myCurrXP;

	xpl = { 0, 400, 1300, 2700, 4800, 7600, 11200, 15700, 21100, 27600,
                35200, 44000, 54100, 65500, 78400, 92800, 108800, 126500,
		145900, 167200, 190400, 215600, 242900, 272300, 304000,
		338000, 374400, 413300, 454700, 499000, 546400, 597200,
		651900, 710500, 773300, 840300, 911900, 988000, 1068800,
		1154500, 1245200, 1341000, 1442000, 1548300, 1660100,
		1777500, 1900700, 2029800, 2164900, 2306100, 2453600,
		2607500, 2767900, 2935000, 3108900, 3289700, 3477600,
		3672600, 3874900, 4084700 }
		
	local totalxp = xpl[myLevel] + myCurrXP;
	local totalMaxXP = xpl[60];
	local totalxppct = totalxp / totalMaxXP;

	local needxp = totalMaxXP - totalxp
	local needxppct = (totalMaxXP - totalxp) / totalMaxXP
	
	local totalgpct = floor(totalxppct * 10000) / 100
	local totalnpct = floor(needxppct * 10000) / 100

	return totalxp,totalMaxXP,totalxppct,needxp,needxppct,totalgpct.."%",totalnpct.."%"
end

function TitanPanelXPBarButton_ShowText()
    TitanToggleVar(TITAN_XPBAR_ID, "ShowStatusBarText")
    TitanPanelButton_UpdateButton(TITAN_XPBAR_ID)
end

function TitanPanelXPBarButton_Chat()
    TitanToggleVar(TITAN_XPBAR_ID, "ShowChat")
    TitanPanelButton_UpdateButton(TITAN_XPBAR_ID)
end

function TitanPanelXPBarButton_ShowCurr()
    TitanSetVar(TITAN_XPBAR_ID, "XPFormat",1)
    TitanPanelButton_UpdateButton(TITAN_XPBAR_ID)
end

function TitanPanelXPBarButton_ShowNext()
    TitanSetVar(TITAN_XPBAR_ID, "XPFormat", nil)
    TitanPanelButton_UpdateButton(TITAN_XPBAR_ID)
end

function TitanPanelXPBarButton_Shift()
    TitanToggleVar(TITAN_XPBAR_ID, "EnableShift")
	TitanPanelButton_UpdateButton("XPBar")
end

function TitanPanelXPBarButton_ShowStatus()
    TitanToggleVar(TITAN_XPBAR_ID, "StatusBar")
    TitanPanelButton_UpdateButton(TITAN_XPBAR_ID);
end


function TitanPanelXPBarButton_OnClick()
	local rxp,curr,max,needed,currpercent,needpcent,currlev,nextlev=TitanPanelXPBarButton_GetXPBarInfo()
	

	if (IsShiftKeyDown()) then
		if (not chatFrame) then
	   		chatFrame = DEFAULT_CHAT_FRAME;
		end
		
		chatType = chatFrame.editBox.chatType;

		if (TitanPanelSettings.Shift == nil) then
		      if (ChatFrameEditBox:IsVisible()) then
	      			ChatFrameEditBox:Insert("Currently "..curr.."/"..max.." XP with "..needed.." XP ("..needpcent..") until level "..nextlev);
	      		else
	        		SendChatMessage("Currently "..curr.."/"..max.." XP with "..needed.." XP ("..needpcent..") until level "..nextlev);
		      end
		
		end
	end
end
