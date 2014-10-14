LeaveLFGSettings = {};

local LeaveLFG_NormalButtonTexture;
local LeaveLFG_NormalTextColor_r;
local LeaveLFG_NormalTextColor_g;
local LeaveLFG_NormalTextColor_b;
local LeaveLFG_DebugOn = nil;
local Realm;
local Player;
local LeaveLFG_SessionAutomaticOff=nil;

function LeaveLFG_OnLoad()
	LeaveLFGButton:SetText("LFG");
	LeaveLFG_NormalButtonTexture = LeaveLFGButton:GetNormalTexture():GetTexture();
	LeaveLFG_NormalTextColor_r, LeaveLFG_NormalTextColor_g, LeaveLFG_NormalTextColor_b = LeaveLFGButton:GetTextColor();
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	this:RegisterEvent("VARIABLES_LOADED");
	Player = UnitName("player");
	Realm = GetRealmName();
	
	SlashCmdList["LEAVELFG"] = LeaveLFG_SlashCmd;
	SLASH_LEAVELFG1 = "/lfg";
	SLASH_LEAVELFG2 = "/leavelfg";
end

function LeaveLFG_SlashCmd(msg)
	if(not msg) then
		msg="help";
	end
	
	local LeaveLFG_CheckForAutomatic=nil;
	
	if(msg=="join" or msg=="join2") then
		LeaveLFG_SlashJoinAddtext="";
		if(msg=="join2") then
			LeaveLFG_SessionAutomaticOff=1;
			LeaveLFG_SlashJoinAddtext=LEAVELFG_BUTTON_NORMAL;
		end
		if(not LeaveLFG_IsInChan()) then
			LeaveLFG_Output(LEAVELFG_BUTTON_JOIN..LeaveLFG_SlashJoinAddtext);
			LeaveLFG_Join();
		else
			LeaveLFG_Output(LEAVELFG_SLASHCMD_JOIN_ALREADY..LeaveLFG_SlashJoinAddtext);
			LeaveLFG_Debug("LFG_Join: AlreadyInChan");
		end
	elseif(msg=="leave" or msg=="leave2") then
		LeaveLFG_SlashLeaveAddtext="";
		if(msg=="leave2") then
			LeaveLFG_SessionAutomaticOff=1;
			LeaveLFG_SlashLeaveAddtext=LEAVELFG_BUTTON_NORMAL;
		end
		if(LeaveLFG_IsInChan()) then
			LeaveLFG_Output(LEAVELFG_BUTTON_LEAVE..LeaveLFG_SlashLeaveAddtext);
			LeaveChannelByName(LEAVELFG_LFGCHANNEL);
		else
			LeaveLFG_Output(LEAVELFG_SLASHCMD_LEAVE_ALREADY..LeaveLFG_SlashLeaveAddtext);
			LeaveLFG_Debug("LFG_Leave: NotInChan");
		end
	elseif(msg=="cities") then
		if(not LeaveLFGSettings[Realm][Player]["dontjoinincities"]) then
			LeaveLFGSettings[Realm][Player]["dontjoinincities"]=1;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_CITIES_OFF);
		else
			LeaveLFGSettings[Realm][Player]["dontjoinincities"]=nil;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_CITIES_ON);
			LeaveLFG_CheckForAutomatic=1;
		end
	elseif(msg=="worldjoin") then
		if(not LeaveLFGSettings[Realm][Player]["dontjoininworld"]) then
			LeaveLFGSettings[Realm][Player]["dontjoininworld"]=1;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_WORLD_JOIN_OFF);
		else
			LeaveLFGSettings[Realm][Player]["dontjoininworld"]=nil;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_WORLD_JOIN_ON);
			LeaveLFG_CheckForAutomatic=1;
		end
	elseif(msg=="worldleave") then
		if(not LeaveLFGSettings[Realm][Player]["leaveinworld"]) then
			LeaveLFGSettings[Realm][Player]["leaveinworld"]=1;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_WORLD_LEAVE_ON);
			LeaveLFG_CheckForAutomatic=1;
		else
			LeaveLFGSettings[Realm][Player]["leaveinworld"]=nil;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_WORLD_LEAVE_OFF);
		end
	elseif(msg=="dungeons") then
		if(not LeaveLFGSettings[Realm][Player]["dontleaveindungeons"]) then
			LeaveLFGSettings[Realm][Player]["dontleaveindungeons"]=1;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_DUNGEON_OFF);
		else
			LeaveLFGSettings[Realm][Player]["dontleaveindungeons"]=nil;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_DUNGEON_ON);
			LeaveLFG_CheckForAutomatic=1;
		end
	elseif(msg=="automatic") then
		if(not LeaveLFGSettings[Realm][Player]["noautomatic"]) then
			LeaveLFGSettings[Realm][Player]["noautomatic"]=1;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_AUTOMATIC_OFF);
		else
			LeaveLFGSettings[Realm][Player]["noautomatic"]=nil;
			LeaveLFG_Output(LEAVELFG_SLASHCMD_AUTOMATIC_ON);
			LeaveLFG_CheckForAutomatic=1;
		end
	else
		if(msg~="status") then
			LeaveLFG_Output(LEAVELFG_SLASHCMD_STATUS[1]);
			LeaveLFG_Output(LEAVELFG_SLASHCMD_STATUS[2]);
			LeaveLFG_Output(LEAVELFG_SLASHCMD_STATUS[3]);
			LeaveLFG_Output(LEAVELFG_SLASHCMD_STATUS[4]);
			LeaveLFG_Output(LEAVELFG_SLASHCMD_STATUS[5]);
		end
		
		helptext = LEAVELFG_SLASHCMD_STATUS[6];
		if(LeaveLFGSettings[Realm][Player]["dontjoinincities"]) then LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_OFF);
		else LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_ON); end
		helptext = LEAVELFG_SLASHCMD_STATUS[7];
		if(LeaveLFGSettings[Realm][Player]["dontjoininworld"]) then LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_OFF);
		else LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_ON); end;
		helptext = LEAVELFG_SLASHCMD_STATUS[8];
		if(LeaveLFGSettings[Realm][Player]["leaveinworld"]) then LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_ON);
		else LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_OFF); end;
		helptext = LEAVELFG_SLASHCMD_STATUS[9];
		if(LeaveLFGSettings[Realm][Player]["dontleaveindungeons"]) then LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_OFF);
		else LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_ON); end;
		helptext = LEAVELFG_SLASHCMD_STATUS[10];
		if(LeaveLFGSettings[Realm][Player]["noautomatic"]) then LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_OFF);
		else LeaveLFG_Output(helptext.." - "..LeaveLFG_STATUS_ON); end;
	end
	
	if(LeaveLFG_CheckForAutomatic) then
		if(LeaveLFG_SessionAutomaticOff) then
			LeaveLFG_SessionAutomaticOff=nil;
			LeaveLFG_Output(LEAVELFG_HINT_SESSION_AUTOMATIC_OFF);
		end
		if(LeaveLFGSettings[Realm][Player]["noautomatic"]) then
			LeaveLFG_Output(LEAVELFG_HINT_AUTOMATIC_OFF);
		end
	end
