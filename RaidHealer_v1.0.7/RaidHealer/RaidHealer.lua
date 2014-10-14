function RaidHealer_OnLoad()
	SLASH_RAIDHEALER1 = "/raidhealer";
	SLASH_RAIDHEALER2 = "/rh";

	SlashCmdList["RAIDHEALER"] = function(msg) RaidHealer_SlashCommandHandler(msg); end
	
	-- register events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("CHAT_MSG_ADDON");
end

function RaidHealer_OnEvent()
	if (event=="ADDON_LOADED" and arg1=="RaidHealer") then
		-- loaded ...
	elseif (event=="PLAYER_LOGIN") then
		RaidHealer_User.faction, _ = UnitFactionGroup("player");
		RaidHealer_Initialize();
		RaidHealer_SetHealClassLabels();
	elseif (event=="RAID_ROSTER_UPDATE") then
		if ( not UnitInRaid("player")) then
			-- left raid, reset assignments
			RaidHealer_ClearAssignments("HEAL");
			RaidHealer_ClearAssignments("BUFF");
		end
		RaidHealer_DrawAssignmentFrames();
	elseif (event=="CHAT_MSG_WHISPER") then
		-- check for heal or buff query's
		if ( string.lower(arg1) == "heal" or string.lower(arg1) == "buff" ) then
			-- whisper heal/buff assignment
			RaidHealer_WhisperAssignmentToPlayer(string.upper(arg1), arg2);
		end
	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA" and arg3 == "RAID" ) then
		if ( RaidHealer_User.inRaid == true ) then
			-- Unit is in raid
			local sMsg = arg2;
			local name = arg4;			
			
			if ( not sMsg ) then
				return;
			end
			
			if ( string.find(msg, "#") ) then
				local arr = RaidHealer_Split(msg, "#");
				for k, v in arr do
					RaitHealer_ParseCTRA_Message(v);
				end
			else
				RaitHealer_ParseCTRA_Message(msg);
			end
		end
	end
end

function RaidHealer_SlashCommandHandler(msg)
	if (msg=="hide") then
		RaidHealer_MainFrame:Hide();
	elseif (msg=="heal" or msg=="buff") then
		RaidHealer_AnnounceAssignment(RaidHealer_GetCC("ASSIGNMENT_CHANNEL_"..string.upper(msg)), string.upper(msg), nil);
	elseif (msg=="show") then
		RaidHealer_MainFrame:Show();
	elseif (msg=="info") then
		RaidHealer_ToggleInfoFrame();
	elseif (msg=="lock") then
		-- lock
	elseif (msg=="unlock") then
		-- unlock
	elseif (msg=="help") then
		RaidHealer_PrintLines(
			"RaidHealer options are:", 
			"/rh - shows/hides the window",
			"/rh show - show window", 
			"/rh hide - hide window", 
			"/rh heal - announce heal assignment",
			"/rh buff - announce buff assignment",
			"/rh info - toggle info frame",
			"/rh help - shows this help text"
		);
	else
		RaidHealer_ToggleMainFrame();
	end
end

function RaidHealer_Initialize()
	_, RaidHealer_User.class = UnitClass("player");
	RaidHealer_User.innervateId = RaidHealer_GetSpellIdByName("Innervate");
	
	RaidHealer_InitializeSavedVaraibles();
	
	if RAIDHEALER_DEBUG then
		RaidHealer_User.class = "PRIEST";
	end
	
	if (RaidHealer_CharacterConfig["HEAL_CLASSES"] == nil or table.getn(RaidHealer_CharacterConfig["HEAL_CLASSES"]) == 0) then
		if (RaidHealer_IsHealClass(RaidHealer_User.class) == true) then
			RaidHealer_CharacterConfig["HEAL_CLASSES"] = { RaidHealer_User.class };
		else
			RaidHealer_CharacterConfig["HEAL_CLASSES"] = RaidHealer_GetValidFactionsClasses(RAIDHEALER_HEALCLASSES);
		end
	else
		RaidHealer_CharacterConfig["HEAL_CLASSES"] = RaidHealer_CharacterConfig["HEAL_CLASSES"];
	end
	
	RaidHealer_InitInterface();
	RaidHealer_DrawHealAssignmentFrame();
	RaidHealer_PrintLines(string.format("RaidHealer Version %s %s.", RAIDHEALER_VERSION, RAIDHEALER_LOADED));
