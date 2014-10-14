-- $Id: RamzClock.lua,v 1.8 2006/08/23 05:31:57 ramzes Exp $      
-- DEFAULT SETTINGS
DEF_SH_ALL_CHARACTERS = 1;
DEF_DO_NOTIFY = 1;
DEF_CLOCK_FMT = 24;
DEF_OFFSET = 0;
DEF_POSITION_X = 0;
DEF_POSITION_Y = 0;
DEF_TOOLTIP_X = 0;
DEF_TOOLTIP_Y = -32;
DEF_EN30MIN = 0;
DEF_DATE_FMT = "%d.%m.%Y";
DEF_SHOW_DATE = 0;

-- GLOBALS
CURRENT_PLAYER_NAME = UnitName("player");
CURRENT_SERVER_NAME = GetCVar("realmName");
SH_ALL_CHARACTERS = DEF_SH_ALL_CHARACTERS;
DO_NOTIFY = DEF_DO_NOTIFY;
CLOCK_FMT = DEF_CLOCK_FMT;
OFFSET = DEF_OFFSET;
POSITION_X = DEF_POSITION_X;
POSITION_Y = DEF_POSITION_Y;
TOOLTIP_X = DEF_TOOLTIP_X;
TOOLTIP_Y = DEF_TOOLTIP_Y;
IS_VARIABLES_LOADED = 0;
CLOCK_UPDATE_RATE = 0.1;
COOLDOWN_UPDATE_RATE = 1.0;
CooldownUpdateTimer = 0;
EN30MIN = DEF_EN30MIN;
DATE_FMT = DEF_DATE_FMT;
SHOW_DATE = DEF_SHOW_DATE;
VERSION = "$Revision: 1.7 $";
VERSION = string.lower(string.gsub(string.gsub(VERSION, "%$", "", 2), "%:", "", 1));

function onVariablesLoaded()
	if (not RamzClock) then
		RamzClock = {};
	end
	if (not RamzClock[CURRENT_PLAYER_NAME]) then
		RamzClock[CURRENT_PLAYER_NAME] = {};
	end
	if (not RamzClock[CURRENT_SERVER_NAME]) then
	    RamzClock[CURRENT_SERVER_NAME] = DEF_OFFSET;
	else
	    OFFSET = RamzClock[CURRENT_SERVER_NAME];
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].TimeFormat) then
	    RamzClock[CURRENT_PLAYER_NAME].TimeFormat = DEF_CLOCK_FMT;
	    CLOCK_FMT = RamzClock[CURRENT_PLAYER_NAME].TimeFormat;
	else
	    CLOCK_FMT = RamzClock[CURRENT_PLAYER_NAME].TimeFormat;
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].doNotify) then
	    RamzClock[CURRENT_PLAYER_NAME].doNotify = DEF_DO_NOTIFY;
	    DO_NOTIFY = RamzClock[CURRENT_PLAYER_NAME].doNotify;
	else
	    DO_NOTIFY = RamzClock[CURRENT_PLAYER_NAME].doNotify;
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].sh_all_characters) then
        RamzClock[CURRENT_PLAYER_NAME].sh_all_characters = DEF_SH_ALL_CHARACTERS;
        SH_ALL_CHARACTERS = RamzClock[CURRENT_PLAYER_NAME].sh_all_characters;
    else
        SH_ALL_CHARACTERS = RamzClock[CURRENT_PLAYER_NAME].sh_all_characters;
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].position_x) then
        RamzClock[CURRENT_PLAYER_NAME].position_x = DEF_POSITION_X;
        POSITION_X = RamzClock[CURRENT_PLAYER_NAME].position_x;
    else
        POSITION_X = RamzClock[CURRENT_PLAYER_NAME].position_x;
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].position_y) then
        RamzClock[CURRENT_PLAYER_NAME].position_y = DEF_POSITION_Y;
        POSITION_Y = RamzClock[CURRENT_PLAYER_NAME].position_y;
    else
        POSITION_Y = RamzClock[CURRENT_PLAYER_NAME].position_y;
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].tooltip_x) then
        RamzClock[CURRENT_PLAYER_NAME].tooltip_x = DEF_TOOLTIP_X;
        TOOLTIP_X = RamzClock[CURRENT_PLAYER_NAME].tooltip_x;
    else
    	TOOLTIP_X = RamzClock[CURRENT_PLAYER_NAME].tooltip_x;
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].tooltip_y) then
        RamzClock[CURRENT_PLAYER_NAME].tooltip_y = DEF_TOOLTIP_Y;
        TOOLTIP_Y = RamzClock[CURRENT_PLAYER_NAME].tooltip_y;
    else
    	TOOLTIP_Y = RamzClock[CURRENT_PLAYER_NAME].tooltip_y;
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].en30min) then
        RamzClock[CURRENT_PLAYER_NAME].en30min = DEF_EN30MIN;
        EN30MIN = RamzClock[CURRENT_PLAYER_NAME].en30min;
    else
    	EN30MIN = RamzClock[CURRENT_PLAYER_NAME].en30min;
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].date_fmt) then
        RamzClock[CURRENT_PLAYER_NAME].date_fmt = DEF_DATE_FMT;
        DATE_FMT = RamzClock[CURRENT_PLAYER_NAME].date_fmt;
    else
    	DATE_FMT = RamzClock[CURRENT_PLAYER_NAME].date_fmt;
	end
	if (not RamzClock[CURRENT_PLAYER_NAME].show_date) then
        RamzClock[CURRENT_PLAYER_NAME].show_date = DEF_SHOW_DATE;
        SHOW_DATE = RamzClock[CURRENT_PLAYER_NAME].show_date;
    else
    	SHOW_DATE = RamzClock[CURRENT_PLAYER_NAME].show_date;
	end
	IS_VARIABLES_LOADED = 1;
	doUpdate();
 end

