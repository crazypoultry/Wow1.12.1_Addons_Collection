--================================================================================================
--
-- Battle Ground Warning v1.1.11200
--
-- Programming by Dash from idea by Valthar on EU Server Kul Tiras
--
-- Guild web site: www.gofguild.com
--
-- History:
-- 2006-04-30, added timeout
-- 2006-05-13, buttons now smaller
-- 2006-05-19, Timeout now 60sec. Keybindings added. No|Off changed to Show|Hide.
-- 2006-05-20, Fixed some typo. Toggle show and hide added.
-- 2006-05-27, Keybindings and lock button added.
-- 2006-05-30, Taged for release of version 1.0.11000
-- 2006-08-28, RAID channel usage removed.	

BGW_NORMAL_LOCK_TEXTURE = "Interface\\AddOns\\TitanBGW\\LockButton-Unlocked-Up";
BGW_PUSHED_LOCK_TEXTURE = "Interface\\AddOns\\TitanBGW\\LockButton-Locked-Up";
BGW_ADDON_PREFIX =        "TITANBGW"; -- not used
BGW_ADDON_INC_PREFIX =    "TITANBGW_INC"
BGW_ADDON_HELP_PREFIX =   "TITANBGW_HELP";
BGW_ADDON_SAFE_PREFIX =   "TITANBGW_SAFE"
BGW_CHAT_CHANNEL =        "BATTLEGROUND";

-- Preparation for futur language extensions
BGW_INC_MSG_PREFIX =  "Inc to";
BGW_HELP_MSG_PREFIX = "Need help at";
BGW_SAFE_MSG_SUFFIX = "safe";

local glb_bDebug = false;   -- false is default value.
local glb_msgTable = {};
local glb_timeTable = {};
local glb_elapsedTime = 0;
local glb_bTimer = false; -- disabled
local TIME_OUT =   60; -- Message timout value is seconds
local TIME_TICKS = 2;  -- 0.5 times / sec is the timeout function called
local glb_bLocked = false; -- BGWFrame not locked at start
--================================================================================================
-- Print the Welcome message and register slash command
--
function fnBGW_OnLoad()
	local zone;

	SlashCmdList[ "BGW" ] = fnBGW_OnSlash;
	SLASH_BGW1 = "/bgw";

-- Keybinding
	BINDING_HEADER_BGW =	"BG Warning"
	BINDING_NAME_BGW_INC =	"Incomming"
	BINDING_NAME_BGW_HELP =	"Help"
	BINDING_NAME_BGW_SAFE =	"Safe"

-- Register Events
	this:RegisterEvent("ZONE_CHANGED"); 
	this:RegisterEvent("ZONE_CHANGED_INDOORS"); 
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterForDrag("LeftButton");	-- Enable the frame to be moved at start.

	ChatFrame1:AddMessage( "BGWarning loaded. Type /bgw for more information." );
	
	zone = GetSubZoneText();
	if(string.len(zone) == 0 or zone == "") then zone = "-------" end;
	
	BGWZone:SetTextHeight(10);
	BGWZone:SetJustifyH("CENTER");
	BGWZone:SetJustifyV("TOP");
	zone = fnBGW_CutIt(zone);
	BGWZone:SetText( zone );
	
	table.setn(glb_msgTable, 5);
	glb_msgTable[1] = "";
	glb_msgTable[2] = "";
	glb_msgTable[3] = "";
	glb_msgTable[4] = "";
	glb_msgTable[5] = "";
	table.setn(glb_timeTable, 5);
	glb_timeTable[1] = 0;
	glb_timeTable[2] = 0;
	glb_timeTable[3] = 0;
	glb_timeTable[4] = 0;
	glb_timeTable[5] = 0;
	
	fnBGW_SetIncMsg();
	glb_bTimer = true; -- enable timer
end

