-- 
-- SkillLevel
-- AUTHOR: Gearshaft
-- 
local version = "1.1";
local SkillLevel_Old_SkillFrame_SetStatusBar = function() end;

local function Initialize()
	if ( SkillLevelOptions == nil ) then			SkillLevelOptions = {};	end
	if ( SkillLevelOptions.Status == nil ) then		SkillLevelOptions.Status = 1;	end
end

local function DisplayBool(setting)
	if ( setting == "1" or setting == 1 ) then
		return SKILLLEVEL_ON;
	elseif ( setting == "0" or setting == 0 ) then
		return SKILLLEVEL_OFF;
	end
	return setting;
end

function SkillLevel_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	SlashCmdList["SKILLLEVEL"] = SkillLevel_SlashCommando;
	SLASH_SKILLLEVEL1 = SLASH_SKILLLEVEL1;
	SLASH_SKILLLEVEL2 = SLASH_SKILLLEVEL2;
	
	Initialize();
	
	if Sea then
		Sea.util.hook("SkillFrame_SetStatusBar", "SkillLevel_SkillBarLevelAdd", "after");
	else
		SkillLevel_Old_SkillFrame_SetStatusBar = SkillFrame_SetStatusBar;
		SkillFrame_SetStatusBar = SkillLevel_SkillBarLevelAdd;
	end
end

function SkillLevel_OnEvent(event)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		Initialize();
	end
end

--[[function SkillLevel_MoreSkillLevelInfo(skillIndex)
	local Skill={GetSkillLineInfo(skillIndex)};
	local c;
	if ( Skill[6] ~= 0 ) then
		c = " with +" .. Skill[6].." totaling " .. Skill[4] + Skill[6];
	else
		c = "";
	end;
	-- Sea.IO.bannerc({r=1,g=.6,b=0}, Skill[1] .. " skill is " .. Skill[4] .. c .. " which is equivilant to level " .. ((Skill[4] + Skill[6]) / 5) );
end]]

function SkillLevel_SkillBarLevelAdd(statusBarID, skillIndex, numSkills, adjustedSkillPoints)
	if not Sea then
		SkillLevel_Old_SkillFrame_SetStatusBar(statusBarID, skillIndex, numSkills, adjustedSkillPoints);
	end
	
	if (SkillLevelOptions.Status == 1) then
		local Skill={GetSkillLineInfo(skillIndex)};
		local statusBarSkillRank = getglobal("SkillRankFrame" .. statusBarID .. "SkillRank");
		local addition;
		local skillBarText = statusBarSkillRank:GetText();
		if ( not skillBarText ) then
			skillBarText = "";
		end
		if ( Skill[4] + Skill[6] > 1) then
				addition = ( Skill[4] + Skill[6] ) / 5;
			statusBarSkillRank:SetText( skillBarText .. SKILLLEVEL_SKILLBAR_PREPEND .. addition .. SKILLLEVEL_SKILLBAR_APPEND);
		end
	end
	return 1;
end

function SkillLevel_About()
	DEFAULT_CHAT_FRAME:AddMessage(SKILLLEVEL_STATUS_ABOUT .. DisplayBool(SkillLevelOptions.Status), 1, 0.8, 0.1);
	DEFAULT_CHAT_FRAME:AddMessage("-----", 1, 1, 0);
	DEFAULT_CHAT_FRAME:AddMessage(SKILLLEVEL_ABOUT1, 0.5, 1, 0);
	DEFAULT_CHAT_FRAME:AddMessage(SKILLLEVEL_ABOUT2, 0.5, 1, 0);
	DEFAULT_CHAT_FRAME:AddMessage(SKILLLEVEL_ABOUT3, 0.5, 1, 0);
end

function SkillLevel_SlashCommando(command)
	local f,u, cmd, param = string.find(command, "^([^ ]+) (.+)$");
	if (not cmd) then
		cmd = command;
	end
	cmd = string.lower(cmd);
	if (cmd == 'on' or cmd == '1' or cmd == 'true') then
		SkillLevelOptions.Status = 1;
		DEFAULT_CHAT_FRAME:AddMessage(SKILLLEVEL_STATUS .. DisplayBool(SkillLevelOptions.Status) , 1, 0.8, 0.1);
	elseif (cmd == 'off' or cmd == '0' or cmd == 'false') then
		SkillLevelOptions.Status = 0;
		DEFAULT_CHAT_FRAME:AddMessage(SKILLLEVEL_STATUS .. DisplayBool(SkillLevelOptions.Status) , 1, 0.8, 0.1);
	elseif (cmd == "about" or cmd == "help" or cmd == "commands") then
		SkillLevel_About();
	else
		DEFAULT_CHAT_FRAME:AddMessage(SKILLLEVEL_STATUS_ABOUT .. DisplayBool(SkillLevelOptions.Status), 1, 0.8, 0.1);
		DEFAULT_CHAT_FRAME:AddMessage(SKILLLEVEL_ABOUT, 1, 0.8, 0.1);
	end
end
