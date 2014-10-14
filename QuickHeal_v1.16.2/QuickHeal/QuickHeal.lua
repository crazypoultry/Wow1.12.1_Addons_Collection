--[ Mod data ]--
QuickHealData = {
    name = 'QuickHeal',
    version = '1.16.2',
    releaseDate = 'October 15th, 2006',
    author = 'Thomas Thorsen and Scott Geeding',
    website = 'http://ui.worldofwar.net/ui.php?id=1872',
    category = MYADDONS_CATEGORY_CLASS
}

--[ References ]--

local OriginalUIErrorsFrame_OnEvent;

--[ Settings ]--
QuickHealVariables = {};
local QHV; -- Local alias
local DQHV = { -- Default values
    DebugMode = false,
    PetPriority = 0.2,
    TargetPriority = false,
    RatioForceself = 0.4,
    RatioHealthyDruid = 0.4,
    RatioHealthyPaladin = 0.1,
    RatioHealthyPriest = 0.3,
    RatioHealthyShaman = 0.6,
    RatioFull = 0.9,
    NotificationStyle = "NORMAL",
    NotificationChannelName = "",
    NotificationWhisper = false,
    NotificationParty = false,
    NotificationRaid = false,
    NotificationChannel = false,
    NotificationTextNormal = "Healing %s with %s",
    NotificationTextWhisper = "Healing you with %s",
    MessageScreenCenterHealing = true,
    MessageScreenCenterInfo = true,
    MessageScreenCenterBlacklist = true,
    MessageScreenCenterError = true,
    MessageChatWindowHealing = false,
    MessageChatWindowInfo = false,
    MessageChatWindowBlacklist = false,
    MessageChatWindowError = false,
    OverhealMessageScreenCenter = false,
    OverhealMessageCastingBar = true,
    OverhealMessagePlaySound = true,
    FilterRaidGroup1 = false,
    FilterRaidGroup2 = false,
    FilterRaidGroup3 = false,
    FilterRaidGroup4 = false,
    FilterRaidGroup5 = false,
    FilterRaidGroup6 = false,
    FilterRaidGroup7 = false,
    FilterRaidGroup8 = false,
    DisplayHealingBar = true,
    QuickClickEnabled = true,
    ClassPriorityDruid = 0.7,
    ClassPriorityHunter = 0.9,
    ClassPriorityMage = 0.9,
    ClassPriorityPaladin = 0.7,
    ClassPriorityPriest = 0.6,
    ClassPriorityRogue = 0.9,
    ClassPriorityShaman = 0.7,
    ClassPriorityWarlock = 0.6,
    ClassPriorityWarrior = 1.0,
}

--[ Monitor variables ]--
local MassiveOverhealInProgress = nil;
local HealingSpell = nil;    
local HealingSpellSize = 0;  
local HealingSpellCastTime = 0;
local HealingTime = 0;
local HealingTarget = nil;
local HealingTargetName = nil;
local CommCache = {};

--[ QuickHeal lock ]--
local QuickHealBusy = false;

--[ Blacklist variables ]--
local BlackList = {}; -- List of times were the players are no longer blacklisted
local LastBlackListTime = 0;

--[ Keybinding ]--
BINDING_HEADER_QUICKHEAL = "QuickHeal";
BINDING_NAME_QUICKHEAL_HEAL = "Heal";
BINDING_NAME_QUICKHEAL_HEALSUBGROUP = "Heal Subgroup";
BINDING_NAME_QUICKHEAL_HEALPARTY = "Heal Party";
BINDING_NAME_QUICKHEAL_HEALMT = "Heal MT";
BINDING_NAME_QUICKHEAL_HEALNONMT = "Heal Non MT";
BINDING_NAME_QUICKHEAL_HEALSELF = "Heal Player";
BINDING_NAME_QUICKHEAL_HEALTARGET = "Heal Target";
BINDING_NAME_QUICKHEAL_HEALTARGETTARGET = "Heal Target's Target";

--[ Reference to external class specific module ]--
QuickHeal_ClassModule = nil;

--[ Load status of mod ]--
QUICKHEAL_LOADED = false;

--[ Local Caches ]--
local SpellCache = {};

--[ Titan Panel functions ]--

function TitanPanelQuickHealButton_OnLoad()
    this.registry = {
        id = QuickHealData.name,
        menuText = QuickHealData.name,
        buttonTextFunction = nil,
        tooltipTitle = QuickHealData.name .. " Configuration",
        tooltipTextFunction = "TitanPanelQuickHealButton_GetTooltipText",
        frequency = 0,
	    icon = "Interface\\Icons\\Spell_Holy_GreaterHeal"
    };
end

function TitanPanelQuickHealButton_GetTooltipText()
    return "Click to toggle configuration panel";
end

--[ Utilities ]--

-- Determine if player is in a battleground
local function InBattleground()
    local id;
    for i=1,MAX_BATTLEFIELD_QUEUES do
        _,_,id = GetBattlefieldStatus(i);
        if id ~= 0 then return true end
    end
    return false;
end

-- Append server name to unit name when available (battlegrounds)
local function UnitFullName(unit)
    if not unit then return "Unknown" end
    local name,server = UnitName(unit);
    if server and type(server) == "string" and type(name) == "string" then
        return name .. "-" .. server;
    else
        return name;
    end
end

-- Write one line to chat
local function writeLine(s,r,g,b)
   if DEFAULT_CHAT_FRAME then
       DEFAULT_CHAT_FRAME:AddMessage(s, r or 1, g or 1, b or 1)
   end
end

-- Display debug info in the chat frame if debug is enabled
function QuickHeal_debug(...)
   if DEFAULT_CHAT_FRAME and QHV.DebugMode then
       local msg = ''
       for k,v in ipairs(arg) do
          msg = msg .. tostring(v) .. ' : '
       end
       writeLine(msg)
   end
end

local function Message(text,kind,duration)
    -- Deliver message to center of screen
    if kind == "Healing" and QHV.MessageScreenCenterHealing then UIErrorsFrame:AddMessage(text, 0.1, 1, 0.1, 1, duration or 2)
    elseif kind == "Info" and QHV.MessageScreenCenterInfo then UIErrorsFrame:AddMessage(text, 0.1, 0.1, 1, 1, duration or 2)
    elseif kind == "Blacklist" and QHV.MessageScreenCenterBlacklist then UIErrorsFrame:AddMessage(text, 1, 0.9, 0, 1, duration or 2)
    elseif kind == "Error" and QHV.MessageScreenCenterError then UIErrorsFrame:AddMessage(text, 1, 0.1, 0.1, 1, duration or 2) end
    -- Deliver message to chat window
    if kind == "Healing" and QHV.MessageChatWindowHealing then writeLine(text, 0.1, 1, 0.1)
    elseif kind == "Info" and QHV.MessageChatWindowInfo then writeLine(text, 0.1, 0.1, 1)
    elseif kind == "Blacklist" and QHV.MessageChatWindowBlacklist then writeLine(text, 1, 0.9, 0.2)
    elseif kind == "Error" and QHV.MessageChatWindowError then writeLine(text, 1, 0.1, 0.1) end
end

