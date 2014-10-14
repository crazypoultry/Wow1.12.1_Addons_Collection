--**********************************************************************************************
-- File:		AsmoHonorRole.lua
-- Author:		Asmo
-- Description:	Infobar and Titan plugin tracks player kills and Honor/Bonus Points for the day
--**********************************************************************************************

--General colors kept as reference for UI
local RED     = "|cffff0000";
local GREEN   = "|cff00ff00";
local BLUE    = "|cff0000ff";
local MAGENTA = "|cffff00ff";
local YELLOW  = "|cffffff00";
local CYAN    = "|cff00ffff";
local WHITE   = "|cffffffff";
local COPPER  = "|cffEDD48E";
local SILVER  = "|cffCECACE";
local GOLD    = "|cffD8BD49";

--TITLE
TITLE_TEXT = UnitName("player").."'s Honor Kills for Today";

--Menu constants
HEADER_MENU_TEXT        = "Asmo Options";
AUTOJOIN_MENU_TEXT      = "AutoJoin Battleground";
AUTOJOINDELAY_MENU_TEXT = "Delay AutoJoin";
AUTOACCEPT_MENU_TEXT    = "AutoAccept Resurrect";
AUTORELEASE_MENU_TEXT   = "AutoRelease after Death";
TRUNCLOWBIES_MENU_TEXT  = "Group lower kills after 40";
NODAILY_RESET_MENU_TEXT = "Don't reset daily totals";

--Titan
TITAN_HONORROLE_ID      = "HonorRole";

--Local vars
local Version = "1.81";
local currentBonus = 0;
local currentHonorText="";
local displaycount = 40;
local serverHonorResetTime = 4;
local playerName = UnitName("player");

HKillTrackerData = {};
HKillTrackerConfig = {};

--******************************************************************************
-- Functions
--******************************************************************************
function HKillTracker_ResetConfig()	
    HKillTrackerConfig.Version       = "1.81";
    HKillTrackerConfig.AutoRelease   = 1;
    HKillTrackerConfig.AutoAccept    = 1;
    HKillTrackerConfig.AutoJoin      = 1;
	HKillTrackerConfig.AutoJoinDelay = 1;
    HKillTrackerConfig.TruncLowbies  = 0;
	HKillTrackerConfig.NoDailyReset  = 0;
end

-- Called when loaded
function HKillTracker_OnLoad()
      
    -- register events
    this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
    this:RegisterEvent("VARIABLES_LOADED"); 
    this:RegisterEvent("UPDATE_WORLD_STATES");
    this:RegisterEvent("AREA_SPIRIT_HEALER_IN_RANGE");
    this:RegisterEvent("PLAYER_DEAD");
    this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");

