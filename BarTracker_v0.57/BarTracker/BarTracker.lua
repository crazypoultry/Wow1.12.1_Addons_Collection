--[[
--
--	BarTracker
--	by Dust of Turalyon
--
--]]

BarTracker_Version = GetAddOnMetadata("BarTracker", "Version");

BarTracker_Settings_Defaults = {
	["Show"]	= true;
	["Scale"]	= 0.75;
	["Alpha"]	= 0.75;
	["TimeScale"]	= 1.0;
	["BattleMode"]	= "auto"; -- "auto", "manual"
	["Timeout"]	= 10;
	["Combatlog"]	= false;
	["Color"]	= {
		["Health"]	= {0.0, 1.0, 0.0, 0.5};
		["Mana"]	= {0.0, 0.5, 1.0, 0.5}; -- for better readability
		["Energy"]	= {1.0, 1.0, 0.0, 0.5};
		["Rage"]	= {1.0, 0.0, 0.0, 0.5};
	};

	["Version"]	= BarTracker_Version;
}

BarTracker_PowerTranslation = {
	[0]	= "Mana";
	[1]	= "Rage";
	[2]	= "Focus";
	[3]	= "Energy";
	[4]	= "Happiness";
};

BarTracker_StatAnchors = {
	["Mana"] = "TOPRIGHT";
	["Energy"] = "TOPRIGHT";
	["Rage"] = "TOPRIGHT";
	["Health"] = "TOPLEFT";
};

BarTracker_Status = "Paused";

BarTracker_ManaType = "Mana";

BarTracker_OnLoad = function ()
	--Slash command
	SlashCmdList["BARTRACKER"] = BarTracker_SlashHandler;
	SLASH_BARTRACKER1 = "/bartracker";
	SLASH_BARTRACKER2 = "/bt";	

	--Events
	BarTracker_MainFrame:RegisterEvent("VARIABLES_LOADED");
	BarTracker_MainFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
	BarTracker_MainFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
	BarTracker_MainFrame:RegisterEvent("PLAYER_LEAVING_WORLD");
	BarTracker_MainFrame:RegisterEvent("PLAYER_LOGIN");
end;

BarTracker_RegisterChatEvents = function ()
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"); -- check for "you"
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"); -- check for "you"
	--BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE"); -- check for "you"
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	--BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
	BarTracker_MainFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
end;

BarTracker_UnregisterChatEvents = function ()
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	--BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	--BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
	BarTracker_MainFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
end;

BarTracker_RegisterEvents = function ()
	BarTracker_MainFrame:RegisterEvent("UNIT_HEALTH");
	BarTracker_MainFrame:RegisterEvent("UNIT_MAXHEALTH");
	BarTracker_MainFrame:RegisterEvent("UNIT_"..string.upper(BarTracker_ManaType));
	BarTracker_MainFrame:RegisterEvent("UNIT_MAX"..string.upper(BarTracker_ManaType));
	
	if BarTracker_Settings["Combatlog"] then
		BarTracker_RegisterChatEvents();
	end
end;

BarTracker_UnregisterEvents = function ()
	BarTracker_MainFrame:UnregisterEvent("UNIT_HEALTH");
	BarTracker_MainFrame:UnregisterEvent("UNIT_MAXHEALTH");
	BarTracker_MainFrame:UnregisterEvent("UNIT_"..string.upper(BarTracker_ManaType));
	BarTracker_MainFrame:UnregisterEvent("UNIT_MAX"..string.upper(BarTracker_ManaType));
	BarTracker_UnregisterChatEvents();
end;

BarTracker_OnEvent = function ()
	if (event == "UNIT_HEALTH") then
		--if (UnitIsUnit("player", arg1)) then
		if (arg1 == "player") then
			BarTracker_HealthChanged();
		end;
	elseif (event == "UNIT_"..string.upper(BarTracker_ManaType)) then
		if (UnitIsUnit("player", arg1)) then
			BarTracker_ManaChanged();
		end;
	elseif (event == "UNIT_MAXHEALTH") then
		if (UnitIsUnit("player", arg1)) then
			BarTracker_MaxHealthChanged();
		end;
	elseif (event == "UNIT_MAX"..string.upper(BarTracker_ManaType)) then
		if (UnitIsUnit("player", arg1)) then
			BarTracker_MaxManaChanged();
		end;
	elseif (string.find(event,"^CHAT_MSG")) then
		BarTracker_AddChatLine(arg1);
	elseif (event == "PLAYER_REGEN_DISABLED") then
		-- Entered Combat
		if BarTracker_Settings["BattleMode"] == "auto" then
			BarTracker_EnterCombat();
		end;
	elseif (event == "PLAYER_REGEN_ENABLED") or
		(event == "PLAYER_LEAVING_WORLD") then
		-- Left Combat
		if BarTracker_Settings["BattleMode"] == "auto" then
			TimeLight_Schedule(BarTracker_Settings["Timeout"], "BarTracker_LeaveCombat", BarTracker_LeaveCombat);
		end;
	elseif (event == "VARIABLES_LOADED") then
		if (BarTracker_Settings == nil) or (BarTracker_Settings["Version"] ~= BarTracker_Version) then
			BarTracker_MSG("BT: BarTracker settings reset");
			BarTracker_Settings = BarTracker_Settings_Defaults;
		end;
		if (BarTracker_StoredLogs == nil) then
			BarTracker_StoredLogs = {};
		end;
		
		--Layout
		if BarTracker_Settings["Show"] then
			BarTracker_OutputFrame0:Show();
		else
			BarTracker_OutputFrame0:Hide();
		end;
		BarTracker_OutputFrame0:SetScale(BarTracker_Settings["Scale"]);
		BarTracker_OutputFrame0:SetAlpha(BarTracker_Settings["Alpha"]);
		BarTracker_OutputFrame0:SetClampedToScreen("TRUE");
		BarTracker_OutputFrame0:SetMinResize(64, 64);
		BarTracker_LogViewer:SetClampedToScreen("TRUE");
		BarTracker_LogViewer:SetMinResize(320, 240);
		if BarTracker_Settings["TimeScale"] == 0 then
			BarTracker_VisualModeScale();
		else
			BarTracker_VisualModeScroll();
		end;
	elseif (event == "PLAYER_LOGIN") then
		BarTracker_ManaType = BarTracker_PowerTranslation[UnitPowerType("player")];
		BarTracker_InitLog();
		BarTracker_RebuildAllDiagrams("BarTracker_OutputFrame0");
		-- Install handlers which don't work without a log
		BarTracker_OutputFrame0:SetScript("OnSizeChanged", BarTracker_FrameResizing);
		BarTracker_OutputFrame0:SetScript("OnEnter", BarTracker_OnMouseEnter);
		BarTracker_OutputFrame0:SetScript("OnLeave", BarTracker_OnMouseLeave);
		BarTracker_LogViewer:SetScript("OnSizeChanged", BarTracker_LogViewUpdate);
	end;
