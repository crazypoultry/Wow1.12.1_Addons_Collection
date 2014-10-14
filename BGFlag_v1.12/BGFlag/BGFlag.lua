
--Version 1.12.0
local LightBlue			= "|c0033CCFF"; --Light Blue Text
local Green				= "|c0033FF66"; --Greenish Text
local BGFlag_Enabled		= true;
local HasHordeFlag		= BGFLAG_STATUS_ATBASE;
local HasAllianceFlag		= BGFLAG_STATUS_ATBASE;
local BGFlag_MiniEnabled	= false;
local BGFlag_IsLocked		= true;
BGFlagConfig =
{ RelXPos			= WorldStateAlwaysUpFrame:GetLeft();
  RelYPos			= WorldStateAlwaysUpFrame:GetTop();
}

function BGFlag_OnLoad()
	SlashCmdList["BGFlag"] = BGFlag_SlashHandler;
	SLASH_BGFlag1 = "/bgflag"
    
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE"); 
    this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE"); 
    this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL"); 
    
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    
	--this:RegisterEvent("CHAT_MSG_SAY");
    
	this:RegisterEvent("VARIABLES_LOADED");	
end

function BGFlag_RCChat(text)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(LightBlue..text);
	end
end

function BGFlag_StartDrag()
	if (BGFlag_MiniEnabled and not BGFlag_IsLocked) then
        frame = getglobal("WorldStateAlwaysUpFrame");
        frame2 = getglobal("BGFlag");
        frame.isLocked = 0;
        frame2.isLocked = 0;
        frame:SetMovable(1);
        frame2:SetMovable(1);
        
        if (arg1 == "LeftButton") then
            frame:StartMoving();
            frame2:StartMoving();
            frame.isMoving = true;
            frame2.isMoving = true;
        end
	end
end
function BGFlag_StopDrag()
	frame = getglobal("WorldStateAlwaysUpFrame");
	frame2 = getglobal("BGFlag");
    
	if (frame.isMoving and frame2.isMoving) then
		frame:StopMovingOrSizing();
		frame.isMoving = false;
		frame2:StopMovingOrSizing();
		frame2.isMoving = false;
	end
    
	frame:SetMovable(0);
	frame2:SetMovable(0);
	BGFlag_GetPositions();
end

function BGFlag_SlashHandler(text)
	if (strlower(text) == "disable") then
		BGFlag_disable();
	elseif (strlower(text) == "enable") then
		BGFlag_Enabled = true;
		BGFlag_RCChat("BGFlag enabled...")
	elseif (strlower(text) == "clear") then
		BGFlag_clear();
		BGFlag_MiniEnabled = true;
      	BGFlag_RCChat("BGFlag cleared...");
	elseif (strlower(text) == "reset") then
		WorldStateAlwaysUpFrame:ClearAllPoints();
		WorldStateAlwaysUpFrame:SetPoint("TOP", "UIParent", "TOP", -5, -15);
		WorldStateAlwaysUpFrame:StopMovingOrSizing();
		BGFlag:StopMovingOrSizing();
		BGFlag_GetPositions();
        BGFlag_RCChat("BGFlag position is reset...");
	elseif (strlower(text) == "testdrag") then --for debug purposes mostly
		if (BGFlag_MiniEnabled) then
			BGFlag_MiniEnabled = false;
			WorldStateAlwaysUpFrame:Hide();
			AlwaysUpFrame1:Hide();
			AlwaysUpFrame2:Hide();
			AlwaysUpFrame1Text:SetText("");
			AlwaysUpFrame2Text:SetText("");
			getglobal("BGFlag"):Hide();
		else
			BGFlag_MiniEnabled = true;
			WorldStateAlwaysUpFrame:Show();
			AlwaysUpFrame1:Show();
			AlwaysUpFrame2:Show();
			AlwaysUpFrame1Text:SetText("0/3");
			AlwaysUpFrame2Text:SetText("0/3");
			getglobal("BGFlag"):Show();
			BGFlagAlliance:SetText("Sinter 0/3");
			BGFlagHorde:SetText("Highlord");
		end

		BGFlag_RCChat("Testing, unlocked or locked for BG");
	elseif (strlower(text) == "lock") then
		BGFlag_IsLocked = true;
		BGFlagButtonAnchor:Hide();
		BGFlag_RCChat("Frame is locked...");
	elseif (strlower(text) == "unlock") then
		BGFlag_IsLocked = false;
		BGFlagButtonAnchor:Show();
		BGFlag_RCChat("Frame is movable...");
	elseif (strlower(text) == "help" or strlower(text) == "" or strlower(text) ~= "" ) then
		BGFlag_help();
	end
