----------------------------------------------------------------------------------------------------
-- Name		: Spell Duration [Slash Handler]
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Name		: SDExtractNextParameter 
-- Comment	: Extract the command usage and the params given by the user
----------------------------------------------------------------------------------------------------
function SDExtractNextParameter(msg)
	local command = msg;
	local name = msg;
	local params = msg;
	local index = strfind(command, " ");
	if(index) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
		index = strfind(params, " ");
		if(index) then
			name = strsub(params, 1, index-1);
			params = strsub(params, index+1);
		else
			name = "";
		end
	else
		params = "";
	end
	return command, name, params;
end

----------------------------------------------------------------------------------------------------
-- Name		: SDSlashHandler
----------------------------------------------------------------------------------------------------
function SDSlashHandler(msg)
	local index, help, frame;
	local lock = false;
	-- Commands Handler
	local cmd, name, param = SDExtractNextParameter(msg);
	-- General Commands
	if(cmd == "help" or cmd == "") then
		-- Start help paragraph
		for index, help in SDHelpStartTable do
			SDSendMsg(help,1.0,1.0,1.0,true);
		end
		-- If your class is supported show the spell bars help paragraph
		if(SDVars.RegisteredClass) then
			index = nil; help = nil;
			for index, help in SDHelpSpellsTable do
				SDSendMsg(help,1.0,1.0,1.0,true);
			end
		end
		-- If your race is supported show the racial help paragraph
		if(SDVars.RegisteredRace) then
			index = nil; help = nil;
			for index, help in SDHelpRacialTable do
				SDSendMsg(help,1.0,1.0,1.0,true);
			end
		end
		-- If it's a troll show their help paragraph
		if(SDVars.Race == SDRaceTable.Troll) then
			index = nil; help = nil;
			for index, help in SDHelpTrollTable do
				SDSendMsg(help,1.0,1.0,1.0,true);
			end
			if(SDConfig.BerserkerInfo) then
				index = nil; help = nil;
				for index, help in SDHelpBerserkerInfoTable do
					SDSendMsg(help,1.0,1.0,1.0,true);
				end
			end
		end
		-- End help paragraph
		index = nil; help = nil;
		for index, help in SDHelpEndTable do
			SDSendMsg(help,1.0,1.0,1.0,true);
		end
	elseif(cmd == "barsonly" and param == "on") then
		SDConfig.BarsOnly = true;
	elseif(cmd == "barsonly" and param == "off") then
		SDConfig.BarsOnly = false;
	elseif(cmd == "reset" and param == "bars") then
		SDBarsResetPosition();
	elseif(cmd == "reset" and param == "buffs") then
		SDBuffsResetPosition();
	elseif(cmd == "reset") then
		SDBarsResetPosition();
		SDBuffsResetPosition();
	elseif(cmd == "debug") then
		if(SDGlobal.Debug) then
			SDSendMsg("Debug mode disabled.", 0, 1, 0, true);
			SDGlobal.Debug = false;
		else 
			SDGlobal.Debug = true;
			SDSendMsg("Debug mode enabled.", 0, 1, 0, true);
		end
	elseif(cmd == "ver") then
		SDSendMsg(SD_VER_MSG,1.0,1.0,1.0,true);
	end
	-- Spell Bars Commands
	if(SDVars.RegisteredClass) then
		if(cmd == "lock" and param == "bars") then
			SDGlobal.LockBars = 1;
			for frame = 1, SDGlobal.MaxBars, 1 do
				local BarFrame = getglobal("SpellDurationBar"..frame);
				BarFrame:Hide();
			end
			SpellDurationBarDragFrame:Hide();
		elseif(cmd == "unlock" and param == "bars") then
			lock = true;
			SDGlobal.LockBars = 0;
			local BarFrame, StatusBar, Spark, Text, TextTime;
			for frame = 1, SDGlobal.MaxBars, 1 do
				BarFrame = getglobal("SpellDurationBar"..frame);
				StatusBar = getglobal(BarFrame:GetName().."StatusBar");
				Spark = getglobal(BarFrame:GetName().."StatusBarSpark");
				Text = getglobal(BarFrame:GetName().."Text");
				TextTime = getglobal(BarFrame:GetName().."Time");
				Text:SetText("Spell Duration Bar "..frame);
				TextTime:SetText("");
				StatusBar:SetMinMaxValues(0, 0);
				StatusBar:SetValue(0);
				Spark:SetPoint("CENTER", StatusBar:GetName(), "LEFT", 0, 0);
				BarFrame:Show();
			end
			SpellDurationBarDragFrame:Show();
		elseif(cmd == "lock" and param == "buffs") then
			SDGlobal.LockBuffs = 1;
			local BuffFrame, Icon;
			for frame = 1, SDGlobal.MaxBuffs, 1 do
				BuffFrame = getglobal("SpellDurationBuff"..frame);
				Icon = getglobal("SpellDurationBuff"..frame.."Icon");
				Icon:Hide();
				BuffFrame:Hide();
			end
			SpellDurationBuffDragFrame:Hide();
		elseif(cmd == "unlock" and param == "buffs") then
			lock = true;
			SDGlobal.LockBuffs = 0;
			local BuffFrame, Icon, Text;
			for frame = 1, SDGlobal.MaxBuffs, 1 do
				BuffFrame = getglobal("SpellDurationBuff"..frame);
				Icon = getglobal("SpellDurationBuff"..frame.."Icon");
				Text = getglobal("SpellDurationBuff"..frame.."Time");
				Text:SetText(frame);
				Icon:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background");
				Icon:SetAlpha(0.4);
				Icon:Show();
				BuffFrame:Show();
			end
			SpellDurationBuffDragFrame:Show();
		end
	end
	-- Racial Commands
	if(SDVars.RegisteredRace) then
		if(cmd == "lock" and param == "racialbar") then
			SDGlobal.LockRacialBar = 1;
			local BarFrame = getglobal("SpellDurationRacialBar");
			BarFrame:Hide();
			SpellDurationRacialBarDragFrame:Hide();
		elseif(cmd == "unlock" and param == "racialbar") then
			lock = true;
			SDGlobal.LockRacialBar = 0;
			local BarFrame = getglobal("SpellDurationRacialBar");
			local StatusBar = getglobal(BarFrame:GetName().."StatusBar");
			local Spark = getglobal(BarFrame:GetName().."StatusBarSpark");
			local Text = getglobal(BarFrame:GetName().."Text");
			local TextTime = getglobal(BarFrame:GetName().."Time");
			Text:SetText("Spell Duration Racial Bar");
			TextTime:SetText("");
			StatusBar:SetMinMaxValues(0, 0);
			StatusBar:SetValue(0);
			Spark:SetPoint("CENTER", StatusBar:GetName(), "LEFT", 0, 0);
			BarFrame:Show();
			SpellDurationRacialBarDragFrame:Show();
		end
	end
	if(SDVars.Race == SDRaceTable.Troll) then
		-- It's a TROLL!
		if(cmd == "berserker") then
			if(SDConfig.BerserkerInfo) then
				SDConfig.BerserkerInfo = false;
				if(SDGlobal.LockBerserker == 0) then
					SDGlobal.LockBerserker = 1;
					local BerserkerFrame = getglobal("SpellDurationBerserkerFrame");
					BerserkerFrame:Hide();
				end
			else
				SDConfig.BerserkerInfo = true;
			end
		end
		if(SDConfig.BerserkerInfo) then
			if(cmd == "lock" and param == "berserker") then
				SDGlobal.LockBerserker = 1;
				SDGlobal.LockRacialBar = 1;
				local BerserkerFrame = getglobal("SpellDurationBerserkerFrame");
				local BarFrame = getglobal("SpellDurationRacialBar");
				local Text = getglobal(BarFrame:GetName().."Text");
				Text:SetText("");
				BarFrame:Hide();
				BerserkerFrame:Hide();
				SpellDurationRacialBarDragFrame:Hide();
			elseif(cmd == "unlock" and param == "berserker") then
				lock = true;
				SDGlobal.LockBerserker = 0;
				SDGlobal.LockRacialBar = 0;
				local BarFrame = getglobal("SpellDurationRacialBar");
				local StatusBar = getglobal(BarFrame:GetName().."StatusBar");
				local Spark = getglobal(BarFrame:GetName().."StatusBarSpark");
				local Text = getglobal(BarFrame:GetName().."Text");
				local TextTime = getglobal(BarFrame:GetName().."Time");
				Text:SetText("Spell Duration Racial Bar");
				TextTime:SetText("");
				StatusBar:SetMinMaxValues(0, 0);
				StatusBar:SetValue(0);
				Spark:SetPoint("CENTER", StatusBar:GetName(), "LEFT", 0, 0);
				BarFrame:Show();
				SpellDurationRacialBarDragFrame:Show();
				SDRacialBarBerserker();
			end
		end
	end
	if(cmd == "unlock" and lock) then
		index = nil; help = nil;
		for index, help in SDHelpUnlockTable do
			SDSendMsg(help,1.0,1.0,1.0,true);
		end
	end
end