--test
    --this:RegisterEvent("MINIMAP_PING");
	    
    SLASH_HKILLTRACKER1 = "/hkill";
    SlashCmdList["HKILLTRACKER"] = function( msg )
	HKillTracker_SlashCommandHandler( msg );
    end

    -- Start fresh
    HKillTracker_ResetConfig();		
		
    DEFAULT_CHAT_FRAME:AddMessage(CYAN .. "Asmo Honor Role (".. Version ..") - Loaded. (/hkill for help)");
    UIErrorsFrame:AddMessage("Asmo Honor Role AddOn loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);					
end

-- Event catcher
function HKillTracker_OnEvent()			
    local PatternText = "(.+) dies%, honorable kill Rank%: (.+) %(Estimated Honor Points: (%d+)%)";
	local HonorCastText = "begins to cast Honor Points %+(%d+)";
    local PlayerDeath, PlayerRank, HonorPoints, PlayerStr, dmReturn;	
	
    -- Auto rez	
    if ( event == "AREA_SPIRIT_HEALER_IN_RANGE" and HKillTrackerConfig.AutoAccept == 1) then
		AutoRez();
        return;
    end
	
    -- Auto release
    if ( event == "PLAYER_DEAD" and HKillTrackerConfig.AutoRelease == 1) then
		AutoRelease();
        return;
    end	

    -- Auto join BG
    if ( event == "UPDATE_BATTLEFIELD_STATUS" and HKillTrackerConfig.AutoJoin == 1) then
		AutoJoin();
		return;
    end	
	
    --When player logs in, check for reset...fix for Server time not being called till way after VAR LOADED
    if (event == "PLAYER_ENTERING_WORLD") then
        HKillTracker_CheckReset(false);
    end

    if (event == "VARIABLES_LOADED") then					
        if (HKillTrackerConfig.Version == nil) then
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .. "Asmo Honor Role - New load detected, loading default settings.");
            HKillTracker_ResetConfig();
        elseif (HKillTrackerConfig.Version ~= Version) then
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .. "Asmo Honor Role - Version upgrade detected, loading default settings.");
            HKillTracker_ResetConfig();
        end
					
    elseif (event == "CHAT_MSG_COMBAT_HONOR_GAIN") then                    
        for PlayerDeath, PlayerRank, HonorPoints in string.gfind(arg1, PatternText) do
            --DEFAULT_CHAT_FRAME:AddMessage("FOUNDMATCH ".. PlayerDeath ..":".. PlayerRank ..":".. HonorPoints);
				
			PlayerStr = CreatePlayerStr(PlayerDeath, PlayerRank);

            -- Kills array
            if (HKillTrackerData[playerName..'kills'] == nil) then
                HKillTrackerData[playerName..'kills'] = {};
            end
						           
            if (HKillTrackerData[playerName..'kills'][PlayerStr] == nil) then
                HKillTrackerData[playerName..'kills'][PlayerStr] = 1;
            else
                HKillTrackerData[playerName..'kills'][PlayerStr] = HKillTrackerData[playerName..'kills'][PlayerStr] + 1;
            end

            -- Determine Diminishing return multiplier for player killed
			dmReturn = DiminishingReturns(PlayerStr);
		
            -- Update Honor Points
            if (HKillTrackerData[playerName..'honor'] == nil) then
                HKillTrackerData[playerName..'honor'] = tonumber(HonorPoints)*dmReturn;
            else
                HKillTrackerData[playerName..'honor'] = HKillTrackerData[playerName..'honor'] + (tonumber(HonorPoints)*dmReturn);
            end

            -- Honor Points per player array
            if (HKillTrackerData[playerName..'honorper'] == nil) then
                HKillTrackerData[playerName..'honorper'] = {};
            end

            -- Honor Points per player
            if (HKillTrackerData[playerName..'honorper'][PlayerStr] == nil) then
                HKillTrackerData[playerName..'honorper'][PlayerStr] = tonumber(HonorPoints)*dmReturn;
            else
                HKillTrackerData[playerName..'honorper'][PlayerStr] = HKillTrackerData[playerName..'honorper'][PlayerStr] + (tonumber(HonorPoints)*dmReturn);
            end
		
	        -- Kill total				
            if (HKillTrackerData[playerName..'killstotal'] == nil) then
                HKillTrackerData[playerName..'killstotal'] = 1;
            else
                HKillTrackerData[playerName..'killstotal'] = HKillTrackerData[playerName..'killstotal'] + 1;
            end
												
            local HonorSum = HKillTrackerData[playerName..'honor']+HKillTrackerData[playerName..'bHonor'];
				
            -- Update Info Bar
            IB_HKillTracker_SetText(HonorSum);
						
        end	

		-- Update Bonus Honor Points for PvP including turnins and world pvp
		local bonusHonor = 0;
		local BonusHonorText = "been awarded (%d+)% honor points";

		for bonusHonor in string.gfind(arg1, BonusHonorText) do

			--DEFAULT_CHAT_FRAME:AddMessage("PvP Bonus"..bonusHonor);
			UpdateBonusDisplay(bonusHonor);
		end
    end