end



function BGFlag_OnEvent()
	if (event == "ZONE_CHANGED_NEW_AREA") then

        local currentZone = GetRealZoneText();
        
		if (currentZone == "Warsong Gulch") then
			--set frame position
			WorldStateAlwaysUpFrame:ClearAllPoints();
			getglobal('WorldStateAlwaysUpFrame'):SetPoint('CENTER', 'UIParent', 'BOTTOMLEFT', BGFlagConfig.RelXPos, BGFlagConfig.RelYPos );

			WorldStateAlwaysUpFrame:StopMovingOrSizing();
			BGFlag:StopMovingOrSizing();
			BGFlag_MiniEnabled = true;
			BGFlag_GetPositions();

			getglobal("BGFlag"):Show();
			
			--test to see if the flags already have statuses, eg if joined in the middle of the game	
			--atext, aicon, aisFlashing, adynamicIcon, atooltip, adynamicTooltip = GetWorldStateUIInfo(1);
			
			if ( AlwaysUpFrame1DynamicIconButtonIcon:IsVisible() ) then
				HasHordeFlag = BGFLAG_STATUS_UNKNOWN;
			else
				HasHordeFlag = BGFLAG_STATUS_ATBASE;
			end

			--htext, hicon, hisFlashing, hdynamicIcon, htooltip, hdynamicTooltip = GetWorldStateUIInfo(2);
			if ( AlwaysUpFrame2DynamicIconButtonIcon:IsVisible() ) then
				HasAllianceFlag = BGFLAG_STATUS_UNKNOWN;
			else
				HasAllianceFlag = BGFLAG_STATUS_ATBASE;
			end
    
			BGFlag_UpdateFrame();
            
        else
            BGFlag_MiniEnabled = false;
			BGFlag_clear();
			getglobal("BGFlag"):Hide();
		end

	elseif (event == "VARIABLES_LOADED") then		
		--set frame position
		WorldStateAlwaysUpFrame:ClearAllPoints();
		getglobal('WorldStateAlwaysUpFrame'):SetPoint('CENTER', 'UIParent', 'BOTTOMLEFT', BGFlagConfig.RelXPos, BGFlagConfig.RelYPos );

		WorldStateAlwaysUpFrame:StopMovingOrSizing();
		BGFlag:StopMovingOrSizing();
		BGFlag_GetPositions();

	elseif (event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE" or event == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
        
        if (BGFlag_Enabled == true and BGFlag_MiniEnabled == true) then
            BGFlag_WhoHasFlag(arg1);
            BGFlag_UpdateFrame();
        end
	
	
	
	--used as a Debugging since getting into the instance is tedious
--[[ 	elseif (event == "CHAT_MSG_SAY") then
  -- 		if (arg2 == "Luaset") then
  -- 			BGFlag_RCChat(arg1);
  -- 			BGFlag_WhoHasFlag(arg1);
  -- 			BGFlag_UpdateFrame();
  -- 		end
  --]]
  
  end
end

function BGFlag_help()
	BGFlag_RCChat("\nCommands:\n" ..Green.. "/bgflag disable" ..LightBlue.. BGFLAG_HELP_DISABLE ..Green.. "/bgflag enable" ..LightBlue.. BGFLAG_HELP_ENABLE ..Green.. "/bgflag clear" ..LightBlue.. BGFLAG_HELP_CLEAR..Green.."/bgflag lock" .. LightBlue.. BGFLAG_HELP_LOCK .. Green.. "/bgflag unlock" .. LightBlue .. BGFLAG_HELP_UNLOCK .. Green .. "/bgflag reset" .. LightBlue .. BGFLAG_HELP_RESET)
end

function BGFlag_WhoHasFlag(text)
	local player
	local faction
	local flagStatus
	local strlength
	local index
	
	--first get flag status
	--flagStatus will be picked, captured, wins, returned, Dropped
	index = strfind(text, BGFLAG_STATUS_PICKED)
	if (index) then
		flagStatus = strlower(BGFLAG_STATUS_PICKED)
	end
	index = strfind(text, BGFLAG_STATUS_CAPTURED);
	if (index) then
		flagStatus = strlower(BGFLAG_STATUS_CAPTURED);
	end
	index = strfind(text, BGFLAG_STATUS_WIN)
	if (index) then
		flagStatus = strlower(BGFLAG_STATUS_WIN);
	end
	index = strfind(text, BGFLAG_STATUS_RETURNED)
	if (index) then
		flagStatus = strlower(BGFLAG_STATUS_RETURNED);
	end
	index = strfind(text, strlower(BGFLAG_STATUS_DROPPED) )
	if (index) then
		flagStatus = strlower(BGFLAG_STATUS_DROPPED);
	end
	

	--now get the faction if one of those words were found, except captured
	if (flagStatus and flagStatus ~= strlower(BGFLAG_STATUS_CAPTURED) ) then 
		--faction is going to be Alliance or Horde
		index = strfind(text, BGFLAG_STATUS_FACTION_HORDE);
		if ( index ) then
			faction = BGFLAG_STATUS_FACTION_HORDE;
		else
			faction = BGFLAG_STATUS_FACTION_ALLIANCE;
		end
		strlength = strlen(text)
	end
	--if the status is Captured
	if (flagStatus and flagStatus == strlower(BGFLAG_STATUS_CAPTURED) ) then
		--faction is going to be Alliance or Horde
		index = strfind(text, BGFLAG_STATUS_FACTION_HORDE);
		if ( index ) then
			faction = BGFLAG_STATUS_FACTION_HORDE;
		else
			faction = BGFLAG_STATUS_FACTION_ALLIANCE;
		end
	end

	--get the player who has the flag, only if the status is picked
	if (flagStatus == strlower(BGFLAG_STATUS_PICKED) ) then
		--to be added for localization
		if ( GetLocale() == "frFR") then
			index = strfind(text, " par ");
			if (index) then
				player = strsub(text, index+5, strlength-2);
			end
		elseif ( GetLocale() == "deDE") then
			index = strfind(text, BGFLAG_STATUS_PICKED);
			if (index) then
				_,_,player = strfind(text, "(%w+) hat die Flagge");
			end
		else
			index = strfind(text, " by ")
			if (index) then
				player = strsub(text, index+4, strlength-1);
			end
		end
	end
	
	--if the flagged is dropped, make it say that it's dropped
	if (flagStatus == strlower(BGFLAG_STATUS_DROPPED) ) then
		player = BGFLAG_STATUS_DROPPED;
	end
	
	--if the flag is captured or returned, make it say "At Base"
	if (flagStatus == BGFLAG_STATUS_CAPTURED or flagStatus == BGFLAG_STATUS_RETURNED or flagStatus == nil or flagStatus == "") then
		player = BGFLAG_STATUS_ATBASE;
	end
	if (faction == BGFLAG_STATUS_FACTION_ALLIANCE) then
		HasAllianceFlag = player;
	elseif (faction == BGFLAG_STATUS_FACTION_HORDE) then
		HasHordeFlag = player;
	end
	if (flagStatus == BGFLAG_STATUS_WIN) then
		BGFlag_HideFrame()
	end
end

function BGFlag_UpdateFrame()
	getglobal("BGFlagHorde"):SetText(HasHordeFlag)
	getglobal("BGFlagAlliance"):SetText(HasAllianceFlag)
end

function BGFlag_HideFrame()
	HasHordeFlag = ""
	HasAllianceFlag = ""
end

function BGFlag_disable()
	BGFlag_clear();
	BGFlag_Enabled = false;
	getglobal("BGFlag"):Hide();
end

function BGFlag_clear()
	BGFlag_HideFrame();
	BGFlag_UpdateFrame();
end

function BGFlag_GetPositions()
    BGFlagConfig.RelXPos, BGFlagConfig.RelYPos = WorldStateAlwaysUpFrame:GetCenter();
end


function BGFlag_target(input)

	-- input: horde flagbearer=false, alliance flagbearer=true
	if (input) then
		BGFlag.target = getglobal("BGFlagAlliance"):GetText();
	else
		BGFlag.target = getglobal("BGFlagHorde"):GetText();
	end

	-- Get the current Flag carrier name
	if (BGFlag.target ~= BGFLAG_STATUS_DROPPED and BGFlag.target ~= BGFLAG_STATUS_ATBASE and BGFlag.target ~= nil and BGFlag.target ~= "") then
		TargetByName(BGFlag.target);
	end

	-- Checking if the target was acquired
	if (BGFlag.target ~= UnitName("target") ) then
		-- Retarget the old target
			TargetLastTarget();
	end
end