--================================================================================================
function fnBGW_OnSlash( arguments )
	if(arguments == "") then
		ChatFrame1:AddMessage("Battleground Warning v1.1.11200 by:");
		ChatFrame1:AddMessage("Dash from idea by Valthar");
		ChatFrame1:AddMessage("active on Kul-Tiras (EU)");
		ChatFrame1:AddMessage("www.gofguild.com");
		ChatFrame1:AddMessage( "Usage: /bgw show | hide" );
		ChatFrame1:AddMessage( "Usage: /bgw toggle" );
		ChatFrame1:AddMessage( "Usage: /bgw lock | unlock" );
	end

	if(arguments == "show") then
		BGWFrame:Show();
	end
	if(arguments == "hide") then
		BGWFrame:Hide();
	end
	
	if(arguments == "toggle") then
		if(BGWFrame:IsVisible()) then
			BGWFrame:Hide();
		else
			BGWFrame:Show();
		end
	end
	
	if(arguments == "debug") then
		glb_bDebug = true;
	end
	if(arguments == "ndebug") then
		glb_bDebug = false;
	end
	if(arguments == "lock") then
		BGWFrame:RegisterForDrag("");
		BGWLock:SetNormalTexture(BGW_PUSHED_LOCK_TEXTURE);
		BGWLock:SetPushedTexture(BGW_NORMAL_LOCK_TEXTURE);
		glb_bLocked = true;
	end
	if(arguments == "unlock") then
		BGWFrame:RegisterForDrag("LeftButton");
		BGWLock:SetNormalTexture(BGW_NORMAL_LOCK_TEXTURE);
		BGWLock:SetPushedTexture(BGW_PUSHED_LOCK_TEXTURE);
		glb_bLocked = false;
	end
end
--================================================================================================
function fnBGW_OnDragStart()
	this:StartMoving();
	this.isMoving = true;
	if(glb_bDebug) then ChatFrame1:AddMessage( "OnDragStart" ); end;
end
--================================================================================================
function fnBGW_OnDragStop()
	if(this.isMoving) then
		this:StopMovingOrSizing();
		this.isMoving = false;
		if(glb_bDebug) then ChatFrame1:AddMessage( "OnDragStop" ); end;
	end;