end

function LeaveLFG_OnEvent()
	if(event=="ZONE_CHANGED_NEW_AREA" or event=="PLAYER_ENTERING_WORLD") then
		if(LeaveLFGSettings[Realm][Player]["noautomatic"]) then
			LeaveLFG_Debug("Automatic join/leave is deactivated.");
		elseif(LeaveLFG_SessionAutomaticOff) then
			LeaveLFG_Debug("Automatic join/leave is currently (this session) deactivated.");
		elseif(LeaveLFG_IsInInstance()) then
			LeaveLFG_Debug("Dungeon");
			if(not LeaveLFGSettings[Realm][Player]["dontleaveindungeons"]) then
				if(LeaveLFG_IsInChan()) then
					LeaveLFG_Output(LEAVELFG_DUNGEON_LEAVE);
					LeaveChannelByName(LEAVELFG_LFGCHANNEL);
				else
					LeaveLFG_Debug("Dungeon_Enter: NotInChan");
				end
			else
				LeaveLFG_Debug("Dungeon_Enter: Automatic_Deactivated");
			end
		elseif(LeaveLFG_IsInCity()) then
			LeaveLFG_Debug("City");
			if(not LeaveLFGSettings[Realm][Player]["dontjoinincities"]) then
				if(not LeaveLFG_IsInChan()) then
					LeaveLFG_Output(LEAVELFG_CITY_JOIN);
					LeaveLFG_Join();
				else
					LeaveLFG_Debug("City_Enter: AlreadyInChan");
				end
			else
				LeaveLFG_Debug("City_Enter: Automatic_Deactivated");
			end
		else
			LeaveLFG_Debug("Normal world");
			if(not LeaveLFG_IsInChan() and not LeaveLFGSettings[Realm][Player]["dontjoininworld"]) then
				LeaveLFG_Output(LEAVELFG_WORLD_JOIN);
				LeaveLFG_Join();
			elseif(LeaveLFG_IsInChan() and LeaveLFGSettings[Realm][Player]["leaveinworld"]) then
				LeaveLFG_Output(LEAVELFG_WORLD_LEAVE);
				LeaveChannelByName(LEAVELFG_LFGCHANNEL);
			elseif(LeaveLFG_DebugOn) then
				if(not LeaveLFG_IsInChan() and LeaveLFGSettings[Realm][Player]["dontjoininworld"]) then
					LeaveLFG_Debug("World_Enter: AutomicJoin_Deactivated");
				elseif(LeaveLFG_IsInChan() and not LeaveLFGSettings[Realm][Player]["leaveinworld"]) then
					LeaveLFG_Debug("World_Enter: AutomicLeave_Deactivated");
				elseif(LeaveLFG_IsInChan()) then
					LeaveLFG_Debug("World_Enter: AlreadyInChan");
				else
					LeaveLFG_Debug("World_Enter: NotInChan");
				end
			end
		end
	elseif(event=="VARIABLES_LOADED") then
		if LeaveLFGSettings==nil then LeaveLFGSettings={} end;
		if LeaveLFGSettings[Realm]==nil then LeaveLFGSettings[Realm]={} end;
		if LeaveLFGSettings[Realm][Player]==nil then LeaveLFGSettings[Realm][Player]={} end;
	elseif(event=="CHAT_MSG_CHANNEL_NOTICE") then
		LeaveLFG_Debug("Channel_Notice: "..arg1.." - "..arg9);
		if(arg1=="YOU_JOINED" and string.lower(arg9)==string.lower(LEAVELFG_LFGCHANNEL)) then
			LeaveLFG_ButtonOn();
		elseif(arg1=="YOU_LEFT" and string.lower(arg9)==string.lower(LEAVELFG_LFGCHANNEL)) then
			LeaveLFG_ButtonOff();
		end
	end