end;

-- Implementation constants
BarTracker_vBorder = 8;
BarTracker_hBorder = 8; -- 8 or 32
BarTracker_MaxWidth = 160;

BarTracker_VisualModeScale = function ()
	-- Set Mode to scale
	if BarTracker_Status == "Paused" then
		BarTracker_OutputFrame0_Slider:Hide();
		BarTracker_OutputFrame0_Slider:SetScrollChild(nil);
		BarTracker_OutputFrame0_Slider_ScrollContainer:SetParent(BarTracker_OutputFrame0);
		BarTracker_OutputFrame0_Slider_ScrollContainer:Show()
		BarTracker_hBorder = 8;
	end;
end;

BarTracker_VisualModeScroll = function ()
	-- Set Mode to scroll
	if BarTracker_Status == "Paused" then
		BarTracker_OutputFrame0_Slider:Show();
		BarTracker_OutputFrame0_Slider:SetScrollChild(BarTracker_OutputFrame0_Slider_ScrollContainer);
		BarTracker_OutputFrame0_Slider_ScrollContainer:Show()
		BarTracker_hBorder = 32;
	end;
end;

BarTracker_EnterCombat = function ()
	if BarTracker_Status == "Paused" then
		BarTracker_InitLog();
		BarTracker_RegisterEvents();
		if (BarTracker_Settings["Show"]) then
			UIFrameFadeIn(BarTracker_OutputFrame0, 1, BarTracker_Settings["Alpha"], 0);
			TimeLight_Schedule(1, "BarTracker_FrameHide", BarTracker_OutputFrame0.Hide, BarTracker_OutputFrame0);
		end;
		BarTracker_Status = "Running";
	else
		TimeLight_Unschedule("BarTracker_LeaveCombat");
	end;
end;

BarTracker_LeaveCombat = function ()
	BarTracker_UnregisterEvents();
	BarTracker_FinishLog();
	BarTracker_RebuildAllDiagrams("BarTracker_OutputFrame0");
	BarTracker_FilterLog(BarTracker_Log["Combatlog"], BarTracker_LogFilter);
	if (BarTracker_Settings["Show"]) then
		BarTracker_OutputFrame0:Show();
		UIFrameFadeIn(BarTracker_OutputFrame0, 1, 0, BarTracker_Settings["Alpha"]);
	end;
	BarTracker_StoreLog(1);
	TimeLight_Unschedule("BarTracker_LeaveCombat");
	BarTracker_Status = "Paused";
end;

BarTracker_InitLog = function ()
	local health = UnitHealth("player");
	local healthMax = UnitHealthMax("Player");
	local mana = UnitMana("player");
	local manaMax = UnitManaMax("player");
	local time =  GetTime();
	BarTracker_Log = {
		["Health"]	= {{health, time}};
		[BarTracker_ManaType]	= {{mana, time}};
		["HealthMax"]	= healthMax;
		[BarTracker_ManaType.."Max"]	= manaMax;
		["HealthMin"]	= health;
		[BarTracker_ManaType.."Min"]	= mana;
		["StartTime"]	= date("!%Y%m%d%H%MZ");
		["Combatlog"]	= {};
		["StartTimeStamp"] = time;
		["EndTimeStamp"] = time;
	}
end;

BarTracker_FinishLog = function ()
	BarTracker_HealthChanged();
	BarTracker_ManaChanged();
	BarTracker_Log["EndTimeStamp"] = GetTime();
end;

BarTracker_LoadLog = function (name)
	local idx = tonumber(name);
	if idx ~= nil then
		name = idx;
	end;
	if BarTracker_StoredLogs[name] ~= nil then
		BarTracker_Log = BarTracker_StoredLogs[name];
		BarTracker_RebuildAllDiagrams("BarTracker_OutputFrame0");
		BarTracker_FilterLog(BarTracker_Log["Combatlog"], BarTracker_LogFilter);
		BarTracker_LogViewUpdate();
		BarTracker_MSG("BarTracker: Loaded entry: "..name);
	else
		BarTracker_MSG("BarTracker: Loading entry "..name.." failed");
	end;
end;

BarTracker_StoreLog = function (name)
	local idx = tonumber(name);
	if idx ~= nil then
		table.insert(BarTracker_StoredLogs, idx, BarTracker_Log);
		BarTracker_StoredLogs[6] = nil;
	else
		BarTracker_StoredLogs[name] = BarTracker_Log;
	end;
	BarTracker_MSG("BarTracker: Stored entry "..name);
end;

BarTracker_DeleteLog = function (name)
	local idx = tonumber(name);
	if idx ~= nil then
		BarTracker_StoredLogs[idx] = nil;
	else
		BarTracker_StoredLogs[name] = nil;
	end;
	BarTracker_MSG("BarTracker: Deleted entry "..name);
end;

BarTracker_ListLog = function ()
	BarTracker_MSG("BarTracker: Stored Logs:");
	for name, log in pairs(BarTracker_StoredLogs) do
		BarTracker_MSG("> "..name.." @ "..log["StartTime"]);
	end;
end;

BarTracker_HealthChanged = function ()
	local health = UnitHealth("player");
	local time =  GetTime();
	local n = table.getn(BarTracker_Log["Health"]);
	if time > BarTracker_Log["Health"][n][2] then
		table.insert(BarTracker_Log["Health"], n+1, {health, time});
		BarTracker_Log["HealthMin"] = math.min(BarTracker_Log["HealthMin"], health);
	end;
end;