end

-- Daily Reset of Honor Kill Database
function HKillTracker_CheckReset ( ForcedReset )     
		
	local _, yesterdayHonor = GetPVPThisWeekStats();
	local cdate = date("%x");
	local HonorSum;
																		

	if (HKillTrackerData[playerName..'datadate'] == nil) then
		-- No datadate exists
		HKillTrackerData[playerName..'yHonor'] = yesterdayHonor; 
		HKillTrackerData[playerName..'datadate'] = cdate;
		HKillTrackerData[playerName..'honor'] = 0;
		HKillTrackerData[playerName..'bHonor'] = 0;
		HKillTrackerData[playerName..'killstotal'] = 0;
						
		-- Set Display
		IB_HKillTracker_SetText("0");

	
	elseif ((HKillTrackerData[playerName..'yHonor'] ~= yesterdayHonor and HKillTrackerConfig.NoDailyReset ~= 1) or (ForcedReset)) then 

		-- Reset the data at switch of Blizzard logged honor for the day
		HonorSum = HKillTrackerData[playerName..'honor']+HKillTrackerData[playerName..'bHonor'];
		UIErrorsFrame:AddMessage(GREEN.."Asmo Honor Role daily reset of Honor Data("..format("%.0f",HonorSum).." Honor)", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
		DEFAULT_CHAT_FRAME:AddMessage(GREEN.."Asmo Honor Role daily reset of Honor Data("..format("%.0f",HonorSum).." Honor)");

		HKillTrackerData = {};
		HKillTrackerData[playerName..'yHonor'] = yesterdayHonor;
		HKillTrackerData[playerName..'datadate'] = cdate;
		HKillTrackerData[playerName..'honor'] = 0;
		HKillTrackerData[playerName..'bHonor'] = 0;
		HKillTrackerData[playerName..'killstotal'] = 0;						
						
		-- Set Display
		IB_HKillTracker_SetText("0");                    
	else
		-- Data is Today's
												
		if (HKillTrackerData[playerName..'honor'] == nil) then
			HKillTrackerData[playerName..'honor'] = 0;
			HKillTrackerData[playerName..'bHonor'] = 0;

			-- Set Honor readout to 0
			IB_HKillTracker_SetText("0");
		else
			-- Set Display                            
			HonorSum = HKillTrackerData[playerName..'honor']+HKillTrackerData[playerName..'bHonor'];
			IB_HKillTracker_SetText(HonorSum);
		end
						
		if (HKillTrackerData[playerName..'killstotal'] == nil) then
			HKillTrackerData[playerName..'killstotal'] = 0;
		end                    
	end
end

--************************
-- Slash command functions
--************************
function HKillTracker_SlashCommandHandler( msg )
    local msgArgs;
    local numArgs;
	
    -- Get args
    msg = string.lower(msg);
    msgArgs = GetArgs(msg, " ");
	
    -- Get num of args
    numArgs = table.getn(msgArgs);	
	
    if (numArgs == 0) then
	HKillTracker_Display_Usage();
    elseif (numArgs == 1) then
         if (msgArgs[1] == "status") then	
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoRelease is ".. StatusText(HKillTrackerConfig.AutoRelease));	
			DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoAccept is ".. StatusText(HKillTrackerConfig.AutoAccept));	
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoJoin is ".. StatusText(HKillTrackerConfig.AutoJoin));
			DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoJoinDelay is ".. StatusText(HKillTrackerConfig.AutoJoinDelay));
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: TruncLowbies is ".. StatusText(HKillTrackerConfig.TruncLowbies));	
			DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: NoDailyReset is ".. StatusText(HKillTrackerConfig.NoDailyReset));
         elseif (msgArgs[1] == "reset") then	
            HKillTracker_CheckReset( true );
	        TitanPanelSelfUpdate(); --Update Titan
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: Resetting kills and honor totals.");          	
         elseif (msgArgs[1] == "autoreleaseoff") then
            HKillTrackerConfig.AutoRelease = 0;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoRelease is now off.");   
         elseif (msgArgs[1] == "autoacceptoff") then 
            HKillTrackerConfig.AutoAccept = 0;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoAccept is now off."); 
         elseif (msgArgs[1] == "autojoinoff") then 
            HKillTrackerConfig.AutoJoin = 0;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoJoin is now off."); 
         elseif (msgArgs[1] == "autojoindelayoff") then 
            HKillTrackerConfig.AutoJoinDelay = 0;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoJoinDelay is now off."); 			
         elseif (msgArgs[1] == "trunclowbiesoff") then 
            HKillTrackerConfig.TruncLowbies = 0;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: TruncLowbies is now off.");
         elseif (msgArgs[1] == "nodailyresetoff") then 
            HKillTrackerConfig.NoDailyReset = 0;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: NoDailyReset is now off.");			
         elseif (msgArgs[1] == "autoreleaseon") then
            HKillTrackerConfig.AutoRelease = 1;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoRelease is now on.");   
         elseif (msgArgs[1] == "autoaccepton") then
            HKillTrackerConfig.AutoAccept = 1;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoAccept if now on."); 
         elseif (msgArgs[1] == "autojoinon") then 
            HKillTrackerConfig.AutoJoin = 1;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoJoin is now on."); 
		 elseif (msgArgs[1] == "autojoindelayon") then 
            HKillTrackerConfig.AutoJoinDelay = 1;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: AutoJoinDelay is now on."); 
         elseif (msgArgs[1] == "trunclowbieson") then 
            HKillTrackerConfig.TruncLowbies = 1;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: TruncLowbies is now on.");            
		elseif (msgArgs[1] == "nodailyreseton") then 
            HKillTrackerConfig.NoDailyReset = 1;
            DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role: NoDailyReset is now on."); 
         else
            HKillTracker_Display_Usage();
         end
    end	
end

--Display slash commands
function HKillTracker_Display_Usage ()
    DEFAULT_CHAT_FRAME:AddMessage(GREEN .."Asmo Honor Role Commands:");
    DEFAULT_CHAT_FRAME:AddMessage(GREEN .."/hkill status - Shows all the current settings");
    DEFAULT_CHAT_FRAME:AddMessage(GREEN .."/hkill reset - Reset the kills and honor");
    DEFAULT_CHAT_FRAME:AddMessage(GREEN .."/hkill autoreleaseon | autoreleaseoff - Turn AutoRelease after death on|off");
    DEFAULT_CHAT_FRAME:AddMessage(GREEN .."/hkill autoaccepton | autoacceptoff - Turn AutoAccept at Spirit on|off");
    DEFAULT_CHAT_FRAME:AddMessage(GREEN .."/hkill autojoinon | autojoinoff - Turn AutoJoin the BG on|off");
	DEFAULT_CHAT_FRAME:AddMessage(GREEN .."/hkill autojoindelayon | autojoindelayoff - Turn AutoJoinDelay for delayed AutoJoin on|off");
    DEFAULT_CHAT_FRAME:AddMessage(GREEN .."/hkill trunclowbieson | trunclowbiesoff - Turn low number kills grouping on|off"); 
	DEFAULT_CHAT_FRAME:AddMessage(GREEN .."/hkill nodailyreseton | nodailyresetoff - Turn daily kill reset on|off"); 
end

function StatusText(var)
    if (var==1) then
	return "ON";
    else
	return "OFF";
    end
end

function HKillTracker_DisplayInfo ( msg ) 
    DEFAULT_CHAT_FRAME:AddMessage(msg);	
end

--******************
--Info bar functions
--******************
--Option Menu Functions
function IB_HKillTracker_Load(state)
    IB_HKillTracker_AutoAcceptCheckBox:SetChecked(HKillTrackerConfig.AutoAccept);
    IB_HKillTracker_AutoReleaseCheckBox:SetChecked(HKillTrackerConfig.AutoRelease);
    IB_HKillTracker_AutoJoinCheckBox:SetChecked(HKillTrackerConfig.AutoJoin);
	IB_HKillTracker_AutoJoinDelayCheckBox:SetChecked(HKillTrackerConfig.AutoJoinDelay);
    IB_HKillTracker_TruncLowbiesCheckBox:SetChecked(HKillTrackerConfig.TruncLowbies);
	IB_HKillTracker_NoDailyResetCheckBox:SetChecked(HKillTrackerConfig.NoDailyReset);
end

function IB_HKillTracker_Save(state)
    HKillTrackerConfig.AutoAccept = IB_HKillTracker_AutoAcceptCheckBox:GetChecked();
    HKillTrackerConfig.AutoRelease = IB_HKillTracker_AutoReleaseCheckBox:GetChecked();
    HKillTrackerConfig.AutoJoin = IB_HKillTracker_AutoJoinCheckBox:GetChecked();
	HKillTrackerConfig.AutoJoinDelay = IB_HKillTracker_AutoJoinDelayCheckBox:GetChecked();
    HKillTrackerConfig.TruncLowbies = IB_HKillTracker_TruncLowbiesCheckBox:GetChecked();
	HKillTrackerConfig.NoDailyReset = IB_HKillTracker_NoDailyResetCheckBox:GetChecked();
end

function IB_HKillTracker_OnLoad()
	this.info = {
		name = TITLE_TEXT,
		version = 181,
		tooltip=HKillTracker_Tooltip, options=IB_HKillTracker_Options};		
    HKillTracker_OnLoad();
    DEFAULT_CHAT_FRAME:AddMessage(CYAN.."  -InfoBar Version Loading");
end

function IB_HKillTracker_SetText( text ) 
    local Suffix = " Honor";
    currentHonorText = format("%.0f",text) .. Suffix;	
    if (IB_HKillTrackerCenteredText ~= nill) then	
    	IB_HKillTrackerCenteredText:SetText (currentHonorText); --Infobar only
    end
end
--*****************************************************END INFOBAR

--******************
--Titan Functions
--******************
--Override/Hook the tooltip in Titan to show the complete text
local PreLongerTitanTooltip_AddTooltipText;
function Hook_Longer_ToolTip()
	PreLongerTitanTooltip_AddTooltipText = TitanTooltip_AddTooltipText;
	TitanTooltip_AddTooltipText = LongerTitanTooltip_AddTooltipText;
end

function LongerTitanTooltip_AddTooltipText(text)
	--PreLongerTitanTooltip_AddTooltipText(text);
	if ( text ) then
		GameTooltip:AddLine(text);
	end
end

function TitanPanelHonorRoleButton_OnLoad()
    HKillTracker_OnLoad();
	Hook_Longer_ToolTip();
    this.registry = {
	id = TITAN_HONORROLE_ID,
	menuText = "Asmo Honor Role",
	buttonTextFunction = "TitanPanelHonorRoleButton_GetButtonText", 
	tooltipTitle = TITLE_TEXT, 
	tooltipTextFunction = "TitanPanelHonorRoleButton_GetTooltipText",
	savedVariables = {
		 ShowLabelText = 1,
	   }
	};
	DEFAULT_CHAT_FRAME:AddMessage(CYAN.." -Titan Version Loading");
    TitanPanelButton_OnLoad();
end

function TitanPanelHonorRoleButton_GetButtonText(id)
     return currentHonorText;
end

function TitanPanelHonorRoleButton_GetTooltipText()
    local txt = HKillTracker_Tooltip();
    TitanPanelButton_UpdateButton(TITAN_HONORROLE_ID);
    return txt;
end

function TitanPanelHonorRole_OnEvent()
    HKillTracker_OnEvent();
    TitanPanelButton_UpdateButton(TITAN_HONORROLE_ID);	
    TitanPanelButton_UpdateTooltip();
end

function TitanPanelSelfUpdate()
    if(TitanPanelBarButton~=nil) then
      TitanPanelButton_UpdateButton(TITAN_HONORROLE_ID);	
    end
end

--Menu
function TitanPanelRightClickMenu_PrepareHonorRoleMenu()
    TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_HONORROLE_ID].menuText);
    local info = {};
    info.text = AUTORELEASE_MENU_TEXT;
    info.func = TitanPanelHonorRole_Toggle_AutoRelease;
	info.checked = CheckToggleVar(HKillTrackerConfig.AutoRelease);
    info.keepShownOnClick = 1;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = AUTOACCEPT_MENU_TEXT;
    info.func = TitanPanelHonorRole_Toggle_AutoAccept;
    info.checked = CheckToggleVar(HKillTrackerConfig.AutoAccept);
    info.keepShownOnClick = 1;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = AUTOJOIN_MENU_TEXT;
    info.func = TitanPanelHonorRole_Toggle_AutoJoin;
    info.checked = CheckToggleVar(HKillTrackerConfig.AutoJoin);
    info.keepShownOnClick = 1;
    UIDropDownMenu_AddButton(info);
	
	info = {};
    info.text = AUTOJOINDELAY_MENU_TEXT;
    info.func = TitanPanelHonorRole_Toggle_AutoJoinDelay;
    info.checked = CheckToggleVar(HKillTrackerConfig.AutoJoinDelay);
    info.keepShownOnClick = 1;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = TRUNCLOWBIES_MENU_TEXT;
    info.func = TitanPanelHonorRole_Toggle_TruncLowbies;
    info.checked = CheckToggleVar(HKillTrackerConfig.TruncLowbies);
    info.keepShownOnClick = 1;
    UIDropDownMenu_AddButton(info);
	
    info = {};
    info.text = NODAILY_RESET_MENU_TEXT ;
    info.func = TitanPanelHonorRole_Toggle_NoDailyReset;
    info.checked = CheckToggleVar(HKillTrackerConfig.NoDailyReset);
    info.keepShownOnClick = 1;
    UIDropDownMenu_AddButton(info);	
	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_HONORROLE_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