function doSetDefaultSettings ()
	if (IS_VARIABLES_LOADED ~= 1) then
	    ClockFrame:Hide();
	    return;
	end
	SH_ALL_CHARACTERS = DEF_SH_ALL_CHARACTERS;
	DO_NOTIFY = DEF_DO_NOTIFY;
	CLOCK_FMT = DEF_CLOCK_FMT;
	OFFSET = DEF_OFFSET;
	POSITION_X = DEF_POSITION_X;
	POSITION_Y = DEF_POSITION_Y;
	TOOLTIP_X = DEF_TOOLTIP_X;
	TOOLTIP_Y = DEF_TOOLTIP_Y;
	EN30MIN = DEF_EN30MIN;
	DATE_FMT = DEF_DATE_FMT;
	SHOW_DATE = DEF_SHOW_DATE;
	ClockFrame:ClearAllPoints();
	ClockFrame:SetPoint("TOP", "UIParent", "TOP", 0, 0);
	doUpdate();
	doInitializeConfig(1);
end

function doUpdate()
	if (IS_VARIABLES_LOADED ~= 1) then
	    ClockFrame:Hide();
	    return;
	end
	RamzClock[CURRENT_SERVER_NAME] = OFFSET;
	RamzClock[CURRENT_PLAYER_NAME].TimeFormat = CLOCK_FMT;
	RamzClock[CURRENT_PLAYER_NAME].doNotify = DO_NOTIFY;
	RamzClock[CURRENT_PLAYER_NAME].sh_all_characters = SH_ALL_CHARACTERS;
	RamzClock[CURRENT_PLAYER_NAME].position_x = POSITION_X;
	RamzClock[CURRENT_PLAYER_NAME].position_y = POSITION_Y;
	RamzClock[CURRENT_PLAYER_NAME].tooltip_x = TOOLTIP_X;
	RamzClock[CURRENT_PLAYER_NAME].tooltip_y = TOOLTIP_Y;
	RamzClock[CURRENT_PLAYER_NAME].en30min = EN30MIN;
	RamzClock[CURRENT_PLAYER_NAME].date_fmt = DATE_FMT;
	RamzClock[CURRENT_PLAYER_NAME].show_date = SHOW_DATE;
	if (CLOCK_FMT == 12) then
		ClockFrame:SetWidth(65);
	elseif(CLOCK_FMT == 24) then
		ClockFrame:SetWidth(46);
	end
	ClockFrame:Show();
end

function doPrepareRamzClockTimeFormatDropDown()

	local info;

	info = {};
	info.text = "24 hours";
	info.func = doSaveTimeFormat;
	info.value = 24;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "12 hours";
	info.func = doSaveTimeFormat;
	info.value = 12;
	UIDropDownMenu_AddButton(info);

end

function doSaveTimeFormat()
	UIDropDownMenu_SetSelectedValue(RamzClockTimeFormatDropDown, this.value);
	CLOCK_FMT = this.value;
	doUpdate();