function QuickHeal_ListUnitEffects(Target)
    if UnitExists(Target) then
        local i=1;
        writeLine("|cffffff80******* Buffs on " .. (UnitFullName(Target) or "Unknown") .. " *******|r");
        while (UnitBuff(Target,i)) do
            local string;
            QuickHeal_ScanningTooltip:ClearLines();
            QuickHeal_ScanningTooltip:SetUnitBuff(Target,i);
            local icon,apps = UnitBuff(Target,i);
            string = "|cff0080ff" .. (QuickHeal_ScanningTooltipTextLeft1:GetText() or "") .. ":|r|cffffd200 ";
            string = string .. (QuickHeal_ScanningTooltipTextRight1:GetText() or "") .. ", ";
            string = string .. icon .. ", ";
            string = string .. apps .. "|r\n";
            string = string .. ">" .. (QuickHeal_ScanningTooltipTextLeft2:GetText() or "");
            writeLine(string);
            i=i+1;
        end
        i=1;
        writeLine("|cffffff80******* DeBuffs on " .. (UnitFullName(Target) or "Unknown") .. " *******|r");
        while (UnitDebuff(Target,i)) do
            local string;
            QuickHeal_ScanningTooltip:ClearLines();
            QuickHeal_ScanningTooltip:SetUnitDebuff(Target,i);
            local icon,apps = UnitDebuff(Target,i);
            string = "|cff0080ff" .. (QuickHeal_ScanningTooltipTextLeft1:GetText() or "") .. ":|r|cffffd200 ";
            string = string .. (QuickHeal_ScanningTooltipTextRight1:GetText() or "") .. ", ";
            string = string .. icon .. ", ";
            string = string .. apps .. "|r\n";
            string = string .. ">" .. (QuickHeal_ScanningTooltipTextLeft2:GetText() or "");
            writeLine(string);
            i=i+1;
        end
    end
end


--[ Initialisation ]--

local function Initialise()

    -- Register to myAddons
    if (myAddOnsFrame_Register) then
        myAddOnsFrame_Register(QuickHealData,{"Important commands:\n'/qh cfg' to open configuration panel.\n'/qh help' to list available commands."});
    end
    
    -- Update configuration panel with version information
    QuickHealConfig_TextVersion:SetText("Version: " .. QuickHealData.version);

    local _,PlayerClass = UnitClass('player');
    PlayerClass = string.lower(PlayerClass);

    if PlayerClass == "druid" then
        QuickHeal_ClassModule = QuickHealDruid;
    elseif PlayerClass == "paladin" then
        QuickHeal_ClassModule = QuickHealPaladin;
    elseif PlayerClass == "priest" then
        QuickHeal_ClassModule = QuickHealPriest;
    elseif PlayerClass == "shaman" then
        QuickHeal_ClassModule = QuickHealShaman;
    end

    -- Destroy unused modules
    QuickHealDruid = nil;
    QuickHealPaladin = nil;
    QuickHealPriest = nil;
    QuickHealShaman = nil;

    if not QuickHeal_ClassModule then
        writeLine(QuickHealData.name .. " " .. QuickHealData.version .. " does not support " .. UnitClass('player') .. ". " .. QuickHealData.name .. " not loaded.")
        return;
    end

    SlashCmdList["QUICKHEAL"] = QuickHeal_Command;
    SLASH_QUICKHEAL1 = "/qh";
    SLASH_QUICKHEAL2 = "/quickheal";

    -- Hook the UIErrorsFrame_OnEvent method
    OriginalUIErrorsFrame_OnEvent = UIErrorsFrame_OnEvent;
    UIErrorsFrame_OnEvent = NewUIErrorsFrame_OnEvent;

    -- Setup QuickHealVariables (and initialise upon first use)
    QHV = QuickHealVariables;
    for k in pairs(DQHV) do
        if QHV[k] == nil then QHV[k] = DQHV[k] end;
    end

    -- Compatibility (TODO: can be removed at the release of 1.17.0)
    if (QHV.PetPriority > 1) or (QHV.PetPriority < 0) then
        QHV.PetPriority = DQHV.PetPriority;
    end

    -- Save the version of the mod along with the configuration
    QuickHealVariables["ConfigID"] = QuickHealData.version;

	--Allows Configuration Panel to be closed with the Escape key
	table.insert(UISpecialFrames, "QuickHealConfig");

    writeLine(QuickHealData.name .. " " .. QuickHealData.version .. " for " .. UnitClass('player') .. " Loaded. Usage: '/qh help'.")

    -- Initialise QuickClick
    if QHV.QuickClickEnabled and (type(QuickClick_Load) == "function") then QuickClick_Load() end

    -- Clear cache when learning new spells
    QuickHealConfig:RegisterEvent("LEARNED_SPELL_IN_TAB");

    QuickHealConfig:RegisterEvent("CHAT_MSG_ADDON");

    QUICKHEAL_LOADED = true;
end

function QuickHeal_SetDefaultParameters()
    for k in pairs(DQHV) do
        QHV[k] = DQHV[k];
    end
end

--[ Event Handlers and monitor setup ]--

local ClassColours = {
PALADIN = "|cFFF48CBA",
WARRIOR = "|cFFC69B6D",
WARLOCK = "|cFF9382C9",
PRIEST  = "|cFFFFFFFF",
DRUID   = "|cFFFF7C0A",
MAGE    = "|cFF68CCEF",
ROGUE   = "|cFFFFF468",
SHAMAN  = "|cFFF48CBA",
HUNTER  = "|cFFAAD372"
}

-- Update the HealingBar
local function UpdateHealingBar(hpcurrent,hpbefore,hpafter,waste,red,green)
    if hpcurrent > 1 then hpcurrent = 1 end
    if hpbefore > 2 then hpbefore = 2 end
    if hpafter > 3 then hpafter = 3 end
    if hpcurrent > hpbefore then hpbefore = hpcurrent end
    if hpbefore > hpafter then hpafter = hpbefore end

    -- Update bars
    QuickHealHealingBarStatusBar:SetValue(hpcurrent);
    QuickHealHealingBarStatusBarPre:SetValue(hpbefore);
    QuickHealHealingBarStatusBarPost:SetValue(hpafter);
    QuickHealHealingBarSparkOne:SetPoint( "CENTER", "QuickHealHealingBarStatusBar", "LEFT", 372/2 * hpcurrent, 0 )
    QuickHealHealingBarSparkTwo:SetPoint( "CENTER", "QuickHealHealingBarStatusBar", "LEFT", 372/2 * hpbefore, 0 )

    local _,class = UnitClass(HealingTarget);
    QuickHealHealingBarText:SetText((ClassColours[class] or "") .. HealingTargetName);

    -- Set colour for health
    QuickHealHealingBarStatusBar:SetStatusBarColor(hpcurrent < 0.5 and 1 or 2*(1-hpcurrent),hpcurrent > 0.5 and 0.8 or 1.6*hpcurrent,0);

    -- Set colour for heal
    QuickHealHealingBarStatusBarPost:SetStatusBarColor(red,green,0)
end

local function UpdateOverhealMessages(waste,red,green)
    local textframe = getglobal("QuickHealOverhealStatus_Text");

    -- Hide text if no overheal
    if waste < 0.1 then
        textframe:SetText("")
        QuickHealOverhealStatusScreenCenter:AddMessage(" ");
        return
    end

    -- Update the label
    local txt = floor(waste*100) .. "% of heal will be wasted (" .. floor(HealingSpellSize*waste) .. " Health)";
    QuickHeal_debug(txt);
    textframe:SetText(txt);
    QuickHealOverhealStatusScreenCenter:AddMessage(txt,1,0,0,1,5);

    MassiveOverhealInProgress = waste > 0.5; -- TODO: make threshold configurable
    if MassiveOverhealInProgress and OverhealMessagePlaySound then PlaySoundFile("Sound\\Doodad\\BellTollTribal.wav") end
    textframe:SetTextColor(red,green,0);
    textframe:SetFont(textframe:GetFont(),11+waste*4);
end