--Use our own vars
function CheckToggleVar(var)
	if (var == 1) then
		return true;
	else
		return false;
	end
end

function TitanPanelHonorRole_Toggle_AutoRelease()
	if ( UIDropDownMenuButton_GetChecked() ) then
		HKillTrackerConfig.AutoRelease = 0;
	else
		HKillTrackerConfig.AutoRelease = 1;
	end
end
function TitanPanelHonorRole_Toggle_AutoAccept()
	if ( UIDropDownMenuButton_GetChecked() ) then
		HKillTrackerConfig.AutoAccept = 0;
	else
		HKillTrackerConfig.AutoAccept = 1;
	end
end
function TitanPanelHonorRole_Toggle_AutoJoin()
	if ( UIDropDownMenuButton_GetChecked() ) then
		HKillTrackerConfig.AutoJoin = 0;
	else
		HKillTrackerConfig.AutoJoin = 1;
	end
end
function TitanPanelHonorRole_Toggle_AutoJoinDelay()
	if ( UIDropDownMenuButton_GetChecked() ) then
		HKillTrackerConfig.AutoJoinDelay = 0;
	else
		HKillTrackerConfig.AutoJoinDelay = 1;
	end
end
function TitanPanelHonorRole_Toggle_TruncLowbies()
	if ( UIDropDownMenuButton_GetChecked() ) then
		HKillTrackerConfig.TruncLowbies = 0;
	else
		HKillTrackerConfig.TruncLowbies = 1;
	end