BarTracker_MaxHealthChanged = function ()
	local healthMax = UnitHealthMax("Player");
	local healthMaxOld = BarTracker_Log["HealthMax"];
	BarTracker_Log["HealthMax"] = math.max(healthMax, healthMaxOld);
end;

BarTracker_ManaChanged = function ()
	local mana = UnitMana("player");
	local time =  GetTime();
	local n = table.getn(BarTracker_Log[BarTracker_ManaType]);
	if time > BarTracker_Log[BarTracker_ManaType][n][2] then
		table.insert(BarTracker_Log[BarTracker_ManaType], n+1, {mana, time});
		BarTracker_Log[BarTracker_ManaType.."Min"] = math.min(BarTracker_Log[BarTracker_ManaType.."Min"], mana);
	end;
end;

BarTracker_MaxManaChanged = function ()
	local manaMax = UnitManaMax("Player");
	local manaMaxOld = BarTracker_Log[BarTracker_ManaType.."Max"];
	BarTracker_Log[BarTracker_ManaType.."Max"] = math.max(manaMax, manaMaxOld);
end;

BarTracker_AddChatLine = function (line)
	local time =  GetTime();
	for _, p in pairs(BarTracker_ForcePatterns) do
		if string.find(line, p) then
			table.insert(BarTracker_Log["Combatlog"], {time, line});
			return;
		end;
	end;
	for _, p in pairs(BarTracker_IgnorePatterns) do
		if string.find(line, p) then
			return;
		end;
	end;
	table.insert(BarTracker_Log["Combatlog"], {time, line});
end;
BarTracker_ForcePatterns = {
	" heals you";
	" fades from you";
}

BarTracker_IgnorePatterns = {
	" heals ";
	" gains";
	" casts";
	" begins to cast";
	" fades from";
	" slain";
}

BarTracker_RebuildAllDiagrams = function (basename)
	local base = getglobal(basename);
	if base then
		BarTracker_MaxWidth = (base:GetWidth()-BarTracker_hBorder);
		local container = getglobal(basename.."_Slider_ScrollContainer");
		if container then
			container:SetWidth(BarTracker_MaxWidth);
		end;
	
		local heightScale;
		if BarTracker_Settings["TimeScale"] > 0 then
			heightScale = BarTracker_Settings["TimeScale"];
		else
			heightScale = (BarTracker_OutputFrame0:GetHeight()-BarTracker_vBorder)/
				(BarTracker_Log["EndTimeStamp"]-BarTracker_Log["StartTimeStamp"]+1);
		end;
	
		BarTracker_RebuildDiagram(basename, "Health", heightScale);
		BarTracker_RebuildDiagram(basename, BarTracker_ManaType, heightScale);
		BarTracker_RebuildDiagramText(basename, heightScale);
	end;
end;

BarTracker_ResetDrawState = function ()
	BarTracker_DrawState = {
		["Health"] = {
			["pLast"]	= 0;
			["tLast"]	= 0;
			["index"]	= 1;
		};
	}
end;

BarTracker_RebuildDiagram = function (basename, Stat, heightScale)
	local container = getglobal(basename.."_Slider_ScrollContainer");
	local statMax = BarTracker_Log[Stat.."Max"];
	local tLast = BarTracker_Log["StartTimeStamp"]-1; -- BarTracker_Log[Stat][1][2]
	local vLast = BarTracker_Log[Stat][1][1];
	local pLast = 0;

	local color = BarTracker_Settings["Color"][Stat];
	local j = 1;
	local anchor = BarTracker_StatAnchors[Stat];
	for i, a in pairs(BarTracker_Log[Stat]) do
		local tex = getglobal(basename.."_Tex"..Stat..i);
		if tex == nil then
			tex = container:CreateTexture(
				basename.."_Tex"..Stat..i,
				basename.."_Slider_ScrollContainer_ScrollLayerBars");
		end;
		local height = (a[2]-tLast)*heightScale;
		tex:ClearAllPoints();
		tex:SetTexture(color[1], color[2], color[3], color[4]);
		local w = BarTracker_MaxWidth*vLast/statMax*0.5;
		if w == 0 then w = 0.01; end;
		tex:SetWidth(w);
		tex:SetHeight(height);
		tex:SetPoint(anchor, 0, pLast);
		pLast = pLast - height;
		tLast = a[2];
		vLast = a[1];
		j = j + 1;
	end;
	while true do
		local tex = getglobal(basename.."_Tex"..Stat..j);
		if tex == nil then
			break;
		else
			tex:SetTexture(0.0, 0.0, 0.0, 0.0);
		end;
		j = j + 1;
	end;
	container:SetHeight(-1*pLast);
	getglobal(basename.."_Slider"):UpdateScrollChildRect();
end;

BarTracker_RebuildDiagramText = function (basename, heightScale)
	local container = getglobal(basename.."_Slider_ScrollContainer");
	local pText = 0;
	local pLast = container:GetHeight()*-1;
	local i = 0;
	while pText > pLast do
		local text = getglobal(basename.."_Text"..i);
		if text == nil then
			text = container:CreateFontString(
				basename.."_Text"..i,
				basename.."_Slider_ScrollContainer_ScrollLayerText");
			text:SetFontObject(GameFontNormalSmall);
			text:SetJustifyH("CENTER");
			text:SetTextColor(1,1,1,0.5);
		end;
		text:SetText(string.format("%2.1f",(i*30/heightScale)).." sec");
		text:SetWidth(BarTracker_MaxWidth);
		text:SetPoint("TOPLEFT", 0, pText);
		pText = pText - 30;
		i = i + 1;
	end;
	while true do
		local text = getglobal(basename.."_Text"..i);
		if text == nil then
			break;
		else
			text:SetText("");
		end;
		i = i + 1;
	end;
	for i = 0, 1, 0.125 do
		local tex = getglobal(basename.."_Mark"..i);
		if tex == nil then
			tex = container:CreateTexture(basename.."_Mark"..i,
				basename.."_Slider_ScrollContainer_ScrollLayerBars");
			tex:SetTexture(1,1,1, 0.25);
		end;
		tex:SetWidth(1/BarTracker_Settings["Scale"]);
		tex:SetPoint("TOPLEFT", BarTracker_MaxWidth*i, 0);
		tex:SetHeight(-pLast);
	end;
end;