end

function LeaveLFG_OnButtonClick()
	if(arg1=="RightButton") then
		if(IsShiftKeyDown()) then
			if(LeaveLFGMover:IsVisible()) then
				LeaveLFGMover:Hide();
			else
				LeaveLFGMover:Show();
			end
		else
			LeaveLFG_SlashCmd("status");
		end
	else
		if(arg1=="MiddleButton" or IsAltKeyDown()) then
			LeaveLFG_SlashCmd("automatic");
		else
			local LeaveLFGOnButtonClickAddtext = "";
			if(IsShiftKeyDown()) then
				LeaveLFGOnButtonClickAddtext = LEAVELFG_BUTTON_SHIFT;
				
				if(LeaveLFGSettings[Realm][Player]["noautomatic"]) then
					LeaveLFGOnButtonClickAddtext = LeaveLFG_STATUS_OFF;
				else
					LeaveLFGOnButtonClickAddtext = LeaveLFG_STATUS_ON;
				end
				if(LeaveLFG_SessionAutomaticOff) then
					LeaveLFG_Output(LEAVELFG_HINT_SESSION_AUTOMATIC_OFF);
				end
			elseif(IsControlKeyDown()) then
				LeaveLFGSettings[Realm][Player]["noautomatic"]=1;
				LeaveLFGOnButtonClickAddtext = LEAVELFG_BUTTON_CTRL;
			else
				LeaveLFG_SessionAutomaticOff = 1;
				LeaveLFGOnButtonClickAddtext = LEAVELFG_BUTTON_NORMAL;
			end
			if(LeaveLFG_IsInChan()) then
				LeaveLFG_Output(LEAVELFG_BUTTON_LEAVE..LeaveLFGOnButtonClickAddtext);
				LeaveChannelByName(LEAVELFG_LFGCHANNEL);
			else
				LeaveLFG_Output(LEAVELFG_BUTTON_JOIN..LeaveLFGOnButtonClickAddtext);
				LeaveLFG_Join();
			end
		end
	end