local function CommGetTotalHeal(Target,EndTime)
    if CommCache[Target] then
        local TotalPreHeal = 0;
        for i,v in pairs(CommCache[Target]) do
            if type(v.Heal) == "number" and type(v.DueTime) == "number" then
                if v.DueTime < GetTime() then
                    v.DueTime = nil;
                    v.Heal = nil;
                elseif v.DueTime < EndTime  then
                    TotalPreHeal = TotalPreHeal + v.Heal;
                end
            end
        end
        return TotalPreHeal;
    else
        return 0;
    end
end

-- Update the Overheal status labels
local function UpdateQuickHealOverhealStatus()
    local hppre,hppost,hp,waste;

    -- Return if monitor is not running
    if not HealingTarget then return end

    -- Return if healing target or targettarget and target changed
    -- (it is impossible to monitor target and targettarget if they change)
    if HealingTarget == 'target' or HealingTarget == 'targettarget' then
        if HealingTargetName ~= UnitFullName(HealingTarget) then return end
    end

    -- Retrieve total healsize of spells that land on target before this heal
    local preheal = CommGetTotalHeal(HealingTargetName,HealingTime);

    -- Determine health percentages of HealingTarget
    if QuickHeal_UnitHasHealthInfo(HealingTarget) then
        -- Full info available
        hp = UnitHealth(HealingTarget)/UnitHealthMax(HealingTarget);
        hppre = (UnitHealth(HealingTarget)+preheal)/UnitHealthMax(HealingTarget);
        hppost = (UnitHealth(HealingTarget)+preheal+HealingSpellSize)/UnitHealthMax(HealingTarget);
    else
        -- Estimate
        hp = UnitHealth(HealingTarget)/100;
        local factor = (1-hp)/QuickHeal_EstimateUnitHealNeed(HealingTarget);
        hppre = hp+preheal*factor;
        hppost = hp+(preheal+HealingSpellSize)*factor;
    end

    -- Determine waste (in percent)
    if hppost > 1 and hppost > hppre then
        waste = (hppost-1)/(hppost-hppre);
    else
        waste = 0;
    end
    if waste > 1 then waste = 1 end

    -- Calculate colour for overheal severity
    local red = waste > 0.1 and 1 or waste*10;
    local green = waste < 0.1 and 1 or -2.5*waste+1.25;
    if waste < 0 then 
        green = 1;
        red = 0;
    end

    UpdateHealingBar(hp,hppre,hppost,waste,red,green);
    UpdateOverhealMessages(waste,red,green);
end

local function StartMonitor(Target)
    MassiveOverhealInProgress = false;
    HealingTarget = Target;
    HealingTargetName = UnitFullName(Target);
    QuickHeal_debug("*Starting Monitor",HealingTargetName);
    QuickHealConfig:RegisterEvent("UNIT_HEALTH"); -- For detecting overheal situations
    QuickHealConfig:RegisterEvent("SPELLCAST_START"); -- For detecting spellcast start
    QuickHealConfig:RegisterEvent("SPELLCAST_STOP"); -- For detecting spellcast stop
    QuickHealConfig:RegisterEvent("SPELLCAST_FAILED"); -- For detecting spellcast stop
    QuickHealConfig:RegisterEvent("SPELLCAST_INTERRUPTED"); -- For detecting spellcast stop
    QuickHealConfig:RegisterEvent("SPELLCAST_DELAYED"); -- For detecting spellcast stop
    UpdateQuickHealOverhealStatus();
    if QHV.OverhealMessageCastingBar then QuickHealOverhealStatus:Show() end
    if QHV.OverhealMessageScreenCenter then QuickHealOverhealStatusScreenCenter:Show() end
    if QHV.DisplayHealingBar then QuickHealHealingBar:Show() end
end

local function StopMonitor(trigger)
    QuickHealOverhealStatus:Hide();
    QuickHealOverhealStatusScreenCenter:Hide();
    QuickHealHealingBar:Hide()
    QuickHealConfig:UnregisterEvent("UNIT_HEALTH");
    QuickHealConfig:UnregisterEvent("SPELLCAST_START");
    QuickHealConfig:UnregisterEvent("SPELLCAST_STOP");
    QuickHealConfig:UnregisterEvent("SPELLCAST_FAILED");
    QuickHealConfig:UnregisterEvent("SPELLCAST_INTERRUPTED");
    QuickHealConfig:UnregisterEvent("SPELLCAST_DELAYED");
    QuickHeal_debug("*Stopping Monitor",trigger or "Unknown Trigger");
    HealingTarget = nil;
    HealingTargetName = nil;
    HealingSpell = nil;
    HealingSpellSize = 0;
    HealingTime = 0;
    HealingSpellCastTime = 0;
    QuickHealBusy = false;
end

local function CommReceive(Healer,Message)
    local _,_,Status,Target,Heal,HoT,TimeLeft = string.find(Message, "^(.+), (.+), .+, (%d+%.?%d*), (%d+%.?%d*), %d+%.?%d*, (%d+%.?%d*)");
    if not type(Status) == "string" then return end

    -- Ignore HoT messages for now
    HoT = tonumber(HoT);
    if type(HoT) == "number" and HoT > 0 then return end

    TimeLeft = tonumber(TimeLeft);
    Heal = tonumber(Heal);
    
    if Status == "Update" then
        if not CommCache[Target] then CommCache[Target] = {} end
        if CommCache[Target][Healer] then
            -- This is an update of earlier info
            CommCache[Target][Healer].DueTime = GetTime()+TimeLeft;
            CommCache[Target][Healer].Heal = Heal;
        else
            -- This is new info
            CommCache[Target][Healer] = {DueTime = GetTime()+TimeLeft, Heal = Heal};
        end
    elseif Status == "Stop" or Status == "Failed" or Status == "Interrupted" then
        if CommCache[Target] and CommCache[Target][Healer] then
            CommCache[Target][Healer].DueTime = nil;
            CommCache[Target][Healer].Heal = nil;
        end
    end
end

local function CommSend(Status, TimeLeft)
    local Channel = InBattleground() and "BATTLEGROUND" or "RAID";
    if HealingSpellSize > 0 then -- only transmit if we actually have useful info
        SendAddonMessage("QuickHeal", Status .. ", " .. HealingTargetName .. ", " .. HealingSpell .. ", " .. HealingSpellSize .. ", " .. 0 .. ", " .. HealingSpellCastTime .. ", " .. TimeLeft, Channel);
    end
end

-- UIErrorsFrame Hook
function NewUIErrorsFrame_OnEvent(...)
    -- Catch only if monitor is running (HealingTarget ~= nil) and if event is UI_ERROR_MESSAGE
    if HealingTarget and event == "UI_ERROR_MESSAGE" and arg1 then
        if arg1 == SPELL_FAILED_LINE_OF_SIGHT then
            Message(string.format(SPELL_FAILED_LINE_OF_SIGHT .. ". %s blacklisted for 2 sec.", HealingTargetName),"Blacklist",2)
            LastBlackListTime = GetTime();
            BlackList[HealingTargetName] = LastBlackListTime + 2;
            return;
        end
    end
    return {OriginalUIErrorsFrame_OnEvent(unpack(arg))};
end

-- Called when the mod is loaded
function QuickHeal_OnLoad()
    this:RegisterEvent("VARIABLES_LOADED");
end

CommDebug = false;

