CritRecord = {};

CritRecord.Version = GetAddOnMetadata("CritRecord", "Version");

CritRecord.Classification = {
	["normal"] = "";
	["elite"] = "(Elite)";
	["worldboss"] = "(Boss)";
}

CritRecord.classColor = {
	["Warrior"] = "|cFFC69B6D",
	["Mage"] = "|cFF68CCEF",
	["Rogue"] = "|cFFFFF468",
	["Druid"] = "|cFFFF7C0A",
	["Hunter"] = "|cFFAAD36D",
	["Shaman"] = "|cFFF48CBA",
	["Priest"] = "|cFFFFFFFF",
	["Warlock"] = "|cFF9342C9",
	["Paladin"] = "|cFFF48CBA",
}

CritRecord.lastCrit = nil;

local bgzones = {
	["Alterac Valley"] = true;
	["Arathi Basin"] = true;
	["Warsong Gulch"] = true;
}

local tmp = {};
local mode = 1;
local screenshot_delay = 15;
local screenshot_counter = 999999999;
local outputChatFrame = DEFAULT_CHAT_FRAME;

function CritRecord:GetLatestCrit()
	local latestTime = 0;
	for index, value in CritRecordDB do
		if (CritRecordDB[index]["Time"] > latestTime) then
			CritRecord.latestCrit = index;
			latestTime = CritRecordDB[index]["Time"];
		end
	end
end

function CritRecord:SetDefaultOptions()
	CritRecordOptions = nil;
	CritRecordOptions = {
		["OptVersion"] = GetAddOnMetadata("CritRecord", "Version");
		["General"] = {
			["EnableAddon"] = true,
			["EnableTooltips"] = true,
			["ReportNewCrits"] = true,
			["ReportInChat"] = true,
			["ReportOnScreen"] = false,
			["EnableBGCrits"] = true,
			["TakeScreenshots"] = false,
			["ShortReview"] = true,
		},
		["Damage"] = {
			["RecordCrits"] = true,
			["CountTrivial"] = false,
			["TooltipTargetInfo"] = true,
			["TooltipLevelRaceClass"] = true,
			["TooltipLocation"] = true,
			["TooltipDateTime"] = true,
		},
		["Healing"] = {
			["RecordCrits"] = true,
			["CountTrivial"] = false,
			["TooltipTargetInfo"] = true,
			["TooltipLevelRaceClass"] = true,
			["TooltipLocation"] = true,
			["TooltipDateTime"] = true,
		},
	}
end

function CritRecord:Print(msg)
	local msgOut = "|cFFFF9E9E[CritRecord]|r " .. msg;
	if (outputChatFrame) then
		outputChatFrame:AddMessage(msgOut);
	end
end

function CritRecord_GameTooltip_OnShow()
	local opt = CritRecordOptions;
	if ((opt["General"]["EnableAddon"]) and (opt["General"]["EnableTooltips"])) then
		local action = GameTooltipTextLeft1:GetText();
		local bestcrit = nil;
		local target = nil;
		local dbRecord = CritRecordDB[action];
		if (dbRecord) then
			bestcrit = dbRecord["DMG"];
			target = dbRecord["Target"];
		end
		if (bestcrit) then
			local tooltip = "|nCrit Record|n|cFFFFFFFF" .. bestcrit;
			local section = "Damage";
			if (dbRecord["Type"] == 2) then
				section = "Healing";
			end
			if (opt[section]["TooltipTargetInfo"]) then
				if (dbRecord["Type"] == 2) then
					tooltip = tooltip .. " healing " .. target;
				else
					tooltip = tooltip .. " against " .. target;
				end
				if ((dbRecord["TargetLevel"]) and (opt[section]["TooltipLevelRaceClass"])) then
					local level = dbRecord["TargetLevel"];
					if (level == -1) then
						level = "??";
					end
					tooltip = tooltip .. "|n- Level " .. level;
					if (dbRecord["TargetIsPlayer"]) then
						if (dbRecord["TargetRace"]) then
							tooltip = tooltip .. " " .. dbRecord["TargetRace"];
						end
						if (dbRecord["TargetClass"]) then
							tooltip = tooltip .. " " .. dbRecord["TargetClass"];
						end
						tooltip = tooltip .. " (Player)";
					else
						if (dbRecord["TargetCreatureFamily"]) then
							tooltip = tooltip .. " " .. dbRecord["TargetCreatureFamily"];
						elseif (dbRecord["TargetCreatureType"]) then
							tooltip = tooltip .. " " .. dbRecord["TargetCreatureType"];
						end
						if (dbRecord["TargetClassification"]) then
							local targetclassificaton = dbRecord["TargetClassification"];
							tooltip = tooltip .. " " .. CritRecord.Classification[targetclassificaton];
						end
					end
				end
				if ((dbRecord["Zone"]) and (opt[section]["TooltipLocation"])) then
					tooltip = tooltip .. "|n- ";
					if (dbRecord["SubZone"] ~= "") then
						tooltip = tooltip .. dbRecord["SubZone"] .. ", ";
					end
					tooltip = tooltip .. dbRecord["Zone"];
				end
				if ((dbRecord["Time"]) and (opt[section]["TooltipDateTime"]))then
					tooltip = tooltip .. "|n- " .. date("%d/%m/%y %H:%M", dbRecord["Time"]);
				end
			end
			GameTooltip:AddLine(tooltip);
		end
	end
    Pre_CritRecord_GameTooltip_OnShow();
	GameTooltip:Show();