end

function doInitializeConfig(isDefaults)
    UIDropDownMenu_Initialize(RamzClockTimeFormatDropDown, doPrepareRamzClockTimeFormatDropDown);
	UIDropDownMenu_SetWidth(80, RamzClockTimeFormatDropDown);
	UIDropDownMenu_SetSelectedValue(RamzClockTimeFormatDropDown, CLOCK_FMT);
	if (isDefaults == 0) then
		getglobal(this:GetName().."SliderOffset"):SetValue(OFFSET);
		getglobal(this:GetName().."CheckButtonShowAllCharacters"):SetChecked(SH_ALL_CHARACTERS);
		getglobal(this:GetName().."CheckButtonDoNotify"):SetChecked(DO_NOTIFY);
		getglobal(this:GetName().."SliderTooltipX"):SetValue(TOOLTIP_X);
		getglobal(this:GetName().."SliderTooltipY"):SetValue(TOOLTIP_Y);
		getglobal(this:GetName().."Enable30min"):SetChecked(EN30MIN);
  		if (EN30MIN == 1) then
			getglobal(this:GetName().."SliderOffset"):SetValueStep(0.5);
		end
		getglobal(this:GetName().."ShowDate"):SetChecked(SHOW_DATE);
		getglobal(this:GetName().."DateFormat"):SetText(DATE_FMT);
	elseif (isDefaults == 1) then
        RamzClockConfigFrameSliderOffset:SetValue(OFFSET);
		RamzClockConfigFrameCheckButtonShowAllCharacters:SetChecked(SH_ALL_CHARACTERS);
		RamzClockConfigFrameCheckButtonDoNotify:SetChecked(DO_NOTIFY);
		RamzClockConfigFrameSliderTooltipX:SetValue(TOOLTIP_X);
		RamzClockConfigFrameSliderTooltipY:SetValue(TOOLTIP_Y);
		RamzClockConfigFrameEnable30min:SetChecked(EN30MIN);
		if (EN30MIN == 1) then
			RamzClockConfigFrameSliderOffset:SetValueStep(0.5);
		end
		RamzClockConfigFrameShowDate:SetChecked(SHOW_DATE);
		RamzClockConfigFrameDateFormat:SetText(DATE_FMT);
	end
end

function doConfigSave()
	local os;
    if (this:GetName() == (this:GetParent():GetName().."SliderOffset" )) then
        OFFSET = getglobal(this:GetName()):GetValue();
        if (getglobal(this:GetName()):GetValue() > 0) then
        	os = "+"..getglobal(this:GetName()):GetValue();
        else
			os = getglobal(this:GetName()):GetValue();	
        end 
	    getglobal(this:GetName().."Text"):SetText("Offset ("..os..")");
	elseif (this:GetName() == (this:GetParent():GetName().."CheckButtonShowAllCharacters" )) then
	    SH_ALL_CHARACTERS = getglobal(this:GetName()):GetChecked();
	elseif (this:GetName() == (this:GetParent():GetName().."CheckButtonDoNotify" )) then
	    DO_NOTIFY = getglobal(this:GetName()):GetChecked();
	elseif (this:GetName() == (this:GetParent():GetName().."Enable30min" )) then
		EN30MIN = getglobal(this:GetName()):GetChecked();
	elseif (this:GetName() == (this:GetParent():GetName().."SliderTooltipX" )) then
	    TOOLTIP_X = getglobal(this:GetName()):GetValue();
	    getglobal(this:GetName().."Text"):SetText("Tooltip Position X ("..getglobal(this:GetName()):GetValue()..")");
	elseif (this:GetName() == (this:GetParent():GetName().."SliderTooltipY" )) then
	    TOOLTIP_Y = getglobal(this:GetName()):GetValue();
	    getglobal(this:GetName().."Text"):SetText("Tooltip Position Y ("..getglobal(this:GetName()):GetValue()..")");
	elseif (this:GetName() == (this:GetParent():GetName().."ShowDate" )) then
	    SHOW_DATE = getglobal(this:GetName()):GetChecked();
	end
	DATE_FMT = RamzClockConfigFrameDateFormat:GetText();
	--RamzClockConfigFrameDateFormat:SetText("");
	if (SH_ALL_CHARACTERS == nil) then
	    SH_ALL_CHARACTERS = 0;
	end
	if (DO_NOTIFY == nil) then
	    DO_NOTIFY = 0;
	end
	if (EN30MIN == nil) then
	    EN30MIN = 0;
	end
	if (SHOW_DATE == nil) then
	    SHOW_DATE = 0;
	end
	doUpdate();