-- Called whenever a registered event occurs
function QuickHeal_OnEvent()
    if (event == "CHAT_MSG_ADDON") then
        if arg1 == "Panza" or arg1 == "QuickHeal" or arg1 == "Heart" or arg1 == "Genesis" then
            if arg4 ~= UnitFullName('player') then -- filter out own heal messages
               if CommDebug then writeLine("|cff00ff00"..arg4..": "..arg2.." ("..arg1..")"); end
               CommReceive(arg4,arg2);
               UpdateQuickHealOverhealStatus();
            end
        end
    elseif (event == "UNIT_HEALTH") then
        if UnitIsUnit(HealingTarget,arg1) then UpdateQuickHealOverhealStatus() end
    elseif (event == "SPELLCAST_STOP") then
        CommSend("Stop",0);
        StopMonitor(event);
    elseif (event == "SPELLCAST_FAILED") then
        CommSend("Failed",0);
        StopMonitor(event);
    elseif (event == "SPELLCAST_INTERRUPTED") then
        CommSend("Interrupted",0);
        StopMonitor(event);
    elseif (event == "SPELLCAST_START") then
        HealingSpellCastTime = arg2/1000;
        HealingTime = GetTime() + HealingSpellCastTime;
        CommSend("Update", HealingSpellCastTime);
        UpdateQuickHealOverhealStatus();
    elseif (event == "SPELLCAST_DELAYED") then
        HealingSpellCastTime = HealingSpellCastTime + arg1/1000;
        HealingTime = HealingTime + arg1/1000;
        CommSend("Update", HealingTime - GetTime());
        UpdateQuickHealOverhealStatus();
    elseif (event == "LEARNED_SPELL_IN_TAB") then
        SpellCache = {};
    elseif (event == "VARIABLES_LOADED") then
        Initialise();
    else
        QuickHeal_debug((event or "Unknown Event"), (arg1 or "nil"), (arg2 or "nil"))
    end
end

--[ User Interface Functions ]--

-- Items in the NotificationStyle ComboBox
function QuickHeal_ComboBoxNotificationStyle_Fill()
    UIDropDownMenu_AddButton{ text = "Normal"; func = QuickHeal_ComboBoxNotificationStyle_Click; value = "NORMAL" };
    UIDropDownMenu_AddButton{ text = "Role-Playing"; func = QuickHeal_ComboBoxNotificationStyle_Click; value = "RP" };
end
-- Function for handling clicks on the NotificationStyle ComboBox
function QuickHeal_ComboBoxNotificationStyle_Click()
    QHV.NotificationStyle = this.value;
    UIDropDownMenu_SetSelectedValue(QuickHealConfig_ComboBoxNotificationStyle,this.value);
end

-- Items in the MessageConfigure ComboBox
function QuickHeal_ComboBoxMessageConfigure_Fill()
    UIDropDownMenu_AddButton{ text = "Healing (Green)"; func = QuickHeal_ComboBoxMessageConfigure_Click; value = "Healing" };
    UIDropDownMenu_AddButton{ text = "Info (Blue)"; func = QuickHeal_ComboBoxMessageConfigure_Click; value = "Info" };
    UIDropDownMenu_AddButton{ text = "Blacklist (Yellow)"; func = QuickHeal_ComboBoxMessageConfigure_Click; value = "Blacklist" };
    UIDropDownMenu_AddButton{ text = "Error (Red)"; func = QuickHeal_ComboBoxMessageConfigure_Click; value = "Error" };
end
-- Function for handling clicks on the MessageConfigure ComboBox
function QuickHeal_ComboBoxMessageConfigure_Click()
    UIDropDownMenu_SetSelectedValue(QuickHealConfig_ComboBoxMessageConfigure,this.value);
    if QHV["MessageScreenCenter" .. this.value] then
        QuickHealConfig_CheckButtonMessageScreenCenter:SetChecked(true);
    else
        QuickHealConfig_CheckButtonMessageScreenCenter:SetChecked(false);
    end
    if QHV["MessageChatWindow" .. this.value] then
        QuickHealConfig_CheckButtonMessageChatWindow:SetChecked(true);
    else
        QuickHealConfig_CheckButtonMessageChatWindow:SetChecked(false);
    end
end

-- Get an explanation of effects based on current settings
function QuickHeal_GetExplanation(Parameter)
    local string = "";

    if Parameter == "RatioHealthy" then
        return QuickHeal_ClassModule:GetRatioHealthyExplanation();
    end

    if Parameter == "NotificationChannel" then
        if QHV.NotificationChannel then
            if QHV.NotificationChannelName and (QHV.NotificationChannelName ~= "") then
                return "Notification will be delivered to channel '" .. QHV.NotificationChannelName .. "' if it exists.";
            else
                return "Enter a channel name to deliver notification to a channel.";
            end
        else
            return "Notification will not be delivered to a channel.";
        end
    end

end

-- Hides/Shows the configuration dialog
function QuickHeal_ToggleConfigurationPanel()
    if QuickHealConfig:IsVisible() then QuickHealConfig:Hide() else QuickHealConfig:Show() end
end

--[ Buff and Debuff detection ]--

-- Detects if a buff is present on the unit and returns the application number
function QuickHeal_DetectBuff(unit,name,app)
    local i=1;
    local state,apps;
    while true do
        state,apps = UnitBuff(unit,i);
        if not state then return false end
        if string.find(state,name) and ((app == apps) or (app == nil)) then return apps end
        i=i+1;
    end
end

-- Detects if a debuff is present on the unit and returns the application number
function QuickHeal_DetectDebuff(unit,name,app)
    local i=1;
    local state,apps;
    while true do
        state,apps = UnitDebuff(unit,i);
        if not state then return false end
        if string.find(state,name) and ((app == apps) or (app == nil)) then return apps end
        i=i+1;
    end
end

-- Priest talent Inner Focus: Spell_Frost_WindWalkOn (1)
-- Shaman skill Water Walking: Spell_Frost_WindWalkOn (0)
-- Spirit of Redemption: Spell_Holy_GreaterHeal (0)
-- Nature's Swiftness: Spell_Nature_RavenForm (1)
-- Hand of Edward the Odd: Spell_Holy_SearingLight
-- Divine Protection (paladin 'bubble' aura): Spell_Holy_Restoration

-- Scan a particular buff/debuff index for buffs contained in tab and returns factor applied to healing
-- returns false if no buff/debuff at index
-- returns 1 if buff does not modify healing
local function ModifierScan(unit,idx,tab,debuff)
    local UnitBuffDebuff = debuff and UnitDebuff or UnitBuff;
    local icon,apps = UnitBuffDebuff(unit,idx);
    if icon then
        _,_,icon = string.find(icon,"Interface\\Icons\\(.+)")
        local stype = tab[icon..apps] or tab[icon];
        if stype then
            if type(stype) == "number" then
                return (debuff and 1-stype or 1+stype);
            elseif type(stype) == "boolean" then
                QuickHeal_ScanningTooltip:ClearLines();
                if debuff then QuickHeal_ScanningTooltip:SetUnitDebuff(unit,idx);
                else QuickHeal_ScanningTooltip:SetUnitBuff(unit,idx) end
                local _,_,modifier = string.find(QuickHeal_ScanningTooltipTextLeft2:GetText()," (%d+)%%")
                modifier = tonumber(modifier);
                if modifier and type(modifier) == "number" and ((modifier >= 0) and (modifier <= 100)) then
                    -- Succesfully scanned and found numerical modifier
                    return (debuff and 1-modifier/100 or 1+modifier/100);
                else
                    -- Failed in scanning, don't count (de)buff in
                    return 1;
                end
            end
        else 
            -- Unknown icon, don't even try to scan
            return 1;
        end
    else return false end
end