end
function TitanPanelHonorRole_Toggle_NoDailyReset()
	if ( UIDropDownMenuButton_GetChecked() ) then
		HKillTrackerConfig.NoDailyReset = 0;
	else
		HKillTrackerConfig.NoDailyReset = 1;
	end
end
--*****************************************************END TITAN

--The tooltip popup
function HKillTracker_Tooltip()

    local text; 	
    local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("player"));	
    if (rankName == nil) then
		rankName = "None";
    end
    if (rankNumber == nil) then
		rankNumber = "0";
    end

    -- Get Weekly Progress Percent
    local progress = GetPVPRankProgress() *100;

    local honor = 0;
    local bHonor = 0;
    local killstotal = 0;
		
    local HonorPos, HonorRank, HonorRankKills, HonorRankContrib;
    local SortedKills = {};
    local SortedRankKills = {};
		
    if (HKillTrackerData[playerName..'honor'] ~= nil) then
        honor = HKillTrackerData[playerName..'honor'];
    end
    if (HKillTrackerData[playerName..'bHonor'] ~= nil) then
        bHonor = HKillTrackerData[playerName..'bHonor'];
    end
    if (HKillTrackerData[playerName..'killstotal'] ~= nil) then
        killstotal = HKillTrackerData[playerName..'killstotal'];
    end

    local honorpk = format("%.2f", (honor / killstotal));
    if (honor == 0 and killstotal == 0) then
	honorpk = "0";
    end

    text = "Rank: ".. WHITE .. rankName .. " (" ..rankNumber..")|r\n" ..
            "Rank Progress: ".. WHITE .. format("%.0f",progress) .."%|r\n\n";
		
    text = text .."Kills: ".. WHITE .. killstotal .."|r\n" ..	
                  "Average Honor per kill: ".. WHITE .. honorpk .."|r\n\n" ..
                  "Honor: ".. WHITE .. format("%.0f",honor) .. "|r\n"..
                  "Bonus Honor: ".. WHITE .. bHonor .. "|r\n";

    text = text .. "\nPlayer Kills \n";
	--Nine rows up to this point
    --Sort kills
    if (HKillTrackerData[playerName..'kills'] ~= nil) then
        for HonorRank, HonorRankKills in HKillTrackerData[playerName..'kills'] do 
            table.insert(SortedKills, HonorRank);
        end
				
        table.sort(SortedKills, function (n1, n2)
         return HKillTrackerData[playerName..'kills'][n1] > HKillTrackerData[playerName..'kills'][n2]    -- compare kill totals
        end)
			
        local lowbies = 0;
		local hnrper = "";	    				    
        for HonorPos, HonorRank in SortedKills do

			--Honor per kill
            hnrper = format("%.0f",HKillTrackerData[playerName..'honorper'][HonorRank]);
		    
			--Player kills are over 40, start truncating any lower kills
			if (HonorPos > displaycount and HKillTrackerConfig.TruncLowbies == 1) then
				lowbies = lowbies +1;
			end
				

			if (lowbies < 5 or HKillTrackerConfig.TruncLowbies == 0) then
				if (HKillTrackerData[playerName..'kills'][HonorRank] < 11) then
					text = text.. WHITE .. HKillTrackerData[playerName..'kills'][HonorRank] .. WHITE.." ".. HonorRank ..COPPER.." (" .. hnrper.. " Honor"..")|r\n";
				else
					text = text.. CYAN .. HKillTrackerData[playerName..'kills'][HonorRank] .. WHITE.." ".. HonorRank ..COPPER.." (" .. hnrper.." Honor"..")|r\n";
				end
            --List is getting long, trunk the single kills    
			elseif (HonorPos == table.getn(SortedKills) and HKillTrackerConfig.TruncLowbies == 1) then
                text = text .. WHITE ..lowbies-4 .. " more lower kills|r\n";
			end
		end
    else
        text = text .. WHITE .."None|r\n";
    end
    text = text..GREEN.."\n                                 Asmo Honor Role v"..Version.."|r";

    return text;