end

function LeaveLFG_MoverOnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
	GameTooltip:SetText(LEAVELFG_MOVER_TOOLTIP1, 1, 1, 1);
	GameTooltip:AddLine(LEAVELFG_MOVER_TOOLTIP2, 1, 1, 1);
	GameTooltip:AddLine(LEAVELFG_MOVER_TOOLTIP3, 1, 1, 1);
	GameTooltip:Show();
end

function LeaveLFG_Lock()
	LeaveLFGMover:Hide();
end

function LeaveLFG_ResetPosition()
	LeaveLFG:ClearAllPoints();
	LeaveLFG:SetPoint("BOTTOMRIGHT", "ChatFrame1", "TOPRIGHT", 0, 0);
	LeaveLFGMover:Hide();
end

function LeaveLFG_ButtonOff()
	LeaveLFGButton:SetNormalTexture(LeaveLFGButton:GetDisabledTexture():GetTexture());
	r, g, b = LeaveLFGButton:GetDisabledTextColor();
	LeaveLFGButton:SetTextColor(r, g, b);
end

function LeaveLFG_ButtonOn()
	LeaveLFGButton:SetNormalTexture(LeaveLFG_NormalButtonTexture);
	LeaveLFGButton:SetTextColor(LeaveLFG_NormalTextColor_r, LeaveLFG_NormalTextColor_g, LeaveLFG_NormalTextColor_b);
end

function LeaveLFG_OnButtonEnter()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(LEAVELFG_BUTTON_TOOLTIP1, 1, 1, 1);
	GameTooltip:AddLine(LEAVELFG_BUTTON_TOOLTIP2, 1, 1, 1);
	GameTooltip:AddLine(LEAVELFG_BUTTON_TOOLTIP3, 1, 1, 1);
	GameTooltip:AddLine(LEAVELFG_BUTTON_TOOLTIP4, 1, 1, 1);
	GameTooltip:AddLine(LEAVELFG_BUTTON_TOOLTIP5, 1, 1, 1);
	GameTooltip:AddLine(LEAVELFG_BUTTON_TOOLTIP6, 1, 1, 1);
	GameTooltip:Show();
end

function LeaveLFG_IsInInstance()
	SetMapToCurrentZone();
	a,b=GetPlayerMapPosition("player");
	c=UnitOnTaxi("player");
	if(a==0 and b==0 and c==nil) then return 1; else return nil; end
end

function LeaveLFG_IsInCity()
	zonetext = GetZoneText();
	LeaveLFG_Debug("Current zone: "..zonetext);
	for i = 0, table.getn(LEAVELFG_CITIES), 1 do
		if (string.find(zonetext, LEAVELFG_CITIES[i])) then
			return 1;
		end
	end
	return nil;
end

function LeaveLFG_IsInChan()
	if(GetChannelName(GetChannelName(LEAVELFG_LFGCHANNEL))>0) then -- double GetChannelName because it returns next free channel number when not in chan
		return 1;
	else
		return nil;
	end
end

function LeaveLFG_Debug(text)
	if(LeaveLFG_DebugOn) then
		DEFAULT_CHAT_FRAME:AddMessage("LeaveLFG Debug: "..text);
	end
end

function LeaveLFG_Output(text)
	local info = ChatTypeInfo["SYSTEM"];
	DEFAULT_CHAT_FRAME:AddMessage(text, info.r, info.g, info.b, info.id);
end

function LeaveLFG_Join()
	local zoneChannel, channelName = JoinChannelByName(LEAVELFG_LFGCHANNEL, "", DEFAULT_CHAT_FRAME:GetID());
	if ( channelName ) then
		name = channelName;
	end
	if ( not zoneChannel ) then
		return;
	end

	local i = 1;
	while ( DEFAULT_CHAT_FRAME.channelList[i] ) do
		i = i + 1;
	end
	DEFAULT_CHAT_FRAME.channelList[i] = name;
	DEFAULT_CHAT_FRAME.zoneChannelList[i] = zoneChannel;
end