-- Tables with known icon names of buffs/debuffs that affect healing
local SelfHealingBuffs = {
Spell_Holy_PowerInfusion = 0.2, -- Power Infusion (Priest Talent)
}
local HealingBuffs = {
}
local HealingDebuffs = {
Ability_CriticalStrike     = true, -- Mortal Wound
Spell_Shadow_GatherShadows = true, -- Curse of the Deadwood, Veil of Shadow and Gehenna's Curse
Ability_Warrior_SavageBlow = 0.5, -- Mortal Strike/Mortal Cleave (Warrior Talent) (app unconfirmed)
Ability_Rogue_FeignDeath0  = 0.5, -- Blood Fury (Orc Racial)
Spell_Shadow_FingerOfDeath = 0.2, -- Hex of Weakness (app unconfirmed)
INV_Misc_Head_Dragon_Green = 0.5, -- Brood Affliction: Green (app unconfirmed)
Ability_Creature_Poison_03 = 0.9 -- Necrotic Poison (app unconfirmed)
}

-- Returns the modifier to healing (as a factor) caused by buffs and debuffs
function QuickHeal_GetHealModifier(unit)
    local HealModifier = 1;
    for i=1,16 do -- Buffs on player that affects the amount healed to others
        local modifier = ModifierScan('player',i,SelfHealingBuffs,false);
        if modifier then HealModifier = HealModifier * modifier;
        else break end
    end
    for i=1,16 do -- Buffs on unit that affect the amount healed on that unit
        local modifier = ModifierScan(unit,i,HealingBuffs,false);
        if modifier then HealModifier = HealModifier * modifier;
        else break end
    end 
    for i=1,16 do -- Debuffs on unit that affects the amount healed on that unit
        local modifier = ModifierScan(unit,i,HealingDebuffs,true);
        if modifier then HealModifier = HealModifier * modifier;
        else break end
    end
    return HealModifier;
end

--[ Healing related helper functions ]--

-- Returns true if the unit is a MainTank defined by CTRA or oRA
-- If number is given, will only return true if the unit is that specific main tank
local function IsMainTank(unit,number)
    local i,v;
    for i,v in pairs(CT_RA_MainTanks or (oRA_MainTank and oRA_MainTank.MainTankTable or nil) or (oRA and oRA.maintanktable or nil) or {}) do
        if v == UnitName(unit) and (i == number or number == nil) then return true end
    end
    return false;
end

-- Returns true if the unit is blacklisted (because it could not be healed)
local function IsBlacklisted(unitname)
    local CurrentTime = GetTime()
    if CurrentTime < LastBlackListTime then
        -- Game time info has overrun, clearing blacklist to prevent permanent bans
        BlackList = {};
        LastBlackListTime = 0;
    end
    if (BlackList[unitname] == nil) or BlackList[unitname] < CurrentTime then return false
    else return true end
end

-- Returns true if the player is in a raid group
local function InRaid()
    return (GetNumRaidMembers() > 0);
end

-- Returns true if the player is in a party or a raid
local function InParty()
    return (GetNumPartyMembers() > 0);
end

-- Returns true if health information is available for the unit
function QuickHeal_UnitHasHealthInfo(unit)
    if not unit then return false end
    if UnitIsUnit('player', unit) or UnitIsUnit('pet', unit) then return true end

    if InRaid() then
        -- In raid
        if UnitPlayerOrPetInRaid(unit) then return true end
    else
        -- Not in raid
        if UnitPlayerOrPetInParty(unit) then return true end
    end
    return false;
end

-- Only used by UnitIsHealable
local function EvaluateUnitCondition(unit,condition,debugText,explain)
    if not condition then
        if explain then QuickHeal_debug(unit, debugText) end
        return true
    else
        return false
    end
end

-- Return true if the unit is healable by player
local function UnitIsHealable(unit,explain)
    if UnitExists(unit) then
        if EvaluateUnitCondition(unit, UnitIsFriend('player', unit), "is not a friend",explain) then return false end
        if EvaluateUnitCondition(unit, not UnitIsEnemy(unit, 'player'), "is an enemy",explain) then return false end
        if EvaluateUnitCondition(unit, not UnitCanAttack('player', unit), "can be attacked by player",explain) then return false end
        if EvaluateUnitCondition(unit, UnitIsConnected(unit), "is not connected",explain) then return false end
        if EvaluateUnitCondition(unit, not UnitIsDeadOrGhost(unit), "is dead or ghost",explain) then return false end
        if EvaluateUnitCondition(unit, UnitIsVisible(unit), "is not visible to client",explain) then return false end
    else return false
    end
    return true
end

-- SpellCache[spellName][rank][stat]
-- stat: SpellID, Mana, Heal, Time
function QuickHeal_GetSpellInfo(spellName)

    -- Check if info is already cached
    if SpellCache[spellName] then
        return SpellCache[spellName];
    end

    SpellCache[spellName] = {};

    -- Gather info (only done if not in cache)
    local i = 1;
    local spellNamei, spellRank, Heal, HealMin, HealMax, Mana, Time;
    while true do
        spellNamei, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
        if not spellNamei then break end

        if spellNamei == spellName then
            -- This is the spell we're looking for, gather info

            _,_,spellRank = string.find(spellRank, " (%d+)$");
            spellRank = tonumber(spellRank);
            QuickHeal_ScanningTooltip:ClearLines();
            QuickHeal_ScanningTooltip:SetSpell(i, BOOKTYPE_SPELL);
    
            -- Try to determine mana
            _,_,Mana = string.find(QuickHeal_ScanningTooltipTextLeft2:GetText() or "","^(%d+)");
            Mana = tonumber(Mana);
            if not (type(Mana) == "number") then Mana = 0 end

            -- Try to determine healing
            _,_,HealMin,HealMax = string.find(QuickHeal_ScanningTooltipTextLeft4:GetText() or "","(%d+) ?[\195\160tobisa到]+ ?(%d+)");
            HealMin,HealMax = tonumber(HealMin),tonumber(HealMax);
            if not ((type(HealMin) == "number") and (type(HealMax) == "number")) then 
                Heal = 0 
            else
                Heal = (HealMin+HealMax)/2;
            end

            -- Try to determine cast time
            _,_,Time = string.find(QuickHeal_ScanningTooltipTextLeft3:GetText() or "","^(%d%.?%d?)");
            Time = tonumber(Time);
            if not (type(Time) == "number") then Time = 0 end

            if not spellRank then
                SpellCache[spellName][0] = {SpellID = i, Mana = Mana, Heal = Heal, Time = Time};
                break;
            else
                SpellCache[spellName][spellRank] = {SpellID = i, Mana = Mana, Heal = Heal, Time = Time};
            end
        end
        i = i + 1;
    end
    return SpellCache[spellName];
end

-- Returns an estimate of the units heal need for external units
function QuickHeal_EstimateUnitHealNeed(unit,report)
    -- Estimate target health
    local HealthPercentage = UnitHealth(unit) or 0;
    HealthPercentage = HealthPercentage/100;
    local _,Class = UnitClass(unit);
    Class = Class or "Unknown";
    MaxHealthTab = {warrior=4100,
                    paladin=4000,
                    shaman=3500,
                    rogue=3100,
                    hunter=3100,
                    druid=3100,
                    warlock=2300,
                    mage=2200,
                    priest=2100};
    local MaxHealth = MaxHealthTab[string.lower(Class)] or 4000;
    local Level = UnitLevel(unit) or 60;
    local HealNeed = (1-HealthPercentage)*MaxHealth*Level/60;
    if report then QuickHeal_debug("Health deficit estimate (" .. Level .. " " .. string.lower(Class) .. " @ " .. HealthPercentage*100 .. "%)",HealNeed) end
    return HealNeed;
end

local function UnitClassPriority(unit)
    if not unit then return 1 end
    local _,class = UnitClass(unit);
    class = string.upper(string.sub(class,1,1)) .. string.lower(string.sub(class,2));
    return QHV["ClassPriority" .. class];