--[[ Fullscreen View ]]
BarTracker_ShowFullscreen = function ()
	local base = BarTracker_FullscreenFrame;
	local basename = "BarTracker_FullscreenFrame";
	local w = GetScreenWidth();
	local h = GetScreenHeight();
	base:SetWidth(w);
	base:SetHeight(h);
	BarTracker_MaxWidth = (w-32);
	BarTracker_FullscreenFrame_Slider_ScrollContainer:SetWidth(BarTracker_MaxWidth);
	base:Show();

	local heightScale = 14;

	BarTracker_RebuildDiagram(basename, "Health", heightScale);
	BarTracker_RebuildDiagram(basename, BarTracker_ManaType, heightScale);
	BarTracker_RebuildDiagramText(basename, heightScale);
	BarTracker_RebuildLogText(basename, heightScale);
	BarTracker_FullscreenFrame_Slider:SetVerticalScroll(0);
	BarTracker_FullscreenFrame_Slider:UpdateScrollChildRect();
end;

BarTracker_RebuildLogText = function (basename, heightScale)
	local container = getglobal(basename.."_Slider_ScrollContainer");
	local logStart = BarTracker_Log["StartTimeStamp"]
	local log = BarTracker_Log["Combatlog"];
	if not log then return; end;

	heightScale = -1*heightScale;
	local color, str, time, text;
	local pLast, pNow, pIndent; pLast = 14;
	local i = 1;
	while log[i] do
		str = log[i][2];
		time = log[i][1]-logStart;
		color = BarTracker_ColorForLogEntry(str);

		text = getglobal(basename.."_LogText"..i);
		if text == nil then
			text = container:CreateFontString(
				basename.."_LogText"..i,
				basename.."_Slider_ScrollContainer_ScrollLayerText");
			text:SetFontObject(GameFontNormalSmall);
			text:SetJustifyH("LEFT");
		end;
		text:SetText(string.format("%2.1f: ",time)..str);
		text:SetTextColor(color.r, color.g, color.b, 1);
		text:SetWidth(BarTracker_MaxWidth);
		pNow = time*heightScale;
		local diff = math.min(pNow - pLast, 0); -- limits indent to 10
		if diff > -10 then
			pNow = pLast - 10;
			pIndent = math.min(pIndent + 10 + diff, 60);
		else
			pIndent = 4;
		end;
		text:SetPoint("TOPLEFT", pIndent, pNow);
		pLast = pNow;
		
		i = i+1;
	end;
	text = getglobal(basename.."_LogText"..i);
	while text do
		text:SetText("");
		text:SetPoint("TOPLEFT", 0, 0);
		i = i+1;
		text = getglobal(basename.."_LogText"..i);
	end;
end;

--[[ Log View ]]
BarTracker_LogFilter = "";
BarTracker_LogFiltered = {};
BarTracker_LogFrameLines = 10;
BarTracker_LogFrameLineHeight = 16;
BarTracker_LogViewUpdate = function ()
	BarTracker_ResizeFrame();
	if not BarTracker_Log["Combatlog"] then return; end;
	
	local logStart = BarTracker_Log["StartTimeStamp"];
	local numEntries = table.getn(BarTracker_LogFiltered);
	local numAll = table.getn(BarTracker_Log["Combatlog"]);
	local offset = FauxScrollFrame_GetOffset(BarTracker_LogViewer_ScrollFrame);

	for i = 1,BarTracker_LogFrameLines,1 do
		local logEntry = getglobal("BarTracker_LogViewer".."_LogText"..i);
		if BarTracker_LogFiltered[i+offset] then
			local logEntryText = getglobal("BarTracker_LogViewer".."_LogText"..i.."_Text");
			local logEntryTime = getglobal("BarTracker_LogViewer".."_LogText"..i.."_Time");
			local logEntryHealth = getglobal("BarTracker_LogViewer".."_LogText"..i.."_Health");
			local logEntryPower = getglobal("BarTracker_LogViewer".."_LogText"..i.."_Power");
			local str = BarTracker_LogFiltered[i+offset][2];
			local t = BarTracker_LogFiltered[i+offset][1];
			local color = BarTracker_ColorForLogEntry(str);
			local h, m = BarTracker_StatsAtTime(t);
			logEntryText:SetText(str);
			logEntryText:SetTextColor(color.r, color.g, color.b, 1);
			logEntryTime:SetText(string.format("%2.1f s",t-logStart));
			logEntryHealth:SetText(h);
			logEntryPower:SetText(m);
			logEntry.time = t-logStart;
			logEntry:Show();
		else
			logEntry:Hide();
		end;
	end;

	getglobal("BarTracker_LogViewer_Count"):SetText(numEntries.."/"..numAll);
	
	FauxScrollFrame_Update(BarTracker_LogViewer_ScrollFrame,
		numEntries,
		BarTracker_LogFrameLines,
		BarTracker_LogFrameLineHeight);
end;

BarTracker_FilterLog = function (logInput, pattern)
	local logOutput = {};
	for i, l in ipairs(logInput) do
		if string.find(l[2], pattern) then
			table.insert(logOutput, l);
		end;
	end;
	BarTracker_LogFiltered = logOutput;
	return logOutput;
end;

BarTracker_ResizeFrame = function ()
	BarTracker_LogFrameLines = (BarTracker_LogViewer:GetHeight()-32)/BarTracker_LogFrameLineHeight;
	local logEntry;
	local hc = BarTracker_Settings["Color"]["Health"];
	local mc = BarTracker_Settings["Color"][BarTracker_ManaType];
	for i = 1, BarTracker_LogFrameLines, 1 do
		logEntry = getglobal("BarTracker_LogViewer".."_LogText"..i);
		if logEntry == nil then
			logEntry = CreateFrame(
				"Button",
				"BarTracker_LogViewer".."_LogText"..i,
				BarTracker_LogViewer, -- BarTracker_LogViewer_ScrollFrame
				"BarTracker_LogLineFrameTemplate");
			logEntry:SetPoint("TOPLEFT", BarTracker_LogViewer_ScrollFrame,
				"TOPLEFT", 0, -(i-1)*BarTracker_LogFrameLineHeight);
			logEntry:SetPoint("BOTTOMRIGHT", BarTracker_LogViewer_ScrollFrame,
				"TOPRIGHT", 0, -(i)*BarTracker_LogFrameLineHeight);
			local logEntryH = getglobal("BarTracker_LogViewer".."_LogText"..i.."_Health");
			local logEntryP = getglobal("BarTracker_LogViewer".."_LogText"..i.."_Power");
			logEntryH:SetTextColor(hc[1], hc[2], hc[3]);
			logEntryP:SetTextColor(mc[1], mc[2], mc[3]);
		end;
	end;
	local i = 1;
	logEntry = getglobal("BarTracker_LogViewer".."_LogText"..i);
	while logEntry do
		logEntry:Hide();
		i = i + 1;
		logEntry = getglobal("BarTracker_LogViewer".."_LogText"..i);
	end;