end
--================================================================================================
function fnBGW_OnEvent(event)
	local zone = GetSubZoneText();
	
	if(glb_bDebug) then ChatFrame1:AddMessage( "OnEvent: "..event); end;
	if(event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA") then
		if(glb_bDebug) then ChatFrame1:AddMessage( "OnEvent: ".."ZONE_CHANGED" ); end;
		if(string.len(zone) == 0 or zone == "") then zone = "-------" end;
		BGWZone:SetTextHeight(10);
		BGWZone:SetJustifyH("CENTER");
		BGWZone:SetJustifyV("TOP");
		zone = fnBGW_CutIt(zone);
		BGWZone:SetText( zone );
		
		if(zone == "-------") then
			BGWBtnInc:Disable();
			BGWBtnHelp:Disable();
			BGWBtnSafe:Disable();
		else
			BGWBtnInc:Enable();
			BGWBtnHelp:Enable();
			BGWBtnSafe:Enable();
		end
	end
	if(event == "CHAT_MSG_ADDON" and
		(arg1 == BGW_ADDON_INC_PREFIX or
		arg1 == BGW_ADDON_HELP_PREFIX or
		arg1 == BGW_ADDON_SAFE_PREFIX)) then
		fnBGW_GetBgMsg(arg1,arg2,arg3,arg4); 
		fnBGW_SetIncMsg();
	end
end
--================================================================================================
function fnBGW_OnUpdate(arg1) -- arg1 is in secs so may me small like 0.020s
	
	glb_elapsedTime = glb_elapsedTime + arg1;

	if(glb_elapsedTime >= TIME_TICKS) then
		glb_elapsedTime = glb_elapsedTime - TIME_TICKS;
		fnBGW_TimeOut();
	end
end
--================================================================================================
-- Incomming button functions
--================================================================================================
function fnBGW_IncClick()
	local zone = GetSubZoneText();
	
	if(string.len(zone) > 0) then 
		if(glb_bDebug) then ChatFrame1:AddMessage( BGW_INC_MSG_PREFIX .." " .. zone ); end;
		SendChatMessage(BGW_INC_MSG_PREFIX .. " " .. zone, BGW_CHAT_CHANNEL);
		SendAddonMessage(BGW_ADDON_INC_PREFIX, zone, BGW_CHAT_CHANNEL);
	end;
end


--================================================================================================
-- Help button functions
--================================================================================================
function fnBGW_HelpClick()
	local zone = GetSubZoneText();
	
	if(string.len(zone) > 0) then 
		if(glb_bDebug) then ChatFrame1:AddMessage( BGW_HELP_MSG_PREFIX .. " " .. zone ); end;
		SendChatMessage(BGW_HELP_MSG_PREFIX .." " .. zone, BGW_CHAT_CHANNEL);
		SendAddonMessage(BGW_ADDON_HELP_PREFIX, zone, BGW_CHAT_CHANNEL);
	end;
end

--================================================================================================
-- Help button functions
--================================================================================================
function fnBGW_SafeClick()
	local zone = GetSubZoneText();
	
	if(string.len(zone) > 0) then 
		if(glb_bDebug) then ChatFrame1:AddMessage( zone .. " " .. BGW_SAFE_MSG_SUFFIX); end;
		SendChatMessage(zone .. " " .. BGW_SAFE_MSG_SUFFIX, BGW_CHAT_CHANNEL);
		SendAddonMessage(BGW_ADDON_SAFE_PREFIX, zone, BGW_CHAT_CHANNEL);
		fnBGW_SetIncMsg();
	end
end

--================================================================================================
-- Lock button functions
--================================================================================================
function fnBGW_LockClick()
	if(glb_bLocked) then
		glb_bLocked = false;
		BGWLock:SetNormalTexture(BGW_NORMAL_LOCK_TEXTURE);
		BGWLock:SetPushedTexture(BGW_PUSHED_LOCK_TEXTURE);
		BGWFrame:RegisterForDrag("LeftButton");
	else
		glb_bLocked = true;
		BGWLock:SetNormalTexture(BGW_PUSHED_LOCK_TEXTURE);
		BGWLock:SetPushedTexture(BGW_NORMAL_LOCK_TEXTURE);
		BGWFrame:RegisterForDrag("");
	end
end

--================================================================================================
-- Misc functions
--================================================================================================
function fnBGW_SetIncMsg()
	local n = table.getn(glb_msgTable);
	local msg = "";
	
	if(n == 0) then
		BGWMsg:SetText( "" );	
	else
		BGWMsg:SetTextHeight(10);
		BGWMsg:SetJustifyH("CENTER");
		BGWMsg:SetJustifyV("TOP");
		BGWMsg:SetTextColor(255, 0, 0); -- Red
		for i=1,n,1 do
			msg = msg..fnBGW_CutIt(glb_msgTable[i]).."\n";
		end
		BGWMsg:SetText( msg );
	end
end

function fnBGW_CutIt(msg)
	if(string.len(msg) > 18) then
		msg = string.sub(msg,1,18).."...";
	end
	return msg;
end

-- arg1 : TitanBGW channel prefix
-- arg2 : zone
-- arg3, arg4: ignored.
function fnBGW_GetBgMsg(arg1,arg2,arg3,arg4)
	local n = table.getn(glb_msgTable);
	local i = 1;

	if(arg2 ~= "") then
		if(arg1 == BGW_ADDON_INC_PREFIX) then
			if(n >= 5) then
				table.remove(glb_msgTable, n);
				table.remove(glb_timeTable, n);
			end;
			table.insert(glb_msgTable, 1, arg2);
			table.insert(glb_timeTable, 1, TIME_OUT);
			PlaySound("PVPENTERQUEUE");
		end
		if(arg1 == BGW_ADDON_SAFE_PREFIX) then
			while (i <= n) do
				if( string.find(arg2, glb_msgTable[i],1,true)) then
					table.remove(glb_msgTable, i);
					table.remove(glb_timeTable, i);
					i = 1; -- restart all over
					n = n - 1;
					PlaySound("PVPENTERQUEUE");
				else
					i = i + 1;
				end
			end

		end
	end
end

function fnBGW_TimeOut()
	local n = table.getn(glb_timeTable);
	local i = 1;
	local dt = 0;
	
	if(glb_bTimer) then
		while(i	<= n) do
			dt = glb_timeTable[i] - TIME_TICKS;
			glb_timeTable[i] = dt;
			if(glb_timeTable[i] <= 0) then
				table.remove(glb_timeTable, i);
				table.remove(glb_msgTable, i);
				fnBGW_SetIncMsg();
				break;
			end
			i= i + 1;
		end
	end
end