end

function doGetAltKeyStatus()
	local isAlt = IsAltKeyDown();
	return isAlt;
end

function doGetShiftKeyStatus()
	local isShift = IsShiftKeyDown();
	return isShift;
end

function doGetControlKeyStatus()
	local isControl = IsControlKeyDown();
	return isControl;
end

function Clock_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_CLOSE");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("ITEM_PUSH");
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("RamzClock |cFF00FF00"..VERSION.."|rloaded.");
	end
	SLASH_RAMZCLOCK1 = "/ramzclock";
	SlashCmdList["RAMZCLOCK"] = SlashCommandHandler;
	ClockFrame.TimeSinceLastUpdate = 0;
	ClockFrame:Hide();
end

function SlashCommandHandler(cmd)
	cmd = string.gsub(cmd, " ", "");
	if (cmd == "") then
	    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00RamzClock|r "..VERSION.." help:");
	    DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF33/ramzclock|r - displays this help;\n|cFFFFFF33/ramzclock config|r - opens configuration window;\n|cFFFFFF33/ramzclock reset|r - loads default variables. Cooldown timers will stay unchanged.");
	elseif (cmd == "config") then
	    RamzClockConfigFrame:Show();
	elseif (cmd == "reset") then
	    doSetDefaultSettings();
	    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00RamzClock|r default variables loaded.");
	end
end

function doShowClock()
	ClockFrame:Show();
	ClockFrame:ClearAllPoints();
	if ((POSITION_X == 0) and (POSITION_Y == 0)) then
		ClockFrame:SetPoint("TOP", "UIParent", "TOP", 0, 0);
	else
		ClockFrame:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", POSITION_X, POSITION_Y);
	end
end

function doShowNotifyWarning()
	GameTooltip:SetOwner(RamzClockConfigFrameCheckButtonShowAllCharacters, "BOTTOMRIGHT");
	GameTooltip:SetPoint("TOPLEFT", "RamzClockConfigFrameCheckButtonShowAllCharacters", "TOP", 0, 0);
	if (RamzClockConfigFrameCheckButtonShowAllCharacters:GetChecked() == 1) then
		GameTooltip:AddLine("Disable this option\nif you dont want to control\ncooldowns and notifications\nof your other characters.");
	else
		GameTooltip:AddLine("Enable this option\nif you wish to control\ncooldowns and notifications\nof all your characters\nby this character.");
	end	
	GameTooltip:Show();
end

function Clock_OnUpdate(arg1)
	ClockFrame.TimeSinceLastUpdate = ClockFrame.TimeSinceLastUpdate + arg1;
	if( ClockFrame.TimeSinceLastUpdate > CLOCK_UPDATE_RATE ) then
		ClockText:SetText(doGetTimeText());
--	### Check if we need to send notification on cooldown expire ###
		if ((IS_VARIABLES_LOADED == 1) and (CooldownUpdateTimer >= COOLDOWN_UPDATE_RATE)) then
			doGetCooldowns(0, DO_NOTIFY, SH_ALL_CHARACTERS, CURRENT_PLAYER_NAME);
			CooldownUpdateTimer = 0;
		end	
--	### End ###
	CooldownUpdateTimer = CooldownUpdateTimer + ClockFrame.TimeSinceLastUpdate;
	ClockFrame.TimeSinceLastUpdate = 0;
	end
end

function doGetTimeText()
	local hour, minute = GetGameTime();
	local pm;

    DotPos = string.find(OFFSET, "%.");
    if (DotPos ~= nil) then
    	DotPos = DotPos - 1;
    	OffsetHour = string.sub(OFFSET, 1, DotPos);
    else
    	OffsetHour = OFFSET;
	end	
	OffsetMinute = string.find(OFFSET, "%.(%d+)");
    if (OffsetMinute ~= nil) then
     	OffsetMinute = 30;
    else
    	OffsetMinute = 0;
    end	

	hour = hour + OffsetHour;
	minute = minute + OffsetMinute;
	if( minute > 59 ) then
		minute = minute - 60;
		hour = hour + 1
	elseif( minute < 0 ) then
		minute = 60 + minute;
		hour = hour - 1;
	end
	if( hour > 23 ) then
		hour = hour - 24;
	elseif( hour < 0 ) then
		hour = 24 + hour;
	end

	if(CLOCK_FMT == 24) then
		return format(TEXT(TIME_TWENTYFOURHOURS), hour, minute);
	elseif(CLOCK_FMT == 12) then 
		if( hour >= 12 ) then
			pm = 1;
			hour = hour - 12;
		else
			pm = 0;
		end
		if( hour == 0 ) then
			hour = 12;
		end
		if( pm == 1 ) then
			return format(TEXT(TIME_TWELVEHOURPM), hour, minute);
		else
			return format(TEXT(TIME_TWELVEHOURAM), hour, minute);
		end
	end