end

function RaidHealer_InitializeSavedVaraibles()
	if ( type(RaidHealer_GlobalConfig) ~= "table" ) then
		RaidHealer_GlobalConfig = {
			["WHISPER_ASSIGNMENT"] = true,
			["HIDE_OUTGOING_WHISPER"] = false,
			["HIDE_INCOMMING_WHISPER"] = false,
			["ANNOUNCE_ALTERNATE"] = false,
			["MINIMAP_SHOW"] = true,
			["MINIMAP_POS"] = RAIDHEALER_DEFAULT_MINIMAP_POS
		};
	end
	
	if ( type(RaidHealer_CharacterConfig) ~= "table" ) then
		RaidHealer_CharacterConfig = {
			["HEAL_CLASSES"] = {},
			["ASSIGNMENT_CHANNEL"]	= "RAID",
			["CURRENT_TANK_CLASS"]	= RAIDHEALER_CLASS_WARRIOR,
			["CURRENT_BUFF_TYPE"]		= 1,
			["LAST_ANNOUNCER_HEAL"]	= "",
			["LAST_ANNOUNCER_BUFF"]	= "",
			["SHOW_INFOFRAME"] = true
		};
	else
		if (type(RaidHealer_CharacterConfig["HEAL_CLASSES"]) ~= "table") then
			RaidHealer_CharacterConfig["HEAL_CLASSES"] = { };
		end
		if (not RaidHealer_CharacterConfig["ASSIGNMENT_CHANNEL_HEAL"]) then
			RaidHealer_CharacterConfig["ASSIGNMENT_CHANNEL_HEAL"] = "RAID";
		end
		if (not RaidHealer_CharacterConfig["ASSIGNMENT_CHANNEL_BUFF"]) then
			RaidHealer_CharacterConfig["ASSIGNMENT_CHANNEL_BUFF"] = "RAID";
		end
		if (not RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"]) then
			RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"] = RAIDHEALER_CLASS_WARRIOR;
		end
		if (not RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"]) then
			RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"] = RaidHealer_GetFirstBuff(RaidHealer_User.class);
		end
		if (not RaidHealer_CharacterConfig["LAST_ANNOUNCER_HEAL"]) then
			RaidHealer_CharacterConfig["LAST_ANNOUNCER_HEAL"] = "";
		end
		if (not RaidHealer_CharacterConfig["LAST_ANNOUNCER_BUFF"]) then
			RaidHealer_CharacterConfig["LAST_ANNOUNCER_BUFF"] = "";
		end
--		if (not RaidHealer_CharacterConfig["SHOW_INFOFRAME"]) then
--		RaidHealer_CharacterConfig["SHOW_INFOFRAME"] = true;
--		end
	end
	
	if ( type(RaidHealer_Assignments) ~= "table" ) then
		RaidHealer_Assignments = {
			["HEAL"] = {},
			["BUFF"] = {
				["STAMINA"] = {},
				["SPIRIT"] = {},
				["SHADOW"] = {},
				["MOTW"] = {},
				["THORNS"] = {},
				["INTELLECT"] = {}
			}
		};
	else
		if ( not RaidHealer_Assignments["HEAL"] ) then
			RaidHealer_Assignments["HEAL"] = {}
		end
		if ( not RaidHealer_Assignments["BUFF"] or type(RaidHealer_Assignments["BUFF"]) ~= "table" ) then
			RaidHealer_Assignments["BUFF"] = {
				["STAMINA"] = {},
				["SPIRIT"] = {},
				["SHADOW"] = {},
				["MOTW"] = {},
				["THORNS"] = {},
				["INTELLECT"] = {}
			};
		end
	end
end

-- returns a global config value
function RaidHealer_GetGC(name)
	if ( type(RaidHealer_GlobalConfig_Default[name]) == "boolean" ) then
		if ( RaidHealer_GlobalConfig[name] ) then
			return RaidHealer_GlobalConfig[name];
		else
			return nil;
		end
	else
		if ( RaidHealer_GlobalConfig[name] ) then
			return RaidHealer_GlobalConfig[name];
		else
			return RaidHealer_GlobalConfig_Default[name];
		end
	end
end
-- sets a global config value
function RaidHealer_SetGC(name, value)
	RaidHealer_GlobalConfig[name] = value;
end
-- returns a character config value
function RaidHealer_GetCC(name)
	if ( type(RaidHealer_CharacterConfig_Default[name]) == "boolean" ) then
		if ( RaidHealer_CharacterConfig[name] ) then
			return RaidHealer_CharacterConfig[name];
		else
			return nil;
		end
	else
		if ( RaidHealer_CharacterConfig[name] ) then
			return RaidHealer_CharacterConfig[name];
		else
			return RaidHealer_CharacterConfig_Default[name];
		end
	end
end
-- sets a character config value
function RaidHealer_SetCC(name, value)
	RaidHealer_CharacterConfig[name] = value;
end

function RaidHealer_ClearAssignments(aType)
	if (aType=="HEAL") then
		RaidHealer_Assignments[aType] = {};
		RaidHealer_DrawHealAssignmentFrame();
	elseif (aType=="BUFF") then
		RaidHealer_Assignments[aType] = {
			["STAMINA"] = {},
			["SPIRIT"] = {},
			["SHADOW"] = {},
			["MOTW"] = {},
			["THORNS"] = {},
			["INTELLECT"] = {}
		};
		RaidHealer_DrawBuffAssignmentFrame();
	end
end

function RaidHealer_ToggleMainFrame()
	if (RaidHealer_MainFrame:IsShown()) then
		RaidHealer_MainFrame:Hide();
	else
		RaidHealer_MainFrame:Show();
	end
end

function RaidHealer_GetValidFactionsClasses(classes)
	local invalid = RAIDHEALER_CLASS_SHAMAN;
	if (string.lower(RaidHealer_User.faction) == "horde") then
		invalid = RAIDHEALER_CLASS_PALADIN
	end
	
	local vClasses = {};
	
	for i=1, table.getn(classes), 1 do
		if (classes[i] ~= invalid) then
			table.insert(vClasses, classes[i]);
		end
	end
	
	return vClasses;
end

function RaidHealer_DrawAssignmentFrames()
	if (RaidHealer_User.inRaid()) then
		RaidHealer_MainFrame_InfoText:Hide();
		RaidHealer_RefreshRaidMember();
		RaidHealer_DrawHealAssignmentFrame();
		RaidHealer_DrawBuffAssignmentFrame();
	else
		RaidHealer_MainFrame_InfoText:Show();
	end
end

function RaidHealer_RefreshRaidMember()
	-- reset raid member
	RaidHealer_RaidMember = {};
	
	if (RAIDHEALER_DEBUG) then
		RaidHealer_RaidMember = RaidHealer_DebugRaidMember;
	end
	
	local nrm = GetNumRaidMembers();
	if (nrm > 0) then
		for n = 1, nrm, 1 do
			local name,_,subgroup,_,class,fileName,_,_,_ = GetRaidRosterInfo(n);
			if (RaidHealer_RaidMember[fileName] == nil) then
				RaidHealer_RaidMember[fileName] = {};
			end
			table.insert(RaidHealer_RaidMember[fileName], { 
					["NAME"] = name,
					["CLASS"] = class,
					["GROUP"] = subgroup,
					["CTRA_MT"] = RaidHealer_GetCTRA_MT_Number(name)
			});
		end
	end
end

function RaidHealer_GetTankName(tankID, tankClass)
	if (RaidHealer_RaidMember[tankClass] ~= nil) then
		return RaidHealer_RaidMember[tankClass][tankID]["NAME"];
	end
end

function RaidHealer_IsHealClass(class)
	for i=1, table.getn(RAIDHEALER_HEALCLASSES), 1 do
		if (RAIDHEALER_HEALCLASSES[i] == class) then
			return true;
		end
	end
	return false;
end

function RaidHealer_IsBuffClass(class)
	for i=1, table.getn(RAIDHEALER_BUFFCLASSES), 1 do
		if (RAIDHEALER_BUFFCLASSES[i] == class) then
			return true;
		end
	end
	return false;
end

function RaidHealer_GetFirstBuff(class)
	for i=1, table.getn(RAIDHEALER_BUFFS), 1 do
		if (RAIDHEALER_BUFFS["CLASS"] == class) then
			return i;
		end
	end
	return 1;
end

function RaidHealer_PlayerInRaid(playerName)
	-- in Debug return true ever
	if (RAIDHEALER_DEBUG == true) then
		return true;
	end
	-- if user is not in raid return false
	if (RaidHealer_User:inRaid() == false) then
		return false;
	end
	-- check raidmember
	local nrm = GetNumRaidMembers();
	if (nrm > 0) then
		for n = 1, nrm, 1 do
			local name,_,subgroup,_,class,fileName,_,_,_ = GetRaidRosterInfo(n);
			if (name == playerName) then
				return true;
			end
		end
	end
	
	return false;
end

function RaidHealer_PlayerHasBuff(unitID, buff) 
  local i = 1;
  while (UnitBuff(unitID, i)) do
    if (string.find(UnitBuff(unitID, i), buff)) then
      return true;
    end
    i = i + 1;
  end
  return false;
end

function RaidHealer_GetSpellIdByName(spell)
	local i = 1;
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)

		if not spellName then
			do break end
		end

		if spellName == spell then
			return i;
		end
		
		i = i+1;
		
	end
	return nil;
end

function RaidHealer_SpellHasCooldown(spellId)
	local start, duration = GetSpellCooldown(spellId, BOOKTYPE_SPELL);
	if ( start > 0 and duration > 0) then
		return true;
	end
	return nil;
end

function RaidHealer_PlayerHasAssignments(playerName, aType)
	if ( RaidHealer_Assignments[aType] ) then
		if (aType == "HEAL") then
			if ( RaidHealer_Assignments[aType][playerName] and type(RaidHealer_Assignments[aType][playerName]) == "table" and table.getn(RaidHealer_Assignments[aType][playerName]) > 0 ) then
				return true;
			end
		elseif (aType == "BUFF") then
			-- do nothing
		end
	end
	return false;
end

function RaidHealer_GetPlayerByName(playerName)
	for cid, ctyp in pairs(RAIDHEALER_HEALCLASSES) do
		for k, v in pairs(RaidHealer_RaidMember[ctyp]) do
			if (v["NAME"] == name) then
				return v["CLASS"], v["GROUP"];
			end
		end
	end
	return nil, nil;
end

function RaidHealer_GetUnitIDByName(playerName)
	if (RaidHealer_User.inRaid() == true) then
		local nrm = GetNumRaidMembers();
		if (nrm > 0) then
			for n = 1, nrm, 1 do
				local name,_,_,_,_,_,_,_,_ = GetRaidRosterInfo(n);
				if (name == playerName) then
					return "raid"..n;
				end
			end
		end
	end
	return nil;
end

function RaidHealer_GetRaidRosterIDByName(playerName)
	if (RaidHealer_User.inRaid() == true) then
		local nrm = GetNumRaidMembers();
		if (nrm > 0) then
			for n = 1, nrm, 1 do
				local name,_,_,_,_,_,_,_,_ = GetRaidRosterInfo(n);
				if (name == playerName) then
					return n;
				end
			end
		end
	end
	return nil;
end

function RaidHealer_PurgeAssignments()

	for aType, values in pairs(RaidHealer_Assignments) do
		if (aType=="HEAL") then
			for healer, tanks in pairs(values) do
				if (RaidHealer_PlayerInRaid(healer) == true) then
					for t=1, table.getn(tanks), 1 do
						if (RaidHealer_PlayerInRaid(tanks[t]) == false) then
							table.remove(RaidHealer_Assignments[aType][healer], t);
							break;
						end
					end
				else
					RaidHealer_Assignments[aType][healer] = {};
				end
			end
		elseif (aType=="BUFF") then
			for buff, ass in pairs(values) do
				for buffer, groups in pairs(ass) do
					if (RaidHealer_PlayerInRaid(buffer) == false) then
						RaidHealer_Assignments[aType][buff][buffer] = {};
					end
				end
			end
		end
	end

end

function RaidHealer_GetTankNames(tankIds)
	local tanks = { }
	for i=1, table.getn(tankIds), 1 do
		local tankName = RaidHealer_RaidMember["WARRIOR"][tankIds[i]]["NAME"];
		table.insert(tanks, tankName);
	end
	return table.concat(tanks, ", ");
end

function RaidHealer_GetShortName(name)
	if (string.len(name) > RAIDHEALER_MAX_NAME_LEN) then
		return string.sub(name, 1, (RAIDHEALER_MAX_NAME_LEN - 2)).."..";
	end
	return name;
end

function RaidHealer_GetCurrentTankClass()
	for i=1, table.getn(RAIDHEALER_TANKCLASSES), 1 do
		if ( RAIDHEALER_TANKCLASSES[i] == RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"] ) then
			return i;
		end
	end
	return 1;
end

function RaidHealer_FilterNamesByClass(names, class)
	local filtered = {};
	if (type(names) == "table") then
		for i=1, table.getn(names), 1 do
			local _, uClass = UnitClass(RaidHealer_GetUnitIDByName(names[i]));
			if (class == uClass) then
				table.insert(filtered, names[i]);
			end
		end
	end
	return filtered;
end

function RaidHealer_Split(msg, char)
	local arr = { };
	while (string.find(msg, char) ) do
		local iStart, iEnd = string.find(msg, char);
		tinsert(arr, strsub(msg, 1, iStart-1));
		msg = strsub(msg, iEnd+1, strlen(msg));
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg);
	end
	return arr;
end

function RaidHealer_ShuffleTable(tab)
	local dest = {}
	
	while table.getn(tab) > 0 do
		table.insert( dest, table.remove(tab, math.random(1, table.getn(tab))) );
	end
	
	return dest;
end

function RaidHealer_pairsByKeys (t, f)
  local a = {};
  for n in pairs(t) do table.insert(a, n) end;
  table.sort(a, f);
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
	i = i + 1;
	if a[i] == nil then return nil;
	else return a[i], t[a[i]];
	end;
  end;
  return iter;
end


function RaidHealer_PrintLines(...)
	local i=1;
	while arg[i] do
		DEFAULT_CHAT_FRAME:AddMessage(arg[i], 0.0, 1.0, 0.25); -- Default green
		i=i+1;
	end
end

-- hiding incoming and outgoing whisper
RaidHealer_OrgChatFrame_OnEvent = ChatFrame_OnEvent;
function RaidHealer_ChatFrame_OnEvent(event)
	-- hide incoming requests
	if ( event == "CHAT_MSG_WHISPER" ) then
		if string.lower(arg1) == "heal" or string.lower(arg1) == "buff" then
			if ( RaidHealer_GlobalConfig["HIDE_INCOMMING_WHISPER"] == true ) then
				return;
			end;
		end
	end
	
	if ( event == "CHAT_MSG_WHISPER_INFORM" ) then
		if ( string.find(arg1,"<"..RAIDHEALER_NAME..">") ) then
			if ( RaidHealer_GlobalConfig["HIDE_OUTGOING_WHISPER"] == true ) then
				return;
			end;	
		end
	end
	
	RaidHealer_OrgChatFrame_OnEvent(event);
end
ChatFrame_OnEvent = RaidHealer_ChatFrame_OnEvent;