end

function CritRecord:OnLoad()
	Pre_CritRecord_GameTooltip_OnShow = function ()
		GameTooltip:GetScript("OnShow");
	end
	GameTooltip:SetScript("OnShow", CritRecord_GameTooltip_OnShow);
	
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UPDATE_CHAT_WINDOWS");
	this:RegisterEvent("MINIMAP_ZONE_CHANGED");
end

function CritRecord:OnEvent(event)
	if (event == "UPDATE_CHAT_WINDOWS") then
		local i=1;
		local chats = "";
		while getglobal("ChatFrame" .. i) do
			local chatFrame = getglobal("ChatFrame" .. i)
			local name, fontSize, r, g, b, a, shown, locked = GetChatWindowInfo(chatFrame:GetID())
			if ((strlower(name) == "critrecord") and (shown)) then
				outputChatFrame = getglobal("ChatFrame" .. i);
				CritRecord:Print("CritRecord Window Found. All CritRecord messages will be output to this window.");
			end
			i = i + 1;
		end
	end
	if (event == "VARIABLES_LOADED") then
		if (CritRecordDB == nil) then
			CritRecord:Print("Preparing database for first use...");
			CritRecordDB = {};
		end
		local optVersion = nil;
		if (CritRecordOptions) then
			if (CritRecordOptions["OptVersion"]) then optVersion = CritRecordOptions["OptVersion"]; end
		end
		if (CritRecordOptions == nil) then
			CritRecord:Print("Creating default options...");
			CritRecord:SetDefaultOptions();
		elseif (optVersion ~= GetAddOnMetadata("CritRecord", "Version")) then
			CritRecord:Print("Creating default options...");
			CritRecord:SetDefaultOptions();
		else
			CritRecord:Print("Configuration Loaded");
		end
		CritRecord:GetLatestCrit();
		CritRecord:Print(string.format(CritRecord.LOCAL.VersionInfo, GetAddOnMetadata("CritRecord", "Version"), GetAddOnMetadata("CritRecord", "Author")));
	end
	local continue = true;
	local zone = GetRealZoneText();
	if (CritRecordOptions["General"]["EnableAddon"] == false) then continue = false; end
	if (CritRecordOptions["General"]["EnableBGCrits"] == false) then
		if (bgzone[zone] ~= true) then continue = false; end
	end
	if (continue) then
		if ((event == "CHAT_MSG_SPELL_SELF_DAMAGE") and (CritRecordOptions["Damage"]["RecordCrits"])) then
			attack, target, dmg, dmgtype = CritRecordGlobalParser_ParseMessage(arg1, SPELLLOGCRITSCHOOLSELFOTHER)
			if (dmg) then CritRecord:AddCrit(attack, target, dmg, 1) end
			attack, target, dmg = CritRecordGlobalParser_ParseMessage(arg1, SPELLLOGCRITSELFOTHER)
			if (dmg) then CritRecord:AddCrit(attack, target, dmg, 1) end
		end
		if ((event == "CHAT_MSG_COMBAT_SELF_HITS") and (CritRecordOptions["Damage"]["RecordCrits"])) then
			target, dmg = CritRecordGlobalParser_ParseMessage(arg1, COMBATHITCRITSELFOTHER)
			if (dmg) then CritRecord:AddCrit(ATTACK, target, dmg, 1); end
		end
		if ((event == "CHAT_MSG_SPELL_SELF_BUFF") and (CritRecordOptions["Healing"]["RecordCrits"])) then
			attack, target, dmg = CritRecordGlobalParser_ParseMessage(arg1, HEALEDCRITSELFOTHER)
			if (dmg) then CritRecord:AddCrit(attack, target, dmg, 2); end
		end
	end