end

--***************************
--Honor calculation functions
--***************************
--Figure out the Dim returns for killing a player repeated times
function DiminishingReturns(plyerName)
    local name, vle, res;

    res=1;
    for name, vle in HKillTrackerData[playerName..'kills'] do
        if (name == plyerName) then
            
            if (vle == 1) then
                res = 1;
			elseif (vle < 11) then
				res = 1.10 - (vle * .10);
			else
				res = 0;
            end
            break;
        end
    end
    return res;
end

--Update bonus honor
function UpdateBonusDisplay(bonusHonor)
    -- Update Bonus Honor Points
    if (HKillTrackerData[playerName..'bHonor'] == nil) then
		HKillTrackerData[playerName..'bHonor'] = tonumber(bonusHonor);
    else
		HKillTrackerData[playerName..'bHonor'] = HKillTrackerData[playerName..'bHonor'] + tonumber(bonusHonor);
    end

	if (HKillTrackerData[playerName..'honor'] == nil) then
		HKillTrackerData[playerName..'honor'] = 0;
	end
	
	--DEFAULT_CHAT_FRAME:AddMessage("PvP Bonus Updating");
    -- Update Honor Bar
    IB_HKillTracker_SetText(HKillTrackerData[playerName..'honor']+HKillTrackerData[playerName..'bHonor']);