end

local function FindWhoToHeal(Restrict,extParam)
    local playerIds = {};
    local petIds = {};
    local i;
    local AllPlayersAreFull = true;
    local AllPetsAreFull = true;

    -- Self Preservation
    local selfPercentage = UnitHealth('player') / UnitHealthMax('player');
    if (selfPercentage < QHV.RatioForceself) and (selfPercentage <= QHV.RatioFull) then
        QuickHeal_debug("********** Self Preservation **********");
        return 'player';
    end

    -- Target Priority
    if QHV.TargetPriority and QuickHeal_UnitHasHealthInfo('target') then
        if (UnitHealth('target') / UnitHealthMax('target')) <= QHV.RatioFull then
        QuickHeal_debug("********** Target Priority **********");
        return 'target';
        end
    end

    -- Heal party/raid etc.
    local RestrictParty = false;
    local RestrictSubgroup = false;
    local RestrictMT = false;
    local RestrictNonMT = false;
    if Restrict == "subgroup" then
        QuickHeal_debug("********** Heal Subgroup **********");
        RestrictSubgroup = true;
    elseif Restrict == "party" then
        QuickHeal_debug("********** Heal Party **********");
        RestrictParty = true;
    elseif Restrict == "mt" then
        QuickHeal_debug("********** Heal MT **********");
        RestrictMT = true;
    elseif Restrict == "nonmt" then
        QuickHeal_debug("********** Heal Non MT **********");
        RestrictNonMT = true;
    else
        QuickHeal_debug("********** Heal **********");
    end

    -- Fill playerIds and petIds with healable targets
    if (InRaid() and not RestrictParty) then
        for i=1,GetNumRaidMembers() do
            if UnitIsHealable("raid" .. i, true) then
                local IsMT = IsMainTank("raid" .. i);
                if not RestrictMT and not RestrictNonMT or RestrictMT and IsMT or RestrictNonMT and not IsMT then
                    playerIds["raid" .. i] = i;
                end
            end
            if UnitIsHealable("raidpet" .. i, true) then
                if not RestrictMT then
                    petIds["raidpet" .. i] = i;
                end
            end
        end
    else
        if UnitIsHealable('player', true) then playerIds["player"] = 0 end
        if UnitIsHealable('pet', true) then petIds["pet"] = 0 end
        for i=1,GetNumPartyMembers() do
            if UnitIsHealable("party" .. i, true) then
                playerIds["party" .. i] = i;
            end
            if UnitIsHealable("partypet" .. i, true) then
                petIds["partypet" .. i] = i;
            end
        end
    end

    local healingTarget = nil;
    local healingTargetHealthP = 1;
    local unit;

    -- Clear any healable target
    local OldPlaySound = PlaySound;
    PlaySound = function() end
    local TargetWasCleared = false;
    if UnitIsHealable('target') then
        TargetWasCleared = true;
        ClearTarget();
    end

    -- Cast the checkspell
    if extParam.CheckSpell then 
        CastSpell(extParam.CheckSpell, BOOKTYPE_SPELL) 
    else 
        QuickHeal_ClassModule:CastCheckSpell() 
    end
    if not SpellIsTargeting() then 
        -- Reacquire target if it was cleared
        if TargetWasCleared then
            TargetLastTarget();
        end
        -- Reinsert the PlaySound
        PlaySound = OldPlaySound;
        return false;
    end

    -- Examine Healable Players
    for unit,i in playerIds do
        local SubGroup = false;
        if InRaid() and not RestrictParty and RestrictSubgroup then
            _,_,SubGroup = GetRaidRosterInfo(i);
        end
        if not RestrictSubgroup or RestrictParty or not InRaid() or (SubGroup and not QHV["FilterRaidGroup" .. SubGroup]) then
            if not IsBlacklisted(UnitFullName(unit)) then
                if SpellCanTargetUnit(unit) then
                    local Health = UnitHealth(unit) / UnitHealthMax(unit);
                    local HealthP = 1 - (1 - Health) * UnitClassPriority(unit);
                    QuickHeal_debug(string.format("%s (%s) : %d%% (%d%%)", UnitFullName(unit), unit, math.floor(100*Health), math.floor(100*HealthP)));
                    if Health <= QHV.RatioFull then 
                        if HealthP < healingTargetHealthP then
                            healingTarget = unit;
                            healingTargetHealthP = HealthP;
                            AllPlayersAreFull = false;
                        end
                    end
                else
                    QuickHeal_debug(UnitFullName(unit) .. " (" .. unit .. ")","is out-of-range or unhealable");
                end
            else
                QuickHeal_debug(UnitFullName(unit) .. " (" .. unit .. ")","is blacklisted");
            end
        end
    end

    -- Examine Healable Pets
    if QHV.PetPriority > 0 then
        for unit,i in petIds do
            local SubGroup = false;
            if InRaid() and not RestrictParty and RestrictSubgroup then
                _,_,SubGroup = GetRaidRosterInfo(i);
            end
            if not RestrictSubgroup or RestrictParty or not InRaid() or (SubGroup and not QHV["FilterRaidGroup" .. SubGroup]) then
                if not IsBlacklisted(UnitFullName(unit)) then
                    if SpellCanTargetUnit(unit) then                              
                        local Health = UnitHealth(unit) / UnitHealthMax(unit);
                        local HealthP = 1 - (1 - Health) * QHV.PetPriority;
                        QuickHeal_debug(string.format("%s (%s) : %d%% (%d%%)", UnitFullName(unit), unit, math.floor(100*Health), math.floor(100*HealthP)));
                        if Health <= QHV.RatioFull then
                            if HealthP < healingTargetHealthP then
                                healingTarget = unit;
                                healingTargetHealthP = HealthP;
                                AllPetsAreFull = false;
                            end
                        end
                    else
                        QuickHeal_debug(UnitFullName(unit) .. " (" .. unit .. ")","is out-of-range or unhealable");
                    end
                else
                    QuickHeal_debug(UnitFullName(unit) .. " (" .. unit .. ")","is blacklisted");
                end
            end
        end
    end

    -- Reacquire target if it was cleared earlier, and stop CheckSpell
    SpellStopTargeting();
    if TargetWasCleared then
        TargetLastTarget();
    end
    PlaySound = OldPlaySound;

    -- Examine External Target
    if AllPlayersAreFull and AllPetsAreFull then
        if not QuickHeal_UnitHasHealthInfo('target') and UnitIsHealable('target',true) then
            QuickHeal_debug(string.format("%s (%s) : %d/%d",UnitFullName('target'),'target',UnitHealth('target'),UnitHealthMax('target')));
            local Health;
            Health = UnitHealth('target') / 100;
            if Health <= QHV.RatioFull then
                return 'target';
            end
        end
    end

    return healingTarget;
end