end

function CritRecord:OnUpdate()
	if (screenshot_counter < screenshot_delay) then
		screenshot_counter = screenshot_counter + 1;
	elseif (screenshot_counter == screenshot_delay) then
		screenshot_counter = 9999999;
		TakeScreenshot();
	end
end

function CritRecord:TakeScreenshot()
	screenshot_counter = 1;
end

function CritRecord:AddCrit(attack, target, dmg, crittype)
	local continue = true;
	local unit = "target";
	local optSection = "Damage";
	if (crittype == 2) then optSection = "Healing"; end
	if (target == "you") then
		unit = "player";
		target = UnitName("player");
	end
	local tmpDB = nil;
	tmpDB = {};
	tmpDB["DMG"] = dmg;
	tmpDB["Target"] = target;
	tmpDB["Type"] = crittype;
	if (UnitName(unit) == target) then
		tmpDB["TargetLevel"] = UnitLevel(unit);
		tmpDB["TargetClassification"] = UnitClassification(unit);
		tmpDB["TargetCreatureFamily"] = UnitCreatureFamily(unit);
		tmpDB["TargetCreatureType"] = UnitCreatureType(unit);
		tmpDB["TargetClass"] = UnitClass(unit);
		tmpDB["TargetRace"] = UnitRace(unit);
		tmpDB["TargetIsPlayer"] = UnitIsPlayer(unit);
	end
	tmpDB["Zone"] = GetRealZoneText();
	tmpDB["SubZone"] = GetSubZoneText();
	tmpDB["Time"] = time();
	CritRecord.lastCrit = tmpDB;
	CritRecord.lastCrit["Attack"] = attack;
	if (CritRecord.TitanLoaded) then TitanPanelButton_UpdateButton("CritRecord"); end
	if (UnitIsTrivial(unit)) then
		continue = CritRecordOptions[optSection]["CountTrivial"];
	end
	if (continue) then
		local bestcrit = 0;
		if (CritRecordDB[attack]) then
			bestcrit = tonumber(CritRecordDB[attack]["DMG"]);
		end
		if (tonumber(dmg) > bestcrit) then
			if (CritRecordOptions["General"]["TakeScreenshots"]) then
				CritRecord:TakeScreenshot();
			end
			CritRecordDB[attack] = tmpDB;
			CritRecord.latestCrit = attack;
			if (CritRecordOptions["General"]["ReportOnScreen"]) then
				UIErrorsFrame:AddMessage(string.format(CritRecord.LOCAL.NewRecordScreen, attack, dmg));
			else
				local outStr = CritRecord.LOCAL["NewRecordChat"..crittype];
				outStr = string.gsub(outStr, "#A", attack);
				outStr = string.gsub(outStr, "#D", dmg);
				outStr = string.gsub(outStr, "#T", target);
				outStr = string.gsub(outStr, "#P", bestcrit);
				outStr = string.gsub(outStr, "#M", (tonumber(dmg) - bestcrit));
				CritRecord:Print(outStr);
			end
		end
	end
end

function CritRecord:PrintTable(args)
	for k, v in args do
		ChatFrame1:AddMessage("-" .. tostring(k) .. " = " .. tostring(v));
	end
end

function CritRecord:Reset()
	CritRecord:Print("Resetting Database...");
	CritRecordDB = nil;
	CritRecordDB = {};
	CritRecord:Print("Done");
end