end

function Clock_OnEvent()
	if( event == "VARIABLES_LOADED") then
		CURRENT_PLAYER_NAME = UnitName("player");
		CURRENT_SERVER_NAME = GetCVar("realmName");
		doUpdate();
		onVariablesLoaded();
		doShowClock();
	elseif(event == "SPELLCAST_START") then
		TradeSkillIndex = GetTradeSkillSelectionIndex();
		if (TradeSkillIndex > 0) then
			CraftingItemName, _, _, _ = GetTradeSkillInfo(TradeSkillIndex)
			isCraftSuccess = 1;
		end
	elseif((event == "SPELLCAST_FAILED") or (event == "SPELLCAST_INTERRUPTED")) then
		TradeSkillIndex = GetTradeSkillSelectionIndex();
		if (TradeSkillIndex > 0) then
			CraftingItemName, _, _, _ = GetTradeSkillInfo(TradeSkillIndex)
			TradeSkillIndex = nil;
			CraftingItemName = nil;
			isCraftSuccess = 0;
		end
	elseif (event == "ITEM_PUSH") then
		if (isCraftSuccess == 1) then
			TradeSkillIndex = GetTradeSkillSelectionIndex();
			if (TradeSkillIndex > 0) then
				CraftingItemName, _, _, _ = GetTradeSkillInfo(TradeSkillIndex);
				if (GetTradeSkillCooldown(TradeSkillIndex) ~= nil) then
	                		--DEFAULT_CHAT_FRAME:AddMessage("Setting cooldown for: "..CraftingItemName);
					cd = GetTradeSkillCooldown(TradeSkillIndex);
					RamzClock[CURRENT_PLAYER_NAME][CraftingItemName.."-available"] = time()+floor(cd);
					isCraftSuccess = 0;
				else
					--DEFAULT_CHAT_FRAME:AddMessage(CraftingItemName.." has no cooldown.");
				end
			end
			isCraftSuccess = 0;
		end
	elseif ((event == "TRADE_SKILL_SHOW") or (event == "TRADE_SKILL_CLOSE")) then
		local name, type;
		for i=1,GetNumTradeSkills() do
			name, type, _, _ = GetTradeSkillInfo(i);
			if (type ~= "header") then
				if (GetTradeSkillCooldown(i)) then
					RamzClock[CURRENT_PLAYER_NAME][name.."-available"] = time() + floor(GetTradeSkillCooldown(i));
				end
			end
		end
	end
end

function ClickHandler(btn, updown)
	local isAlt = doGetAltKeyStatus();
	local isShift = doGetShiftKeyStatus();
	local isControl = doGetControlKeyStatus();
	if (btn == "LeftButton") then
		if (ClockFrame.moving) then
			if (updown == "CLICK") then
				ClockFrame.moving = nil;
				ClockFrame:StopMovingOrSizing();
				POSITION_X, POSITION_Y = ClockFrame:GetCenter();
				ClockFrame:SetMovable(0);
				doUpdate();
			end
 		elseif (isShift and updown == "DOWN") then
			ClockFrame.moving = true;
			ClockFrame:SetMovable(1);
			ClockFrame:StartMoving();
		end
		if (isAlt and updown == "CLICK") then
				if (OFFSET == 23) then
					OFFSET = -1;
				end
			OFFSET = OFFSET + 1;
			doUpdate();
		end
	elseif (btn == "RightButton") then
		if (isAlt and updown == "CLICK") then
				if (OFFSET == 0) then
					OFFSET = 24;
				end
			OFFSET = OFFSET - 1;
			doUpdate();
		end
		if (isControl and updown == "CLICK") then
			if (EN30MIN == 0) then
				RamzClockConfigFrameSliderOffset:SetValueStep(1);
			end
			RamzClockConfigFrameDateFormat:SetText(DATE_FMT);
			RamzClockConfigFrame:Show();
   		end
	end