end

--**************
--Addon Functions 
--**************
function AutoJoin()		
--DEFAULT_CHAT_FRAME:AddMessage(RED.."AutoJoin called");
	for i=1, MAX_BATTLEFIELD_QUEUES do
	   local status, _, _ = GetBattlefieldStatus(i);
	   if ( status == "confirm" ) then
			--check if you are in an existing BG, if so no AutoJoin
			for j=1, MAX_BATTLEFIELD_QUEUES do
				local curstatus, _, _ = GetBattlefieldStatus(j);
				if ( curstatus == "active" ) then
					DEFAULT_CHAT_FRAME:AddMessage(RED.."AutoJoin will not join, you are currently in a battleground");
					return;
				end
			end

			if (HKillTrackerConfig.AutoJoinDelay == 1) then
				local expireTime = GetBattlefieldPortExpiration(i)/1000
				expireTime = math.floor(expireTime);
				local timetillJoin = expireTime - 31;
				DEFAULT_CHAT_FRAME:AddMessage(RED.."AutoJoin will join in "..timetillJoin.." seconds");
				if( expireTime < 61) then
					AcceptBattlefieldPort(i, 1);
					StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY", i);
				elseif ( expireTime > 60) then
					-- Alert sound that the BG is ready
					PlaySoundFile("Interface\\AddOns\\AsmoHonorRole\\cgs.wav");
				end			
			else
				AcceptBattlefieldPort(i, 1);
				StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY", i);		
				-- Alert sound that the BG is ready
				PlaySoundFile("Interface\\AddOns\\AsmoHonorRole\\cgs.wav");
			end
	   end
	end
end

function AutoRelease()		
	for i=1, MAX_BATTLEFIELD_QUEUES do
	   local _, _, instanceID = GetBattlefieldStatus(i);
	   if ( instanceID ~= 0 ) then
		   RepopMe();
	   end
	end
end

function AutoRez()		
   AcceptAreaSpiritHeal();
   getglobal("StaticPopup1Button1"):Hide();
   getglobal("StaticPopup1Button2"):Hide();
end

--Message parse
function GetArgs(message, separator)
   local args = {};
   i = 0;

   -- Parse data
   for value in string.gfind(message, "[^"..separator.."]+") do
	i = i + 1;
	args[i] = value;
   end
   return args;
end

--common player string function
function CreatePlayerStr(plyr, rnk)
   local PlayerStr = "";
   if (rnk == nil) then
	rnk = "";
   end
   if (plyr == nil) then
	plyr = "";
   end
   PlayerStr = plyr .." (".. rnk ..")";
   return PlayerStr;
end