local function Notification(unit, spellName)
    local unitName = UnitFullName(unit);
    local rand = math.random(1,10);
    local read;
    local _,race = UnitRace('player');
    race = string.lower(race);

    if race == "scourge" then
        rand = math.random(1,7);
    end

    if race == "human" then
        rand = math.random(1,7);
    end

    if race == "dwarf" then
        rand = math.random(1,7);
    end

    -- If Normal notification style is selected override random number (also if healing self)
    if QHV.NotificationStyle == "NORMAL" or UnitIsUnit('player',unit) then
        rand = 0;
    end

    if rand == 0 then read = string.format(QHV.NotificationTextNormal, unitName, spellName) end
    if rand == 1 then read = string.format("%s is looking pale, gonna heal you with %s.", unitName, spellName) end
    if rand == 2 then read = string.format("%s doesn't look so hot, healing with %s.", unitName, spellName) end
    if rand == 3 then read = string.format("I know it's just a flesh wound %s, but I'm healing you with %s.", unitName, spellName) end
    if rand == 4 then read = string.format("Oh great, %s is bleeding all over, %s should take care of that.", unitName, spellName) end
    if rand == 5 then read = string.format("Death is near %s... or is it? Perhaps a heal with %s will keep you with us.", unitName, spellName) end
    if rand == 6 then read = string.format("%s, lack of health got you down? %s to the rescue!", unitName, spellName) end
    if rand == 7 then read = string.format("%s is being healed with %s.", unitName, spellName) end
    if race == "orc" then
        if rand == 8 then read = string.format("Zug Zug %s with %s.", unitName, spellName) end
        if rand == 9 then read = string.format("Loktar! %s is being healed with %s.", unitName, spellName) end
        if rand == 10 then read = string.format("Health gud %s, %s make you healthy again!", unitName, spellName) end
    end
    if race == "tauren" then
        if rand == 8 then read = string.format("By the spirits, %s be healed with %s.", unitName, spellName) end
        if rand == 9 then read = string.format("Ancestors, save %s with %s.", unitName, spellName) end
        if rand == 10 then read = string.format("Your noble sacrifice is not in vain %s, %s will keep you in the fight!", unitName, spellName) end
    end
    if race == "troll" then
        if rand == 8 then read = string.format("Whoa mon, doncha be dyin' on me yet! %s is gettin' %s'd.", unitName, spellName) end
        if rand == 9 then read = string.format("Haha! %s keeps dyin' an da %s voodoo, keeps bringin' em back!.", unitName, spellName) end
        if rand == 10 then read = string.format("Doncha tink the heal is comin' %s, %s should keep ya' from whinin' too much!", unitName, spellName) end
    end
    if race == "night elf" then
        if rand == 8 then read = string.format("Asht'velanon, %s! Elune sends you the gift of %s.", unitName, spellName) end
        if rand == 9 then read = string.format("Remain vigilent %s, the Goddess' %s shall revitalize you!", unitName, spellName) end
        if rand == 10 then read = string.format("By Elune's grace I grant you this %s, %s.", spellName, unitName) end
    end

    -- Check if NotificationChannelName exists as a channel
    local ChannelNo,ChannelName = GetChannelName(QHV.NotificationChannelName);

    if QHV.NotificationChannel and ChannelNo ~= 0 and ChannelName then
        SendChatMessage(read, "CHANNEL", nil, ChannelNo);
    elseif QHV.NotificationRaid and InRaid() then
        SendChatMessage(read, "RAID");
    elseif QHV.NotificationParty and InParty() and not InRaid() then
        SendChatMessage(read, "PARTY");
    end

    if QHV.NotificationWhisper and not UnitIsUnit('player',unit) and UnitIsPlayer(unit) then
        SendChatMessage(string.format(QHV.NotificationTextWhisper,spellName), "WHISPER", nil, unitName);
    end

end