end;

BarTracker_ScrollToTime = function (t)
	local pointInTime = BarTracker_Log["StartTimeStamp"]+t;
	local i = 1; -- linear search! omg!
	while BarTracker_LogFiltered[i] and BarTracker_LogFiltered[i][1] < pointInTime do
		i = i + 1;
	end;
	i = math.floor(math.max(1, i-BarTracker_LogFrameLines/2));
	BarTracker_LogViewer_ScrollFrameScrollBar:SetValue(i*BarTracker_LogFrameLineHeight);
	FauxScrollFrame_SetOffset(BarTracker_LogViewer_ScrollFrame, i);
	BarTracker_LogViewUpdate();
end;

-- [[ Tooltip Functions ]]
BarTracker_OnMouseEnter = function ()
	if (BarTracker_Tooltip:IsOwned(UIParent)) then
		BarTracker_Tooltip:ClearLines();
	else
		local anchor;
		local x, y = this:GetCenter();
		local scale = this:GetScale();
		if x*scale > GetScreenWidth()/2 then
			anchor = "ANCHOR_LEFT";
		else
			anchor = "ANCHOR_RIGHT";
		end;
		BarTracker_Tooltip:SetOwner(this, anchor);
	end;
	-- Fill the Tooltip
	BarTracker_Tooltip:AddLine("BarTracker", 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Start Time", BarTracker_Log["StartTime"], 1,1,1, 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Duration",
		string.format("%2.1f",BarTracker_Log["EndTimeStamp"]-BarTracker_Log["StartTimeStamp"]).."s", 1,1,1, 1,1,1);
	local color = BarTracker_Settings["Color"]["Health"];
	BarTracker_Tooltip:AddDoubleLine("Health", nil, color[1],color[2],color[3], color[1],color[2],color[3]);
	BarTracker_Tooltip:AddDoubleLine("Max", BarTracker_Log["HealthMax"], color[1],color[2],color[3], 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Min", BarTracker_Log["HealthMin"], color[1],color[2],color[3], 1,1,1);
	local gain, loss, maxGain, maxLoss = BarTracker_CalculateChanges("Health");
	BarTracker_Tooltip:AddDoubleLine("Gain", gain, color[1],color[2],color[3], 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Max Gain", maxGain, color[1],color[2],color[3], 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Loss", loss, color[1],color[2],color[3], 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Max Loss", maxLoss, color[1],color[2],color[3], 1,1,1);
	
	local color = BarTracker_Settings["Color"][BarTracker_ManaType];
	BarTracker_Tooltip:AddDoubleLine(BarTracker_ManaType, nil, color[1],color[2],color[3], 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Max", BarTracker_Log[BarTracker_ManaType.."Max"], color[1],color[2],color[3], 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Min", BarTracker_Log[BarTracker_ManaType.."Min"], color[1],color[2],color[3], 1,1,1);
	local gain, loss, maxGain, maxLoss = BarTracker_CalculateChanges(BarTracker_ManaType);
	BarTracker_Tooltip:AddDoubleLine("Gain", gain, color[1],color[2],color[3], 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Max Gain", maxGain, color[1],color[2],color[3], 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Loss", loss, color[1],color[2],color[3], 1,1,1);
	BarTracker_Tooltip:AddDoubleLine("Max Loss", maxLoss, color[1],color[2],color[3], 1,1,1);
	
	BarTracker_Tooltip:Show();
	
	if BarTracker_Settings["Combatlog"] then
		BarTracker_MainFrame:SetScript("OnUpdate", BarTracker_TooltipOnUpdate);
	end;
end;

BarTracker_OldX = -1;
BarTracker_OldY = -1;
BarTracker_TooltipOnUpdate = function ()
	local mx, my = GetCursorPosition();
	if mx == BarTracker_OldX and my == BarTracker_OldY then
		return;
	else
		BarTracker_OldX = mx;
		BarTracker_OldY = my;
	end;
	local x = BarTracker_OutputFrame0:GetLeft() + BarTracker_hBorder/2;
	local y = BarTracker_OutputFrame0:GetTop() - BarTracker_vBorder/2;
	local scaleL, scaleW;
	scaleL = BarTracker_OutputFrame0:GetScale();
	scaleW = UIParent:GetScale();
	mx = mx/scaleW;
	my = my/scaleW;
	x = x*scaleL;
	y = y*scaleL
	x = (mx - x)/scaleL;
	y = (my - y)/scaleL;
	local heightScale;
	if BarTracker_Settings["TimeScale"] > 0 then
		heightScale = BarTracker_Settings["TimeScale"];
	else
		heightScale = (BarTracker_OutputFrame0:GetHeight()-BarTracker_vBorder)/
			(BarTracker_Log["EndTimeStamp"]-BarTracker_Log["StartTimeStamp"]+1);
	end;
	
	if (BarTracker_TooltipLog:IsOwned(UIParent)) then
		BarTracker_TooltipLog:ClearLines();
	else
		local anchor, anchorO;
		local x, y = BarTracker_OutputFrame0:GetCenter();
		local scale = BarTracker_OutputFrame0:GetScale();
		if x*scale > GetScreenWidth()/2 then
			anchor = "TOPRIGHT";
			anchorO = "TOPLEFT";
		else
			anchor = "TOPLEFT";
			anchorO = "TOPRIGHT";
		end;
		BarTracker_TooltipLog:SetOwner(BarTracker_OutputFrame0, "ANCHOR_NONE");
		BarTracker_TooltipLog:SetPoint(anchor, BarTracker_OutputFrame0, anchorO);
	end;
	
	local i = 1;
	local log = BarTracker_Log["Combatlog"];
	local logStart = BarTracker_Log["StartTimeStamp"];
	local logTime = -y/heightScale + logStart;
	
	local hc = BarTracker_Settings["Color"]["Health"];
	local mc = BarTracker_Settings["Color"][BarTracker_ManaType];
	local h,m = BarTracker_StatsAtTime(logTime);
	
	BarTracker_TooltipLog:AddDoubleLine("Combatlog", string.format("%2.1f", logTime-logStart), 1,1,1, 1,1,1);
	BarTracker_TooltipLog:AddDoubleLine("Health: "..h,
		BarTracker_ManaType..": "..m,
		hc[1],hc[2],hc[3], mc[1],mc[2],mc[3]);

	if (not log) or (not log[1]) then return; end;
	while log[i] and log[i][1] < logTime do -- linear search! omg!
		i = i+1;
	end;
	i = math.max(i - 3,1);
	local j = 0;
	local color = {["r"] = 0.75; ["g"] = 0.75; ["b"] = 0.75;};
	while log[i] and j < 7 do
		local str = log[i][2];
		color = BarTracker_ColorForLogEntry(str);
		BarTracker_TooltipLog:AddDoubleLine(str, string.format("%2.1f",log[i][1]-logStart),
			color.r,color.g, color.b, 0.75,0.75,0.75);
		i = i+1;
		j = j+1;
	end;
	BarTracker_TooltipLog:Show();
end;

BarTracker_StatsAtTime = function (logTime)
	local iH = 1;
	local iM = 1;
	local logH = BarTracker_Log["Health"];
	local logM = BarTracker_Log[BarTracker_ManaType];
	while logH[iH] and logH[iH][2] < logTime do -- linear search! omg!
		iH = iH+1;
	end;
	while logM[iM] and logM[iM][2] < logTime do -- linear search! omg!
		iM = iM+1;
	end;
	
	return logH[math.max(1,iH-1)][1], logM[math.max(1,iM-1)][1];
end;

BarTracker_ColorForLogEntry = function (str)
	if string.find(str, "heals you") or string.find(str, "^You gain (%d+) health") then
		color =  {["r"] = 0.5; ["g"] = 1.0; ["b"] = 0.5;};
	elseif string.find(str, "^You gain (%d+) Mana") or string.find(str, "^You gain (%d+) Rage") or
		string.find(str, "^You gain (%d+) Energy")then
		color =  {["r"] = 0.5; ["g"] = 0.5; ["b"] = 1.0;};
	elseif string.find(str, "^You suffer") or string.find(str, "its you") then
		color =  {["r"] = 1.00; ["g"] = 0.5; ["b"] = 0.5;};
	elseif string.find(str, "die") then
		color =  {["r"] = 1.00; ["g"] = 0.0; ["b"] = 0.0;};
	elseif string.find(str, "afflicted") then
		color =  {["r"] = 1.0; ["g"] = 0.5; ["b"] = 1.0;};
	elseif string.find(str, "gain") then
		color =  {["r"] = 1.0; ["g"] = 1.0; ["b"] = 0.5;};
	else	
		color = {["r"] = 0.75; ["g"] = 0.75; ["b"] = 0.75;};
	end;
	return color;
end;

BarTracker_CalculateChanges = function (Stat)
	local gain = 0;
	local loss = 0;
	local maxGain = 0;
	local maxLoss = 0;
	local last = BarTracker_Log[Stat][1][1];
	for i, a in pairs(BarTracker_Log[Stat]) do
		local change = a[1] - last;
		if change > 0 then
			gain = gain + change;
			if change > maxGain then maxGain = change; end;
		else
			loss = loss - change;
			if change < maxLoss then maxLoss = change; end;
		end;
		last = a[1];
	end;
	return gain, loss, maxGain, -maxLoss;
end;

BarTracker_OnMouseLeave = function ()
	BarTracker_Tooltip:Hide();
	BarTracker_TooltipLog:Hide();
	BarTracker_MainFrame:SetScript("OnUpdate", nil);
end;

BarTracker_PrintLog = function (stat)
	for _, a in pairs(BarTracker_Log[stat]) do
		BarTracker_MSG(a[2] .. ": " .. a[1]);
	end;
end;

--[[ Settings ]]
BarTracker_ToggleShown = function (state)
	BarTracker_TogglePref("Show", state);
	if BarTracker_Settings["Show"] then
		BarTracker_OutputFrame0:Show();
	else
		BarTracker_OutputFrame0:Hide();
	end;
end;

BarTracker_SetTimescale = function (scale)
	BarTracker_SetPrefNum("TimeScale", scale);
	if BarTracker_Settings["TimeScale"] == 0 then
		BarTracker_VisualModeScale();
	else
		BarTracker_VisualModeScroll();
	end;
	BarTracker_RebuildAllDiagrams("BarTracker_OutputFrame0");
end;

BarTracker_TogglePref = function (setting, state)
	local array = BarTracker_Settings;
	if state == "off" or state == "false" then
		array[setting] = false;
		BarTracker_MSG("BT: "..setting.." Disabled");
	elseif state == "on" or state == "true" then
		array[setting] = true;
		BarTracker_MSG("BT: "..setting.." Enabled");
	else
		array[setting] = not array[setting];
		if array[setting] then
			BarTracker_MSG("BT: "..setting.." Enabled");
		else
			BarTracker_MSG("BT: "..setting.." Disabled");
		end;
	end;
end;

BarTracker_SetPrefNum = function (setting, value)
	local valueNum = tonumber(value);
	if valueNum == nil then
		BarTracker_MSG("BT: "..setting.." Input Error, "..value.." is not a number");
	else 
		BarTracker_Settings[setting] = valueNum;
		BarTracker_MSG("BT: "..setting.." set to "..valueNum);
	end;
end;

BarTracker_SlashHandler = function (msg)
 	local Cmd, SubCmd = BarTracker_GetCmd(msg);
 	Cmd = string.lower(Cmd);
 	if (Cmd == "show") then
		BarTracker_ToggleShown(SubCmd);
	elseif (Cmd == "scale") then
		BarTracker_SetPrefNum("Scale", SubCmd);
		BarTracker_OutputFrame0:SetScale(BarTracker_Settings["Scale"]);
	elseif (Cmd == "alpha") then
		BarTracker_SetPrefNum("Alpha", SubCmd);
		BarTracker_OutputFrame0:SetAlpha(BarTracker_Settings["Alpha"]);
	elseif (Cmd == "timescale") then
		BarTracker_SetTimescale(SubCmd);
	elseif (Cmd == "timeout") then
		BarTracker_SetPrefNum("Timeout", SubCmd);
	elseif (Cmd == "combatlog") then
		BarTracker_TogglePref("Combatlog", SubCmd);
	elseif (Cmd == "battlemode") then
		if SubCmd == "auto" then
			BarTracker_Settings["BattleMode"] = "auto";
			BarTracker_MSG("BT:  Battle Mode set to Automatic");
		elseif SubCmd == "manual" then
			BarTracker_Settings["BattleMode"] = "manual";
			BarTracker_MSG("BT:  Battle Mode set to Manual");
		else
			BarTracker_MSG("BT: Battle Mode Input Error");
		end;
	elseif (Cmd == "print") then
		BarTracker_PrintLog(SubCmd);
	elseif (Cmd == "rebuild") then
		BarTracker_RebuildAllDiagrams("BarTracker_OutputFrame0");
	elseif (Cmd == "load") then
		BarTracker_LoadLog(SubCmd);
	elseif (Cmd == "store") then
		BarTracker_StoreLog(SubCmd);
	elseif (Cmd == "list") then
		BarTracker_ListLog();
	elseif (Cmd == "delete") then
		BarTracker_DeleteLog(SubCmd);
	elseif (Cmd == "start") then
		BarTracker_EnterCombat();
	elseif (Cmd == "pause") then
		BarTracker_LeaveCombat();
 	else
 		BarTracker_MSG("|cffccccccBarTracker v"..BarTracker_Version);
 		BarTracker_MSG("Shift Click to Move, Alt Click to resize, Ctrl Click for menu");
		BarTracker_MSG("/bartracker show [on|off]");
		BarTracker_MSG("/bartracker scale <num>");
		BarTracker_MSG("/bartracker battlemode [auto|manual]");
		BarTracker_MSG("/bartracker timeout <num>");
		BarTracker_MSG("/bartracker timescale <num>");
		BarTracker_MSG("/bartracker combatlog [on|off]");
		BarTracker_MSG("/bartracker load <numame>");
		BarTracker_MSG("/bartracker store <numame>");
		BarTracker_MSG("/bartracker list");
		BarTracker_MSG("/bartracker delete <numame>");
		BarTracker_MSG("/bartracker start");
		BarTracker_MSG("/bartracker pause");
 	end;
end;

BarTracker_MSG = function (msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end;

BarTracker_Transforming = false;
BarTracker_FrameMouseDown = function ()
	if (arg1 == "LeftButton") then
		if (IsShiftKeyDown()) then
			this:StartMoving();
			BarTracker_Transforming = true;
		elseif (IsAltKeyDown()) then
			local w = this:GetWidth();
			local h = this:GetHeight();
			local x, y = this:GetCenter();
			local mx, my = GetCursorPosition();
			local scaleL, scaleW;
			scaleL = this:GetScale();
			scaleW = UIParent:GetScale();
			mx = mx/scaleW;
			my = my/scaleW;
			x = x*scaleL;
			y = y*scaleL;
			x = mx - x;
			y = my - y;
			x = x/w*h;
			if (abs(x) > abs(y)) then
				if (x > 0) then
					this:StartSizing("RIGHT");
				else
					this:StartSizing("LEFT");
				end;
			else
				if (y > 0) then
					this:StartSizing("TOP");
				else
					this:StartSizing("BOTTOM");
				end;
			end;
			BarTracker_Transforming = true;
		end;
	elseif (arg1 == "RightButton") then
		local menu = getglobal(this:GetName().."_Menu");
		ToggleDropDownMenu(1, nil, menu, this:GetName(), 0, 0);
	end;
end;

--[[
List of button attributes
======================================================
info.text = [STRING]  --  The text of the button
info.value = [ANYTHING]  --  The value that UIDROPDOWNMENU_MENU_VALUE is set to when the button is clicked
info.func = [function()]  --  The function that is called when you click the button
info.checked = [nil, 1]  --  Check the button
info.isTitle = [nil, 1]  --  If it's a title the button is disabled and the font color is set to yellow
info.disabled = [nil, 1]  --  Disable the button and show an invisible button that still traps the mouseover event so menu doesn't time out
info.hasArrow = [nil, 1]  --  Show the expand arrow for multilevel menus
info.hasColorSwatch = [nil, 1]  --  Show color swatch or not, for color selection
info.r = [1 - 255]  --  Red color value of the color swatch
info.g = [1 - 255]  --  Green color value of the color swatch
info.b = [1 - 255]  --  Blue color value of the color swatch
info.textR = [1 - 255]  --  Red color value of the button text
info.textG = [1 - 255]  --  Green color value of the button text
info.textB = [1 - 255]  --  Blue color value of the button text
info.swatchFunc = [function()]  --  Function called by the color picker on color change
info.hasOpacity = [nil, 1]  --  Show the opacity slider on the colorpicker frame
info.opacity = [0.0 - 1.0]  --  Percentatge of the opacity, 1.0 is fully shown, 0 is transparent
info.opacityFunc = [function()]  --  Function called by the opacity slider when you change its value
info.cancelFunc = [function(previousValues)] -- Function called by the colorpicker when you click the cancel button (it takes the previous values as its argument)
info.notClickable = [nil, 1]  --  Disable the button and color the font white
info.notCheckable = [nil, 1]  --  Shrink the size of the buttons and don't display a check box
info.owner = [Frame]  --  Dropdown frame that "owns" the current dropdownlist
info.keepShownOnClick = [nil, 1]  --  Don't hide the dropdownlist after a button is clicked
info.tooltipTitle = [nil, STRING] -- Title of the tooltip shown on mouseover
info.tooltipText = [nil, STRING] -- Text of the tooltip shown on mouseover
info.justifyH = [nil, "CENTER"] -- Justify button text
info.arg1 = [ANYTHING] -- This is the first argument used by info.func
info.arg2 = [ANYTHING] -- This is the second argument used by info.func
info.textHeight = [NUMBER] -- font height for button text
]]

BarTracker_Menu_Initialize = function (level)
	if level == 1 then
		UIDropDownMenu_AddButton({
			["text"] = "BarTracker v"..BarTracker_Version;
			["isTitle"] = 1;
			["notCheckable"] = 1;
			["owner"] = BarTracker_OutputFrame0;
			});
		if BarTracker_Settings["BattleMode"] == "manual" then
		UIDropDownMenu_AddButton({
			["text"] = "Start";
			["notCheckable"] = 1;
			["func"] = BarTracker_EnterCombat;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Pause";
			["notCheckable"] = 1;
			["func"] = BarTracker_LeaveCombat;
			});
		end;
		UIDropDownMenu_AddButton({
			["text"] = "Show Log View";
			["notCheckable"] = 1;
			["func"] = BarTracker_LogViewer.Show;
			["arg1"] = BarTracker_LogViewer;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Show Fullscreen";
			["notCheckable"] = 1;
			["func"] = BarTracker_ShowFullscreen;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Store";
			["notCheckable"] = 1;
			["func"] = BarTracker_StoreName.Show;
			["arg1"] = BarTracker_StoreName;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Load";
			["value"] = "Load";
			["notCheckable"] = 1;
			["hasArrow"] = 1;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Hide";
			["notCheckable"] = 1;
			["func"] = BarTracker_ToggleShown;
			["arg1"] = "off";
			});
		UIDropDownMenu_AddButton({
			["text"] = "Options";
			["isTitle"] = 1;
			["notCheckable"] = 1;
			});
		UIDropDownMenu_AddButton({
			["text"] = "BattleMode";
			["value"] = "BattleMode";
			["notCheckable"] = 1;
			["hasArrow"] = 1;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Timescale";
			["value"] = "Timescale";
			["notCheckable"] = 1;
			["hasArrow"] = 1;
			});
		UIDropDownMenu_AddButton({
			["text"] = "OOC Timeout";
			["value"] = "Timeout";
			["notCheckable"] = 1;
			["hasArrow"] = 1;
			});
		local checked;
		if BarTracker_Settings["Combatlog"] then
			checked = 1;
		else
			checked = nil;
		end;
		UIDropDownMenu_AddButton({
			["text"] = "Combatlog";
			["value"] = "Timeout";
			["checked"] = checked;
			["func"] = BarTracker_SlashHandler;
			["arg1"] = "combatlog";
			});
	elseif level == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "Timescale" then
			UIDropDownMenu_AddButton({
				["text"] = "Autoscale";
				["notCheckable"] = 1;
				["func"] = BarTracker_SetTimescale;
				["arg1"] = 0;
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "1";
				["notCheckable"] = 1;
				["func"] = BarTracker_SetTimescale;
				["arg1"] = 1;
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "2";
				["notCheckable"] = 1;
				["func"] = BarTracker_SetTimescale;
				["arg1"] = 2;
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "5";
				["notCheckable"] = 1;
				["func"] = BarTracker_SetTimescale;
				["arg1"] = 5;
				}, 2);
		elseif UIDROPDOWNMENU_MENU_VALUE == "Timeout" then
			UIDropDownMenu_AddButton({
				["text"] = "off";
				["notCheckable"] = 1;
				["func"] = BarTracker_SetPrefNum;
				["arg1"] = "Timeout";
				["arg2"] = 0;
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "15 secs";
				["notCheckable"] = 1;
				["func"] = BarTracker_SetPrefNum;
				["arg1"] = "Timeout";
				["arg2"] = 15;
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "30 secs";
				["notCheckable"] = 1;
				["func"] = BarTracker_SetPrefNum;
				["arg1"] = "Timeout";
				["arg2"] = 30;
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "60 secs";
				["notCheckable"] = 1;
				["func"] = BarTracker_SetPrefNum;
				["arg1"] = "Timeout";
				["arg2"] = 60;
				}, 2);
		elseif UIDROPDOWNMENU_MENU_VALUE == "BattleMode" then
			UIDropDownMenu_AddButton({
				["text"] = "Automatic";
				["notCheckable"] = 1;
				["func"] = BarTracker_SlashHandler; -- ugly hack, I know...
				["arg1"] = "battlemode auto";
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "Manual";
				["notCheckable"] = 1;
				["func"] = BarTracker_SlashHandler; -- ugly hack, I know...
				["arg1"] = "battlemode manual";
				}, 2);
		elseif UIDROPDOWNMENU_MENU_VALUE == "Load" then
			local i = 1;
			for name, log in pairs(BarTracker_StoredLogs) do
				if i > 20 then	
					UIDropDownMenu_AddButton({
						["text"] = "More...";
						["notCheckable"] = 1;
						["disabled"] = 1;
						}, 2);
					return;
				end;
			UIDropDownMenu_AddButton({
				["text"] = name.." @ "..log["StartTime"];
				["notCheckable"] = 1;
				["func"] = BarTracker_LoadLog;
				["arg1"] = name;
				}, 2);
			i = i + 1;
			end;
		end;
	end
end;

BarTracker_Menu_Load = function ()
	UIDropDownMenu_Initialize(BarTracker_Menu, BarTracker_Menu_Initialize, "MENU");
end;

BarTracker_FrameResizing = function ()
	local height = BarTracker_OutputFrame0:GetHeight();
	BarTracker_MaxWidth = (BarTracker_OutputFrame0:GetWidth()-BarTracker_hBorder)/2;
	BarTracker_RebuildAllDiagrams("BarTracker_OutputFrame0");
end;

-- Some CMD parsing code, written by Tigerheart on http://www.wowwiki.com/HOWTO:_Extract_Info_from_a_Slash_Command
BarTracker_GetCmd = function (msg)
	if msg then
		local a,b,c=strfind(msg, "(%S+)"); --contiguous string of non-space characters
		if a then
			return c, strsub(msg, b+2);
		else	
			return "";
		end
	end
end;

BarTracker_GetArgument = function (msg)
	if msg then
		local a,b=strfind(msg, "=");
		if a then
			return strsub(msg,1,a-1), strsub(msg, b+1);
		else
			return "";
		end
	end
end;
