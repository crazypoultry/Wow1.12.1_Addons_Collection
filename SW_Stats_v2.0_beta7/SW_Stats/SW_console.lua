
function SW_SlashCommand(msg)
	if msg == nil then return; end
	
	local _,_, c, v = string.find(msg, "([^ ]+) (.+)");
	if c == nil then
		c = string.gsub(msg, " ", "");
	end
	if c == "" then
		SW_PrintHelp();
		return;
	end
	
	local cmd = nil;
	for k,v in pairs(SW_SlashCommands) do
		if v["c"] == c then
			cmd = v;
			break;
		end
	end
	if cmd == nil then
		SW_printStr(SW_CONSOLE_NOCMD .. c);
		SW_printStr(SW_CONSOLE_HELP ..SW_RootSlashes[1].." "..SW_SlashCommands["help"]["c"]);
		return;
	end
	
	if cmd["aC"] > 0 then
		if v == nil or string.gsub(v, " ", "") == "" then
			SW_printStr(cmd["u"]);
			return;
		end
		cmd["f"](v);
	elseif cmd["aC"] < 0 then -- 2.0.beta.2 optional arguments
		if not v or string.gsub(v, " ", "") == "" then
			cmd["f"]();
		else
			cmd["f"](v);
		end
	else
		cmd["f"]();
	end
end
function SW_ResetAllWindows()
	SW_BarFrame1:SetPoint("TOPLEFT",UIParent, "CENTER", -50, 50); 
	SW_BarFrame1:SetWidth(200);
	SW_BarFrame1:SetHeight(300);
	SW_BarFrame1:Show();
	SW_BarsLayout("SW_BarFrame1");
	
	SW_TextWindow:SetPoint("TOPLEFT", UIParent, "CENTER");
	SW_GeneralSettings:SetPoint("TOPLEFT",UIParent, "CENTER", 20, -20);
	SW_GeneralSettings:Show();
	SW_BarReportFrame:SetPoint("TOPLEFT",UIParent, "CENTER", 40, -40);
	SW_BarReportFrame:Show();
	SW_BarSyncFrame:SetPoint("TOPLEFT",UIParent, "CENTER", 60, -60);
	SW_BarSyncFrame:Show();
	SW_BarSettingsFrameV2:SetPoint("TOPLEFT",UIParent, "CENTER");
	SW_FrameConsole:SetPoint("TOPLEFT",UIParent, "CENTER");
	SW_TimeLine:SetPoint("TOPLEFT",UIParent, "CENTER");
end
function SW_ToggleConsole()
	local frame = getglobal("SW_FrameConsole")
	if(  frame:IsVisible() ) then
		frame:Hide();
	else
		frame:Show();
	end
end
function SW_ToggleBarFrame()
	local frame = getglobal("SW_BarFrame1")
	if(  frame:IsVisible() ) then
		SW_Settings["SHOWMAIN"] = nil;
		frame:Hide();
	else
		SW_Settings["SHOWMAIN"] = true;
		frame:Show();
	end
end
function SW_ToggleLocks()
	if SW_Settings["BFLocked"] then
		SW_LockFrames();
	else
		SW_LockFrames(true);
	end
end
function SW_ToggleMMIcon()
	if SW_Settings.HideMiniMap then
		SW_Settings.HideMiniMap = false;
		SW_IconFrame:Show();
	else
		SW_Settings.HideMiniMap = true;
		SW_IconFrame:Hide();
	end
end
function SW_ToggleGeneralSettings()
	local frame = getglobal("SW_GeneralSettings")
	if(  frame:IsVisible() ) then
		frame:Hide();
	else
		frame:Show();
	end
end
function SW_DumpVar(cmdString)
	local varName = string.gsub(cmdString, " ", "")
	local g = getfenv();
	
	if g[varName] == nil then
		SW_printStr(varName..SW_CONSOLE_NIL_TRAILER);
		return;
	else
		if type(g[varName]) == "table" then
			SW_DumpTable(g[varName]);
		else
			SW_printStr(g[varName]);
		end
	end
	
end
function SW_ResetInfo(newName)
	SW_CombatTime = 0;
	SW_DPS_Dmg =0;
	
	SW_DataCollection:createNewSegment(newName);
end
function SW_ShowNukeDialog()
	StaticPopup_Show("SW_TL_Nuke");
end
function SW_NukeDataCollection()
	SW_StrTable = SW_C_StringTable:new(); 
	SW_DataCollection = SW_C_DataCollection:new();
	SW_DataCollection.meta:updateGroupRaid();
	SW_DataCollection:raiseMarkerChanged();
	SW_DataCollection:checkGroup();
	collectgarbage();
end
function SW_PostCheck(target)
	
	if SW_RPOST then
		return true;
	end
	if UnitInRaid("player") then
		if IsRaidLeader() or IsRaidOfficer() then
			return true;
		else
			if target == "RAID" then
				return false;
			else
				return true;
			end
		end
	--[[ hmm i think this is to restrictive
	elseif UnitInParty("player") then
		if IsPartyLeader() then
			return true;
		else
			if target == "PARTY" then
				return false;
			else
				return true;
			end
		end
	--]]
	else
		return true;
	end
end
function SW_InitResetVote(newName)
	if not newName then
		newName = SW_DS_RESET;
	end
	if SW_SYNC_DO and SW_SYNC_TO_USE then
		SW_ResetVote:send(newName);
	end
end
function SW_ResetCheck(newName)
	if not newName then
		newName = SW_DS_RESET;
	end
	if SW_SYNC_DO and SW_SYNC_TO_USE then
		--here we are in a active syncchan 
		if UnitInRaid("player") then
			if IsRaidLeader() or IsRaidOfficer() then
				StaticPopupDialogs.SW_ResetSync.SW_SegmentName = newName;
				StaticPopup_Show("SW_ResetSync");
			else
				StaticPopup_Show("SW_ResetFailInfo");
			end
		else
			if IsPartyLeader() then
				StaticPopupDialogs.SW_ResetSync.SW_SegmentName = newName;
				StaticPopup_Show("SW_ResetSync");
			else
				StaticPopup_Show("SW_ResetFailInfo");
			end
		end
	else
		StaticPopupDialogs.SW_Reset.SW_SegmentName = newName;
		StaticPopup_Show("SW_Reset");
		return;
	end
end

function SW_PrintHelp()
	local con = getglobal("SW_FrameConsole");
	
	if con ~= nil and con:IsVisible() then
		con = getglobal("SW_FrameConsole_Text1_MsgFrame");
	else
		con = DEFAULT_CHAT_FRAME;
	end
	if con ~= nil then
		for k,v in pairs(SW_SlashCommands) do	
			if v["c"] ~= nil then
				if v["si"] ==nil then
					con:AddMessage("|cc0c0ff00"..v["c"]..":");
				else
					con:AddMessage("|cc0c0ff00"..v["c"]..":"..NORMAL_FONT_COLOR_CODE.."  "..v["si"]);
				end
				if v["u"] ~= nil then
					con:AddMessage(NORMAL_FONT_COLOR_CODE.."     "..v["u"]);
				end
			end
		end
	end
end