end

function doGetCooldownPeriod(time)
	local days = floor(time/86400);
	local time = time - days*86400;
	local hours = floor(time/3600);
	local time = time - hours*3600;
	local minutes = floor(time/60);
	if (days > 0) then
		days = days.."d ";
	else
		days = "";
	end
	if (hours > 0) then
		hours = hours.."h ";
	else
		hours = "";
	end
	if (minutes > 0) then
		minutes = minutes.."m";
	else
		minutes = "";
	end
	if ((days == "") and (hours == "") and (minutes == "")) then
		period = "< 1min";
	else
		period = days..hours..minutes;
	end
	return period;
end

function doShowTooltip ()
	local isControl = doGetControlKeyStatus();
	if (IS_VARIABLES_LOADED == 1) then
		GameTooltip:SetOwner(ClockFrame, "ANCHOR_NONE");
		GameTooltip:SetPoint("TOP", "ClockFrame", "TOP", TOOLTIP_X, TOOLTIP_Y);
		GameTooltip:AddLine("", 1,1,1);
		if (SHOW_DATE == 1) then
			GameTooltip:AddLine(date(DATE_FMT), 1,1,1);
		end
--		GameTooltip:SetPoint("TOP", "ClockFrame", "TOP", TOOLTIP_X, TOOLTIP_Y);
		GameTooltip:AddLine("Cooldown Statistics", 1,1,1);
		if (doGetCooldowns(1, DO_NOTIFY, SH_ALL_CHARACTERS, CURRENT_PLAYER_NAME) == 0) then
			if (SH_ALL_CHARACTERS == 1) then
				GameTooltip:AddLine("No active cooldowns", 0.5, 0.5, 0.5);
			else
				GameTooltip:AddLine("You have no active cooldowns", 0.5, 0.5, 0.5);
			end
		end
		GameTooltip:Show();
  	end
end

function doGetCooldowns (doTooltip, isNotify, isAllCharacters, PlayerName)
	local TooltipLines = "";
	local TooltipNameExists = "";
	local isNotificationSent = 0;
	local isCooldownAtAll = 0;
	for index, value in pairs(RamzClock) do
	    local isCooldown = 0;
		if ((index) and (type(value) == "table")) then
			if (((isAllCharacters == 0) and (index == PlayerName)) or (isAllCharacters == 1)) then
				for idx, val in pairs (RamzClock[index]) do
				    PlayerName = index;
					if (string.find(idx, "-available")) then
						CooldownName = string.gsub(idx, "-available", "", 1);
						isCooldown = 1;
						if (val) then
							TimeRemaining = val - time();
						else
							TimeRemaining = 0;
						end
						if (doTooltip == 1) then
							isCooldownAtAll = 1;
								if (PlayerName ~= TooltipNameExists) then
									GameTooltip:AddLine(PlayerName);
									TooltipNameExists = PlayerName;
								end
							GameTooltip:AddDoubleLine(CooldownName, doGetCooldownPeriod(TimeRemaining), 1,1,1,1,1,1);
						elseif ((doTooltip == 0) and (TimeRemaining <= 0)) then
							if (isNotificationSent == 0) then
								if (isNotify == 1) then
							    	doSendNotify(PlayerName, CooldownName);
							    	RamzClock[index][idx] = nil;
							    	isNotificationSent = 1;
								end	
							end
						end
					end
				end
			end	
		end		
	end
	return isCooldownAtAll;
end

function doSendNotify(PlayerName, CooldownName)
	if (PlayerName == CURRENT_PLAYER_NAME) then
		PlayerName = "Your"
	else
		PlayerName = PlayerName.."'s";
	end
	SELECTED_CHAT_FRAME:AddMessage("|cFF66FF00RamzClock: |cFFFFFF33"..PlayerName.."|cFF00FFFF cooldown on |cFFFFFF33"..CooldownName.."|cFF00FFFF has expired!");
	PlaySound("AuctionWindowOpen");
end

function doChangeAjustMode()
	if (RamzClockConfigFrameEnable30min:GetChecked() == 1) then
		RamzClockConfigFrameSliderOffset:SetValueStep(0.5);
	else
		RamzClockConfigFrameSliderOffset:SetValueStep(1);
	end
end