-- Heals Target with SpellID, no checking on parameters
local function ExecuteHeal(Target,SpellID)
    local TargetWasChanged = false;

    -- Setup the monitor and related events
    StartMonitor(Target);

    -- Supress sound from target-switching
    local OldPlaySound = PlaySound;
    PlaySound = function() end

    -- If the current target is healable, take special measures
    if UnitIsHealable('target') then
        -- If the healing target is targettarget change current healable target to targettarget
        if Target == 'targettarget' then
            local old = UnitFullName('target');
            TargetUnit('targettarget');
            Target = 'target';
            TargetWasChanged = true;
            QuickHeal_debug("Healable target preventing healing, temporarily switching target to target's target",old,'-->',UnitFullName('target'));
        end
        -- If healing target is not the current healable target clear the healable target
        if not (Target == 'target') then
            QuickHeal_debug("Healable target preventing healing, temporarily clearing target",UnitFullName('target'));
            ClearTarget();
            TargetWasChanged = true;
        end
    end

    -- Get spell info
    local SpellRank;
    HealingSpell, SpellRank = GetSpellName(SpellID, BOOKTYPE_SPELL);
    if SpellRank == "" then SpellRank = nil end
    local SpellNameAndRank = HealingSpell .. (SpellRank and " (" .. SpellRank .. ")" or "");

    QuickHeal_debug("  Casting: " .. SpellNameAndRank .. " on " .. UnitFullName(Target) .. " (" .. Target .. ")" .. ", ID: " .. SpellID);

    -- Clear any pending spells
    if SpellIsTargeting() then SpellStopTargeting() end

    -- Cast the spell
    CastSpell(SpellID, BOOKTYPE_SPELL);

    -- Target == 'target'
        -- Instant channeling --> succesful cast
        -- Instant channeling --> instant 'out of range' fail
        -- Instant channeling --> delayed 'line of sight' fail
        -- No channeling --> SpellStillTargeting (unhealable NPC's, duelists etc.)

    -- Target ~= 'target'
        -- SpellCanTargetUnit == true           
            -- Channeling --> succesful cast
            -- Channeling --> instant 'out of range' fail
            -- Channeling --> delayed 'line of sight' fail
            -- No channeling --> SpellStillTargeting (unknown circumstances)
        -- SpellCanTargetUnit == false
            -- Duels/unhealable NPC's etc.

    -- The spell is awaiting target selection, write to screen if the spell can actually be cast
    if SpellCanTargetUnit(Target) or ((Target == 'target') and HealingTarget) then

        Notification(Target, SpellNameAndRank);

        -- Write to center of screen
        if UnitIsUnit(Target,'player') then
            Message(string.format("Casting %s on yourself", SpellNameAndRank),"Healing",3)
        else
            Message(string.format("Casting %s on %s",SpellNameAndRank,UnitFullName(Target)),"Healing",3)
        end
    end

    -- Assign the target of the healing spell
    SpellTargetUnit(Target);

    -- Check if spell is still targeting (Healing people in duels!)
    if SpellIsTargeting() then 
        StopMonitor("Spell cannot target " .. (UnitFullName(Target) or "unit"));
        SpellStopTargeting() 
    end

    -- Reacquire target if it was changed earlier
    if TargetWasChanged then
        local old = UnitFullName('target') or "None";
        TargetLastTarget();
        QuickHeal_debug("Reacquired previous target",old,'-->',UnitFullName('target'));
    end

    -- Enable sound again
    PlaySound = OldPlaySound;
end

-- Heals the specified Target with the specified Spell
-- If parameters are missing they will be determined automatically
function QuickHeal(Target,Spell,extParam)

    -- Only one instance of QuickHeal allowed at a time
    if QuickHealBusy then
        if HealingTarget and MassiveOverhealInProgress then
            QuickHeal_debug("Massive overheal aborted.");
            SpellStopCasting();
        else
            QuickHeal_debug("Healing in progress, command ignored");
        end
        return;
    end

    QuickHealBusy = true;
    local AutoSelfCast = GetCVar("autoSelfCast");
    SetCVar("autoSelfCast",0);

    -- Protect against invalid extParam
    if not (type(extParam) == "table") then extParam = {} end

    -- Decode special values for Target
    local Restrict = nil;
    if Target then Target = string.lower(Target) end
    if Target == "party" or Target == "subgroup" then 
        Restrict = Target;
        Target = nil;
    elseif Target == "mt" or Target == "nonmt" then
        if InRaid() then
            Restrict = Target;
            Target = nil;
        else
            Message("You are not in a raid","Error",2);            
            SetCVar("autoSelfCast",AutoSelfCast);
            QuickHealBusy = false;
            return;
        end
    end

    -- Decode spell specified as string
    local spellName, spellRank, spellID;
    if type(Spell) == "string" then
        _,_,spellName,spellRank = string.find(Spell, "^(..-)%s*(%d*)$");
        if not spellName and spellRank then
            -- Failed to decode the string
            Message("Spell not found","Error",2);
            SetCVar("autoSelfCast",AutoSelfCast);
            QuickHealBusy = false;
            return;
        end

        -- Both substrings matched, get a list of SpellIDs
        local slist = QuickHeal_GetSpellInfo(spellName);

        if slist[0] then
            -- Spell does not have different ranks use entry 0
            spellRank = 0;
            spellID = slist[0].SpellID;
        elseif table.getn(slist) > 0 then
            -- Spell has different ranks get the one specified or choose max rank
            spellRank = tonumber(spellRank);
            if spellRank and slist[spellRank] then
                -- Rank specified and exists
                spellID = slist[spellRank].SpellID;
            else
                -- rank not specified or does not exist, use max rank
                spellRank = table.getn(slist);
                spellID = slist[table.getn(slist)].SpellID;
            end
        else
            -- Failed to find the spell
            Message("Spell not found","Error",2);
            SetCVar("autoSelfCast",AutoSelfCast);
            QuickHealBusy = false;
            return;
        end
        -- Use this spell as the CheckSpell for range-checking
        extParam.CheckSpell = spellID;
    end

    if Target then -- Target is specified, check it
        QuickHeal_debug("********** Heal "..Target.." **********");
        if UnitIsHealable(Target,true) then
            QuickHeal_debug(string.format("%s (%s) : %d/%d",UnitFullName(Target),Target,UnitHealth(Target),UnitHealthMax(Target)));
            local targetPercentage;
            if QuickHeal_UnitHasHealthInfo(Target) then
                targetPercentage = UnitHealth(Target) / UnitHealthMax(Target);
            else
                targetPercentage = UnitHealth(Target) / 100;
            end
            if targetPercentage <= QHV.RatioFull then
                -- Does need healing (fall through to healing code)
            else
                -- Does not need healing
                if UnitIsUnit(Target,'player') then
                    Message("You don't need healing","Info",2);
                elseif Target == 'target' then
                    Message(UnitFullName('target') .. " doesn't need healing","Info",2);
                elseif Target == "targettarget" then
                    Message(UnitFullName('target') .. "'s Target (" .. UnitFullName('targettarget') .. ") doesn't need healing","Info",2);
                else
                    Message(UnitFullName(Target) .. " doesn't need healing","Info",2);
                end
                SetCVar("autoSelfCast",AutoSelfCast);
                QuickHealBusy = false;
                return;
            end
        else -- Unit is not healable, report reason and return
            if Target == 'target' and not UnitExists('target') then
                Message("You don't have a target","Error",2);
            elseif Target == 'targettarget' then
                if not UnitExists('target') then
                    Message("You don't have a target","Error",2);
                elseif not UnitExists('targettarget') then
                    Message((UnitFullName('target') or "Target") .. " doesn't have a target","Error",2);
                else
                    Message(UnitFullName('target') .. "'s Target (" .. UnitFullName('targettarget') .. ") cannot be healed","Error",2);
                end
            elseif UnitExists(Target) then
                -- Unit exists but cannot be healed
                if UnitIsUnit(Target,'player') then
                    Message("You cannot be healed","Error",2);
                else
                    Message(UnitFullName(Target) .. " cannot be healed","Error",2);
                end
            else
                Message("Unit does not exist","Error",2);
            end
            SetCVar("autoSelfCast",AutoSelfCast);
            QuickHealBusy = false;
            return;
        end
    else -- Target not specified, determine automatically
        Target = FindWhoToHeal(Restrict,extParam)
        if not Target then -- No healing target found
            if Target == false then
                -- Means that FindWhoToHeal couldn't cast the CheckSpell (reason will be reported by UI)
            else
                if Restrict == "mt" then
                    local tanks = false;
                    local i,v;
                    for i,v in pairs(CT_RA_MainTanks or (oRA_MainTank and oRA_MainTank.MainTankTable or nil) or (oRA and oRA.maintanktable or nil) or {}) do
                        tanks = true;
                        break;
                    end
                    if not tanks then
                        Message("No players assigned as Main Tank by Raid Leader","Error",2);
                    else
                        Message("No Main Tank to heal","Info",2);
                    end
                elseif InParty() or InRaid() then
                    Message("No one to heal","Info",2);
                else
                    Message("You don't need healing","Info",2);
                end
            end
            SetCVar("autoSelfCast",AutoSelfCast);
            QuickHealBusy = false;
            return;
        end
    end

    -- Target acquired
    QuickHeal_debug(string.format("  Healing target: %s (%s)", UnitFullName(Target), Target));

    -- Check SpellID input
    if not Spell then
        -- No Spell specified, find appropriate spell
        spellID,HealingSpellSize = QuickHeal_ClassModule:FindSpellToUse(Target);
    elseif spellName and spellRank then
        -- Spell was specified, get information about healing
        HealingSpellSize = QuickHeal_ClassModule:GetSpellInfo(spellName, Target)[spellRank].EffectiveHeal;
    end

    if spellID then
        ExecuteHeal(Target,spellID);
    else
        Message("You have no healing spells to cast","Error",2);
        SetCVar("autoSelfCast",AutoSelfCast);
        QuickHealBusy = false;
    end

    SetCVar("autoSelfCast",AutoSelfCast);
end

function QuickHeal_Command(msg)

    local cmd = string.lower(msg)

    if cmd == "cfg" then
        QuickHeal_ToggleConfigurationPanel();
        return;
    end

    if cmd == "debug on" then
        QHV.DebugMode = true;
        writeLine(QuickHealData.name .. " debug mode enabled",0,0,1);
        return;
    end

    if cmd == "debug off" then
        QHV.DebugMode = false;
        writeLine(QuickHealData.name .. " debug mode disabled",0,0,1);
        return;
    end

    if cmd == "reset" then
        QuickHeal_SetDefaultParameters();
        writeLine(QuickHealData.name .. " reset to default configuration",0,0,1);
        QuickHeal_ToggleConfigurationPanel();
        QuickHeal_ToggleConfigurationPanel();
        return;
    end

    -- Parse healing commands
    if cmd == "" then
        QuickHeal();
        return;
    elseif cmd == "player" or cmd == "target" or cmd == "targettarget" or cmd == "party" or cmd == "subgroup" or cmd == "mt" or cmd == "nonmt" then
        QuickHeal(cmd);
        return;
    end

    -- Print usage information
    writeLine(QuickHealData.name .. " Usage:");
    writeLine("/qh - Heals the party/raid member that most need it with the best suited healing spell.");
    writeLine("/qh player - Forces the target of the healing to be yourself.");
    writeLine("/qh target - Forces the target of the healing to be your current target.");
    writeLine("/qh targettarget - Forces the target of the healing to be your current target's target.");
    writeLine("/qh party - Restricts the healing to the party when in a raid.");
    writeLine("/qh mt - Restricts the healing to the Main Tanks defined by the Raid Leader in CTRaidAssist, oRA or oRA2.");
    writeLine("/qh nonmt - Restricts the healing to players who are not defined as Main Tanks by the Raid Leader in CTRaidAssist, oRA or oRA2.");
    writeLine("/qh subgroup - Forces the healing to the groups selected in the configuration panel.");
    writeLine("/qh cfg - Opens up the configuration panel.");
    writeLine("/qh reset - Reset configuration to default parameters for all classes.");
end
